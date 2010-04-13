/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
var address;
var startZoom = 17;
var map;
var dataPoints = new Array();
var distMi = Number(0);
var distKm = Number(0);
var MILES_TO_KM = 1.609;
var AUTH_TOKEN;
var displayType;
var routename;
var routetype;
var distanceFromPrev;
var prevTotDist;

function init()
{
    switch (displayType)
    {
        case 'new':
            newRoute();
            break;
        case 'show':
            showRoute();
            break;
        case 'edit':
            editRoute();
            break;
        default:
            newRoute();
            break;
    }
}

function newRoute()
{
    // initially set all the map controls to disabled.
    document.getElementById('undopoint').disabled = true;
    document.getElementById('clearmap').disabled = true;
    document.getElementById('autocenter').disabled = true;
    
    if (GBrowserIsCompatible())
    {
        map = new GMap2(document.getElementById("map"));
        var geocoder = new GClientGeocoder();
	var mapControl = new GMapTypeControl();

	map.addControl(mapControl);
	map.addControl(new GLargeMapControl());

        geocoder.getLatLng(address,
	function (point)
	{
            if (!point)
            {
            	alert(address + " not found!");
            }
            else
            {
            	map.setCenter(point, startZoom);
            }
         }
         );

         GEvent.addListener(map, "click", function(overlay, latlng)
         {
             var distanceFromPrev = Number(0);
             var prevTotDist = Number(0);
             distMi = Number(0);
             distKm = Number(0);
            // var curmarker = new GMarker(latlng, icon);
             dataPoints.push(latlng);
             //map.addOverlay(curmarker);
             drawRoute();
         }
         );
    }
}

function showRoute()
{
    if (GBrowserIsCompatible())
    {
        map = new GMap2(document.getElementById("map"));
        var geocoder = new GClientGeocoder();
	var mapControl = new GMapTypeControl();

	map.addControl(mapControl);
	map.addControl(new GLargeMapControl());

        geocoder.getLatLng(address,
	function (point)
	{
            if (!point)
            {
            	alert(address + " not found!");
            }
            else
            {
            	map.setCenter(point, startZoom);
            }
         }
         );

         // Create the map_marker
         var icon = new GIcon();
         icon.image = '/images/map_marker.png';
         icon.iconsize = new GSize(10, 10);
         icon.iconAnchor = new GPoint(5, 5);

          var prevpoint = new GLatLng();
          // plot the route
          for( var i=0; i<dataPoints.length; i++)
          {
             var latlng = dataPoints[i];
             var marker = new GMarker(latlng, icon);
             map.addOverlay(marker);
             
             if( i!=0 && dataPoints.length !=1 )
             {
                 // Create GPolylineOptions argument as an object literal.
                 // Note that we don't use a constructor.
                 var polyline = new GPolyline([prevpoint, latlng], "#000080", 2, 1);
                 map.addOverlay(polyline);
             }
             prevpoint = latlng;
          }
          updateDistanceTable(distMi, distKm);
    }
}

function editRoute()
{
    if (GBrowserIsCompatible())
    {
        map = new GMap2(document.getElementById("map"));
        var geocoder = new GClientGeocoder();
	var mapControl = new GMapTypeControl();

	map.addControl(mapControl);
	map.addControl(new GLargeMapControl());

        geocoder.getLatLng(address,
	function (point)
	{
            if (!point)
            {
            	alert(address + " not found!");
            }
            else
            {
            	map.setCenter(point, startZoom);
            }
         }
         );

         // Create the map_marker
         var icon = new GIcon();
         icon.image = '/images/map_marker.png';
         icon.iconsize = new GSize(10, 10);
         icon.iconAnchor = new GPoint(5, 5);

          var prevpoint = new GLatLng();
          // plot the route
          for( var i=0; i<dataPoints.length; i++)
          {
             var latlng = dataPoints[i];
             var marker = new GMarker(latlng, icon);
             map.addOverlay(marker);

             if( i!=0 && dataPoints.length !=1 )
             {
                 // Create GPolylineOptions argument as an object literal.
                 // Note that we don't use a constructor.
                 var polyline = new GPolyline([prevpoint, latlng], "#000080", 2, 1);
                 map.addOverlay(polyline);
             }
             prevpoint = latlng;
          }
          updateDistanceTable(distMi, distKm);

         GEvent.addListener(map, "click", function(overlay, latlng)
         {
             var distanceFromPrev = Number(0);
             var prevTotDist = Number(0);
             distMi = Number(0);
             distKm = Number(0);
             var marker = new GMarker(latlng, icon);

             dataPoints.push(latlng);

             // calc the total distance
             for( var i=0; i<dataPoints.length; i++)
             {
                if( i!=0 && dataPoints.length !=1 )
		{
                    distanceFromPrev = dataPoints[i-1].distanceFrom(dataPoints[i], 3959).toFixed(2);
                    prevTotDist = parseFloat(distMi) + parseFloat(distanceFromPrev);
                    distMi = prevTotDist.toFixed(2);
                    distKm = parseFloat(distMi) * MILES_TO_KM;
                    distKm = roundNumber(distKm, 2);


                    // Create GPolylineOptions argument as an object literal.
                    // Note that we don't use a constructor.
                    var polyline = new GPolyline([
                      dataPoints[i-1],
                      dataPoints[i]
                    ], "#000080", 2, 1);
                    map.addOverlay(polyline);
 		}
             }
             updateDistanceTable(distMi, distKm);
             map.addOverlay(marker);
         }
         );
         updateNameType();
    }
}

