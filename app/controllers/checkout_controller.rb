class CheckoutController < ApplicationController
  before_action :authenticate_user!
  before_action :assign_pending_booking, only: :index

  def index; end

  def assign_pending_booking
    booking_id = cookies[:booking_id]
    if booking_id.present?
      booking = Booking.find_by(id: booking_id)
      if booking
        current_user.bookings << booking unless current_user.bookings.find_by(id: booking.id)
        cookies.delete :booking_id
      end
    end
  end
end
