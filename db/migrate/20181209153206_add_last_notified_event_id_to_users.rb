class AddLastNotifiedEventIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :last_notified_event_id, :integer, null: false, default: 0
  end
end
