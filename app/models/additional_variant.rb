class AdditionalVariant < ApplicationRecord
  belongs_to :booking
  belongs_to :variant

  after_create :update_booking_total

  def update_booking_total
    booking.update_price
  end
end
