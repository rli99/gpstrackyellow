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
     @walking_events = 0
     @tram_events = 0
     @car_events = 0
     @walkingtotalespeed = 0.0
     @tramtotalespeed = 0.0
     @cartotalespeed = 0.0
     @walkingtotalduration = 0.0
     @tramtotalduration = 0.0
     @cartotalduration = 0.0
     
     
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
	        if t.transportation == "walking"
	        	@walking_events += 1
	            @walkingtotalduration += ((t.intermediatepoints[0].time - t.intermediatepoints[-1].time)/60).round(2).to_f
	             t.intermediatepoints.each do |e|
	             	@walking += 1
	                 @walkingtotalespeed += e.speed.to_f * 3.6
	             end
	             
	        end 
	        
	        if t.transportation == "car"
	        	@car_events += 1
	            @cartotalduration += ((t.intermediatepoints[0].time - t.intermediatepoints[-1].time)/60).round(2).to_f
	             t.intermediatepoints.each do |e|
	             	@car += 1
	                 @cartotalespeed += e.speed.to_f * 3.6
	             end

	        end 
	        
	        if t.transportation == "tram"
	        	@tram_events += 1
	            @tramtotalduration += ((t.intermediatepoints[0].time - t.intermediatepoints[-1].time)/60).round(2).to_f
	             t.intermediatepoints.each do |e|
	             	@tram += 1
	                 @tramtotalespeed += e.speed.to_f * 3.6
	             end
	        end 
	    end 

        @walkingavgduration = (@walkingtotalduration/@walking_events).round(2)
         @walkingavgspeed = (@walkingtotalespeed/@walking).round(2)
         @walkingtotaldistance = (@walkingavgspeed*@walkingtotalduration / 60).round(2)
         @walkingavgdistance = (@walkingtotaldistance/@walking_events).round(2)

         @caravgduration = (@cartotalduration/@car_events).round(2)
         @caravgspeed = (@cartotalespeed/@car).round(2)
         @cartotaldistance = (@caravgspeed*@cartotalduration / 60).round(2)
         @caravgdistance = (@cartotaldistance/@car_events).round(2)
	   

         @tramavgduration = (@tramtotalduration/@tram_events).round(2)
         @tramavgspeed = (@tramtotalespeed/@tram).round(2)
         @tramtotaldistance = (@tramavgspeed*@tramtotalduration / 60).round(2)
         @tramavgdistance = (@tramtotaldistance/@tram_events).round(2)
	   
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
     @tripresultsumdistance = sum(arrtripdistance).round(2)
     @tripresultsumduration = sum(arrtripduration).round(2)
     @tripresultsumavgSpeed = sum(arrtripavgSpeed).round(2)
       
     # average of distance, duration, avgspeed of trips
     @avetripresultdistance = (@tripresultsumdistance/@tripresultcount).round(2)
     @avetripresultduration = (@tripresultsumduration/@tripresultcount).round(2)
     @avetripresultavgSpeed = (@tripresultsumavgSpeed/@tripresultcount).round(2)

    end
    
    def sum(arr)
        
		summary=0.0
		arr.each{ |val| summary = summary + val}
	    return summary
    end 
end 
    	
	
    
 
