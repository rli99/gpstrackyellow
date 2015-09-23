function drawTripPolyline(eventsData) {
    //to be checked, we added -1 but is not correct
    for(var i=0;i<eventsData.length ;i++){
      var intPointsData = [];
      for(var j=0;j<eventsData[i]["intermediatepoints"].length;j++){
        intPointsData.push(eventsData[i]["intermediatepoints"][j]);
      }
      random_color = '#'+Math.floor(Math.random()*16777215).toString(16);
      drawEventPolyline(intPointsData, random_color);
    }
}

function drawEventPolyline(intPointsData, color){
    // console.log(intPointsData);

    var polylinePath;

    var polylineCoordinates = [];
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

    var form = "<form action='/view/change_event_transportation/" + intPointsData[0]["event_id"] + "' method='post'>"
            + '<select name="transportation">'
            + '<option value="walking">walking</option>'
            + '<option value="car">car</option>'
            + '<option value="tram">tram</option>'
            + '</select>'
            + "<button type = 'submit'> Change the transportation </button>"
            + "</form>";

    var infowindow = new google.maps.InfoWindow({      
      content: "event id: " + intPointsData[0]["event_id"] + "<br/><br/>" + "Transportation: " + intPointsData[0]["transportation"] + "<br/><br/>" + form
    });

    polylinePath.addListener('click', function(e) {  
      infowindow.open(map);
      infowindow.setPosition(e.latLng);
    });

    polylinePath.setMap(map);
}