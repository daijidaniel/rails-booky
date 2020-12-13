class AddBookingsToPayment < ActiveRecord::Migration[6.0]
  def change
    add_reference :bookings, :payment, foreign_key: true
  end
end
