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
    e.trip_id = t.id
    e.save
    p1 = gpsData[0]
    p2 = gpsData[5]

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

    count = 0
    gpsData.each do |point|
      if count == 5
        # count = 0
        e = Event.new
        t3 = TransferZone.new
        t4 = TransferZone.new
        e.transportation = "bus"
        e.trip_id = t.id
        e.save
        p3 = gpsData[5]
        p4 = gpsData[10]

        t3.latitude = p3.latitude
        t3.longitude = p3.longitude
        t3.time = p3.time
        t3.event_id = e.id
        t3.save

        t4.latitude = p4.latitude
        t4.longitude = p4.longitude
        t4.time = p4.time
        t4.event_id = e.id
        t4.save 

      end

      count += 1
      i = Intermediatepoint.new
      i.latitude = point.latitude
      i.longitude = point.longitude
      i.time = point.time
      i.event_id = e.id
      i.save
    end
    	
	end

end
