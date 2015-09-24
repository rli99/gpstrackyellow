require 'rails_helper'

RSpec.describe GpsDatum, :type => :model do 

	it "belongs to user" do
		$trip = GpsDatum.reflect_on_association(:user)
		$trip.macro.should == :belongs_to
	end

	it {should respond_to(:time)}
	it {should respond_to(:latitude)}
	it {should respond_to(:longitude)}
	it {should respond_to(:altitude)}
	it {should respond_to(:accuracy)}
	it {should respond_to(:speed)}
	it {should respond_to(:bearing)}
	
end