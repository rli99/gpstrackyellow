class CreateTransferZones < ActiveRecord::Migration
  def change
    create_table :transfer_zones do |t|
      t.datetime :time
      t.string :latitude
      t.string :longitude
      t.string :altitude

      t.timestamps null: false
    end
  end
end
