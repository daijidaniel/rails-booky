class UserMailer < ApplicationMailer
  def order_mail_placed payment_id
    @payment = Payment.find(payment_id)
  end

  def order_mail_paid payment_id
    @payment = Payment.find(payment_id)
    @user = @payment.user
  end

  def admin_mail payment_id
    @payment = Payment.find(payment_id)
    @user = @payment.user
  end
end
