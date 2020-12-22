class PaymentNotifyController < ApplicationController
  def create
    payment = Payment.find_by(payu_id: params['order']['orderId'])
    status = params['order']['status']
    new_order_processing(payment, status)
  end

  def new_order_processing(payment, status)
    case status
    when "COMPLETED"
      payment&.complete! unless payment.paid?
      UserMailer.order_mail_placed(
        payment.id
      ).deliver_now
    when "CANCELED"
      payment&.failure!

    when "PENDING"
      payment&.pending! unless payment&.cancelled?
    end
  end
end
