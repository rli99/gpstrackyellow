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
 
     @tripresult = Trip.find_by_sql("SELECT * FROM trips WHERE created_at >= '#{fromtime1}' AND created_at <= '#{totime1}'")
       
        print @tripresult
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
