class Trip < ActiveRecord::Base
	has_many :events
end
