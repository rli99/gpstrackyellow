require 'json'

class GpsIncomingServiceController < ApplicationController
	def receive_data

		puts "______________________"

		render text: "#{params}"

		data = JSON.parse(request.body.read)
		
		dataLength = 0

		data.each do |gps|
			dataLength += 1
			GpsDatum.create(
				latitude: gps["LATITUDE (DEG)"],
				longitude: gps["LONGITUDE (DEG)"],
				speed: gps["SPEED (M/S)"]
				)
		end

		Algorithm.transform(GpsDatum.last(dataLength).reverse_order)
	end
end
