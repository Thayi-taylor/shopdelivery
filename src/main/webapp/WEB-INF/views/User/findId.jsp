<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!-- 부트스트랩 5.2.3 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
    crossorigin="anonymous"></script>    
<style>
	a{
		width:18rem;
		margin:10px;
	}
</style>
<!-- 부트스트랩 5.2.3 -->   
 <div class="container">
 	<div class="text-center mt-5">
 		<h2>로그인</h2>
 	</div>
 </div>
 <div class="container">
 	<div class="d-flex justify-content-center mt-5">
 		<a href="${contextPath }/Store/findStoreId.do" class="card" >
 			<div class="card-body">
 				<%System.out.println("눌리긴 하니"); %>
 				<p align="center">매장 아이디를 모르겠어요:(<p>
 				<h5 class="card-title" align="center">매장 아이디찾기</h5>
 			</div>
 		</a>
 		
 		<a href="${contextPath }/Driver/findDriverId.do" class="card" >
 			<div class="card-body">
 				<p align="center">기사 아이디를 모르겠어요:(<p>
 				<h5 class="card-title" align="center">기사 아이디찾기</h5>
 			</div>
 		</a>
 	</div>
 </div>