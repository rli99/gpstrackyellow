class AddUserToGpsData < ActiveRecord::Migration
	def change
	  add_reference :gps_data, :user, index: true, foreign_key: true
	end
end
