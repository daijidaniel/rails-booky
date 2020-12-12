class AddChildCapacityToBookings < ActiveRecord::Migration[6.0]
  def change
    add_column :bookings, :child_capacity, :integer, default: 0
  end
end
