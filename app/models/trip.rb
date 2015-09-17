class Trip < ActiveRecord::Base
	has_many :events
	has_many :intermediatepoints
	belongs_to :user
end
