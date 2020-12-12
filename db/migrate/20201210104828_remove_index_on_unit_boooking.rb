class RemoveIndexOnUnitBoooking < ActiveRecord::Migration[6.0]
  def change
    remove_index :unit_bookings, :unit_id
    remove_index :unit_bookings, :booking_id
  end
end
