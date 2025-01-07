<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>현재 위치 및 행정구역 경계 표시</title>
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
		    display: inline-block; /* 글자 길이에 맞게 상자 크기 조정 */
		    padding: 5px 10px; /* 상자 안 여백 */
		    margin: 3px; /* 상자 간격 */
		    border: 1px solid #ccc; /* 테두리 색상 */
		    border-radius: 12px; /* 모서리 둥글게 */
		    background-color: #f1f1f1; /* 배경색 */
		    font-size: 14px; /* 글자 크기 */
		    color: #333; /* 글자 색상 */
		    text-align: center; /* 텍스트 가운데 정렬 */
		    white-space: nowrap; /* 글자 줄바꿈 방지 */
		}
		
		#regionList li:hover {
		    background-color: #e0e0e0; /* 호버 시 배경색 변경 */
		    border-color: #bbb; /* 호버 시 테두리 색상 변경 */
		}
    </style>
</head>
<body>
    <h1>현재 위치 및 행정구역 경계 표시</h1>
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
                    console.log("Access Token:", accessToken);
                    getLocationCoords();
                },
                error: function (xhr, status, error) {
                    console.error("Access Token 오류: ", error);
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
                    marker.addTo(map).bindInfoWindow("현재 위치").openInfoWindow();
                }, function (error) {
                    console.error("위치 정보 오류: ", error);
                });
            } else {
                alert("브라우저가 Geolocation API를 지원하지 않습니다.");
            }
        }

        // 📌 **지도 클릭 이벤트 (왼쪽 클릭)**
		map.on("click", function (e) {
		    console.log(e);  // e 객체 확인
		
		    // e.utmk.x, e.utmk.y 값 사용
		    var x_coor = e.utmk.x;
		    var y_coor = e.utmk.y;
		    //console.log(`🖱️ 지도 클릭 좌표: x=${x_coor}, y=${y_coor}`);
		    var html = "<p> 지도클릭 좌표 x :"+x_coor+" , y :"+y_coor+"</p>";
            $("#divCon").append(html);
		
		    if (x_coor && y_coor) {
		        fetchAreaCode(x_coor, y_coor);  // 좌표가 유효하면 API 호출
		    } else {
		        console.error("좌표 값이 유효하지 않습니다.");
		    }
		});

		var arr = [];
		// 📌 **지역 코드 추출 API 호출**
		function fetchAreaCode(x, y) {
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
		            if (data.result && data.result.length > 0) {
		                var sido_cd = data.result[0].sido_cd || "";
		                var sgg_cd = data.result[0].sgg_cd || "";
		                var sgg_nm = data.result[0].sgg_nm || "알 수 없음";
		                
		                // 📌 시군구 코드 강제 변환
		                if (/^05\d$/.test(sgg_cd)) {
		                    sgg_cd = "050";
		                }
		                sgg_nm = getRegionName(sgg_cd, sgg_nm);
		                var adm_cd = sido_cd + sgg_cd; // sido_cd와 sgg_cd 결합
		                
		                console.log("지역코드: ", adm_cd, ", 지역명 : ", sgg_nm);
		                
		                arr.push(adm_cd);

		                fetchBoundary(adm_cd, sgg_nm);
		            } else {
		                console.warn('⚠️ 유효한 지역 코드가 없습니다.');
		            }
		        },
		        error: function (xhr, status, error) {
		            console.error("❌ 지역 코드 추출 실패: ", error);
		        }
		    });
		}


     	// 📌 **시군구 코드 변환 함수**
        function normalizeSggCd(sgg_cd) {
            if (/^05\d$/.test(sgg_cd)) {
                return "050"; // 05* 패턴은 모두 050으로 변경
            }
            return sgg_cd;
        }
     	
        // 📌 **시군구 이름 통합**
        function getRegionName(sgg_cd, sgg_nm) {
            if (sgg_cd === "050") {
                return "부천시";
            }
            return sgg_nm;
        }

        // 📌 **행정구역 경계 API 호출 및 목록 추가/제거**
        function fetchBoundary(adm_cd, sgg_nm) {
            if (polygons[adm_cd]) {
                removePolygon(adm_cd);
            } else {
                // 시군구 코드 변환
                var normalized_adm_cd = normalizeSggCd(adm_cd);

                $.ajax({
                    url: 'https://sgisapi.kostat.go.kr/OpenAPI3/boundary/hadmarea.geojson',
                    type: 'GET',
                    data: {
                        accessToken: accessToken,
                        year: 2023,
                        adm_cd: normalized_adm_cd,
                        low_search: 0
                    },
                    success: function (data) {
                        var features = data.features;
                        if (!features || features.length === 0) {
                            console.warn("경계 데이터를 찾을 수 없습니다.");
                            return;
                        }

                        var geometry = features[0].geometry;
                        var coordinates = geometry.coordinates;

                        // 1. `Polygon`인데 coordinates 길이가 2 이상인 경우 -> `MultiPolygon`으로 강제 변환
                        if (geometry.type === "Polygon" && coordinates.length > 1) {
                            geometry.type = "MultiPolygon";
                            coordinates = [coordinates]; // 배열을 한 번 더 감싸 MultiPolygon 구조로 변환
                        }

                        // 2. `Polygon` 또는 `MultiPolygon` 처리
                        if (geometry.type === "Polygon") {
                            var polygonCoords = coordinates[0].map(coord => [coord[0], coord[1]]);
                            var polygon = sop.polygon([polygonCoords], {
                                color: "blue",
                                fill: true,
                                fillColor: "blue",
                                fillOpacity: 0.4
                            }).addTo(map);

                            polygons[adm_cd] = polygon;
                        } else if (geometry.type === "MultiPolygon") {
                            var geoJsonData = {
                                type: "FeatureCollection",
                                features: [{
                                    type: "Feature",
                                    geometry: {
                                        type: "MultiPolygon",
                                        coordinates: coordinates
                                    }
                                }]
                            };

                            var multiPolygon = sop.geoJson(geoJsonData, {
                                color: "blue",
                                fill: true,
                                fillColor: "blue",
                                fillOpacity: 0.4
                            }).addTo(map);

                            polygons[adm_cd] = multiPolygon;
                        }

                        // 리스트에 구 이름 추가
                        $("#regionList").append(
                            '<li id="region-' + adm_cd + '">' +
                            '<span>' + sgg_nm + '</span>' +
                            '</li>'
                        );
                        
                    },
                    error: function (xhr, status, error) {
                        console.error("API 호출 오류:", error);
                    }
                });
            }
        }

        // 📌 **폴리곤 및 목록 항목 제거**
        function removePolygon(adm_cd) {
            if (polygons[adm_cd]) {
                map.removeLayer(polygons[adm_cd]);
                delete polygons[adm_cd];
            }

            // 문자열 연결 방식으로 요소 삭제
            $("#region-" + adm_cd).remove();
        }
		
        getAccessToken();
    </script>
</body>
</html>
