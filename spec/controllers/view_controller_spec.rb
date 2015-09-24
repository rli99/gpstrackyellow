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

    describe "DELETE #delete_transfer_zone" do

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

	it "assigns the requested event as tf" do
		post :delete_transfer_zone, use_route: :view_delete_transfer_zone, transfer_zone_id: @transferZone
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

end