<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>배송가능지역 설정</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="https://sgisapi.kostat.go.kr/OpenAPI3/auth/javascriptAuth?consumer_key=15e24dc29377490ea324"></script>
    <style>
        html, body {
            margin: 0;
            padding: 0;
            height: 100%;
        }
        #map {
            width: 100%;
            height: 500px;
            border: 1px solid #ccc;
        }
        #controls {
            margin: 10px 0;
        }
        #regionList {
            margin-top: 10px;
            padding: 0;
            list-style: none;
        }
        #regionList li {
            display: inline-block;
            padding: 5px 10px;
            margin: 3px;
            border: 1px solid #ccc;
            border-radius: 12px;
            background-color: #f1f1f1;
            font-size: 14px;
            color: #333;
            text-align: center;
            white-space: nowrap;
        }
        .btn {
            padding: 8px 15px;
            border: none;
            border-radius: 5px;
            background-color: #0078D7;
            color: white;
            cursor: pointer;
            margin-right: 5px;
        }
        .btn:hover {
            background-color: #005ea2;
        }
    </style>
</head>
<body>
<h1>배송가능지역 설정</h1>
<div id="map"></div>
<div id="controls">
    <input type="number" id="radiusInput" placeholder="반경(m)" value="5000">
    <button class="btn" onclick="drawRadiusCircle()">반경 원 그리기</button>
    <button class="btn" onclick="resetAll()">전체 초기화</button>
</div>
<ul id="regionList"></ul>

<script type="text/javascript">
    var polygons = {}; // 읍면동 폴리곤 저장
    var selectedPolygons = {}; // 선택된 읍면동
    var accessToken = null; // API 토큰 저장
    var circleLayer = null; // 반경 원 레이어
    var map = sop.map('map');

    map.setView(sop.utmk(953820, 1953437), 5);


    // 📌 **토큰 발급**
    function getAccessToken() {
        $.ajax({
            url: 'https://sgisapi.kostat.go.kr/OpenAPI3/auth/authentication.json',
            type: 'GET',
            data: {
                consumer_key: '15e24dc29377490ea324',
                consumer_secret: '1d1c9e56466c41e5b3c6'
            },
            success: function (data) {
                accessToken = data.result.accessToken;
                console.log("✅ Access Token:", accessToken);
                getLocationCoords();
            }
        });
    }

    // 📌 **현재 위치 가져오기**
    function getLocationCoords() {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function (position) {
                var lat = position.coords.latitude;
                var lon = position.coords.longitude;
                var utmkXY = new sop.LatLng(lat, lon);

                map.setView(sop.utmk(utmkXY.x, utmkXY.y), 7);

                var marker = sop.marker(sop.utmk(utmkXY.x, utmkXY.y));
                marker.addTo(map).bindInfoWindow("📍 현재 위치").openInfoWindow();
            }, function (error) {
                console.error("❌ 위치 정보 오류: ", error);
            });
        } else {
            alert("❌ 브라우저가 Geolocation API를 지원하지 않습니다.");
        }
    }

    // 📌 **반경 원 그리기**
    function drawRadiusCircle() {
        var radius = parseInt($('#radiusInput').val()) || 5000; // 입력된 반경 값 또는 기본값

        // 현재 위치를 가져와 원의 중심으로 사용
        navigator.geolocation.getCurrentPosition(function (position) {
            var lat = position.coords.latitude; // 위도
            var lon = position.coords.longitude; // 경도

            console.log("📍 현재 위치 (WGS84):", lat, lon);

            // WGS84 → UTMK 좌표 변환
            var utmkXY = sop.utmk(lon, lat);

            console.log("📍 현재 위치 (UTMK):", utmkXY);

            // 기존 원 제거
            if (circleLayer) {
                map.removeLayer(circleLayer);
            }

            // 새 원 생성 (UTMK 좌표 사용)
            circleLayer = sop.circle([utmkXY.x, utmkXY.y], {
                color: '#FF4500', // 원 테두리 색상
                weight: 2, // 테두리 두께
                opacity: 0.7, // 테두리 투명도
                fillColor: '#FFA07A', // 원 내부 색상
                fillOpacity: 0.2 // 원 내부 투명도
            });

            // 반경 설정
            circleLayer.setRadius(radius);

            // 지도에 원 추가
            circleLayer.addTo(map);

            // 지도 중심 이동
            map.setView(sop.utmk(utmkXY.x, utmkXY.y), 7); // 원 중심으로 지도 이동

            // 인포 윈도우 추가
            circleLayer.bindInfoWindow("⭕ 반경 " + radius + "m 원입니다.").openInfoWindow();

            console.log("⭕ 반경 " + radius + "m 원이 그려졌습니다.");
        }, function (error) {
            console.error("❌ 위치 정보를 가져오는데 실패했습니다:", error);
        });
    }




    // 📌 **읍면동 폴리곤 추가**
    function fetchBoundary(cd, name) {
        $.ajax({
            url: 'https://sgisapi.kostat.go.kr/OpenAPI3/addr/stage.json',
            type: 'GET',
            data: {
                accessToken: accessToken,
                cd: cd,
                pg_yn: 1
            },
            success: function (data) {
                var geometry = JSON.parse(data.result[0].pg);
                var layer = sop.geoJson(geometry).addTo(map);
                polygons[cd] = layer;

                $('#regionList').append(
                    '<li id="region-' + cd + '">' +
                    name +
                    '<button onclick="removeLayer(\'' + cd + '\')">❌</button>' +
                    '</li>'
                );
            }
        });
    }

    // 📌 **레이어 및 리스트 제거**
    function removeLayer(cd) {
        if (polygons[cd]) {
            map.removeLayer(polygons[cd]);
            delete polygons[cd];
        }
        $('#region-' + cd).remove();
    }

    // 📌 **전체 초기화**
    function resetAll() {
        if (circleLayer) map.removeLayer(circleLayer);
        Object.keys(polygons).forEach(cd => map.removeLayer(polygons[cd]));
        polygons = {};
        $('#regionList').empty();
    }

    getAccessToken();
</script>
</body>
</html>
