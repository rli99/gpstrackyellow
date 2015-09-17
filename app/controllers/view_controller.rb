class ViewController < ApplicationController
	def map
		puts "------------------testing map"
	end

	def tripdata
		@trips = Trip.all
	end

	def user
		
	end

	def gmap
		
		events = Trip.find_by(id:6).events

		@hash_eventsData = []

		# intermediatepoints.each do |point|
		# 	data = {id: point.id, lat: point.latitude.to_f, lng: point.longitude.to_f, alt: point.altitude.to_f} 
		# 	@hash_intPointsData.push(data)
		# end

		events.each do |event|
			data = {id: event.id, transportation: event.transportation, trip_id: event.trip_id}

			data[:transferzones] = []
			transferzones = event.transfer_zones
			transferzones.each do |zone|
				data[:transferzones].push({id: zone.id, lat: zone.latitude.to_f, lng: zone.longitude.to_f, alt: zone.altitude.to_f})
			end

			data[:intermediatepoints] = []
			intpoints = event.intermediatepoints
			intpoints.each do |point|
				data[:intermediatepoints].push({id: point.id, lat: point.latitude.to_f, lng: point.longitude.to_f, alt: point.altitude.to_f})
			end
			@hash_eventsData.push(data)
		end

	end
	
end