function drawRoute()
{
    map.clearOverlays();
    // calc the total distance
    for( var i=0; i<dataPoints.length; i++)
    {
       var latlng = dataPoints[i];
       addMarkerToMap( latlng );
       
       if( i!=0 && dataPoints.length !=1 )
       {
           distanceFromPrev = dataPoints[i-1].distanceFrom(dataPoints[i], 3959).toFixed(2);
           prevTotDist = parseFloat(distMi) + parseFloat(distanceFromPrev);
           distMi = prevTotDist.toFixed(2);
           distKm = parseFloat(distMi) * MILES_TO_KM;
           distKm = roundNumber(distKm, 2);

           // Create GPolylineOptions argument as an object literal.
           // Note that we don't use a constructor.
           var polyline = new GPolyline([
             dataPoints[i-1],
             dataPoints[i]
           ], "#000080", 2, 1);
           map.addOverlay(polyline);
       }
    }
    updateDistanceTable(distMi, distKm);

    // See if we need to turn on/off the various map control buttons.
    if( dataPoints.length > 0 )
    {
        document.getElementById('undopoint').disabled = false;
        document.getElementById('clearmap').disabled = false;
    }
    else
    {
        document.getElementById('undopoint').disabled = true;
        document.getElementById('clearmap').disabled = true;
    }
}

function addMarkerToMap( latlng )
{
    // Create the map_marker
    var icon = new GIcon();
    icon.image = '/images/map_marker.png';
    icon.iconsize = new GSize(10, 10);
    icon.iconAnchor = new GPoint(5, 5);
    var marker = new GMarker(latlng, icon);

    map.addOverlay(marker);
}

function updateDistanceTable(distMi, distKm)
{
    var tdMiles;
    var tdKilometers;

    if(document.getElementById && (tdMiles = document.getElementById("mi")))
    {
        while (tdMiles.hasChildNodes())
            tdMiles.removeChild(tdMiles.lastChild);
        tdMiles.appendChild(document.createTextNode(distMi + 'mi'));
    }

    if(document.getElementById && (tdKilometers = document.getElementById("km")))
    {
        while (tdKilometers.hasChildNodes())
            tdKilometers.removeChild(tdKilometers.lastChild);
        tdKilometers.appendChild(document.createTextNode(distKm + 'km'));
    }
}

function updateNameType()
{
    var routeName_input = document.getElementById("name");
    var routeType_select = document.getElementById("type");

    if(document.getElementById && (routeName_input ))
    {
        routeName_input.value = routename;
        routeName_input.disabled = true;
    }

    if(document.getElementById && (routeType_select ))
    {
        for(var i=0; i<4; i++)
        {
            if( routeType_select.options[i].text == routetype )
                routeType_select.options[i].selected = true;
        }
        routeType_select.disabled = true;
    }
}

function setAddress(user_address)
{
    address = user_address;
}

function setDisplayType(type)
{
    diplayType = type;
}

function setDistance(miles, kilometers)
{
    distMi = miles;
    distKm = kilometers;
}

function setNameType(route_name, route_type)
{
    routename = route_name;
    routetype = route_type;
}

function saveRoute()
{
    AUTH_TOKEN = window._token;
    var name = document.getElementById('name');
    var type = document.getElementById('type');
    var route_name = name.getValue();
    var route_type = type.getValue();
    var route_array = new Array();
    route_array['name'] = route_name;
    route_array['route_type'] = route_type;
    route_array['distMi'] = distMi;
    route_array['distKm'] = distKm;

    // Create the jsonObject for the data_points.
    var jsonPoints = '[';
    for( var i = 1; i <= dataPoints.length; i++)
    {
        if (i !=1 )
            jsonPoints = jsonPoints + ',';
        
        jsonPoints = jsonPoints + '{"lat":' + dataPoints[i-1].lat();
        jsonPoints = jsonPoints + ',"lng":' + dataPoints[i-1].lng() + '}';
    }
    jsonPoints = jsonPoints + ']';

    route_array['jsonPoints'] = jsonPoints;
    
    // Send the data to server to create/save the route and each data point.
    new Ajax.Request('/routes'+ '?authenticity_token='+AUTH_TOKEN,
        {method: 'post',
          parameters: route_array,
          onComplete: function(request)
          {
              // parse the result to JSON by eval-ing it
              result = eval( "(" + request.responseText + ")" );

              // check to see if it was an error or success
              if(!result.success)
              {
                  alert( 'AJAX.Request FAILED!' + '\n' + result.content);
              }
              else
              {
                  // everything went right so redirect back to the routes index page.
                  location.href = "/routes";
              }
          }
        }); // end of the Ajax request

    //alert('jsonRoute: ' + jsonRoute);
}

function undoLastPoint()
{
    // First pop off the last point added to the dataPoints array.
    if( dataPoints.length > 0 )
    {
        dataPoints.pop();
        // re-draw the poly-lines and calc the distance
        distMi = Number(0);
        distKm = Number(0);
        map.clearOverlays();
        drawRoute();
    }
}

function clearMap()
{
    dataPoints.length = 0;
    map.clearOverlays();
    distMi = 0;
    distKm = 0;
    updateDistanceTable(distMi, distKm);
    document.getElementById('undopoint').disabled = true;
    document.getElementById('clearmap').disabled = true;
}

function loadPoints( routePoints )
{
    alert(routePoints);
    var points = new Array();
    points = eval( '(' + routePoints + ')' );
    // turn the json objects into GLatLng objects.
    for( i=0; i<points.length;i++)
    {
        dataPoints.push(new GLatLng(points[i].lat, points[i].lng));
    }
}

function roundNumber(number,decimalPlaces)
{
    var placeSetter = Math.pow(10, decimalPlaces);
    number = Math.round(number * placeSetter) / placeSetter;
    return number;
}

window.onload = init;
window.onunload = GUnload;