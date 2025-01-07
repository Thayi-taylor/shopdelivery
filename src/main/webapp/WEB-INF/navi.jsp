<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>최단 경로 찾기</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=c5yw7rzqzt"></script>
    <style>
        #map {
            width: 100%;
            height: 400px;
            margin-bottom: 20px;
        }
        #search-container {
            margin-bottom: 10px;
        }
        #search-results {
            margin-top: 10px;
            border: 1px solid #ccc;
            padding: 10px;
            max-height: 300px;
            overflow-y: auto;
        }
        .search-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }
        .search-item:last-child {
            border-bottom: none;
        }
        .search-item-left {
            display: flex;
            flex-direction: column;
        }
        .search-item-top {
            display: flex;
            align-items: center;
        }
        .search-item-index {
            font-size: 14px;
            font-weight: bold;
            margin-right: 10px;
            color: #000;
        }
        .search-item-title {
            font-size: 16px;
            font-weight: bold;
            color: #000;
        }
        .search-item-category {
            font-size: 12px;
            color: #777;
            margin-left: 5px;
        }
        .search-item-address {
            font-size: 14px;
            color: #444;
            margin-top: 5px;
        }
        .search-item-buttons {
            display: flex;
            flex-direction: column;
        }
        .search-item-buttons button {
            margin: 2px 0;
        }
    </style>
</head>
<body>
    <h1>장소 검색 및 경로 설정</h1>

    <!-- 검색창 -->
    <div id="search-container">
        <input type="text" id="searchInput" placeholder="장소를 검색하세요" required>
        <button onclick="searchPlace()">검색</button>
    </div>

    <!-- 검색 결과 목록 -->
    <div id="search-results"></div>

    <!-- 지도 표시 -->
    <div id="map"></div>

    <!-- 출발지 & 도착지 선택 -->
    <form id="routeForm" action="naviResult.jsp" method="get">
        출발지: <input type="text" name="start" id="start" placeholder="출발지를 선택하세요" readonly><br>
        도착지: <input type="text" name="end" id="end" placeholder="도착지를 선택하세요" readonly><br>
        <button type="submit">경로 찾기</button>
    </form>

    <script>
        let map;
        let markers = [];

        // 지도 초기화
        function initMap() {
            map = new naver.maps.Map('map', {
                center: new naver.maps.LatLng(37.5665, 126.9780),
                zoom: 14
            });
        }

        // 장소 검색 (서버 경유)
        function searchPlace() {
            let query = $('#searchInput').val();
            if (!query) {
                alert('검색어를 입력하세요.');
                return;
            }

            $.ajax({
                url: 'searchPlace.jsp',
                method: 'GET',
                data: { query: query },
                dataType: 'json',
                success: function (response) {
                    console.log(response); // API 응답 확인용

                    if (response.items && response.items.length > 0) {
                        displaySearchResults(response.items);
                    } else {
                        $('#search-results').html('<p>검색 결과가 없습니다.</p>');
                    }
                },
                error: function (xhr, status, error) {
                    console.error('서버 API 오류:', status, error);
                    alert('오류 발생: ' + error);
                }
            });
        }


		// 검색 결과 리스트 표시
		function displaySearchResults(items) {
		    let resultsHTML = '';
		    markers.forEach(marker => marker.setMap(null)); // 기존 마커 제거
		    markers = [];
		
		    items.slice(0, 5).forEach(function(item, index) {
		        let lat = parseFloat(item.mapy) / 1e7;
		        let lng = parseFloat(item.mapx) / 1e7;
		
		        // HTML 태그 제거 (title 값)
		        let title = item.title ? item.title.replace(/<[^>]*>/g, '') : '제목 없음';
		        let category = item.category || '카테고리 없음';
		        let address = item.address || item.roadAddress || '주소 없음';
		
		        resultsHTML += '<div class="search-item">' +
		                            '<div class="search-item-left">' +
		                                '<div class="search-item-top">' +
		                                    '<div class="search-item-index">' + (index + 1) + '.</div>' +
		                                    '<div class="search-item-title">' + title + '</div>' +
		                                    '<div class="search-item-category">' + category + '</div>' +
		                                '</div>' +
		                                '<div class="search-item-address">' + address + '</div>' +
		                            '</div>' +
		                            '<div class="search-item-buttons">' +
		                                '<button type="button" onclick="setStart(\'' + title + '\', ' + lat + ', ' + lng + ')">출발지로 선택</button>' +
		                                '<button type="button" onclick="setEnd(\'' + title + '\', ' + lat + ', ' + lng + ')">도착지로 선택</button>' +
		                            '</div>' +
		                        '</div>';
		
		        let marker = new naver.maps.Marker({
		            position: new naver.maps.LatLng(lat, lng),
		            map: map
		        });
		        markers.push(marker);
		    });
		
		    $('#search-results').html(resultsHTML);
		}
		
		        
        // 출발지 설정
        // 출발지는 매장 주소로 넘어올 수 있도록 할 것(2025.01.07 14:11)
        function setStart(name, lat, lng) {
            console.log('출발지 설정:', name);
            $('#start').val(name).attr('placeholder', name);
            map.setCenter(new naver.maps.LatLng(lat, lng));
        }

        // 도착지 설정
        function setEnd(name, lat, lng) {
            console.log('도착지 설정:', name);
            $('#end').val(name).attr('placeholder', name);
            map.setCenter(new naver.maps.LatLng(lat, lng));
        }

        // 초기화
        $(document).ready(function () {
            initMap();
        });
    </script>
</body>
</html>
