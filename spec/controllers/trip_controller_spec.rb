require 'rails_helper'
require 'sampledata'

RSpec.describe TripController, :type => :controller do 
    	describe "POST#verify" do
    	    before (:each) do
    		  @request.env['HTTP_REFERER'] = 'http://localhost:3000/sessions/new'
	       	   @request.env["devise.mapping"] = Devise.mappings[:user]
	       	   @tripdata=SampleData.gdata
	       	   @user=@tripdata[0]
	       	  @trip=@tripdata[1]
	       	   sign_in @user
	       	 # @user=FactoryGirl.create(:user)
	       	 #puts @user.id
		    end 
		    it "update the verified attribute" do
		        	post :verify, tripId: @trip.id
		        	@trip.reload
		            expect(@trip.verified).to eq(true)
		    end
    	end
    	
    	describe "delete#destroy" do
    	    before (:each) do
    		  @request.env['HTTP_REFERER'] = 'http://localhost:3000/sessions/new'
	       	   @request.env["devise.mapping"] = Devise.mappings[:user]
	       	   @tripdata=SampleData.gdata
	       	   @user=@tripdata[0]
	       	  @trip=@tripdata[1]
	       	  @tf=@tripdata[2]
	       	   sign_in @user
	       	 # @user=FactoryGirl.create(:user)
	       	 #puts @user.id
		    end 
		    it "delete the trip" do
		    	puts @trip
		    	expect{	delete :destroy, trip_id: @trip.id}.to change(Trip, :count).by(-1)
		    end
		    
		    it "delete related events" do
		    		expect{	delete :destroy, trip_id: @trip.id}.to change(Event, :count).by(-2)
		    end
		    
		    it "delete related transferZones" do
		    			puts "112233c"
		    		puts @tf
		    	puts "112233c"
		    	expect{	delete :destroy, trip_id: @trip.id}.to change(TransferZone, :count).by(-3)
		   # delete :destroy, trip_id: @trip.id
		    	puts @tf
		    	puts "aaabbbccc"
		    end
		    
		    it "delete intermediatepoints related" do
		    	expect{	delete :destroy, trip_id: @trip.id}.to change(Intermediatepoint, :count).by(-6)
		    end
    	end
end