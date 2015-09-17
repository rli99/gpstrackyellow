require 'json'

class GpsIncomingServiceController < ApplicationController
	def receive_data

		puts "______________________"

		render text: "#{params}"

		data = JSON.parse(request.body.read)
		
		data.each do |gps|
			GpsDatum.create(
				latitude: gps["LATITUDE (DEG)"],
				longitude: gps["LONGITUDE (DEG)"]
				)
		end

		Algorithm.transform(GpsDatum.all)
	end
end
