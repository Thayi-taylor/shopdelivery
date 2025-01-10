<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!-- 
<link rel="stylesheet" href="${contextPath}/resources/css/style.csshttps://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

<link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/style.css"/>
 -->    
 
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
	<br>
	<div class="container">
		<div class="d-flex justify-content-center">
			<a href="${contextPath}/dashboard/dashboard.do"><img alt="메인로고" src="${contextPath}/resources/img/dashboardLogo.jpg" style="width:300px; height: 150px;"></a>
		</div>
	</div>
	<hr id="hr-deco">
	<div class="container">
		<div class="d-flex justify-content-between">
			<div class="col-8">
				<table class="table table-bordered">
		            <tr style="height: 40px;">
		            	<td><a href="${contextPath}/menu/page1.do">1</a></td>
		           		<td><a href="${contextPath}/menu/page2.do">2</a></td>
		            	<td><a href="${contextPath}/menu/page3.do">3</a></td>
		            	<td><a href="${contextPath}/menu/page4.do">4</a></td>
		            	<td><a href="${contextPath}/menu/page5.do">5</a></td>
		            	<td><a href="${contextPath}/menu/page6.do">6</a></td>
		            	<td><a href="${contextPath}/menu/page7.do">7</a></td>
		            	<td><a href="${contextPath}/menu/page8.do">8</a></td>
		            </tr>
		             <tr style="height: 40px;">
		            	<td><a href="${contextPath}/menu/page1.do">1</a></td>
		           		<td><a href="${contextPath}/menu/page2.do">2</a></td>
		            	<td><a href="${contextPath}/menu/page3.do">3</a></td>
		            	<td><a href="${contextPath}/menu/page4.do">4</a></td>
		            	<td><a href="${contextPath}/menu/page5.do">5</a></td>
		            	<td><a href="${contextPath}/menu/page6.do">6</a></td>
		            	<td><a href="${contextPath}/menu/page7.do">7</a></td>
		            	<td><a href="${contextPath}/menu/page8.do">8</a></td>
		            </tr>
		        </table>
			</div>
			<div class="col-3 d-flex justify-content-end">
				<form action="${contextPath}/menu/20_search.do" method="post" class="">
					<div class="input-group" style="width:300px;">
						<input type="text" name="search" class="form-control" placeholder="넣을까뺄까고민중(구현안시킴)">
						<button type="submit" class="btn custom-button">라이더 검색</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	
	
</body>
</html>