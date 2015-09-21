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
		
		if Trip.last()
			events = Trip.last().events

			@hash_eventsData = []

			events.each do |event|
				data = {id: event.id, transportation: event.transportation, trip_id: event.trip_id}

				data[:transferzones] = []
				transferzones = event.transfer_zones
				transferzones.each do |zone|
					data[:transferzones].push({event_id: zone.event_id, id: zone.id, lat: zone.latitude.to_f, lng: zone.longitude.to_f, alt: zone.altitude.to_f})
				end

				data[:intermediatepoints] = []
				intpoints = event.intermediatepoints
				intpoints.each do |point|
					data[:intermediatepoints].push({transportation: event.transportation, event_id: point.event_id, id: point.id, lat: point.latitude.to_f, lng: point.longitude.to_f, alt: point.altitude.to_f})
				end
				@hash_eventsData.push(data)
			end
		end		

	end

	def change_event_transportation
		puts "------------------"
		puts params

		e = Event.find_by(id: params[:event_id])
		e.transportation = params[:transportation]
		e.save

		respond_to do |format|
	      format.html {
	        redirect_to(:back)
	      }
	      format.js
	      format.json
    	end
	end
	
end
