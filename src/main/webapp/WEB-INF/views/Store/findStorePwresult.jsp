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

	<c:if test="${check==1 }">
		<div class="container">
			<div class="text-center mt-5">
				<h3>비밀번호 찾기 결과</h3>
			</div>
		</div>
		<div class="container">
			<div class="d-flex justify-content-center mt-4">
				<label class="me-5">비밀번호</label>
				<label><b>${sessionScope.findPw }</b></label>
			</div>
		</div>
		<div class="container">
			<div class="d-flex justify-content-center mt-4">
				<a href="${contextPath }/Store/loginStore.do" class="btn btn-info btn-sm">로그인</a>
			</div>
		</div>
	</c:if>
	
	<c:if test="${check==-1}">
		<script>
			alert("입력한 정보를 다시 확인해주세요");
			window.location.href = "${contextPath}/Store/findStorePw.do";
		</script>
	</c:if>









