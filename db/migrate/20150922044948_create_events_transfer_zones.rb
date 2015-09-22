class CreateEventsTransferZones < ActiveRecord::Migration
  def change
    create_table :events_transfer_zones do |t|
    	t.integer :event_id
      	t.integer :transfer_zone_id
    end
  end
end
