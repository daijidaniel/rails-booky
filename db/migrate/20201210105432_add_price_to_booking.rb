class AddPriceToBooking < ActiveRecord::Migration[6.0]
  def change
    add_monetize :bookings, :price, currency: { present: true, default: "PLN" }
  end
end
