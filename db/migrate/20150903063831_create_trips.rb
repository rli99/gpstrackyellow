class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :avgSpeed
      t.string :duration
      t.string :distance
      t.boolean :verified

      t.timestamps null: false
    end
  end
end
