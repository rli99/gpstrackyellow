class AddEventToTransferZone < ActiveRecord::Migration
  def change
    add_reference :transfer_zones, :category, index: true, foreign_key: true
  end
end
