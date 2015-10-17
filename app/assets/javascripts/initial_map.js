 function initMap() {
    // map = new google.maps.Map(document.getElementById('map'), {
    //     center: {lat: -37.810868914072984, lng: 144.96597290039062},
    //     zoom: 10
    // });
    
    map = new google.maps.Map(document.getElementById("map"), {
        center: new google.maps.LatLng(-37.810868914072984, 144.96597290039062),
        zoom: 10
    });

    // map.addListener('click', function(e) {
    //   console.log(e.latLng);
    // });
    
    drawTripIntermediatePoints(eventsData);
    drawTripPolyline(eventsData);
    drawTripTransferZone(eventsData);
    map.fitBounds(bounds);
    
  }
  