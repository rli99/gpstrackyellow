require 'rails_helper'

RSpec.describe ViewController, :type => :controller do 

	describe "POST#change_event_transportation"do

	before do
		 @request.env['HTTP_REFERER'] = 'http://localhost:3000/sessions/new'
		@event1=Event.create(transportation: "Train")
		@event2=Event.create(transportation: "car")
		@event=[@event1, @event2]

		@transferZone=TransferZone.create(latitude: "100",
			                                longitude: "100",
			                                altitude: "100",
			                               )
		TransferZone.create(latitude: "200",
			                                longitude: "200",
			                                altitude: "200",
			                                )
	end

	it "update the transportation" do
		post :change_event_transportation, use_route: :view_change_event_transportation, event_id: @event1,transportation: "tram"
		@event1.reload
		expect(@event1.transportation).to eq("tram")
	end

    end

    describe "POST#delete_transfer_zone" do

	before do
		 @request.env['HTTP_REFERER'] = 'http://localhost:3000/sessions/new'
=begin
		@event1=Event.create(transportation: "Train")
		@event2=Event.create(transportation: "car")
		@event3=Event.create(transportation: "car")
		@event4=Event.create(transportation: "car")
		@event=[@event1, @event2]

		@transferZone1=TransferZone.create(latitude: "100",
			                                longitude: "100",
			                                altitude: "100",
			                               )
		@transferZone2=TransferZone.create(latitude: "200",
			                                longitude: "200",
			                                altitude: "200",
			                               )
		@transferZone3=TransferZone.create(latitude: "300",
			                                longitude: "300",
			                                altitude: "300",
			                               )
		@transferZone.event_ids=[@event1.id, @event2.id]
=end
		@transferZone = Trip.gdata
	end

	it "assigns the requested event as tf" do
		post :delete_transfer_zone, use_route: :view_delete_transfer_zone, transfer_zone_id: @transferZone.id
		expect(assigns(:tf)).to eq(@transferZone)
	end
    	it "delete the transferZone" do
    	
    		expect{post :delete_transfer_zone, use_route: :view_delete_transfer_zone, transfer_zone_id: @transferZone}.to change(TransferZone, :count).by(-1)
    	end
    	it "combine two events" do
    		@tf=TransferZone.last()
    		expect{post :delete_transfer_zone, transfer_zone_id: @transferZone, use_route: :view_delete_transfer_zone}.to change(Event, :count).by(-1)
    	end
    end

    describe "GET#gmap" do
    	it "involves events" do

    	end
    end

end