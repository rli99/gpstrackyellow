class TripController < ApplicationController
   
  def verify
    t = Trip.find(params[:tripId])
    t.verified = true
    t.save
    redirect_to '/view/tripdata'
  end
  
  def destroy
    trip = Trip.find(params[:trip_id])
    events = trip.events
    events.each do |e|
      e.intermediatepoints.destroy_all
      e.transfer_zones.destroy_all
      e.destroy
    end
    trip.destroy
    redirect_to '/view/tripdata'
    # if t.destroy
      
    # end
  end
    
end
