class OrderCompletedController < ApplicationController
  def index
    @payment = Payment.find_by(id: params[:payment])
    
    if user_signed_in?
      unless current_user.payments.find_by(id: @payment.id)
        @payment = nil 
      end
    else
      redirect_to new_user_session_path, flash: { error: "Must be signed in" }
    end
  end
end
