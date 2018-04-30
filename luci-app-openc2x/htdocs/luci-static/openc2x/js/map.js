
/**
 * Initialises the Map.
 */
function initMap(){
	//init map
	map = L.map('mapContainer');

	// start the map in Paderborn
	viewPosition = [51.7315, 8.739];
	map.setView(viewPosition,15);

	// The tiles can also be cached using marble and used for field tests with no internet connectivity.
	// https://docs.kde.org/stable5/en/kdeedu/marble/download-region.html
	// http://stackoverflow.com/questions/18735001/openstreetmap-offline
	L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
    attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'}).addTo(map);
	
	markers = [];
	
	window.setInterval(function(){
		if (camData.init()){//not uninitalised
			markers.forEach(function(marker) {
				map.removeLayer(marker);
			})
			var redMarker = L.icon({
				    iconUrl: '/luci-static/resources/openc2x/image/marker/marker-icon-red.png',
				    iconSize: [25,41],
				    iconAnchor: [12,41],
                                    popupAnchor:  [0, -20]
				});
			var redMarkerPale = L.icon({
			    iconUrl: '/luci-static/resources/openc2x/image/marker/marker-icon-red-pale.png',
			    iconSize: [25,41],
			    iconAnchor: [12,41],
                            popupAnchor:  [0, -20]
			});
            var blueMarker = L.icon({
			    iconUrl: '/luci-static/resources/openc2x/image/marker/marker-icon-blue.png',
			    iconSize: [25,41],
			    iconAnchor: [12,41],
                            popupAnchor:  [0, -20]
			});

			//var ownCam = camData.getLastOwnCam();
			camData.cams.forEach(function(cam, key) {
				if ( key == camData.mymac){//own cam
					var lat = cam.coop.camParameters.basicContainer.latitude/10000000;
					var lon = cam.coop.camParameters.basicContainer.longitude/10000000;
					viewPosition = [lat, lon];
					var marker = L.marker(viewPosition,{icon:blueMarker}).addTo(map);
					//station id popup
					marker.bindPopup("self");
					marker.on('mouseover', function(e){
					    marker.openPopup();
					});
					markers.push(marker);
				} else {//other cams : red marker
					var icon = redMarker;
					var lat = cam.coop.camParameters.basicContainer.latitude/10000000;
					var lon = cam.coop.camParameters.basicContainer.longitude/10000000;
					var marker = L.marker([lat, lon],{icon: icon}).addTo(map);
					marker.bindPopup(cam.header.stationID.toString());
					marker.on('mouseover', function(e){
					    marker.openPopup();
					});
					markers.push(marker);
				}
			})
		}
		map.invalidateSize();
		map.setView(viewPosition);
	},1300);
	

	//$("#mapWrapper").draggable().resizable();
}

$(document).ready(function(){
	initMap();
});
