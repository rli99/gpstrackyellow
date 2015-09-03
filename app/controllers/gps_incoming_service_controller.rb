class GpsIncomingServiceController < ApplicationController
	def receive_data

		puts "______________________"

		render text: "#{params}"
		
	end
end
