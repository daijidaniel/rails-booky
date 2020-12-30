class RenameCalendarIdToEventId < ActiveRecord::Migration[6.0]
  def change
    rename_column :bookings, :calendar_id, :event_id
  end
end
