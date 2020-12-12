class CreateVariants < ActiveRecord::Migration[6.0]
  def change
    create_table :variants do |t|
      t.belongs_to :item
      t.string :name
      t.string :description
    end
    
    add_monetize :variants, :price, currency: { present: true, default: "PLN" }
  end
end
