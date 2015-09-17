require 'rails_helper'

RSpec.describe TransferZone, :type => :model do 
	
	it "belongs to event" do
		$transferzone = TransferZone.reflect_on_association(:event)
		$transferzone.macro.should == :belongs_to
	end

	it {should respond_to(:time)}
	it {should respond_to(:latitude)}
	it {should respond_to(:longitude)}
	it {should respond_to(:altitude)}
	
end