function drawTripIntermediatePoints(eventsData) {
    for(var i=0;i<eventsData.length;i++){
      var intPoints = (eventsData[i]["intermediatepoints"]).slice(1, eventsData[i]["intermediatepoints"].length - 1);
      intPoints.sort(compareTime);
      for(var j=0;j<intPoints.length;j++){
        makeIntPoint(intPoints[j]);        
      }
    }
}

function makeIntPoint(intPointData){
    var marker = new google.maps.Marker({
      position: intPointData,
      draggable:true
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
