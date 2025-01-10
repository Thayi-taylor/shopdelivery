<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
 <!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/style.css"/>

<!-- Bootstrap JS (Bundle includes Popper.js) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 
	<div class="container">
		<div class="row">
			<div class="col-12 col-xl-4">
				<div class="d-flex justyfy-content-center justify-content-xl-start">
					<div class="card border">
						<div style="width: 400px; height: 300px;">
							<img alt="jordy" src="${contextPath}/resources/img/jordy.jpg" class="img-fluid">	
							<p>주간 매출</p>
						</div>		
					</div>
				</div>
			</div>
			
			<div class="col-12 col-xl-4">	<!-- 00_12_monthApi.jsp 삽입 -->
				<div class="d-flex justyfy-content-center justify-content-xl-center">
					<div class="card border">
						<div style="width: 400px; height: 300px;">
							<img alt="jordy" src="${contextPath}/resources/img/jordy.jpg" class="img-fluid">	
							<p>월별 매출</p>
						</div>		
					</div>		
				</div>
			</div>
		
			
			<div class="col-12 col-xl-4"><!-- 00_13_riderApi.jsp 삽입 -->
				<div class="d-flex justyfy-content-center justify-content-xl-end">
					<div class="card border">
						<div style="width: 400px; height: 300px;">
							<img alt="jordy" src="${contextPath}/resources/img/jordy.jpg" class="img-fluid">	
							<p>라이더별 매출</p>
						</div>		
					</div>
				</div>
			</div>
		</div>
	</div>
	<br>
</body>
</html>