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

        gpsData[1, -2].each do |point|
            i = Intermediatepoint.new
            i.latitude = point.latitude
            i.longitude = point.longitude
            i.time = point.time
            i.event_id = e.id
            i.save
        end

    end

	def self.transform(gpsData)

        points = gpsData

        t = Trip.new
        t.avgSpeed = "10km/hr"
        t.duration = "2hrs"
        t.save

        currentTransportation = ""
        pointsChecked = 0
        totalPointsChecked = 0

        points.each do |point|
            pointsChecked += 1
            totalPointsChecked += 1
            newTransportation = ""
            if point.speed.to_f < 1.6
                newTransportation = "walking"
            elsif point.speed.to_f >= 1.6 && point.speed <= 10.0
                newTransportation = "tram"
            elsif point.speed.to_f >= 10.0
                newTransportation = "car"
            end

            if newTransportation != currentTransportation && currentTransportation != ""
                if totalPointsChecked == pointsChecked
                    createEvent(t, points[totalPointsChecked - pointsChecked, totalPointsChecked], currentTransportation)
                    pointsChecked = 0
                else
                    createEvent(t, points[totalPointsChecked - pointsChecked - 1, totalPointsChecked], currentTransportation)
                    pointsChecked = 0
                end

            end

            currentTransportation = newTransportation

        end

	end

end
