class AddUserToTrip < ActiveRecord::Migration
  def change
    add_reference :trips, :user, index: true, foreign_key: true
  end
end
