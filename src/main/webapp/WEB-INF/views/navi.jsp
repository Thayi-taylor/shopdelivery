<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>최단 경로 찾기</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="/js/navi.js"></script>
</head>
<body>
<h1>출발지와 도착지를 입력하세요</h1>
<form id="routeForm" action="naviResult.jsp" method="get">
    출발지: <input type="text" name="start" id="start" required><br>
    도착지: <input type="text" name="end" id="end" required><br>
    <button type="submit">경로 찾기</button>
</form>
</body>
</html>