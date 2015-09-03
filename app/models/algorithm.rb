class Algorithm < ActiveRecord::Base

	def self.transform (gpsdata_block)
		puts "@@@@@@@@@@"
		puts gpsdata_block

		t = Trip.new
    	t.avgSpeed = "8km/hr"
    	t.duration = "1hr"
    	t.distance = "111km"
    	t.verified = false
    	t.save

    	e1 = Event.new
    	e1.transportation = "bus"
    	e1.trip_id = t.id
    	e1.save

    	e2 = Event.new
    	e2.transportation = "car"
    	e2.trip_id = t.id
    	e2.save

		tf1 = TransferZone.new
		tf1.time = nil
    	tf1.latitude = "111"
    	tf1.longitude = "222"
    	tf1.altitude = "333"
    	tf1.event_id = e1.id
    	tf1.save

    	tf2 = TransferZone.new
		tf2.time = nil
    	tf2.latitude = "1111"
    	tf2.longitude = "2222"
    	tf2.altitude = "3333"
    	tf2.event_id = e1.id
    	tf2.save

    	tf3 = TransferZone.new
		tf3.time = nil
    	tf3.latitude = "1111"
    	tf3.longitude = "2222"
    	tf3.altitude = "3333"
    	tf3.event_id = e2.id
    	tf3.save

    	tf4 = TransferZone.new
		tf4.time = nil
    	tf4.latitude = "111"
    	tf4.longitude = "222"
    	tf4.altitude = "333"
    	tf4.event_id = e2.id
    	tf4.save
    	
	end

end
