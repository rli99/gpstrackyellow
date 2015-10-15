class TripController < ApplicationController
   
  before_filter :authenticate_user!
   
  def verify
    t = Trip.find(params[:tripId])
    t.verified = true
    if t.save
      redirect_to '/view/tripdata', notice: 'Trip successfully verified.'
    else
      redirect_to '/view/tripdata', alert: 'Trip could not be verified.'
    end
  end
  
  def destroy
    trip = Trip.find(params[:trip_id])
    events = trip.events
    events.each do |e|
      e.intermediatepoints.destroy_all
      e.transfer_zones.destroy_all
      e.destroy
    end
    if trip.destroy
      redirect_to '/view/tripdata', notice: 'Trip successfully deleted.'
    else
      redirect_to '/view/tripdata', alert: 'Trip could not be deleted.'
    end
  end
    
end
