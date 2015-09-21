class Algorithm < ActiveRecord::Base

    def self.createEvent(trip, gpsPoints, transportation)
        
        e = Event.new
        t1 = TransferZone.new
        t2 = TransferZone.new

        e.transportation = transportation
        e.trip_id = trip.id
        e.save

        startPoint = gpsPoints[0]
        endPoint = gpsPoints[-1]


        t1.latitude = startPoint.latitude
        t1.longitude = startPoint.longitude
        t1.time = startPoint.time
        t1.event_id = e.id
        t1.save

        t2.latitude = endPoint.latitude
        t2.longitude = endPoint.longitude
        t2.time = endPoint.time
        t2.event_id = e.id
        t2.save

        gpsPoints.shift
        gpsPoints.pop

        if !gpsPoints.empty?
            gpsPoints.each do |point|
                i = Intermediatepoint.new
                i.latitude = point.latitude
                i.longitude = point.longitude
                i.time = point.time
                i.event_id = e.id
                i.save
            end
        end
    end

	def self.transform(gpsData)

        t = Trip.new
        t.avgSpeed = "10km/hr"
        t.duration = "2hrs"
        t.save

        currentTransportation = ""
        pointsChecked = 0
        totalPointsChecked = 0

        gpsData.each do |point|
            pointsChecked += 1
            totalPointsChecked += 1
            newTransportation = ""
            if point.speed.to_f < 1.6
                newTransportation = "walking"
            elsif point.speed.to_f >= 1.6 && point.speed.to_f <= 10.0
                newTransportation = "tram"
            elsif point.speed.to_f > 10.0
                newTransportation = "car"
            end 

            if ((newTransportation <=> currentTransportation) != 0) && currentTransportation != ""
                puts "new #{newTransportation}"
                puts "current #{currentTransportation}"
                if totalPointsChecked == pointsChecked
                    createEvent(t, gpsData[totalPointsChecked - pointsChecked, totalPointsChecked], currentTransportation)
                    pointsChecked = 0
                else
                    createEvent(t, gpsData[totalPointsChecked - pointsChecked - 1, totalPointsChecked], currentTransportation)
                    pointsChecked = 0
                end

            end

            currentTransportation = newTransportation

        end

	end

end
