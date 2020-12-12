class CreateAdditionalItems < ActiveRecord::Migration[6.0]
  def change
    create_table :additional_items do |t|
      t.belongs_to :booking
      t.belongs_to :item, index: { unique: true }
      t.integer :quantity
      t.integer :total_price
    end
  end
end
