require 'rails_helper'

RSpec.describe Trip, :type => :model do 
	
	it "belongs to user" do
		$trip = Trip.reflect_on_association(:user)
		$trip.macro.should == :belongs_to
	end

	it "has many events" do
		$trip = Trip.reflect_on_association(:events)
		$trip.macro.should == :has_many
	end

	it {should respond_to(:avgSpeed)}
	it {should respond_to(:duration)}
	it {should respond_to(:distance)}
	it {should respond_to(:verified)}
	
end