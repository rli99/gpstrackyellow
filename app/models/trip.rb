class Trip < ActiveRecord::Base
	has_many :events
	belongs_to :user

	def self.gdata       

        # -------add transfer zone ---------

        # melbourne 37.8136° S, 144.9631° E
        tf1 = TransferZone.new
        tf1.time = Time.new
        tf1.latitude = "-37.79025"
        tf1.longitude = "145.0415"
        tf1.altitude = "333"
        #tf1.event_ids = [e1.id]
        tf1.save

        # canberra 35.3075° S, 149.1244° E
=begin
        tf2 = TransferZone.new
        tf2.time = Time.new
        tf2.latitude = "-35.3196"
        tf2.longitude = "149.1943"
        tf2.altitude = "333"
        tf2.event_id = e2.id
        tf2.save
=end

        # canberra 35.3075° S, 149.1244° E
        tf3 = TransferZone.new
        tf3.time = Time.new
        tf3.latitude = "-35.3196"
        tf3.longitude = "149.1943"
        tf3.altitude = "555555555"
        #tf3.event_ids = [e1.id,e2.id]
        tf3.save

        # sydney 33.8650° S, 151.2094° E
        tf4 = TransferZone.new
        tf4.time = Time.new
        tf4.latitude = "-33.8650"
        tf4.longitude = "151.2094"
        tf4.altitude = "333"
        #tf4.event_ids = [e2.id]
        tf4.save  

        # ----- add trip  ------

        t = Trip.new
        t.avgSpeed = "8km/h"
        t.duration = "2h"
        t.distance = "16km"
        t.verified = false
        t.user_id = 1
        t.save

        e1 = Event.new
        e1.transportation = "walking"
        e1.trip_id = t.id
        e1.transfer_zone_ids = [tf1.id,tf3.id]
        e1.save

        e2 = Event.new
        e2.transportation = "car"
        e2.trip_id = t.id        
        e2.transfer_zone_ids = [tf3.id,tf4.id]
        e2.save

        # -------add intermediate points ---------

        # melbourne (-37.79025192793327, 145.04150390625)
        i1 = Intermediatepoint.new
        i1.time = Time.new
        i1.latitude = "-37.79025"
        i1.longitude = "145.0415"
        i1.altitude = "333"
        i1.event_id = e1.id
        i1.save

        # (-36.56480607840352, 147.37060546875)
        i5 = Intermediatepoint.new
        i5.time = Time.new
        i5.latitude = "-36.5648"
        i5.longitude = "147.3706"
        i5.altitude = "333"
        i5.event_id = e1.id
        i5.save

        # canberra (-35.31960740586162, 149.1943359375)
        i2 = Intermediatepoint.new
        i2.time = Time.new
        i2.latitude = "-35.3196"
        i2.longitude = "149.1943"
        i2.altitude = "333"
        i2.event_id = e1.id
        i2.save

        # canberra (-35.31960740586162, 149.1943359375)
        i3 = Intermediatepoint.new
        i3.time = i2.time
        i3.latitude = "-35.3196"
        i3.longitude = "149.1943"
        i3.altitude = "333"
        i3.event_id = e2.id
        i3.save

        # (-34.601563177240884, 150.3369140625)
        i6 = Intermediatepoint.new
        i6.time = Time.new
        i6.latitude = "-34.6016"
        i6.longitude = "150.3369"
        i6.altitude = "333"
        i6.event_id = e2.id
        i6.save

        # sydney (-33.865, 151.20939999999996)
        i4 = Intermediatepoint.new
        i4.time = Time.new
        i4.latitude = "-33.8650"
        i4.longitude = "151.2094"
        i4.altitude = "333"
        i4.event_id = e2.id
        i4.save

        return tf3

	end

end
