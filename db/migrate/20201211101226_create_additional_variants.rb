class CreateAdditionalVariants < ActiveRecord::Migration[6.0]
  def change
    create_table :additional_variants do |t|
      t.belongs_to :variant
      t.belongs_to :booking
      t.integer :quantity, default: 0
    end
  end
end
