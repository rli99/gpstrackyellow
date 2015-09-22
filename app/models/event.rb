class Event < ActiveRecord::Base
	belongs_to :trip
	has_and_belongs_to_many :transfer_zones	
	has_many :intermediatepoints
end
