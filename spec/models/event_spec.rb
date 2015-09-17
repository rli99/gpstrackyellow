require 'rails_helper'

RSpec.describe Event, :type => :model do 
	
	it "belongs to trip" do
		$event = Event.reflect_on_association(:trip)
		$event.macro.should == :belongs_to
	end

	it "has many transfer_zone" do
		$event = Event.reflect_on_association(:transfer_zones)
		$event.macro.should == :has_many
	end

	it {should respond_to(:transportation)}
	
end