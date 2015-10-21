class ViewController < ApplicationController
	
	before_filter :authenticate_user!
	
	def tripdata
	  if params[:date]
	    @trips = []
	    @startdate = DateTime.new(params[:date]["startdate(1i)"].to_i, 
                        params[:date]["startdate(2i)"].to_i,
                        params[:date]["startdate(3i)"].to_i,
                        params[:date]["startdate(4i)"].to_i,
                        params[:date]["startdate(5i)"].to_i)
	    @enddate = DateTime.new(params[:date]["enddate(1i)"].to_i, 
                  params[:date]["enddate(2i)"].to_i,
                  params[:date]["enddate(3i)"].to_i,
                  params[:date]["enddate(4i)"].to_i,
                  params[:date]["enddate(5i)"].to_i)
	    Trip.all.each do |t|
	      triptime = t.events[0].intermediatepoints[0].time
	      if triptime < @enddate && triptime > @startdate
	        @trips.push(t)
	      end
	    end
	  else
	    @trips = current_user.trips.order("id ASC")
	  end
	end
	
	def profile
	  @user = User.find_by(id: current_user.id)
	end
  
  def update
    user = User.find_by(id: current_user.id)
    user.update(user_params)
    if user.save
      redirect_to '/profile', notice: 'Your profile has been successfully updated.'
    else
      redirect_to '/profile', alert: 'Your profile could not be updated.'
    end
  end
  
	def gmap
		@tripId = params[:trip_id]
		if Trip.find_by(id: params[:trip_id])

			events = Trip.find_by(id: params[:trip_id]).events

			@hash_eventsData = []

			events.each do |event|
				data = {id: event.id, transportation: event.transportation, trip_id: event.trip_id}

				data[:transferzones] = []
				transferzones = event.transfer_zones
				transferzones.each do |zone|
					# some kind of bug maybe
					data[:transferzones].push({event_ids: zone.event_ids, id: zone.id, lat: zone.latitude.to_f, lng: zone.longitude.to_f, alt: zone.altitude.to_f, 
						time: zone.time})
				end

				data[:intermediatepoints] = []
				intpoints = event.intermediatepoints
				intpoints.each do |point|
					data[:intermediatepoints].push({transportation: event.transportation, event_id: point.event_id, id: point.id, lat: point.latitude.to_f, lng: point.longitude.to_f, alt: point.altitude.to_f, 
						time: point.time})
				end
				@hash_eventsData.push(data)
			end
		end		

	end

	def change_event_transportation
	  puts "--------change_event_transportation----------"

    if params[:transportation] == "empty"
      flash[:alert] = "ERROR: You did not choose a transportation when changing a event!"
    else
      e = Event.find_by(id: params[:event_id])
  		e.transportation = params[:transportation]
  		e.save
    end
		
		respond_to do |format|
	      format.html {
	        redirect_to(:back)
	      }
	      format.js
	      format.json
    end
	end

	def delete_transfer_zone
	  puts "-------- delete_transfer_zone ----------"
      
    if params[:transportation] == "empty"
      flash[:alert] = "ERROR: You did not choose a transportation when deleting a transfer zone!"
    else
      real_delete_transfer_zone(params[:transfer_zone_id], params[:transportation])
    end

  	respond_to do |format|
  	   format.html {
  	     redirect_to(:back)
  	   }
  	   format.js
  	   format.json
    end
	end
  
  def real_delete_transfer_zone(params_transfer_zone_id, params_transportation)
      puts "-------- real_delete_transfer_zone ----------"
    
      # --- get the transfer zone
  		#tf = TransferZone.find_by(id: params[:transfer_zone_id])
  		tf = TransferZone.find_by(id: params_transfer_zone_id)
  
      # --- we only allow user to delete the transferzone that is not the start and the end,
      #     for this step, a transfer zone must have 2 events,
      #     get these 2 events
  		e1 = Event.find_by(id: tf.event_ids[0])
  		e2 = Event.find_by(id: tf.event_ids[1])
  		
  		puts e1.intermediatepoints.length
  	  puts e2.intermediatepoints.length

      # --- get the transferzone ids of the 2 events and ignore the one we want to delete
      arr_transfer_zone_id = []
      e1.transfer_zone_ids.each do |transfer_zone_id|
        if transfer_zone_id != tf.id
          arr_transfer_zone_id.push(transfer_zone_id)
        end 
      end
      e2.transfer_zone_ids.each do |transfer_zone_id|
        if transfer_zone_id != tf.id
          arr_transfer_zone_id.push(transfer_zone_id)
        end 
      end
      
      # puts '+++++++++qkqkkqkqkqk+++++++++'
      # p arr_transfer_zone_id
      # puts '+++++++++qkqkkqkqkqk+++++++++'

