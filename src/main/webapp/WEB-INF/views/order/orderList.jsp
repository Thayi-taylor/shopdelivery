<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 부트스트랩 5.2.3 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
    	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
	    integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
	    crossorigin="anonymous"></script>    
    <!-- 부트스트랩 5.2.3 -->
<title>Insert title here</title>
</head>
<body>
		<br>
		<h2 class="text-center">주문 목록</h2>
		<br>
		
		<!-- 총 주문 건수 -->
	    <div class="text-center">
	        총 주문 건수 : ${count}건
	    </div>
	    <hr>
		
		<!-- 주문 리스트 -->
	    <div style="margin-left: 12%; margin-right: 12%;">
	        <table class="table table-bordered">
	            <tr>
	                <th style="width: 55px;">No.</th>
	                <th class="text-center" style="width: 300px;">품명</th>
	                <th class="text-center" style="width: 300px;">배달일시</th>
	                <th class="text-center" style="width: 500px;">배달장소</th>
	                <th class="text-center" style="width: 500px;">보내는 이</th>
	            </tr>
				<c:forEach var="order" items="${orderList}">
					<tr onclick="location.href='${contextPath}/order/orderDetailInfo.do?orderIndex=${order.orderIndex}'" style="cursor: pointer;">
						<td>${ order.orderIndex }</td>
						<td>${ order.productName }</td>
						<td>${ order.deliveryDatetime }</td>
						<td>${ order.deliveryAddress1 }</td>
						<td>${ order.senderName }</td>
					</tr>
				</c:forEach>
			</table>
		</div>
</body>
</html>