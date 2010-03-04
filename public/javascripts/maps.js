/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
var address = '6061 Brofield Dr, Hamilton, OH, 45011'
var startZoom = 13;
var description = 'Golden Gate Bridge';
var map;

function init()
{
    if (GBrowserIsCompatible())
    {
        map = new GMap2(document.getElementById("map"));
        var geocoder = new GClientGeocoder();
	var mapControl = new GMapTypeControl();

	map.removeMapType(G_HYBRID_MAP);
	map.removeMapType(G_SATELLITE_MAP);
	map.addControl(mapControl);
	map.addControl(new GLargeMapControl());

        geocoder.getLatLng(address,
	function (point)
	{
            //if (!point)
            //{
            //	alert(address + " not found!");
            //}
            //else
            //{
            	map.setCenter(point, startZoom);
            //}
         }
         );

    }
}

function addMarker(latitude, longitude, description)
{
    var marker = new GMarker(new GLatLng(latitude, longitude));

    GEvent.addListener(marker, 'click',
        function()
        {
            marker.openInfoWindowHtml(description);
        }
    );

    map.addOverlay(marker);
}

window.onload = init;
window.onunload = GUnload;