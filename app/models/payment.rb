class Payment < ApplicationRecord
  has_many :bookings
  belongs_to :user, required: false
  before_save :complete, if: Proc.new { |booking| booking.paid? }
  before_save :failure, if: Proc.new { |booking| booking.cancelled? }
  before_save :pending, if: Proc.new { |booking| booking.pending? }
  before_save :unpaid, if: Proc.new { |booking| booking.unpaid? }

  enum status: %i[unpaid pending paid cancelled]
  enum confirmation_sent: %i[confimation_not_sent sent] 

  def complete
    self.status = :paid

    bookings.each do |booking| 
      booking.update payment_status: :paid
      if RAILS_ENV != "development"	
        GoogleCalendarServices::Calendar.new({	
          booking: booking	
        }).create_event if booking.event_id.nil?	
      end
    end
  end

  def unpaid
    self.status = :unpaid
    bookings.each { |booking| booking.update payment_status: :unpaid }
  end

  def complete!
    update status: :paid
    
    bookings.each do |booking| 
      booking.update payment_status: :paid
      if RAILS_ENV != "development"	
        GoogleCalendarServices::Calendar.new({	
          booking: booking	
        }).create_event if booking.event_id.nil?	
      end
    end
  end

  def completed?
    return true if paid?
    false
  end

  def pending!
    update status: :pending
    bookings.each { |booking| booking.update payment_status: :pending }
  end

  def pending
    self.status = :pending
    bookings.each { |booking| booking.update payment_status: :pending }
  end

  def failure
    self.status = :cancelled

    bookings.each do |booking| 
      booking.update payment_status: :cancelled
      if RAILS_ENV != "development"
        GoogleCalendarServices::Calendar.new({
          booking: booking
        }).delete_event unless event_id.nil?
      end
    end
  end

  def failure!
    update status: :cancelled

    bookings.each do |booking| 
      booking.update payment_status: :cancelled
      if RAILS_ENV != "development"
        GoogleCalendarServices::Calendar.new({
          booking: booking
        }).delete_event unless event_id.nil?
      end
    end
  end
end
