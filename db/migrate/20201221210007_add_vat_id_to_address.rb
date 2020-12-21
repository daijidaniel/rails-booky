class AddVatIdToAddress < ActiveRecord::Migration[6.0]
  def change
    add_column :addresses, :vat_id, :string
  end
end
