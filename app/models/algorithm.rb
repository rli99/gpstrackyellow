class Algorithm < ActiveRecord::Base

    @transferZoneId = nil

    def self.createEvent(trip, gpsPoints, transportation, startTransferZoneId)
        
        e = Event.new
        t2 = TransferZone.new

        endPoint = gpsPoints[-1]

        t2.latitude = endPoint.latitude
        t2.longitude = endPoint.longitude
        t2.time = endPoint.time
        t2.save

        e.transportation = transportation
        e.trip_id = trip.id
        e.transfer_zone_ids = [startTransferZoneId, t2.id]
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

        t = Trip.new
        t.avgSpeed = "10km/hr"
        t.duration = "2hrs"
        t.save

        t0 = TransferZone.new
        t0.latitude = gpsData[0].latitude
        t0.longitude = gpsData[0].longitude
        t0.time = gpsData[0].time
        t0.save

        puts gpsData[0].latitude

        @transferZoneId = t0.id

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
                if totalPointsChecked == pointsChecked
                    createEvent(t, gpsData[(totalPointsChecked - pointsChecked)..(totalPointsChecked - 1)], currentTransportation, @transferZoneId)
                    pointsChecked = 0
                else
                    createEvent(t, gpsData[(totalPointsChecked - pointsChecked - 1)..(totalPointsChecked - 1)], currentTransportation, @transferZoneId)
                    pointsChecked = 0
                end
            else
                if totalPointsChecked == gpsData.length
                    createEvent(t, gpsData[(totalPointsChecked - pointsChecked - 1)..(totalPointsChecked - 1)], currentTransportation, @transferZoneId)
                end
            end

            currentTransportation = newTransportation

        end
	end
end
