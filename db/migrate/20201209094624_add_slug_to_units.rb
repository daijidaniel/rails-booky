class AddSlugToUnits < ActiveRecord::Migration[6.0]
  def change
    add_column :units, :slug, :string
    add_index :units, :slug, unique: true
  end
end
