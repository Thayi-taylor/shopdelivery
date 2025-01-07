function initMap(startLat, startLng, endLat, endLng) {
    var map = new naver.maps.Map('map', {
        center: new naver.maps.LatLng(startLat, startLng),
        zoom: 10
    });

    var startMarker = new naver.maps.Marker({
        position: new naver.maps.LatLng(startLat, startLng),
        map: map,
        title: '출발지'
    });

    var endMarker = new naver.maps.Marker({
        position: new naver.maps.LatLng(endLat, endLng),
        map: map,
        title: '도착지'
    });

    var polyline = new naver.maps.Polyline({
        map: map,
        path: [
            new naver.maps.LatLng(startLat, startLng),
            new naver.maps.LatLng(endLat, endLng)
        ],
        strokeColor: '#FF0000',
        strokeWeight: 5
    });
}