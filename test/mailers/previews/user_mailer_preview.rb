# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def order_mail_placed
    UserMailer.order_mail_placed(
      Payment.first.id
    )
  end
end
