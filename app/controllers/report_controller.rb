class ReportController < ApplicationController
   
    def index
    end
    
    
    
    def show
        puts "----------report show ---------------"
        puts params

     fromtime = params[:fromtime]
     fromtime1 = Time.new( fromtime["fromtime1(1i)"].to_i, fromtime["fromtime1(2i)"].to_i, fromtime["fromtime1(3i)"].to_i,  
                     fromtime["fromtime1(4i)"].to_i, fromtime["fromtime1(5i)"].to_i).to_s
     
     totime = params[:totime]
     totime1 = Time.new( totime["totime1(1i)"].to_i, totime["totime1(2i)"].to_i, totime["totime1(3i)"].to_i, 
                     totime["totime1(4i)"].to_i, totime["totime1(5i)"].to_i).to_s
 
     @tripresult=[] 
     @eventresult=[]
     @walking = 0
     @tram = 0
     @car = 0
     @walkingtotalespeed = 0
     @tramtotalespeed = 0
     @cartotalespeed = 0
     
       puts "----------aaaaaaaaa---------------"
        Trip.all.each do |t|
            
             puts "----------aaaaaaaaa if outside---------------"
              puts t
	          triptime1 = t.events[0].intermediatepoints[0].time
	          triptime2 = t.events[-1].intermediatepoints[-1].time
	            if triptime2 < totime1 && triptime1 > fromtime1
	                 puts "----------aaaaaaaaa if inside ---------------"
	                 puts t
	                 @tripresult.push(t)
	            end
	    end
	    
	    @tripresult.each do |t|
	        t.events.each do|e|
	        @eventresult.push(e)
	        end
	    end 
	    
	    @eventresult.each do |t|
	        if t.transportation = "walking"
	            @walking += 1
	            @walkingtotalduration = ((t.intermediatepoints[-1].time - t.intermediatepoints[0].time)/3600).to_f
	             t.intermediatepoints.each do |e|
	                 @walkingtotalespeed += e.speed.at(0..-5).to_f
	             end
	             @walkingavgduration = @walkingtotalduration/@walking
	             @walkingavgspeed = @walkingtotalespeed/@walking
	             @walkingtotaldistance = @walkingavgspeed*@walkingtotalduration
	             @walkingavgdistance = @walkingtotaldistance/@walking
	        end 
	        
	        if t.transportation = "car"
	            @car += 1
	            @cartotalduration = ((t.intermediatepoints[-1].time - t.intermediatepoints[0].time)/3600).to_f
	             t.intermediatepoints.each do |e|
	                 @cartotalespeed += e.speed.at(0..-5).to_f
	             end
	             @caravgduration = @cartotalduration/@car
	             @caravgspeed = @cartotalespeed/@car
	             @cartotaldistance = @caravgspeed*@cartotalduration
	             @caravgdistance = @cartotaldistance/@car
	        end 
	        
	        if t.transportation = "tram"
	            @tram += 1
	            @tramtotalduration = ((t.intermediatepoints[-1].time - t.intermediatepoints[0].time)/3600).to_f
	             t.intermediatepoints.each do |e|
	                 @tramtotalespeed += e.speed.at(0..-5).to_f
	             end
	             @tramavgduration = @tramtotalduration/@tram
	             @tramavgspeed = @tramtotalespeed/@tram
	             @tramtotaldistance = @tramavgspeed*@tramtotalduration
	             @tramavgdistance = @tramtotaldistance/@tram
	        end 
	    end 
	   
      #number of trips  
     @tripresultcount = @tripresult.count()
     
     arrtripdistance = Array.new
     arrtripduration = Array.new
     arrtripavgSpeed = Array.new
     @tripresult.each do |trip|
         
         arrtripdistance << (trip.distance.at(0..-3)).to_f
         arrtripduration << (trip.duration.at(0..-2)).to_f
         arrtripavgSpeed << (trip.avgSpeed.at(0..-5)).to_f
     end 
     
     #total distance, duration, avgspeed of trips
     @tripresultsumdistance = sum(arrtripdistance)
     @tripresultsumduration = sum(arrtripduration)
     @tripresultsumavgSpeed = sum(arrtripavgSpeed)
       
     # average of distance, duration, avgspeed of trips
     @avetripresultdistance = @tripresultsumdistance/@tripresultcount
     @avetripresultduration = @tripresultsumduration/@tripresultcount
     @avetripresultavgSpeed = @tripresultsumavgSpeed/@tripresultcount

    end
    
    def sum(arr)
        
		summary=0.0
		arr.each{ |val| summary = summary + val}
	    return summary
    end 
end 
    	
	
    
 
