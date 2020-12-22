# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def order_mail_placed
    UserMailer.order_mail_placed(
      Payment.last.id
    )
  end

  def order_mail_paid
    UserMailer.order_mail_placed(
      Payment.last.id
    )
  end

  def admin_mail
    UserMailer.order_mail_placed(
      Payment.last.id
    )
  end
end
