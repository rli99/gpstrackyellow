require 'rails_helper'

class SampleData < ActiveRecord::Base
    	def self.gdata  
    	    
    	     # ----- add a user  ------
    	     user=FactoryGirl.create(:user)
    	    
    	      # ----- add 3 transferZones  ------
    	      tf1=FactoryGirl.create(:transferZone,
    	                               latitude: "-37.79025",
                                       longitude: "145.0415",
                                       altitude: "333" )
                                       
            tf2=FactoryGirl.create(:transferZone,
    	                               latitude: "-35.3196",
                                       longitude: "149.1943",
                                       altitude: "555555555" )
                                       
            tf3=FactoryGirl.create(:transferZone,
    	                               latitude: "-33.8650",
                                       longitude: "151.2094",
                                       altitude: "333" )
    	      
    	       # ----- add one trip  ------
    	      trip=FactoryGirl.create(:trip,
    	                               user: user)
    	                               
    	        # ----- add 2 events  ------
    	        e1=FactoryGirl.create(:event,
    	                                   trip: trip)
    	       e1.transfer_zone_ids = [tf1.id,tf2.id]
    	       
    	        e2=FactoryGirl.create(:event,
    	                                   transportation: 'car',
    	                                   trip: trip)
    	       e2.transfer_zone_ids = [tf2.id,tf3.id]
    	       
    	        # ----- add 6 intermediatepoints  ------
    	        i1=FactoryGirl.create(:intermediatepoint,
    	                               latitude: "-37.79025",
                                       longitude: "145.0415",
                                       altitude: "333",
                                       event: e1)
                                       
                 i2=FactoryGirl.create(:intermediatepoint,
    	                               latitude: "-35.3196",
                                       longitude: "149.1943",
                                       altitude: "333",
                                       event: e1)
                                       
                 i3=FactoryGirl.create(:intermediatepoint,
    	                               latitude: "-35.3196",
                                       longitude: "149.1943",
                                       altitude: "333",
                                       event: e2)
                                       
                 i4=FactoryGirl.create(:intermediatepoint,
    	                               latitude: "-33.8650",
                                       longitude: "151.2094",
                                       altitude: "333",
                                       event: e2)
                                       
                 i5=FactoryGirl.create(:intermediatepoint,
    	                               latitude: "-36.5648",
                                       longitude: "147.3706",
                                       altitude: "333",
                                       event: e1)
                                       
                 i6=FactoryGirl.create(:intermediatepoint,
    	                               latitude: "-34.6016",
                                       longitude: "150.3369",
                                       altitude: "333",
                                       event: e2)
            
              # ----- return all the information as an array  ------
              tripdata=[user, trip, tf1, tf2, tf3, e1, e2, i1, i2, i3, i4, i5, i6]
    	     return tripdata
    	end
end