class UserMailer < ApplicationMailer
  def order_mail_placed payment_id
    @payment = Payment.find(payment_id)
    @user = @payment.user
    @title = 'order_placed'
    mail(
      to: @user.email,
      subject: t('order_placed', scope: 'mail')
    )
  end

  def order_mail_paid payment_id
    @payment = Payment.find(payment_id)
    @user = @payment.user
    @title = 'new_booking'

    mail(
      to: @user.email,
      subject: t('new_booking', scope: 'mail')
    )
  end

  def admin_mail payment_id
    @payment = Payment.find(payment_id)
    @user = @payment.user
    @title = 'new_booking'

    mail(
      to: @user.email,
      subject: t('new_booking', scope: 'mail')
    )
  end
end
