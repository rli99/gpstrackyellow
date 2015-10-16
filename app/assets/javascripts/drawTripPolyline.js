function drawTripPolyline(eventsData) {
    //to be checked, we added -1 but is not correct
    for(var i=0;i<eventsData.length ;i++){
      color = transportationColour(eventsData[i].transportation);
      var intPointsData = [];
      for(var j=0;j<eventsData[i]["intermediatepoints"].length;j++){
        intPointsData.push(eventsData[i]["intermediatepoints"][j]);
      }
      drawEventPolyline(intPointsData, color);
    }
}

function drawEventPolyline(intPointsData, color){
    // console.log(intPointsData);

    var polylineCoordinates = [];
    var sortedIntPointsData = intPointsData.sort(compareTime);
    for(var i=0;i<intPointsData.length;i++){
      polylineCoordinates.push(intPointsData[i]);
    }

    polylinePath = new google.maps.Polyline({
      path: polylineCoordinates,
      geodesic: true,
      strokeColor: color,
      strokeOpacity: 1.0,
      strokeWeight: 5
    });

    var form = "<h5>Please select a transportation before changing! </h5>"
              + "<form class='form-inline' action='/view/change_event_transportation/" + intPointsData[0]["event_id"] + "' method='post'>"
              + '<div class="form-group">'
              + '<select name="transportation" class="form-control">'
              + '<option value="empty"></option>'
              + '<option value="walking">walking</option>'
              + '<option value="car">car</option>'
              + '<option value="tram">tram</option>'
              + '</select>'
              + '</div>'
              + '<div class="form-group">'
              + "<button type = 'submit' class = 'btn btn-success'> Change the transportation </button>"
              + '</div>'
              + "</form>";

    var infowindow = new google.maps.InfoWindow({      
      content: //"event id: " + intPointsData[0]["event_id"] + "<br/><br/>" + "Transportation: " + intPointsData[0]["transportation"] + "<br/><br/>" + 
               form
    });

    polylinePath.addListener('click', function(e) {  
      infowindow.open(map);
      infowindow.setPosition(e.latLng);
    });

    polylinePath.setMap(map);
}