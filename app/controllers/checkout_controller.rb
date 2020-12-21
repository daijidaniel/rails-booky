class CheckoutController < ApplicationController
  before_action :authenticate_user!
  before_action :assign_pending_booking

  def index; end

  def assign_pending_booking
    booking_id = cookies[:booking_id]
    if booking_id
      booking = Booking.find_by(id: booking_id)

      if booking
        unless booking_exists? booking.id
          current_user.bookings << booking
          cookies.delete :booking_id
        end
      end
    end
  end

  def booking_exists? booking_id
    current_user.bookings.find_by(id: booking_id)
  end
end
