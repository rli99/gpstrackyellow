class Algorithm < ActiveRecord::Base

	def self.transform (gpsData)

    t = nil
    totalPointCount = 0
    gpsData.each do |point|
      if pointCount == 5
        pointCount = 0
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
        p1 = gpsData[totalPointCount - 5]
        p2 = gpsData[totalPointCount]

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
      end

      totalPointCount += 1
      i = Intermediatepoint.new
      i.latitude = point.latitude
      i.longitude = point.longitude
      i.time = point.time
      i.event_id = t.id
      i.save
    end
    	
	end

end
