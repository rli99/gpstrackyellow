function drawTripIntermediatePoints(eventsData) {
    for(var i=0;i<eventsData.length;i++){
      var intPoints = eventsData[i]["intermediatepoints"].slice(1, eventsData[i]["intermediatepoints"].length);
      intPoints.sort(compareTime);
      for(var j=1;j<eventsData[i]["intermediatepoints"].length-1;j++){
        makeIntPoint(eventsData[i]["intermediatepoints"][j]);        
      }
    }
}

function compareTime(a, b) {
  if (a["time"] < b["time"]) {
    return -1
  } else if (a["time"] == b["time"]) {
    return 0
  } else {
    return 1
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
