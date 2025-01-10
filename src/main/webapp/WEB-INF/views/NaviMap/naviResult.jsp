<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.io.*" %>
<%@ page import="java.net.*" %>
<%@ page import="org.json.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>최단 경로 안내</title>
    <script src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=c5yw7rzqzt"></script>
    <style>
        #map {
            width: 100%;
            height: 400px;
        }
        #routeInfo {
            margin-top: 10px;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <h1>거리 및 소요시간 안내</h1>
    <div id="map"></div>
    <div id="routeInfo"></div>

<%! 
    // 📌 장소 좌표를 가져오는 메서드
    String getLocation(String query) {
        try {
            String apiURL = "https://openapi.naver.com/v1/search/local.json?query=" + URLEncoder.encode(query, "UTF-8") + "&display=1";
            HttpURLConnection con = (HttpURLConnection) new URL(apiURL).openConnection();
            con.setRequestMethod("GET");
            con.setRequestProperty("X-Naver-Client-Id", "k1IcrZXdoOilmpmM1Mfu");
            con.setRequestProperty("X-Naver-Client-Secret", "sNnATBJGA1");

            BufferedReader br = (con.getResponseCode() == 200) 
                ? new BufferedReader(new InputStreamReader(con.getInputStream())) 
                : new BufferedReader(new InputStreamReader(con.getErrorStream()));

            StringBuilder response = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                response.append(line);
            }
            br.close();

            JSONObject jsonResponse = new JSONObject(response.toString());
            JSONArray items = jsonResponse.getJSONArray("items");

            if (items.length() > 0) {
                JSONObject item = items.getJSONObject(0);
                String lat = String.valueOf(Double.parseDouble(item.getString("mapy")) / 1e7);
                String lng = String.valueOf(Double.parseDouble(item.getString("mapx")) / 1e7);
                return lat + "," + lng;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

	//📌 최단 경로를 가져오는 메서드
	String getDirection(String startLng, String startLat, String endLng, String endLat) throws IOException {
		String apiURL = "https://naveropenapi.apigw.ntruss.com/map-direction/v1/driving?"
		              + "start=" + startLng + "," + startLat 
		              + "&goal=" + endLng + "," + endLat
		              + "&option=traoptimal"; // 옵션 추가
		
		HttpURLConnection con = (HttpURLConnection) new URL(apiURL).openConnection();
		con.setRequestMethod("GET");
		con.setRequestProperty("X-NCP-APIGW-API-KEY-ID", "c5yw7rzqzt");
		con.setRequestProperty("X-NCP-APIGW-API-KEY", "vctRiGgwuELxM35s3ZK0XFzh9q17lW5ZzmWF6eZA");
		
		BufferedReader br = (con.getResponseCode() == 200) 
		    ? new BufferedReader(new InputStreamReader(con.getInputStream())) 
		    : new BufferedReader(new InputStreamReader(con.getErrorStream()));
		
		StringBuilder response = new StringBuilder();
		String line;
		while ((line = br.readLine()) != null) {
		    response.append(line);
		}
		br.close();
		
		System.out.println("Direction API Response: " + response.toString());
		return response.toString();
	}
%>

<%
    String start = request.getParameter("start");
    String end = request.getParameter("end");

    String startLat = "", startLng = "", endLat = "", endLng = "";
    String distance = "0", duration = "0", pathData = "";

    if (start != null && end != null) {
        String startCoords = getLocation(start);
        String endCoords = getLocation(end);

        if (startCoords != null && endCoords != null) {
            String[] startPoint = startCoords.split(",");
            String[] endPoint = endCoords.split(",");

            startLat = startPoint[0];
            startLng = startPoint[1];
            endLat = endPoint[0];
            endLng = endPoint[1];

            System.out.println("Start Coordinates: " + startLng + "," + startLat);
            System.out.println("End Coordinates: " + endLng + "," + endLat);

            try {
                String directionResponse = getDirection(startLng, startLat, endLng, endLat);
                JSONObject jsonResponse = new JSONObject(directionResponse);

                if (jsonResponse.has("route")) {
                    JSONObject traoptimal = jsonResponse.getJSONObject("route")
                                                         .getJSONArray("traoptimal")
                                                         .getJSONObject(0);

                    JSONObject summary = traoptimal.getJSONObject("summary");
                    distance = String.valueOf(summary.get("distance"));
                    duration = String.valueOf(summary.get("duration"));

                    JSONArray path = traoptimal.getJSONArray("path");
                    StringBuilder pathBuilder = new StringBuilder();
                    for (int i = 0; i < path.length(); i++) {
                        JSONArray point = path.getJSONArray(i);
                        pathBuilder.append(point.getDouble(1)) // lat
                                   .append(",")
                                   .append(point.getDouble(0)) // lng
                                   .append(";");
                    }
                    pathData = pathBuilder.toString();
                }
            } catch (JSONException e) {
                e.printStackTrace();
            }
        }
    }
%>



<script>
	document.addEventListener('DOMContentLoaded', function () {
	    let startLat = "<%= startLat %>";
	    let startLng = "<%= startLng %>";
	    let endLat = "<%= endLat %>";
	    let endLng = "<%= endLng %>";
	    let distance = "<%= distance %>";
	    let duration = "<%= duration %>";
	    let pathData = "<%= pathData %>";
	
	    let map = new naver.maps.Map('map', {
	        center: new naver.maps.LatLng(startLat, startLng),
	        zoom: 14
	    });
	
	    let startMarker = new naver.maps.Marker({
	        position: new naver.maps.LatLng(startLat, startLng),
	        map: map,
	        title: "출발지"
	    });
	
	    let endMarker = new naver.maps.Marker({
	        position: new naver.maps.LatLng(endLat, endLng),
	        map: map,
	        title: "도착지"
	    });
	
	    // 📌 출발지와 도착지를 포함하는 경계 영역 생성
	    let bounds = new naver.maps.LatLngBounds();
	    bounds.extend(new naver.maps.LatLng(startLat, startLng));
	    bounds.extend(new naver.maps.LatLng(endLat, endLng));
	
	    // 📌 경계 영역을 기준으로 지도 줌과 중심 조정
	    map.fitBounds(bounds);
	
	    // 📌 Polyline으로 경로 그리기
	    if (pathData) {
	        let path = pathData.split(";").map(point => {
	            let coords = point.split(",");
	            let lat = parseFloat(coords[0]);
	            let lng = parseFloat(coords[1]);
	
	            // 유효한 위도(-90 ~ 90)와 경도(-180 ~ 180) 확인
	            if (!isNaN(lat) && !isNaN(lng) && lat >= -90 && lat <= 90 && lng >= -180 && lng <= 180) {
	                console.log("✅ Valid Point: Lat =", lat, ", Lng =", lng);
	                return new naver.maps.LatLng(lat, lng);
	            } else {
	                console.warn("⚠️ Invalid Point Detected: Lat =", coords[0], ", Lng =", coords[1]);
	                return null; // 잘못된 좌표는 무시
	            }
	        }).filter(point => point !== null); // 유효하지 않은 좌표는 제거
	
	        new naver.maps.Polyline({
	            path: path,
	            strokeColor: '#0077ff',
	            strokeWeight: 5,
	            map: map
	        });
	    } else {
	        console.error("Path data is empty or invalid.");
	    }
	
	    // 📌 경로 정보 표시 (duration 값 강제 숫자 변환)
	    let routeInfo = "<p><strong>거리:</strong> " + Number(distance).toLocaleString() + " m</p>";
	
	    let durationValue = Number(duration); // 문자열을 숫자로 강제 변환
	
	    if (!isNaN(durationValue)) { 
	        let durationInMinutes = Math.floor(durationValue / 1000 / 60); // 초를 분으로 변환
	        routeInfo += "<p><strong>예상 소요 시간:</strong> " + durationInMinutes + " 분</p>";
	    } else {
	        console.error("Duration 값이 숫자가 아닙니다:", duration);
	        routeInfo += "<p><strong>예상 소요 시간:</strong> 시간 정보를 불러올 수 없습니다.</p>";
	    }
	
	    document.getElementById('routeInfo').innerHTML = routeInfo;
	});

</script>

</body>
</html>
