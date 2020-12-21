class OrderCompletedController < ApplicationController
  def index
    @payment = Payment.find_by(id: params[:payment])
    
    unless current_user.payments.find_by(id: @payment.id)
      @payment = nil 
    end
  end
end
