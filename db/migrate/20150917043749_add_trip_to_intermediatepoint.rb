class AddTripToIntermediatepoint < ActiveRecord::Migration
  def change
    add_reference :intermediatepoints, :trip, index: true, foreign_key: true
  end
end
