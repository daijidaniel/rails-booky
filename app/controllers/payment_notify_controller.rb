class PaymentNotifyController < ApplicationController
  def create
    payment = Payment.find_by(payu_id: params['order']['orderId'])
    status = params['order']['status']
    new_order_processing(payment, status)
  end

  def new_order_processing(payment, status)
    if status == "COMPLETED"
      payment&.complete! unless payment.paid?
      
      if !payment.sent?
        [payment.user.email, ENV["ADMIN_EMAIL"]].each do |email|
          UserMailer.order_mail_placed(
            payment.id,
            email
          ).deliver_now
        end

        payment.sent!
      end
    elsif status == "CANCELED"
      payment&.failure!

    elsif status == "PENDING"
      payment&.pending! unless payment&.cancelled?
    end
  end
end
