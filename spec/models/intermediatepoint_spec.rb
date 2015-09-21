require 'rails_helper'

RSpec.describe Intermediatepoint, :type => :model do 
	
	it "belongs to trip" do
		$intermediatepoint = Intermediatepoint.reflect_on_association(:trip)
		$intermediatepoint.macro.should == :belongs_to
	end

	it {should respond_to(:time)}
	it {should respond_to(:latitude)}
	it {should respond_to(:longitude)}
	it {should respond_to(:altitude)}
	
end