# frozen_string_literal: true

class PayuCreateOrder
  class << self
    def execute!(bookings, token, ip_address, totalAmount, user_id, payment_id)
      payment = Payment.find(payment_id)
      user = User.find(user_id)
      uri = URI.parse ENV["PAYU_ORDER_URL"]

      all_bookings = Booking.where(id: bookings).map do |booking|
        { name: booking.units.first.name, unitPrice: booking.price_cents, quantity: 1 }
      end

      order_req = JSON.dump({
        "notifyUrl": ENV['PAYU_NOTIFY_URL'],
        "customerIp": ip_address,
        "merchantPosId": ENV['PAYU_MERCHANT_POS_ID'],
        "description": ENV['PAYU_INVOICE_DESCRIPTION'],
        "currencyCode": "PLN",
        "totalAmount": totalAmount,
        "buyer": {
          "email": user.email,
          "phone": user.address.phone,
          "firstName": user.fname,
          "lastName": user.lname
        },
        "products": all_bookings,
        "redirectUri": "https://#{ENV['HOST']}/order_completed?payment=#{payment.id}",
        "continueUrl": "https://#{ENV['HOST']}/order_completed?payment=#{payment.id}"
      })

      # Create the HTTP objects
      https = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Post.new(uri.request_uri)
      request.content_type = "application/json"
      request["Authorization"] = "Bearer #{token}"
      request.body = order_req
      https.use_ssl = true

      # Send the request
      response = https.request(request)
      response_parsed = JSON.parse(response.body)
      payment.update!(payu_id: response_parsed["orderId"])

      response_parsed["redirectUri"]
    end
  end
end
