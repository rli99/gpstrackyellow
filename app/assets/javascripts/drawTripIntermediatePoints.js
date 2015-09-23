function drawTripIntermediatePoints(eventsData) {
    for(var i=0;i<eventsData.length;i++){
      for(var j=1;j<eventsData[i]["intermediatepoints"].length-1;j++){
        makeIntPoint(eventsData[i]["intermediatepoints"][j]);        
      }
    }
}

function makeIntPoint(intPointData){
    var marker = new google.maps.Marker({
      position: intPointData 
    });

    var form = "<form action='/view/change_event_transportation/" + intPointData["event_id"] + "' method='post'>"
            + '<select name="transportation">'
            + '<option value="walking">walking</option>'
            + '<option value="car">car</option>'
            + '<option value="tram">tram</option>'
            + '</select>'
            + "<button type = 'submit'> Change the transportation </button>"
            + "</form>";

    var infowindow = new google.maps.InfoWindow({      
      content: "event id: " + intPointData["event_id"] + "<br/><br/>" + "Transportation: " + intPointData["transportation"] + "<br/><br/>" + form
    });

    marker.addListener('click', function(e) {

      infowindow.open(map,marker);
    });

    marker.setMap(map);
}
