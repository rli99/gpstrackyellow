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
        t.duration = (((gpsData[0].time - gpsData[-1].time).to_f) / 60).round(2).to_s + " mins"
        t.user_id = gpsData[0].user_id
        t.save

        currentTransportation = ""
        pointsChecked = 0
        totalPointsChecked = 0
        totalAvgSpeed = 0

        gpsData.each do |point|
            totalAvgSpeed += point.speed.to_f
            pointsChecked += 1
            totalPointsChecked += 1
            newTransportation = ""
            if point.speed.to_f < 5
                newTransportation = "walking"
            elsif point.speed.to_f >= 5 && point.speed.to_f <= 10.0
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
                    if totalPointsChecked == pointsChecked
                       createEvent(t, gpsData[(totalPointsChecked - pointsChecked)..(totalPointsChecked - 1)], currentTransportation)
                   else
                       createEvent(t, gpsData[(totalPointsChecked - pointsChecked - 1)..(totalPointsChecked - 1)], currentTransportation)    
                    end
                    
                end
            end

            currentTransportation = newTransportation

        end
        t.avgSpeed = ((3.6 * totalAvgSpeed) / gpsData.length).round(2).to_s + " km/h"
        t.distance = (((3.6 * totalAvgSpeed) / gpsData.length) * (((gpsData[0].time - gpsData[-1].time) / 3600).to_f)).round(2).to_s + " km"
        t.verified = false
        t.save
    end
end
