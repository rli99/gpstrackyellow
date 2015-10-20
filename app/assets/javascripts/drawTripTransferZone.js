// function drawTripTransferZone(eventsData){
//     for(var i=0;i<eventsData.length;i++){
//       drawEventTransferZone(eventsData[i],0);
//       drawEventTransferZone(eventsData[i],1);
//     }
//     //drawEventTransferZone(eventsData[eventsData.length-1],1);
// }

function drawTripTransferZone(eventsData){
    var allTransferZones = [];
    
    for(var i = 0; i < eventsData.length; i++){
      if(i == 0){
        allTransferZones.push(eventsData[i]["transferzones"][0]);
        allTransferZones.push(eventsData[i]["transferzones"][1]);
      }else{
        if(!existInArr(allTransferZones, eventsData[i]["transferzones"][0])){
          allTransferZones.push(eventsData[i]["transferzones"][0]);
        }
        if(!existInArr(allTransferZones, eventsData[i]["transferzones"][1])){
          allTransferZones.push(eventsData[i]["transferzones"][1]);
        }
      }
    }
    
    for(var i = 0; i < allTransferZones.length; i++){
      makeTransferZone(allTransferZones[i]);
    }
}

function existInArr(arr, element){
    for(var i = 0; i < arr.length; i++){
      //console.log(arr[i]["id"]);
      if(arr[i]["id"] == element["id"]){
        return true;
      }
    }
    return false;
}


// function drawEventTransferZone(eventData, index){
//       var pointsData = eventData["transferzones"];
//       pointsData.sort(compareTime);
//       makeTransferZone(pointsData[index]);
// }


function makeTransferZone(transferZoneData){    

    var image = 'http://commons.utopia.gr/images/icons/map_marker.png';

    var marker = new google.maps.Marker({
        position: transferZoneData,
        draggable: false,
        zIndex: 2,
        optimized: false,
        icon: image,
        scale: 0.75
      });
    
    // var marker = new google.maps.Marker({
    //         position: new google.maps.LatLng(-37.787526, 145.12466),
    //         draggable: true
    //     });

    if (marker.getPosition() !== undefined) {
      bounds.extend(marker.getPosition());
    }

    var event_ids_str = "";
    if (transferZoneData !== undefined) { //fix this bug, why when you remove some transferzones transferZoneData["event_ids"] in undefined?
      for(var i = 0; i < transferZoneData["event_ids"].length; i++){
        if (i == transferZoneData["event_ids"].length - 1) {
          event_ids_str += transferZoneData["event_ids"][i];
        }else{
          event_ids_str += transferZoneData["event_ids"][i] + ", ";
        }
      }      
    } 

    var form = "";

    if(transferZoneData["event_ids"].length == 2){
      marker.draggable = true;
      form = "<h5>Please select a transportation before you delete this transfer zone! </h5>"
              + "<form class='form-inline' action='/view/delete_transfer_zone/" + transferZoneData["id"] + "' method='post'>"
              + '<div class="form-group">'
              + '<select name="transportation" class="form-control">'
              + '<option value="empty"></option>'
              + '<option value="walking">walking</option>'
              + '<option value="car">car</option>'
              + '<option value="tram">tram</option>'
              + '</select>'
              + '</div>'
              + '<div class="form-group">'
              + "<button type = 'submit' class = 'btn btn-danger'> Delete this transfer zone </button>"
              + '</div>'
              + "</form>";
    }else if (transferZoneData["event_ids"].length == 1){
      form = "<h5>This is the first/last transferzone, so you are not allowed to delete it.</h5>";
    } else {
      form = "error";
    }

    var infowindow = new google.maps.InfoWindow({ 
      content: " transferZone id: " +  transferZoneData["id"]
              +form 
    });

    marker.addListener('click', function(e) {
      infowindow.open(map,marker);
    });
      
      // marker.addListener('dragend', function(e) {
      //   var r = confirm("Are you sure to change the transfer zone to the nearest intermediate point to the current position?");
      //   if (r==true)
      //     {
      //     console.log("You pressed OK!");
      //     // console.log(e.latLng);
      //     // console.log(transferZoneData);
      //     drag_transfer_zone_to_intermediatepoint(transferZoneData, e.latLng);
      //     }
      //   else
      //     {
      //     console.log("You pressed Cancel!");
      //     window.location.reload();
      //     }
      // });

    marker.setMap(map);
      
    // console.log("----- polyline -----");
    // var flightPlanCoordinates = [
    //   {lat: 37.772, lng: -122.214},
    //   {lat: 21.291, lng: -157.821},
    //   {lat: -18.142, lng: 178.431},
    //   {lat: -27.467, lng: 153.027}
    // ];
    // console.log(polylinePath.getPath());
    // polylinePath.getPath().insertAt(polylinePath.getPath().getLength(), flightPlanCoordinates);
      
    google.maps.event.addListenerOnce(map,"projection_changed", function() {
        var snapToRoute = new SnapToRoute(map, marker, polylinePath_for_drag);
    });
      
    // marker.addListener('dragend', function(e) {
    //   var r = confirm("Are you sure to change the transfer zone to the nearest intermediate point to the current position?");
    //   if (r==true)
    //     {
    //     console.log("You pressed OK!");
    //     // console.log(e.latLng);
    //     // console.log(transferZoneData);
    //     drag_transfer_zone_to_intermediatepoint(transferZoneData, e.latLng);
    //     }
    //   else
    //     {
    //     console.log("You pressed Cancel!");
    //     window.location.reload();
    //     }
    // });



}

function drag_transfer_zone_to_intermediatepoint(transferZoneData, intpoint_latLng){
    console.log(transferZoneData);
    console.log(intpoint_latLng);
 
    // var xmlhttp;
    // if (window.XMLHttpRequest)
    // {// code for IE7+, Firefox, Chrome, Opera, Safari
    //     xmlhttp=new XMLHttpRequest();
    // }
    // else
    // {// code for IE6, IE5
    //     xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
    // }
    // var url = "";
    // console.log(url);
    // xmlhttp.open("POST",url,true);
    // xmlhttp.send();

    // xmlhttp.onreadystatechange=function()
    // {
    //     if (xmlhttp.readyState==4 && xmlhttp.status==200)
    //     {
    //         console.log(xmlhttp.responseText);
    //     }
    // }
          
    post('drag_transfer_zone_to_intpoint/' + transferZoneData.id, {intpoint_latLng :intpoint_latLng});  
}

function post(URL, PARAMS) {        
    var temp = document.createElement("form");        
    temp.action = URL;        
    temp.method = "post";        
    temp.style.display = "none";        
    for (var x in PARAMS) {        
        var opt = document.createElement("textarea");        
        opt.name = x;        
        opt.value = PARAMS[x];        
        // alert(opt.name)        
        temp.appendChild(opt);        
    }        
    document.body.appendChild(temp);        
    temp.submit();        
    return temp;        
}

