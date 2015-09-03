class GpsIncomingServiceController < ApplicationController
	def receive_data

		puts "______________________"

		render text: "#{params}"
		
		GpsDatum.create(
			latitude: "try1",
			longitude: "try2",
			accuracy: "try3",
			)

	end
end
