require 'rails_helper'

RSpec.describe TransferZone, :type => :model do 
	
	it "many to many relationship with event" do
		$transferzone = TransferZone.reflect_on_association(:events)
		$transferzone.macro.should == :has_and_belongs_to_many
	end
	

	it {should respond_to(:time)}
	it {should respond_to(:latitude)}
	it {should respond_to(:longitude)}
	it {should respond_to(:altitude)}
	
end