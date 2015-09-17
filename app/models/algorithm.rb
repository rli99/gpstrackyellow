class Algorithm < ActiveRecord::Base

	def self.transform (gpsData)

    t = Trip.new
    t.avgSpeed = "10km/hr"
    t.duration = "2hrs"
    t.save
    t1 = TransferZone.new
    t2 = TransferZone.new
    e = Event.new
    e.transportation = "walking"
    e.save
    p1 = gpsData[0]
    p2 = gpsData[-1]

    t1.latitude = p1.latitude
    t1.longitude = p1.longitude
    t1.time = p1.time
    t1.event_id = e.id
    t1.save

    t2.latitude = p2.latitude
    t2.longitude = p2.longitude
    t2.time = p2.time
    t2.event_id = e.id
    t2.save 

    gpsData.each do |point|
      i = Intermediatepoint.new
      i.latitude = point.latitude
      i.longitude = point.longitude
      i.time = point.time
      i.trip_id = t.id
      i.save
    end


		# puts "@@@@@@@@@@"
		# puts gpsdata_block

		#   t = Trip.new
  #   	t.avgSpeed = "8km/hr"
  #   	t.duration = "1hr"
  #   	t.distance = "111km"
  #   	t.verified = false
  #   	t.save

  #   	e1 = Event.new
  #   	e1.transportation = "bus"
  #   	e1.trip_id = t.id
  #   	e1.save

  #   	#e2 = Event.new
  #   	#e2.transportation = "car"
  #   	#e2.trip_id = t.id
  #   	#e2.save

	 #   	tf1 = TransferZone.new
		#   tf1.time = Time.new
  #    	tf1.latitude = "-34.397"
  #    	tf1.longitude = "150.644"
  #    	tf1.altitude = "333"
  #    	tf1.event_id = e1.id
  #   	tf1.save

  #     tf2 = TransferZone.new
	 #    tf2.time = Time.new
  #    	tf2.latitude = "-33.865"
  #    	tf2.longitude = "151.2094"
  #    	tf2.altitude = "333"
  #    	tf2.event_id = e1.id
  #    	tf2.save

  # #   	tf3 = TransferZone.new
		# # # tf3.time = nil
  # #   	tf3.latitude = "1111"
  # #   	tf3.longitude = "2222"
  # #   	tf3.altitude = "3333"
  # #   	tf3.event_id = e2.id
  # #   	tf3.save

  # #   	tf4 = TransferZone.new
		# # # tf4.time = nil
  # #   	tf4.latitude = "111"
  # #   	tf4.longitude = "222"
  # #   	tf4.altitude = "333"
  # #   	tf4.event_id = e2.id
  # #   	tf4.save
    	
	end

end
