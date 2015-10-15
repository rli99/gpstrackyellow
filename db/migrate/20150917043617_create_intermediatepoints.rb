class CreateIntermediatepoints < ActiveRecord::Migration
  def change
    create_table :intermediatepoints do |t|
      t.datetime :time
      t.string :latitude
      t.string :longitude
      t.string :altitude
      
      t.timestamps null: false
    end
  end
end
