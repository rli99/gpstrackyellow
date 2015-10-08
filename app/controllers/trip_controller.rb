class TripController < ApplicationController
   
  def verify
    t = Trip.find(params[:tripId])
    t.verified = true
    t.save
    redirect_to '/view/tripdata'
  end
    
end
