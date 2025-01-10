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
<!-- 부트스트랩 5.2.3 -->   
	<div class="container">
		<div class="text-center mt-5">
			<h2>아이디찾기</h2>
		</div>
	</div>
	<div class="container">
		<div class="d-flex justify-content-center mt-5">
			<form method="post" action="${contextPath }/Store/findStoreIdPro.do">
				<label>매장명</label>
				<div class="input-group mt-3">
					<input type="text" class="form-control" name="storeName" style="width: 180px;">
				</div>
				<label class="mt-3">매장 유선전화</label>
				<div class="input-group mt-3">
					<input type="text" class="form-control" name="storePhone1">
					-
					<input type="text" class="form-control" name="storePhone2">
					-
					<input type="text" class="form-control" name="storePhone3"> 
				</div> 
				<div class="mt-5" align="center">
					<button type="submit" class="btn btn-info">아이디찾기</button>
				</div>
			</form>
		</div>
	</div>
	<div class="container">
		<div class="d-flex justify-content-center mt-5">
			<a href="${contextPath}/index.do">메인화면</a>
		</div>
	</div>