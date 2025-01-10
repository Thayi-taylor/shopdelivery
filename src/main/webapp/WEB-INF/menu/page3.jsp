<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/style.css"/>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container">
		<div align="center">
			<h1>page 3 이동</h1>
			<br>
			
			<a href="${contextPath}/dashboard/dashboard.do">메인으로 돌아가기</a>	
		
		</div>
	</div>
</body>
</html>