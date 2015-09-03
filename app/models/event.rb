class Event < ActiveRecord::Base
	belongs_to :trip
	has_many :transfer_zones
end
