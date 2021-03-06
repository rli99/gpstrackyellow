require 'rails_helper'

RSpec.describe Algorithm do 
	before do
		@gpsData1=GpsDatum.new
		@gpsData2=GpsDatum.new
		@gpsData=[@gpsData1,@gpsData2]
	end


	describe "#transform" do
	it "should accept gpsData as parameter" do
		expect {Algorithm.transform(@gpsData)}.to_not raise_error
	end
	it "should generate a new trip record" do
		expect {Algorithm.transform(@gpsData)}.to change(Trip, :count).by(1)
	end
	it "should generate new transfer_zone" do
		expect {Algorithm.transform(@gpsData)}.to change(TransferZone, :count)
	end
	it "should genearate new event" do
		expect {Algorithm.transform(@gpsData)}.to change(Event, :count)
	end
	it "should generate new intermediatepoints" do
		expect {Algorithm.transform(@gpsData)}.to change(Intermediatepoint, :count)
	end
end
end