require 'rails_helper'
require 'sampledata'

RSpec.describe ViewController, :type => :controller do 

	describe "POST#change_event_transportation"do

       before (:each) do
    		   @request.env['HTTP_REFERER'] = 'http://localhost:3000/sessions/new'
	       	   @request.env["devise.mapping"] = Devise.mappings[:user]
	       	   tripdata=SampleData.gdata
	       	   @user=tripdata[0]
	       	   @e1=tripdata[5]
	       	   
	       	   sign_in @user
	       	 # @user=FactoryGirl.create(:user)
	       	 #puts @user.id
		    end 

	it "update the transportation" do
		post :change_event_transportation, event_id: @e1, transportation: "tram"
		@e1.reload
		expect(@e1.transportation).to eq("tram")
	end

    end

    describe "POST#delete_transfer_zone" do

        	 before (:each) do
    		      @request.env['HTTP_REFERER'] = 'http://localhost:3000/sessions/new'
	       	   @request.env["devise.mapping"] = Devise.mappings[:user]
	       	   tripdata=SampleData.gdata
	       	   @user=tripdata[0]
	       	   @tf1=tripdata[2]
	       	   @tf2=tripdata[3]
	       	   @tf3=tripdata[4]
	       	   @e1=tripdata[5]
	       	   @e2=tripdata[6]
	       	   sign_in @user
	       	 # @user=FactoryGirl.create(:user)
	       	 #puts @user.id
		    end 

    	it "delete the transferZone" do
    		expect{post :delete_transfer_zone, transfer_zone_id: @tf2}.to change(TransferZone, :count).by(-1)
    	end
    	it "combines two events" do
    			expect{post :delete_transfer_zone, transfer_zone_id: @tf2}.to change(Event, :count).by(-1)
    	end
    	it "change the transferzones of old events to the new one" do
    		post :delete_transfer_zone, transfer_zone_id: @tf2
    		@tf1.reload
    		@tf3.reload
    		expect(@tf1.event_ids).not_to eq [@e1.id]
    		expect(@tf3.event_ids).not_to eq [@e2.id]
    	end
    end

    describe "GET#gmap" do
    		before (:each) do
    		  @request.env['HTTP_REFERER'] = 'http://localhost:3000/sessions/new'
	       	   @request.env["devise.mapping"] = Devise.mappings[:user]
	       	   tripdata=SampleData.gdata
	       	   @user=tripdata[0]
	       	   @trip=tripdata[1]
	       	   @tf1=tripdata[2]
	       	   @tf2=tripdata[3]
	       	   @tf3=tripdata[4]
	       	   @e1=tripdata[5]
	       	   @e2=tripdata[6]
	       	   @i1=tripdata[7]
	       	    @i2=tripdata[8]
	       	    @i3=tripdata[9]
	       	    @i4=tripdata[10]
	       	    @i5=tripdata[11]
	       	    @i6=tripdata[12]
	       	   
	       	   sign_in @user
	       	 # @user=FactoryGirl.create(:user)
	       	# puts @user.id
		    end 
    	it "gets the requested trip" do
    		get :gmap, trip_id: @trip
    		expect(assigns(:tripId)).to eq "#{@trip.id}"
    	end
    	it "gets all the detailed information of the requested trip" do
    			get :gmap, trip_id: @trip
    			detailed_data=assigns(:hash_eventsData)
    		
    	    	expect(detailed_data).to eq [{:id=>@e1.id,
         :transportation=>@e1.transportation,
         :trip_id=>@trip.id,
         :transferzones=>
          [{:event_ids=>[@e1.id],
            :id=>@tf1.id,
            :lat=>@tf1.latitude.to_f,
            :lng=>@tf1.longitude.to_f,
            :alt=>@tf1.altitude.to_f,
            :time=>@tf1.time.to_s},
           {:event_ids=>[@e1.id, @e2.id],
            :id=>@tf2.id,
            :lat=>@tf2.latitude.to_f,
            :lng=>@tf2.longitude.to_f,
            :alt=>@tf2.altitude.to_f,
            :time=>@tf2.time}],
         :intermediatepoints=>
          [{:transportation=>@e1.transportation,
            :event_id=>@e1.id,
            :id=>@i5.id,
            :lat=>@i5.latitude.to_f,
            :lng=>@i5.longitude.to_f,
            :alt=>@i5.altitude.to_f,
            :time=>@i5.time},
           {:transportation=>@e1.transportation,
            :event_id=>@e1.id,
            :id=>@i2.id,
            :lat=>@i2.latitude.to_f,
            :lng=>@i2.longitude.to_f,
            :alt=>@i2.altitude.to_f,
            :time=>@i2.time},
           {:transportation=>@e1.transportation,
            :event_id=>@e1.id,
            :id=>@i1.id,
            :lat=>@i1.latitude.to_f,
            :lng=>@i1.longitude.to_f,
            :alt=>@i1.altitude.to_f,
            :time=>@i1.time}]},
        {:id=>@e2.id,
         :transportation=>@e2.transportation,
         :trip_id=>@trip.id,
         :transferzones=>
          [{:event_ids=>[@e1.id, @e2.id],
            :id=>@tf2.id,
            :lat=>@tf2.latitude.to_f,
            :lng=>@tf2.longitude.to_f,
            :alt=>@tf2.altitude.to_f,
            :time=>@tf2.time},
           {:event_ids=>[@e2.id],
            :id=>@tf3.id,
            :lat=>@tf3.latitude.to_f,
           :lng=>@tf3.longitude.to_f,
            :alt=>@tf3.altitude.to_f,
            :time=>@tf3.time}],
         :intermediatepoints=>
          [{:transportation=>@e2.transportation,
            :event_id=>@e2.id,
            :id=>@i6.id,
            :lat=>@i6.latitude.to_f,
            :lng=>@i6.longitude.to_f,
            :alt=>@i6.altitude.to_f,
            :time=>@i6.time},
           {:transportation=>@e2.transportation,
            :event_id=>@e2.id,
            :id=>@i4.id,
           :lat=>@i4.latitude.to_f,
            :lng=>@i4.longitude.to_f,
            :alt=>@i4.altitude.to_f,
            :time=>@i4.time},
           {:transportation=>@e2.transportation,
            :event_id=>@e2.id,
            :id=>@i3.id,
           :lat=>@i3.latitude.to_f,
            :lng=>@i3.longitude.to_f,
            :alt=>@i3.altitude.to_f,
            :time=>@i3.time}]}]
         end
    end
    
    describe "get#profile" do
    	before (:each) do
    		  @request.env['HTTP_REFERER'] = 'http://localhost:3000/sessions/new'
	       	   @request.env["devise.mapping"] = Devise.mappings[:user]
	       	   tripdata=SampleData.gdata
	       	   @user=tripdata[0]
	       	   sign_in @user
	       	 # @user=FactoryGirl.create(:user)
	       	 puts @user.id
		    end 
		    
		    it "get the requested user" do
                get :profile, user_id: @user.id
                expect(assigns(:user)).to eq @user
		    end
    end
    
    describe "post#update" do
    		before (:each) do
    		  @request.env['HTTP_REFERER'] = 'http://localhost:3000/sessions/new'
	       	   @request.env["devise.mapping"] = Devise.mappings[:user]
	       	   tripdata=SampleData.gdata
	       	   @user=tripdata[0]
	       	   sign_in @user
	       	 # @user=FactoryGirl.create(:user)
	       	 puts @user.id
		    end 
		    
		    it "update the user's profile details" do
               	post :update, user: { #email: @user.email,
                                      #password: @user.password,
                                      name: "Jack",
                                      surname: "Lee",
                                      bithday: "1992-10-10",
                                      address: "calton" }
		    	@user.reload
		    	expect(@user.name).to eq("Jack")
		    	expect(@user.surname).to eq("Lee")
		    	expect(@user.bithday).to eq("1992-10-10")
		    	expect(@user.address).to eq("calton")
		    end
		    
    end
    
    describe "post#change_to_transfer_zone" do
     before (:each) do
    		  @request.env['HTTP_REFERER'] = 'http://localhost:3000/sessions/new'
	       	   @request.env["devise.mapping"] = Devise.mappings[:user]
	       	   @tripdata=SampleData.gdata
	       	   @user=@tripdata[0]
	       	    @i1=@tripdata[7]
	       	    @i2=@tripdata[8]
	       	    @i3=@tripdata[9]
	       	    @i4=@tripdata[10]
	       	    @i5=@tripdata[11]
	       	    @i6=@tripdata[12]
	       	   sign_in @user
	       	 # @user=FactoryGirl.create(:user)
	       	 #puts @user.id
		    end 
		    it "add a new transfer_zone" do
		     
		     expect{ post :change_to_transfer_zone, intpoint_id: @i4.id}.to change(TransferZone, :count).by(1)
		   end 
		   it "devide an event into two" do
		     expect{ post :change_to_transfer_zone, intpoint_id: @i4.id}.to change(Event, :count).by(1)
		  end 
		  it "change the intermediatepoints of old event to two new ones" do 
		   e1Id=@tripdata[5].id
		   e2Id=@tripdata[6].id
		    post :change_to_transfer_zone, intpoint_id: @i4.id
		    @i1.reload
		    @i2.reload
		    @i3.reload
		    @i4.reload
		    @i5.reload
		    @i6.reload
		   expect(@i1.event).not_to eq e1Id
		    expect(@i2.event).not_to eq e1Id
		     expect(@i5.event).not_to eq e1Id
		      expect(@i3.event).not_to eq e2Id
		       expect(@i4.event).not_to eq e2Id
		        expect(@i6.event).not_to eq e2Id
		  end 
    end
    describe "get#tripdata" do
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
		    it "gets all the trips if no date params" do
		    	get :tripdata
		    	expect(assigns(:trips)).to eq [@trip]
		    end 
		    it "gets no trip for period from 2015-01-01 to 2015-10-01" do
		    		get :tripdata, date:{"startdate(3i)"=>"1","startdate(2i)"=>"1","startdate(1i)"=>"2015",
		    			                 "startdate(4i)"=>"00","startdate(5i)"=>"00",
		    			                 "enddate(3i)"=>"1","enddate(2i)"=>"10","enddate(1i)"=>"2015",
		    			                 "enddate(4i)"=>"00","enddate(5i)"=>"00"}
		    	expect(assigns(:trips)).to eq []
		    end 
		    it "gets one trip for period from 2015-10-01 to now" do
		    		get :tripdata, date: {"startdate(3i)"=>"1","startdate(2i)"=>"10","startdate(1i)"=>"2015",
		    			                 "startdate(4i)"=>"00","startdate(5i)"=>"00",
		    			                 "enddate(3i)"=>"25","enddate(2i)"=>"10","enddate(1i)"=>"2015",
		    			                 "enddate(4i)"=>"00","enddate(5i)"=>"00"}
		    	expect(assigns(:trips)).to eq [@trip]
		    end 
    end
    
    describe "POST#drag_transfer_zone_to_intpoint" do
    	 before (:each) do
    		  @request.env['HTTP_REFERER'] = 'http://localhost:3000/sessions/new'
	       	   @request.env["devise.mapping"] = Devise.mappings[:user]
	       	   @tripdata=SampleData.gdata
	       	   @user=@tripdata[0]
	       	   @tf2=@tripdata[3]
	       	   @i6=@tripdata[12]
	       	   @i5=@tripdata[11]
	       	   @i3=@tripdata[9]
	       	   sign_in @user
	       	 # @user=FactoryGirl.create(:user)
	       	 #puts @user.id
		    end 
		    
		    it "change the event of the intermediatepoints related" do
		    	 post :drag_transfer_zone_to_intpoint, transfer_zone_id: @tf2, intpoint_latLng: "(#{@i6.latitude}, #{@i6.longitude})"
		    	 expect(@i3.event).to eq @i5.event
		    end 
		    it "do not change the number of transferzones" do
		    	 expect{post :drag_transfer_zone_to_intpoint, transfer_zone_id: @tf2, intpoint_latLng: "(#{@i6.latitude}, #{@i6.longitude})"}.to change(TransferZone, :count).by(0)
		    end
    end

end