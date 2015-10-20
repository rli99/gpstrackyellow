 function initMap() {
    // map = new google.maps.Map(document.getElementById('map'), {
    //     center: {lat: -37.810868914072984, lng: 144.96597290039062},
    //     zoom: 10
    // });
    
    map = new google.maps.Map(document.getElementById("map"), {
        center: new google.maps.LatLng(-37.810868914072984, 144.96597290039062),
        zoom: 10
    });

    map.addListener('click', function(e) {
      console.log(e.latLng);
    });
    
    drawTripIntermediatePoints(eventsData);
    drawTripPolyline(eventsData);
    drawTripPolylineForDrag(eventsData);
    drawTripTransferZone(eventsData);
    map.fitBounds(bounds);
    
    // console.log("----- polyline -----");
    // console.log(polylinePath.getPath());
    // polylinePath.getPath().insertAt(polylinePath.getPath().getLength(), new google.maps.LatLng(37.330634806919754, -122.0650202035904));
    // polylinePath.getPath().insertAt(polylinePath.getPath().getLength(), new google.maps.LatLng(37.331470842924574, -122.07004129886627));
    
  }
  