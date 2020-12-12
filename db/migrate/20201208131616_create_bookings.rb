class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.string :amount
      t.integer :payment_status, default: 0

      t.timestamps
    end
  end
end
