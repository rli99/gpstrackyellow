class Trip < ActiveRecord::Base
	has_many :events
	has_many :intermediatepoints
	belongs_to :user

	def self.gIntPoints
		i1 = Intermediatepoint.new
		i1.time = Time.new
     	i1.latitude = "-35.3075"
     	i1.longitude = "149.1244"
     	i1.altitude = "333"
     	i1.trip_id = 1
    	i1.save

    	i2 = Intermediatepoint.new
		i2.time = Time.new
     	i2.latitude = "-34.397"
     	i2.longitude = "150.644"
     	i2.altitude = "333"
     	i2.trip_id = 1
    	i2.save

      	i3 = Intermediatepoint.new
	    i3.time = Time.new
     	i3.latitude = "-33.865"
     	i3.longitude = "151.2094"
     	i3.altitude = "333"
     	i3.trip_id = 1
     	i3.save
	end
end
