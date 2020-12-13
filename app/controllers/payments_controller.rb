class PaymentsController < ApplicationController
  before_action :ensure_address, :ensure_cart, only: :index

  def index; end

  def create
    payment = Payment.create!(
      user_id: current_user.id, 
      booking_ids: current_user.bookings.unpaid.pluck(:id)
    )
    token = PayuAccessToken.execute!

    redirect = PayuCreateOrder.execute!(
      current_user.bookings.unpaid.pluck(:id),
      token,
      request.remote_ip,
      current_user.bookings.unpaid.pluck(:price_cents).sum,
      current_user.id,
      payment.id
    )

    redirect_to redirect
  end

  def ensure_address
    redirect_to addresses_path, flash: { error: t('address_error')} if current_user.address.nil?
  end
end