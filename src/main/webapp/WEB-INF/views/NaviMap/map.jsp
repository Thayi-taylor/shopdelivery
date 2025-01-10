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
            height: 100%;
            margin: 0;
            padding: 0;
        }
        #map {
            width: 100%;
            height: 70%;
            border: 1px solid #ccc;
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
        #regionList li:hover {
            background-color: #e0e0e0;
            border-color: #bbb;
        }
    </style>
</head>
<body>
    <h1>배송가능지역 설정</h1>
    <div id="map"></div>
    <ul id="regionList"></ul>
    
    <script type="text/javascript">
        var map = sop.map('map');
        map.setView(sop.utmk(953820, 1953437), 5);

        var polygons = {}; // 폴리곤 저장 객체
        var accessToken = null; // API 토큰 저장

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
                },
                error: function (xhr, status, error) {
                    console.error("❌ Access Token 오류: ", error);
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

        // 📌 **지도 클릭 이벤트**
        map.on("click", function (e) {
            var x_coor = e.utmk.x;
            var y_coor = e.utmk.y;

            console.log("🖱️ 클릭한 좌표: x=", x_coor, ", y=", y_coor);

            if (x_coor && y_coor) {
                fetchClickedLocationInfo(x_coor, y_coor);
            } else {
                console.error("❌ 유효하지 않은 좌표입니다.");
            }
        });

     // 📌 **클릭한 위치 정보 및 경계 확인**
        function fetchClickedLocationInfo(x, y) {
            if (!accessToken) {
                alert("❌ Access Token이 없습니다. 다시 시도해 주세요.");
                return;
            }

            $.ajax({
                url: 'https://sgisapi.kostat.go.kr/OpenAPI3/addr/rgeocode.json',
                type: 'GET',
                data: {
                    accessToken: accessToken,
                    x_coor: x,
                    y_coor: y,
                    addr_type: 20 // 읍면동 반환
                },
                success: function (data) {
                    console.log("📊 API 반환 데이터 (rgeocode):", data);

                    if (data.result && data.result.length > 0) {
                        var sido_cd = data.result[0].sido_cd || "";
                        var sgg_cd = data.result[0].sgg_cd || "";
                        var emdong_cd = data.result[0].emdong_cd || "";
                        var sgg_nm = data.result[0].sgg_nm || "알 수 없음";
                        var emdong_nm = data.result[0].emdong_nm || "알 수 없음";

                        var full_cd = sido_cd + sgg_cd + emdong_cd; // 최종 8자리 코드
                        var full_name = sgg_nm + " " + emdong_nm; // 전체 지역명
                        sgg_cd = sido_cd + sgg_cd; // 시군구 코드

                        console.log("🗂️ 읍면동 코드 (8자리):", full_cd);
                        console.log("🏷️ 주소 이름:", full_name);

                        // 경계 데이터 요청
                        fetchBoundary(sgg_cd, full_cd, full_name);
                    } else {
                        console.warn('⚠️ 유효한 주소 데이터가 없습니다.');
                    }
                },
                error: function (xhr, status, error) {
                    console.error("❌ 읍면동 코드 확인 실패: ", error);
                }
            });
        }

        // 📌 **읍면동 경계 표시 (pg 문자열 → GeoJSON 변환 및 표시)**
        function fetchBoundary(sgg_cd, full_cd, full_name) {
            if (!accessToken) {
                alert("❌ Access Token이 없습니다. 다시 시도해 주세요.");
                return;
            }

            // 이미 해당 경계가 존재하는 경우 생성을 막음
            if (polygons[full_cd]) {
                removePolygon(full_cd);
                return;
            }

            $.ajax({
                url: 'https://sgisapi.kostat.go.kr/OpenAPI3/addr/stage.json',
                type: 'GET',
                data: {
                    accessToken: accessToken,
                    cd: sgg_cd,
                    pg_yn: 1 // 경계 포함
                },
                success: function (data) {
                    console.log("📊 API 반환 데이터 (stage):", data);

                    if (data.result && data.result.length > 0) {
                        // 기존 폴리곤 제거
                        if (polygons[full_cd]) {
                            removePolygon(full_cd);
                        }

                        let matchingBoundary = null;

                        // 📌 **반복문을 사용해 cd 매칭**
                        for (let i = 0; i < data.result.length; i++) {
                            if (data.result[i].cd == full_cd && data.result[i].pg.includes('MULTIPOLYGON')) {
                                matchingBoundary = data.result[i].pg;
                                console.log("✅ 일치하는 POLYGON 데이터:", matchingBoundary);
                                break;
                            }
                        }

                        // 📌 **일치하는 MULTIPOLYGON을 GeoJSON으로 변환 및 지도에 표시**
                        if (matchingBoundary) {
                            try {
                                // 1️⃣ MULTIPOLYGON 문자열에서 좌표 추출
                                let cleanedPg = matchingBoundary
                                    .replace('MULTIPOLYGON(((', '') // 시작 부분 제거
                                    .replace(')))', '') // 끝 부분 제거
                                    .trim(); // 양 끝 공백 제거

                                console.log("🔄 정제된 MULTIPOLYGON 문자열:", cleanedPg);

                                // 2️⃣ 쉼표(`,`)로 좌표 분리 및 [x, y] 배열로 변환
                                let geoJsonCoordinates = [
                                    cleanedPg.split(',').map(coord => {
                                        let [x, y] = coord.trim().split(' ').map(Number); // 공백으로 x, y 분리 후 숫자로 변환
                                        return [x, y];
                                    })
                                ];

                                console.log("✅ 변환된 GeoJSON 좌표:", geoJsonCoordinates);

                                // 3️⃣ GeoJSON 데이터 생성
                                var geoJsonData = {
                                    type: "FeatureCollection",
                                    features: [{
                                        type: "Feature",
                                        geometry: {
                                            type: "MultiPolygon",
                                            coordinates: [geoJsonCoordinates]
                                        }
                                    }]
                                };

                                console.log("🌍 생성된 GeoJSON 데이터:", geoJsonData);

                                // 4️⃣ GeoJSON으로 지도에 표시
                                var boundaryLayer = sop.geoJson(geoJsonData, {
                                    style: {
                                        color: "#2E64FE", // 경계선 색상 (파란색)
                                        weight: 2, // 경계선 두께
                                        opacity: 0.7, // 경계선 투명도
                                        fillColor: "#81BEF7", // 내부 색상 (연한 파란색)
                                        fillOpacity: 0.3 // 내부 투명도
                                    }
                                }).addTo(map);

                                // 5️⃣ 폴리곤 객체 저장
                                polygons[full_cd] = boundaryLayer;

                                console.log("✅ 일치하는 경계가 지도에 표시되었습니다:", full_name);

                                // 6️⃣ 리스트에 지역명 추가
                                $("#regionList").append(
                                    '<li id="region-' + full_cd + '">' +
                                    '<span>' + full_name + '</span>' +
                                    '</li>'
                                );

                            } catch (error) {
                                console.error("❌ MULTIPOLYGON 변환 오류:", error);
                            }
                        } else {
                            console.warn("⚠️ 일치하는 MULTIPOLYGON 데이터가 없습니다.");
                        }
                    } else {
                        console.warn("⚠️ 유효한 경계 데이터가 없습니다.");
                    }
                },
                error: function (xhr, status, error) {
                    console.error("❌ 경계 데이터 확인 실패:", error);
                }
            });
        }



        // 📌 **폴리곤 및 목록 항목 제거**
        function removePolygon(full_cd) {
            if (polygons[full_cd]) {
                map.removeLayer(polygons[full_cd]);
                delete polygons[full_cd];
            }

            // 문자열 연결 방식으로 요소 삭제
            $("#region-" + full_cd).remove();
        }


        getAccessToken();
    </script>
</body>
</html>
