require 'json'
require 'uri'
require 'net/http'
require 'net/https'

class GpsIncomingServiceController < ApplicationController
	def receive_data

		data = JSON.parse(request.body.read)

		dataLength = 0

		userId = data.shift["USER"]

		data.each do |gps|
			dataLength += 1
			GpsDatum.create(
				latitude: gps["LATITUDE (DEG)"],
				longitude: gps["LONGITUDE (DEG)"],
				speed: gps["SPEED (M/S)"],
				user_id: userId
				)
		end

		Algorithm.transform(GpsDatum.last(dataLength).reverse)

	end
end
