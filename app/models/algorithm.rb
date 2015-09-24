class Algorithm < ActiveRecord::Base

    @transferZoneId = nil

    def self.createEvent(trip, gpsPoints, transportation)
        
        e = Event.new
        t2 = TransferZone.new

        endPoint = gpsPoints[-1]

        t2.latitude = endPoint.latitude
        t2.longitude = endPoint.longitude
        t2.time = endPoint.time
        t2.save

        e.transportation = transportation
        e.trip_id = trip.id
        e.transfer_zone_ids = [t2.id, @transferZoneId]
        e.save

        @transferZoneId = t2.id

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

        t0 = TransferZone.new
        t0.latitude = gpsData[0].latitude
        t0.longitude = gpsData[0].longitude
        t0.time = gpsData[0].time
        t0.save

        @transferZoneId = t0.id

        t = Trip.new
        t.duration = gpsData[-1].date - gpsData[0].date
        t.user_id = gpsData[0].user_id
        t.save

        currentTransportation = ""
        pointsChecked = 0
        totalPointsChecked = 0
        totalAvgSpeed = 0

        gpsData.each do |point|
            totalAvgSpeed += point.speed
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
                if totalPointsChecked == pointsChecked
                    createEvent(t, gpsData[(totalPointsChecked - pointsChecked)..(totalPointsChecked - 1)], currentTransportation)
                    pointsChecked = 0
                else
                    createEvent(t, gpsData[(totalPointsChecked - pointsChecked - 1)..(totalPointsChecked - 1)], currentTransportation)
                    pointsChecked = 0
                end
            else
                if totalPointsChecked == gpsData.length
                    createEvent(t, gpsData[(totalPointsChecked - pointsChecked - 1)..(totalPointsChecked - 1)], currentTransportation)
                end
            end

            currentTransportation = newTransportation

        end
    end
    t.avgSpeed = (totalAvgSpeed / gpsData.length)
    t.save
end
