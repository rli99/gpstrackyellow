function drawTripTransferZone(eventsData){
    for(var i=0;i<eventsData.length;i++){
      drawEventTransferZone(eventsData[i],0);
    }
    drawEventTransferZone(eventsData[eventsData.length-1],1);
}


function drawEventTransferZone(eventData, index){
      pointsData = eventData["transferzones"];
      pointsData.sort(compareTime);
      makeTransferZone(pointsData[index]);
}


function makeTransferZone(transferZoneData){    

    var image = 'http://vignette3.wikia.nocookie.net/farmville/images/9/9b/Purple_Flag-icon.png/revision/latest/scale-to-width-down/50?cb=20100110191552';

    var marker = new google.maps.Marker({
        position: transferZoneData,
        draggable:true,
        icon: image
      });

    var event_ids_str = "";
    for(var i = 0; i < transferZoneData["event_ids"].length; i++){
      if (i == transferZoneData["event_ids"].length - 1) {
        event_ids_str += transferZoneData["event_ids"][i];
      }else{
        event_ids_str += transferZoneData["event_ids"][i] + ", ";
      }      
    } 

    var form = ""

    if(transferZoneData["event_ids"].length == 2){
      form = "Please select a transportation before you delete this trasfer zone! <br/><br/>"
            + "<form action='/view/delete_transfer_zone/" + transferZoneData["id"] + "' method='post'>"
            + '<select name="transportation">'
            + '<option value="walking">walking</option>'
            + '<option value="car">car</option>'
            + '<option value="tram">tram</option>'
            + '</select>'
            + "<button type = 'submit'> delete this transfer zone </button>"
            + "</form>";
    }else{
      form = "This is the first/last transferzone, so it is not allowed to delete it."
    }


      
    var infowindow = new google.maps.InfoWindow({ 
      content: "transfer_zone id: " + transferZoneData["id"] + "<br/><br/>" 
             + "event_ids: " + event_ids_str + "<br/><br/>" + form 
    });

    marker.addListener('click', function(e) {
      infowindow.open(map,marker);
      console.log(transferZoneData);
    });

    marker.setMap(map);

    if (marker.getPosition() !== undefined) {
      bounds.extend(marker.getPosition());
    }
}

