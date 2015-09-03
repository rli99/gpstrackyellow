class CreateGpsData < ActiveRecord::Migration
  def change
    create_table :gps_data do |t|
      t.datetime :time
      t.string :latitude
      t.string :longitude
      t.string :altitude
      t.string :accuracy
      t.string :speed
      t.string :bearing

      t.timestamps null: false
    end
  end
end
