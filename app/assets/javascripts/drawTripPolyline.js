function drawTripPolyline(eventsData) {
    
    // var firstAndLastIntpointsSet = [];
    
    for(var i=0;i<eventsData.length ;i++){
        color = transportationColour(eventsData[i].transportation);
        var intPointsData = [];
        for(var j=0;j<eventsData[i]["intermediatepoints"].length;j++){
          intPointsData.push(eventsData[i]["intermediatepoints"][j]);
        }
        //console.log(i);
        //console.log(intPointsData);
        //drawEventPolyline(intPointsData, color);
        
        sortedPolylineData = getSortedPolylineData(intPointsData);
        // firstAndLastIntpointsSet.push(sortedPolylineData[0]);
        // firstAndLastIntpointsSet.push(sortedPolylineData[sortedPolylineData.length-1]);
        
        drawEventPolyline(sortedPolylineData, color);
    }
    
    //drawTripPolylineForDrag(eventsData);
    
    // console.log(firstAndLastIntpointsSet);
    
    // var sourceAndTargetArr = [];
    
    // for(var i = 0; i < firstAndLastIntpointsSet.length; i++){
    //   var source = firstAndLastIntpointsSet[i];
    //   var target = null;
    //   var sourceAndTarget = [];
    //   for(var j = 0; j < firstAndLastIntpointsSet.length; j++){
    //     if(i!=j){
    //       if(firstAndLastIntpointsSet[i]["lat"] == firstAndLastIntpointsSet[j]["lat"] && firstAndLastIntpointsSet[i]["lng"] == firstAndLastIntpointsSet[j]["lng"]){
    //         target = firstAndLastIntpointsSet[j];
    //         sourceAndTarget.push(source);
    //         sourceAndTarget.push(target);
    //         sourceAndTargetArr.push(sourceAndTarget);
    //       }
    //     }
    //   }
    // }
    
    // sourceAndTargetArr = clearDuplication(sourceAndTargetArr);
    
    // drawJointBetweenEvents(sourceAndTargetArr);
    
    // console.log(sourceAndTargetArr);
}

// --- important: draw polylinePath_for_drag ---
function drawTripPolylineForDrag(eventsData) {
    var intPointsData = [];
    for(var i = 0; i < eventsData.length; i++){
      color = '#ffffff';
      for(var j=0;j<eventsData[i]["intermediatepoints"].length;j++){
        intPointsData.push(eventsData[i]["intermediatepoints"][j]);
      }
    }
    sortedPolylineData = getSortedPolylineData(intPointsData);
    
    // drawEventPolyline(sortedPolylineData, color);
    polylinePath_for_drag = new google.maps.Polyline({
      path: sortedPolylineData,
      zIndex: -1,
      geodesic: true,
      strokeColor: color,
      strokeOpacity: 1.0,
      strokeWeight: 5
    });
    
    // for(var i = 0; i < polylineCoordinates.length; i++){
    //   polylinePath.getPath().insertAt(polylinePath.getPath().getLength(), new google.maps.LatLng(polylineCoordinates[i]["lat"], polylineCoordinates[i]["lng"]));
    // }
    
    // polylinePath.strokeColor.push('#ffffff');
    
    // polylinePath.getPath().insertAt(polylinePath.getPath().getLength(), new google.maps.LatLng(37.330634806919754, -122.0650202035904));
    // polylinePath.getPath().insertAt(polylinePath.getPath().getLength(), new google.maps.LatLng(37.331470842924574, -122.07004129886627));

    polylinePath_for_drag.setMap(map);
}

// function drawJointBetweenEvents(sourceAndTargetArr){
//   for(var i = 0; i < sourceAndTargetArr.length; i++){ 
    
//   }
// }

// function clearDuplication(sourceAndTargetArr){
//   for(var i = 0; i < sourceAndTargetArr.length; i++){
//     for(var j = 0; j < sourceAndTargetArr.length; j++){
//       if(i!=j){
//         if(sourceAndTargetArr[i][0] == sourceAndTargetArr[j][0] || sourceAndTargetArr[i][0] == sourceAndTargetArr[j][1]){
//           sourceAndTargetArr.splice(j,1);
//         }
//       }
//     }
//   }
//   return sourceAndTargetArr;
// }


function getSortedPolylineData(intPointsData){
  var polylineCoordinates = [];
  var sortedIntPointsData = intPointsData.sort(compareTime);
  for(var i=0;i<intPointsData.length;i++){
    polylineCoordinates.push(intPointsData[i]);
  }
  return polylineCoordinates;
}


function drawEventPolyline(polylineCoordinates, color){
    // console.log(intPointsData);

    // var polylineCoordinates = [];
    // var sortedIntPointsData = intPointsData.sort(compareTime);
    // for(var i=0;i<intPointsData.length;i++){
    //   polylineCoordinates.push(intPointsData[i]);
    // }
    
    console.log("polylineCoordinates: event_id :" + polylineCoordinates[0]["event_id"]);
    console.log(polylineCoordinates);
    // console.log(color);

    var polylinePath = new google.maps.Polyline({
      path: polylineCoordinates,
      draggable: true,
      // draggable: false,
      geodesic: true,
      strokeColor: color,
      strokeOpacity: 1.0,
      strokeWeight: 5
    });
    
    // for(var i = 0; i < polylineCoordinates.length; i++){
    //   polylinePath.getPath().insertAt(polylinePath.getPath().getLength(), new google.maps.LatLng(polylineCoordinates[i]["lat"], polylineCoordinates[i]["lng"]));
    // }
    
    // polylinePath.strokeColor.push('#ffffff');
    
    // polylinePath.getPath().insertAt(polylinePath.getPath().getLength(), new google.maps.LatLng(37.330634806919754, -122.0650202035904));
    // polylinePath.getPath().insertAt(polylinePath.getPath().getLength(), new google.maps.LatLng(37.331470842924574, -122.07004129886627));

    var form = "<h5>Please select a transportation before changing! </h5>"
              + "<form class='form-inline' action='/view/change_event_transportation/" + polylineCoordinates[0]["event_id"] + "' method='post'>"
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
      content: "event id: " + polylineCoordinates[0]["event_id"] + "<br/><br/>" + "Transportation: " + polylineCoordinates[0]["transportation"] + "<br/><br/>" + 
               form
    });

    polylinePath.addListener('click', function(e) {  
      infowindow.open(map);
      infowindow.setPosition(e.latLng);
    });

    polylinePath.setMap(map);
}