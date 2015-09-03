class AddTripToEvent < ActiveRecord::Migration
  def change
    add_reference :events, :trip, index: true, foreign_key: true
  end
end
