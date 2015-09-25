require 'rails_helper'

RSpec.describe Event, :type => :model do 
	
	it "belongs to trip" do
		$event = Event.reflect_on_association(:trip)
		$event.macro.should == :belongs_to
	end

	it "has many itermediatepoint" do
		$event = Event.reflect_on_association(:intermediatepoints)
		$event.macro.should == :has_many
	end

	it "has many to many relationship with transferzone" do
        $event = Event.reflect_on_association(:transfer_zones)
		$event.macro.should == :has_and_belongs_to_many
	end

	it {should respond_to(:transportation)}
	
end