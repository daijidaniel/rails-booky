class CreatePayment < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.string :payu_id
      t.belongs_to :user
      t.integer :status, default: 0
    end
  end
end
