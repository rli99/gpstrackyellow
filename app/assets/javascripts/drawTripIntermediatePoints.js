function drawTripIntermediatePoints(eventsData) {
    for(var i=0;i<eventsData.length;i++){
      var intPoints = eventsData[i]["intermediatepoints"];
      intPoints.sort(compareTime);
      //intPoints = (eventsData[i]["intermediatepoints"]).slice(1, eventsData[i]["intermediatepoints"].length - 1);

      for(var j=0;j<intPoints.length;j++){
        makeIntPoint(intPoints[j]);        
      }
    }
}

var image = '/assets/int_marker.png';

function makeIntPoint(intPointData){
    var marker = new google.maps.Marker({
      position: intPointData,
      icon: image,
      draggable:true
    });

    var form_change_transportation = "<form action='/view/change_event_transportation/" + intPointData["event_id"] + "' method='post'>"
            + '<select name="transportation">'
            + '<option value="walking">walking</option>'
            + '<option value="car">car</option>'
            + '<option value="tram">tram</option>'
            + '</select>'
            + "<button type = 'submit'> Change the transportation </button>"
            + "</form>";

    var form_to_transferzone = "<form action='/view/change_to_transfer_zone/" + intPointData["id"] + "' method='post'>"
            + "<button type = 'submit'> Change to a transferzone </button>"
            + "</form>";

    var infowindow = new google.maps.InfoWindow({      
      content: "event id: " + intPointData["event_id"] + "<br/><br/>" 
             + "intpoint id: " + intPointData["id"] + "<br/><br/>" 
             + "Transportation: " + intPointData["transportation"] + "<br/><br/>" 
             + form_change_transportation + "<br/>" 
             + form_to_transferzone
    });

    marker.addListener('click', function(e) {

      infowindow.open(map,marker);
    });

    marker.setMap(map);
}
