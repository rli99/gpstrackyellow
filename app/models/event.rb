class Event < ActiveRecord::Base
	belongs_to :trip
	has_many :transfer_zones	
	has_many :intermediatepoints
end
