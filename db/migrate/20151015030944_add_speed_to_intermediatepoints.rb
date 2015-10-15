class AddSpeedToIntermediatepoints < ActiveRecord::Migration
  def change
    add_column :intermediatepoints, :speed, :string
  end
end
