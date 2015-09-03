class CreateTransferZones < ActiveRecord::Migration
  def change
    create_table :transfer_zones do |t|

      t.timestamps null: false
    end
  end
end
