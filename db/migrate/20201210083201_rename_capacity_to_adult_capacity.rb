class RenameCapacityToAdultCapacity < ActiveRecord::Migration[6.0]
  def change
    rename_column :bookings, :capacity, :adult_capacity
  end
end
