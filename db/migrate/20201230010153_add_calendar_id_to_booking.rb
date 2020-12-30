class AddCalendarIdToBooking < ActiveRecord::Migration[6.0]
  def change
    add_column :bookings, :calendar_id, :string
  end
end
