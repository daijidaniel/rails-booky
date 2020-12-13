class OrderCompletedController < ApplicationController
  def index
    @payment = Payment.find_by(payu_id: params[:payment])
  end
end
