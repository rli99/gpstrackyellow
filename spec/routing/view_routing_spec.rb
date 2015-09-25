require 'rails_helper'

RSpec.describe "Routing", :type => :routing do 
	describe "ViewController" do
		it "routes to #map" do
			expect(:get => 'view/map').to route_to("view#map")
		end
		it "routes to #gmap" do
			expect(:get => 'view/gmap').to route_to("view#gmap")
		end
		it "routes to #tripdata" do
			expect(:get => 'view/tripdata').to route_to("view#tripdata")
		end
		it "routes to #change_event_transportation" do
			expect(:post => "view/change_event_transportation/1").to route_to("view#change_event_transportation", :event_id => "1")
		end
		it "routes to #delete_transfer_zone" do
			expect(:post => "view/delete_transfer_zone/1").to route_to("view#delete_transfer_zone", :transfer_zone_id => "1")
		end
	end

	describe "datatransformationController" do
		it "routes to #transform_to_tripdata" do
			expect(:post => "datatransformation/transfrom_to_tripdata").to route_to("datatransformation#transform_to_tripdata")
		end
	end
	describe "gps_incoming_serviceController" do
		it "routes to #receive_data" do
			expect(:post => "/gps-data").to route_to("gps_incoming_service#receive_data")
		end
	end
	describe "welcomeController" do
		it "routes to #index" do
			expect(:get => "welcome/index").to route_to("welcome#index")
		end
	end
end