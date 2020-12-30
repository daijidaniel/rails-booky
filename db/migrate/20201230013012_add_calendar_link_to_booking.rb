class AddCalendarLinkToBooking < ActiveRecord::Migration[6.0]
  def change
    add_column :bookings, :calendar_link, :string
  end
end
