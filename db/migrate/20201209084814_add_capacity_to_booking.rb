class AddCapacityToBooking < ActiveRecord::Migration[6.0]
  def change
    add_column :bookings, :capacity, :integer
  end
end
