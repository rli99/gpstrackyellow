require 'json'

class GpsIncomingServiceController < ApplicationController
	def receive_data

		render text: "Data succesfully received"

		data = JSON.parse(request.body.read)

		dataLength = 0

		data.each do |gps|
			dataLength += 1
			GpsDatum.create(
				latitude: gps["LATITUDE (DEG)"],
				longitude: gps["LONGITUDE (DEG)"],
				speed: gps["SPEED (M/S)"],
				time: gps["TIME"],
				user_id: gps["USER"]
				)
		end

		Algorithm.transform(GpsDatum.last(dataLength).reverse)

	end
end
