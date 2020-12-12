class AddPriceCentsToUnit < ActiveRecord::Migration[6.0]
  def change
    add_monetize :units, :price, currency: { present: true, default: "PLN" }
  end
end
