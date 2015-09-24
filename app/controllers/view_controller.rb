class ViewController < ApplicationController
	def map
	end

	def tripdata
		@trips = Trip.all
	end

	def user
		
	end

	def gmap
		
		if Trip.last()
			events = Trip.last().events

			@hash_eventsData = []

			events.each do |event|
				data = {id: event.id, transportation: event.transportation, trip_id: event.trip_id}

				data[:transferzones] = []
				transferzones = event.transfer_zones
				transferzones.each do |zone|
					# some kind of bug maybe
					data[:transferzones].push({event_ids: zone.event_ids, id: zone.id, lat: zone.latitude.to_f, lng: zone.longitude.to_f, alt: zone.altitude.to_f})
				end

				data[:intermediatepoints] = []
				intpoints = event.intermediatepoints
				intpoints.each do |point|
					data[:intermediatepoints].push({transportation: event.transportation, event_id: point.event_id, id: point.id, lat: point.latitude.to_f, lng: point.longitude.to_f, alt: point.altitude.to_f})
				end
				@hash_eventsData.push(data)
			end
		end		

	end

	def change_event_transportation
		puts "------------------"
		puts params

		e = Event.find_by(id: params[:event_id])
		e.transportation = params[:transportation]
		e.save

		respond_to do |format|
	      format.html {
	        redirect_to(:back)
	      }
	      format.js
	      format.json
    	end
	end

	def delete_transfer_zone
		puts "------------------"
		puts params

		tf = TransferZone.find_by(id: params[:transfer_zone_id])

		puts params[:transportation]
		puts tf.event_ids[0]
		puts tf.event_ids[1]

		# ==================


		e1 = Event.find_by(id: tf.event_ids[0])
		e2 = Event.find_by(id: tf.event_ids[1])
		e_new = Event.new		

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

    	check_arr = []
    	uniq_transfer_zones = []
    	arr_transfer_zone_id.each do |point|
    		t = TransferZone.find_by(id: point)
    		if !check_arr.include? i["time"]
    			uniq_transfer_zones.push(point)
    			check_arr.push(i["time"])
    		else
    			t.destroy
    		end
    	end

    	arr_transfer_zone_id = uniq_transfer_zones

    	#p arr_transfer_zone_id
        
        e_new.transportation = params[:transportation]
        e_new.trip_id = e1.trip_id
        e_new.transfer_zone_ids = arr_transfer_zone_id 

        e_new.save
        # ====finish the event side


        tf1 = TransferZone.find_by(id: arr_transfer_zone_id[0])
        tf2 = TransferZone.find_by(id: arr_transfer_zone_id[1])

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
      		puts tf1.event_ids
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
      		puts tf2.event_ids
      		puts "Error: tf2 transferzone is related to more than 2 events or no event"
      	end

      	tf1.save
		tf2.save
      	# ====finish the transfer zone side

      	arr_intpoint_id = []

        e1.intermediatepoint_ids.each do |intpoint_id|
        	arr_intpoint_id.push(intpoint_id)
    	end
    	e2.intermediatepoint_ids.each do |intpoint_id|
        	arr_intpoint_id.push(intpoint_id)
    	end
    	#p arr_intpoint_id

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
    	# ====finish the intermediate point side

		tf.destroy
		e1.destroy
		e2.destroy

		respond_to do |format|
	      format.html {
	        redirect_to(:back)
	      }
	      format.js
	      format.json
    	end
	end
	
end