=begin
    	# puts '!!!!!!!!!!!!!------------'
    	check_arr = []
    	uniq_transfer_zones = []
    	arr_transfer_zone_id.each do |point|
    		t = TransferZone.find_by(id: point)
    		if !check_arr.include? t["time"]
    			uniq_transfer_zones.push(point)
    			check_arr.push(t["time"])
    		else
    			t.destroy
    		end
    	end
    	# puts arr_transfer_zone_id
    	# puts uniq_transfer_zones
    	# puts '!!!!!!!!!!!!---------------'

    	arr_transfer_zone_id = uniq_transfer_zones
=end

        # --- generate a new events 
  		  e_new = Event.new	
        e_new.transportation = params_transportation
        e_new.trip_id = e1.trip_id 
        #e_new.transfer_zone_ids = arr_transfer_zone_id
        e_new.save
        
        #puts '+++++++++qkqkkqkqkqk+++++++++'
        #p e_new
        #puts '+++++++++qkqkkqkqkqk+++++++++'

        # --- get the other two transfer zones of the new event
        tf1 = TransferZone.find_by(id: arr_transfer_zone_id[0])
        tf2 = TransferZone.find_by(id: arr_transfer_zone_id[1])

        #puts '++++++++++++++++++'
        #p tf1.event_ids
        #p tf2.event_ids
        #p e_new.transfer_zone_ids
        #puts '++++++++++++++++++'

      	if tf1.event_ids.length == 1
      		tf1.event_ids = [e_new.id]
      	elsif tf1.event_ids.length == 2
      		arr_event_ids = []
      		tf1.event_ids.each do |event_id|
      			if event_id != e1.id
      				arr_event_ids.push(event_id)
      			end
      		end
      		arr_event_ids.push(e_new.id) # (1,x)
      		tf1.event_ids = arr_event_ids
      	else
      		puts "Error: tf1 transferzone is related to more than 2 events or no event"
      	end

      	if tf2.event_ids.length == 1
      		tf2.event_ids = [e_new.id]
      	elsif tf2.event_ids.length == 2
      		arr_event_ids = []
      		arr_event_ids.push(e_new.id) # (x,4)
      		tf2.event_ids.each do |event_id|
      			if event_id != e2.id
      				arr_event_ids.push(event_id)
      			end
      		end      		
      		tf2.event_ids = arr_event_ids
      	else
      		puts "Error: tf2 transferzone is related to more than 2 events or no event"
      	end

      	#puts '-----------------------'
      	#p tf1.event_ids
      	#p tf2.event_ids
      	#p e_new.transfer_zone_ids
        #puts '-----------------------'

      	tf1.save
		    tf2.save
      	# === finish the transfer zone part

        # --- add intermediate points to the new event---------------------------------------------------------------------
        puts "--- add intermediate points to the new event------------------------------------------------"
        
      	arr_intpoint_id = []

        e1.intermediatepoint_ids.each do |intpoint_id|
          	arr_intpoint_id.push(intpoint_id)
      	end
      	e2.intermediatepoint_ids.each do |intpoint_id|
          	arr_intpoint_id.push(intpoint_id)
      	end
      	
      	p arr_intpoint_id
  
      	check_arr = []
      	uniq_intpoints = []
      	
      	arr_intpoint_id.each do |point|
      		i = Intermediatepoint.find_by(id: point)
      		if !check_arr.include? i["time"]
      			uniq_intpoints.push(point)
      			check_arr.push(i["time"])
      		else
      			i.destroy
      		end
      	end
  
      	uniq_intpoints.each do |intpoint_id|
      		i = Intermediatepoint.find_by(id: intpoint_id)
      		i.event_id = e_new.id
      		i.save
      	end
      
      	# === finish the intermediate point part---------------------------------------------------------------------------
  
    		tf.destroy
    		e1.destroy
    		e2.destroy

  end
  
  def change_to_transfer_zone
    puts "--------change_to_transfer_zone----------"

    the_intpoint = Intermediatepoint.find_by(id: params[:intpoint_id])
    trip = the_intpoint.event.trip

    trip.events.each do |event|
      event.transfer_zones.each do |tf|
        # puts the_intpoint.latitude
        # puts tf.latitude
        if the_intpoint != nil && the_intpoint.latitude == tf.latitude && the_intpoint.longitude == tf.longitude
          p tf
          the_intpoint = nil
          break
        end
      end
    end
    
    if the_intpoint != nil
      real_change_to_transfer_zone(params[:intpoint_id])
    else
      puts "--- ERROR: It is a transfer zone!"
      flash[:alert] = "ERROR: It is a transfer zone!"
    end

    respond_to do |format|
        format.html {
          redirect_to(:back)
        }
        format.js
        format.json
    end
    
  end
  
  def real_change_to_transfer_zone(params_intpoint_id)
    puts "--------real_change_to_transfer_zone----------"
    
    # --- find the intpoint and event ---
    i_old = Intermediatepoint.find_by(id: params_intpoint_id)
    e_old = i_old.event
    
    # --- make 2 new events --- *
    e1 = Event.new
    e2 = Event.new
    e_arr = [e1,e2]
    e_arr.each do |event|
      event.transportation = e_old.transportation
      event.trip_id = e_old.trip_id
      event.save
    end
    
    # --- make 2 copies of the intpoint --- *
    i1 = Intermediatepoint.new
    i2 = Intermediatepoint.new
    i_arr = [i1,i2]
    i_arr.each do |intpoint|
      intpoint.time = i_old.time
      intpoint.latitude = i_old.latitude
      intpoint.longitude = i_old.longitude
      intpoint.altitude = i_old.altitude
      #intpoint.event_id = i_old.event_id
      intpoint.speed = i_old.speed
      intpoint.save
    end
    
    # --- make a new transfer zone --- *
    tf_new = TransferZone.new
    tf_new.time = i_old.time
    tf_new.latitude = i_old.latitude
    tf_new.longitude = i_old.longitude
    tf_new.altitude = i_old.altitude
    # add event_ids, 
    # after you do this, 
    # the tf.id is automatically added to the e1 and e2' transfer_zone_ids
    tf_new.event_ids = [e1.id,e2.id]
    tf_new.save
    
    puts "--- ex.intermediatepoint ids  ---"
    p e1.id, e1.intermediatepoint_ids
    p e2.id, e2.intermediatepoint_ids
    
    # --- add intermediate points to 2 events --- *
    i1.event_id = e1.id
    i1.save
    i2.event_id = e2.id # after doing this, ix is automatically added to ex.intermediatepoints 
    i2.save
    e_old.intermediatepoints.each do |intpoint|
      if intpoint.time < i_old.time
        intpoint.event_id = e1.id
      elsif intpoint.time > i_old.time
        intpoint.event_id = e2.id
      else  
          # do nothing
      end
      intpoint.save
    end
    
    puts "--- ex.intermediatepoint ids  ---"
    p e1.id, e1.intermediatepoint_ids
    p e2.id, e2.intermediatepoint_ids
    
    puts "--- ex.intermediatepoint ids in data base ---"
    p e1.id, Event.find(e1.id).intermediatepoint_ids
    p e2.id, Event.find(e2.id).intermediatepoint_ids
    
    
    # --- add transfer zones to 2 events ---
    tf1 = TransferZone.find(e_old.transfer_zones[0].id)
    tf2 = e_old.transfer_zones[1]
    tf_arr = [tf1,tf2]
    
    puts "----  tfx event_ids  ----"
    p tf1.id, tf1.event_ids
    p tf2.id, tf2.event_ids
    
    puts "jian qu" 
    puts e_old.id
    
    tf1.event_ids -= [e_old.id]
    tf2.event_ids -= [e_old.id]
    
    puts "----  tfx event_ids after jian qu ----"
    p tf1.id, tf1.event_ids
    p tf2.id, tf2.event_ids
    
    tf_arr.each do |tf|
      e_arr.each do |event|
        event.intermediatepoints.each do |intpoint|
          if tf.latitude == intpoint.latitude && tf.longitude == intpoint.longitude
            event.transfer_zone_ids += [tf.id]
            tf.event_ids += [event.id]
          end
        end
      end
    end
    
    puts "----  tfx event_ids after jia shang  ----"
    p tf1.id, tf1.event_ids
    p tf2.id, tf2.event_ids

    puts "======== ex intermediatepoint ids ======="
    p e1.id, e1.intermediatepoint_ids
    p e2.id, e2.intermediatepoint_ids
    
    puts "======== ex transfer zone ids ========"
    p e1.id, e1.transfer_zone_ids
    p e2.id, e2.transfer_zone_ids
    
    puts "======== transfer zone event_ids ========"
    p tf1.id, tf1.event_ids
    p tf2.id, tf2.event_ids
    p tf_new.id, tf_new.event_ids
    
    # --- save ---
    tf1.save
    tf2.save
    tf_new.save
    
    # --- destroy the intpoint and old event ---
    i_old.destroy
    e_old.destroy
    
    # --- fix the tfx.event_ids bug ---
    
    # tfp = TransferZone.find(tf1.id)
    # tfp.event_ids = []
    # tfp.event_ids = tf1.event_ids
    # tfp.save
   
    # temp_tf2_event_ids = tf2.event_ids
    # tf2.event_ids = []
    # tf2.event_ids = temp_tf2_event_ids
    # tf2.save
    
    tf_arr.each do |tf|
      temp_tf_event_ids = tf.event_ids
      tf.event_ids = []
      tf.event_ids = temp_tf_event_ids
      tf.save
    end
    
    
    puts "======== transfer zone event_ids ========"
    
    p tf1.id, tf1.event_ids
    
    p tf1.id, TransferZone.find(tf1.id).event_ids
    
    p tf2.id, tf2.event_ids
    
    p tf2.id, TransferZone.find(tf2.id).event_ids
    
    p tf_new.id, tf_new.event_ids
    
    p tf_new.id, TransferZone.find(tf_new.id).event_ids
    
  end
  
  def drag_transfer_zone_to_intpoint
    puts "--------drag_transfer_zone_to_intpoint----------"
    
    trip_id = TransferZone.find_by(id: params[:transfer_zone_id]).events[0].trip_id
    nearest_intpoint = find_nearest_intpoint(trip_id, params[:intpoint_latLng])

    # Added to fix dragging point. Before it was just 'walking' passed to real_delete_transfer_zone
    # This finds out what transportation we need to set for real_delete_transfer_zone below
    
    oldTransportation = ''
    if nearest_intpoint != nil
      event_one = TransferZone.find_by(id: params[:transfer_zone_id]).events[0]
      event_two = TransferZone.find_by(id: params[:transfer_zone_id]).events[1]
      if event_one.intermediatepoints.include? nearest_intpoint
        oldTransportation = event_two.transportation
      elsif event_two.intermediatepoints.include? nearest_intpoint
        oldTransportation = event_one.transportation
      else
        puts 'error in locating correct event for dragging transfer zone'
      end
    end
    
    # puts "oldTransportation: " + oldTransportation

    if nearest_intpoint != nil
      # We have swapped the below two lines. 
      # Both produce an error. In the current order, we get the correct transportation, but there are extra lines being drawn
      # In the old order, the transportation is not correct.
      # We believe this should be the correct order. The error is probably not here.
      # It is very possible that there is an error in real_change_to_transfer_zone or real_delete_transfer_zone
      
      real_change_to_transfer_zone(nearest_intpoint.id)
      real_delete_transfer_zone(params[:transfer_zone_id], oldTransportation)
      
      # real_delete_transfer_zone(params[:transfer_zone_id], "oldTransportation")
      # real_change_to_transfer_zone(nearest_intpoint.id)
      
    else
      puts "--- ERROR: the nearest intpoint is a transfer zone!"
      flash[:alert] = "ERROR: The nearest intpoint is a transfer zone!"
    end
    
    respond_to do |format|
      format.html {
        redirect_to(:back)
      }
      format.js
      format.json
    end
  end
  
  def find_nearest_intpoint(trip_id, intpoint_latLng) 
    puts "--------find_nearest_intpoint----------"
    # puts trip_id
    # puts intpoint_latLng
    
    intpoint_latLng_hash = transfer_latLngString_to_hash(intpoint_latLng)
    # p intpoint_latLng_hash
    
    trip = Trip.find_by(id: trip_id)
    start_intpoint =  trip.events[0].intermediatepoints[0]
    the_intpoint = start_intpoint
    min_distance = (start_intpoint.latitude.to_f - intpoint_latLng_hash[:lat].to_f) ** 2 + (start_intpoint.longitude.to_f - intpoint_latLng_hash[:lng].to_f) ** 2
    
    trip.events.each do |event|
      event.intermediatepoints.each do |intpoint|
        distance = (intpoint.latitude.to_f - intpoint_latLng_hash[:lat].to_f) ** 2 + (intpoint.longitude.to_f - intpoint_latLng_hash[:lng].to_f) ** 2
        if distance < min_distance
          min_distance = distance
          the_intpoint = intpoint
        end
      end
    end

    trip.events.each do |event|
      event.transfer_zones.each do |tf|
        # puts the_intpoint.latitude
        # puts tf.latitude
        if the_intpoint != nil && the_intpoint.latitude == tf.latitude && the_intpoint.longitude == tf.longitude
          # p tf
          the_intpoint = nil
          break
        end
      end
    end
    
    return the_intpoint
    
  end
  
  def transfer_latLngString_to_hash(intpoint_latLng)
    intpoint_latLng_hash = {}
    intpoint_latLng_hash[:lat] = intpoint_latLng.split(",")[0].split("(")[1]
    intpoint_latLng_hash[:lng] = intpoint_latLng.split(",")[1].split(")")[0]
    return intpoint_latLng_hash
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :name, :surname, :bithday, :address)
  end

end
