<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.io.*" %>
<%@ page import="java.net.*" %>
<%@ page import="org.json.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>최단 경로</title>
    <script src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=k1IcrZXdoOilmpmM1Mfu"></script>
    <script src="/js/map.js"></script>
    <script src="/js/navi.js"></script>
</head>
<body>
<h1>출발지와 도착지 간 최단 경로</h1>
<div id="map" style="width:100%;height:400px;"></div>
<%
    String start = request.getParameter("start");
    String end = request.getParameter("end");

    // 지역검색 API 호출
    String apiURL = "https://openapi.naver.com/v1/search/local.json?query=" + URLEncoder.encode(start + " " + end, "UTF-8");

    HttpURLConnection con = (HttpURLConnection) new URL(apiURL).openConnection();
    con.setRequestMethod("GET");
    con.setRequestProperty("X-Naver-Client-Id", "k1IcrZXdoOilmpmM1Mfu");
    con.setRequestProperty("X-Naver-Client-Secret", "sNnATBJGA1");

    BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
    String line;
    StringBuilder apiResponse = new StringBuilder();
    while ((line = br.readLine()) != null) {
        apiResponse.append(line);
    }
    br.close();

    JSONObject jsonResponse = new JSONObject(apiResponse.toString());
    JSONArray items = jsonResponse.getJSONArray("items");

    String startLat = "37.5665"; // 기본 좌표 (서울)
    String startLng = "126.9780";
    String endLat = "37.5651";
    String endLng = "126.9895";

    if (items.length() > 1) {
        startLat = items.getJSONObject(0).getString("mapx");
        startLng = items.getJSONObject(0).getString("mapy");
        endLat = items.getJSONObject(1).getString("mapx");
        endLng = items.getJSONObject(1).getString("mapy");
    }
%>
<script>
    let startLat = "<%=startLat%>";
    let startLng = "<%=startLng%>";
    let endLat = "<%=endLat%>";
    let endLng = "<%=endLng%>";
    initMap(startLat, startLng, endLat, endLng);
</script>
</body>
</html>