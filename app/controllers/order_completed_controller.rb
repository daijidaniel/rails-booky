class OrderCompletedController < ApplicationController
  def index
    @payment = Payment.find_by(id: params[:payment])
    @payment = nil unless current_user.payments.find(@payment.id)
  end
end
