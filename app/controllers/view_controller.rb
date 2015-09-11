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

		img_url = "http://images.clipartpanda.com/clipart-star-RTA9RqzTL.png"

		transferzones = Trip.all[0].events[0].transfer_zones

		# @hash = Gmaps4rails.build_markers(transferzones) do |transferzone, marker|
		#   marker.lat transferzone.latitude
		#   marker.lng transferzone.longitude
		#   marker.infowindow transferzone.altitude
		@hash = []

		transferzones.each do |zone|
			data = {lat: zone.latitude.to_f, lng: zone.longitude.to_f, alt: zone.altitude.to_f} 
			@hash.push(data)
		end
		  #marker.picture({
       		#{}"url" => "images/star.png",
       		#{}"width" =>  32,
       		#{}"height" => 32})
		# end

	end
	
end
