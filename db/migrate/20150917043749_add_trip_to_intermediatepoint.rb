class AddEventToIntermediatepoint < ActiveRecord::Migration
  def change
    add_reference :intermediatepoints, :event, index: true, foreign_key: true
  end
end
