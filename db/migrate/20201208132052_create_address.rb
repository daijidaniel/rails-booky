class CreateAddress < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.belongs_to :user, index: { unique: true }, foreign_key: true
      t.string :line1
      t.string :line2
      t.string :city
      t.string :country
      t.string :postcode
    end
  end
end
