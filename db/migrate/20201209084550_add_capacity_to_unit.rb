class AddCapacityToUnit < ActiveRecord::Migration[6.0]
  def change
    add_column :units, :capacity, :integer
  end
end
