class ViewController < ApplicationController
	def map
		puts "------------------testing map"
	end

	def tripdata
		@trips = Trip.all
	end

	def user
		
	end
end
