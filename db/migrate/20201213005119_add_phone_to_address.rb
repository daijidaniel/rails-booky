class AddPhoneToAddress < ActiveRecord::Migration[6.0]
  def change
    add_column :addresses, :phone, :string
  end
end
