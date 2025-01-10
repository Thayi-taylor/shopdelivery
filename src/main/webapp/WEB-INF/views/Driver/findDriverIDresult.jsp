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
    
    
       
    <c:if test="${check==1}">
	    <div class="container">
	    	<div class="text-center mt-5">
	    		<h3>아이디 찾기 결과</h3>
	    	</div>
	    </div>
  		<div class="container">
  			<div class="d-flex justify-content-center mt-5">
	  			<label class="me-5">아이디</label>
	  			<label><b>${sessionScope.findId }</b></label>
  			</div>
  		</div>
  		<div class="container">
  			<div class="d-flex justify-content-center mt-5">
	  			<a class="btn btn-info btn-sm me-4" href="${contextPath}/Driver/findDriverPw.do">비밀번호 찾기</a>
	  			<a class="btn btn-info btn-sm " href="${contextPath}/index.do">메인화면</a>
  			</div>
  		</div>
  	</c:if>
  	<c:if test="${check==-1}">
  		<script>
  			alert("정보가 존재하지 않습니다.");
  			
  		</script>
  	</c:if>
