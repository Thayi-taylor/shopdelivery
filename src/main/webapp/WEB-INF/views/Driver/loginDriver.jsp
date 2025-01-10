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
    	input{
    		width:230px;
    	}
    </style> 
  
<!-- 부트스트랩 5.2.3 -->   
<div class="container">
	<div class="text-center mt-5">
		<h2>로그인</h2>
	</div>
</div>
<div class="container">
	<div class="d-flex justify-content-center">
		<form method="post" action="${contextPath }/Driver/loginDriverPro.do">
			<label class="mt-3">아이디</label>
			<div class="input-group mt-3">
				<input type="text" class="form-control" id="driverID" name="driverID" onfocus="checkDriverIDFocus(event)" oninput="clearDriverIDMessage()">
				<div id="msg-DriverID"></div>
			</div>
			<label class="mt-3">비밀번호</label>
			<div class="input-group mt-3">
				<input type="password" class="form-control" id=" driverPW" name="driverPW"  onfocus="checkDriverPWFocus(event)">
				<div id="msg-DriverPW"></div>
			</div>
			<div class="mt-5" align="center">
				<input type="submit" value="로그인" class="btn btn-info">
			</div>
		</form>
	</div>
</div>
<div class="container">
	<div class="d-flex justify-content-center mt-5">
		<a href="${contextPath }/index.do">메인화면</a>
	</div>
</div>
<script>
	
	// 아이디 입력 필드가 포커스될 때 처리
    let checkDriverIDFocus = (event) => {
        let driverID = document.getElementById("driverID").value; 
        let idMsg = document.querySelector("#msg-DriverID");

        // 아이디 필드가 비어 있으면 메시지 표시
        if (driverID === "") {
            idMsg.innerHTML = "<span style='color:#F03F40; font-size:12px;'>아이디를 입력해주세요.</span>";
        }
    }

    // 비밀번호 입력 필드가 포커스될 때 처리
    let checkDriverPWFocus = (event) => {
        let driverPW = document.getElementById("driverPW").value; 
        let pwMsg = document.querySelector("#msg-DriverPW");

        // 아이디 필드가 비어 있으면 아이디 입력 안내 메시지 표시
        if (driverPW === "") {
            pwMsg.innerHTML = "<span style='color:#F03F40; font-size:12px;'>비밀번호를 입력해주세요.</span>";
        }
    }
	 // 아이디 입력 시 메시지 제거
    let clearDriverIDMessage = () => {
        let idMsg = document.querySelector("#msg-DriverID");
        idMsg.innerHTML = ""; // 메시지 지우기
    }
</script>