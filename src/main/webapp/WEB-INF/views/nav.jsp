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
	<div class="d-flex justify-content-end mt-3">
		<div class="nav">
			<c:if test="${empty sessionScope.log }">
			<a href="${contextPath }/User/registerUser.do">회원가입</a>&nbsp;&nbsp;
			<a href="${contextPath }/User/login.do">로그인</a>&nbsp;&nbsp;
			<a href="${contextPath }/User/findId.do">아이디찾기</a>
			</c:if>
			
			<c:if test="${not empty sessionScope.log and sessionScope.log != 'admin'}">
			<p>${sessionScope.log }님 접속 중 :D<p>&nbsp;
			<a href="${contextPath }/User/loggout.do">로그아웃</a>&nbsp;&nbsp;
			</c:if>
			<c:if test="${sessionScope.log=='admin'}">
			<p>${sessionScope.log }님 접속 중 :D<p>&nbsp;
			<a href="${contextPath }/User/loggout.do">로그아웃</a>&nbsp;&nbsp;
			</c:if>
		</div>
	</div>
</div>