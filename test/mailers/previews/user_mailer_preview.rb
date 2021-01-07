# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def order_mail_placed
    UserMailer.order_mail_placed(
      Payment.last.id,
      "test@test.com"
    )
  end

  def order_mail_paid
    UserMailer.order_mail_placed(
      Payment.last.id,
      "test@test.com"
    )
  end

  def admin_mail
    UserMailer.order_mail_placed(
      Payment.last.id,
      "test@test.com"
    )
  end
end
