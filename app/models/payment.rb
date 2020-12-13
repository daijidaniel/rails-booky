class Payment < ApplicationRecord
  belongs_to :user, required: false
  has_many :bookings

  enum status: %i[unpaid pending paid cancelled]

  def complete!
    update status: :paid
    bookings.each { |booking| booking.update payment_status: :paid }
  end

  def completed?
    return true if paid?
    false
  end

  def pending!
    update status: :pending
    bookings.each { |booking| booking.update payment_status: :pending }
  end

  def failure!
    update status: :cancelled
    bookings.each { |booking| booking.update payment_status: :cancelled }
  end
end