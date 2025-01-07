<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>메인 페이지</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin-top: 50px;
        }
        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 50vh;
        }
        .btn {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            font-size: 16px;
            color: #fff;
            background-color: #0078D7;
            text-decoration: none;
            border-radius: 5px;
        }
        .btn:hover {
            background-color: #005EA6;
        }
    </style>
</head>
<body>
    <h1>환영합니다!</h1>
    <p>다음 페이지로 이동하여 지도를 확인하세요.</p>
    <div class="container">
        <a href="map.jsp" class="btn">지도 페이지로 이동하기</a>
        <a href="navi.jsp" class="btn">내비 페이지로 이동하기</a>
    </div>
</body>
</html>
