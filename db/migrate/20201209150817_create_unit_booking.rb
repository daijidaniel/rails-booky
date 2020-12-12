class CreateUnitBooking < ActiveRecord::Migration[6.0]
  def change
    create_table :unit_bookings do |t|
      t.belongs_to :unit, index: { unique: true }, foreign_key: true
      t.belongs_to :booking, index: { unique: true }, foreign_key: true
    end
  end
end
