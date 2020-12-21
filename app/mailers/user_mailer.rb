class UserMailer < ApplicationMailer
  def order_mail_placed payment_id
    @payment = Payment.find(payment_id)
    @user = @payment.user

    mail(
      to: email_address_with_name(@user.email, @user.name),
      subject: t('order_placed', scope: 'mail')
    )
  end

  def order_mail_paid payment_id
    @payment = Payment.find(payment_id)
    @user = @payment.user

    mail(
      to: email_address_with_name(@user.email, @user.name),
      subject: t('order_paid', scope: 'mail')
    )
  end

  def admin_mail payment_id
    @payment = Payment.find(payment_id)
    @user = @payment.user

    mail(
      to: email_address_with_name(@user.email, @user.name),
      subject: t('new_booking', scope: 'mail')
    )
  end
end
