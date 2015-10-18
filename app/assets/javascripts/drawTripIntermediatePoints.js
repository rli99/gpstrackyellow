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

var mapIcon = new google.maps.MarkerImage(
    // "https://lh4.ggpht.com/Tr5sntMif9qOPrKV_UVl7K8A_V3xQDgA7Sw_qweLUFlg76d_vGFA7q1xIKZ6IcmeGqg=w300",
    // "http://www.clker.com/cliparts/D/K/l/x/c/2/map-marker-hi.png",
    "http://www.clker.com/cliparts/y/K/J/U/l/Z/black-dot-md.png",
    //"images/intpoint.png",
    null, /* size is determined at runtime */
    null, /* origin is 0,0 */
    new google.maps.Point(4, 4), /* anchor is bottom center of the scaled image */
    new google.maps.Size(8, 8)
);  


function makeIntPoint(intPointData){
    var marker = new google.maps.Marker({
      position: intPointData,
      icon: mapIcon,
      draggable:true,
      zindex: 1,
      optimized: false
    });

    var form_change_transportation = "<form action='/view/change_event_transportation/" + intPointData["event_id"] + "' method='post'>"
            + '<select name="transportation" class="form-control">'
            + '<option value="walking">walking</option>'
            + '<option value="car">car</option>'
            + '<option value="tram">tram</option>'
            + '</select>'
            + "<button type = 'submit' class='btn btn-primary'> Change the transportation </button>"
            + "</form>";

    var form_to_transferzone = "<form action='/view/change_to_transfer_zone/" + intPointData["id"] + "' method='post'>"
            + "<button type = 'submit' class='btn btn-primary'> Change to a transferzone </button>"
            + "</form>";

    var infowindow = new google.maps.InfoWindow({      
      content: "<h5> Transportation: " + intPointData["transportation"] + "</h5>" 
             //+ "event id: " + intPointData["event_id"] + "<br/><br/>" 
             //+ "intpoint id: " + intPointData["id"] + "<br/><br/>" 
             //+ form_change_transportation + "<br/>" 
             + form_to_transferzone
    });

    marker.addListener('click', function(e) {
      infowindow.open(map,marker);
      console.log(marker.zIndex);
    });

    marker.setMap(map);
}
