class AddEventToTransferZone < ActiveRecord::Migration
  def change
    add_reference :transfer_zones, :event, index: true, foreign_key: true
  end
end
