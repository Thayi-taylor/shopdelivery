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
		<form method="post" action="${contextPath }/Store/loginStorePro.do">
			<label class="mt-3">아이디</label>
			<div class="input-group mt-3">
				<input type="text" class="form-control" id="storeID" name="storeID" onfocus="checkStoreIDFocus(event)" oninput="clearStoreIDMessage()">
				<div id="msg-storeID"></div>
			</div>
			<label class="mt-3">비밀번호</label>
			<div class="input-group mt-3">
				<input type="password" class="form-control" pw=" storePW" name="storePW"  onfocus="checkStorePWFocus(event)">
				<div id="msg-storePW"></div>
			</div>
			<div class="mt-5" align="center">
				<input type="submit" value="로그인" class="btn btn-info"">
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
    let checkStoreIDFocus = (event) => {
        let storeID = document.getElementById("storeID").value; 
        let idMsg = document.querySelector("#msg-storeID");

        // 아이디 필드가 비어 있으면 메시지 표시
        if (storeID === "") {
            idMsg.innerHTML = "<span style='color:#F03F40; font-size:12px;'>아이디를 입력해주세요.</span>";
        }
    }

    // 비밀번호 입력 필드가 포커스될 때 처리
    let checkStorePWFocus = (event) => {
        let storeID = document.getElementById("storeID").value; 
        let idMsg = document.querySelector("#msg-storeID");

        // 아이디 필드가 비어 있으면 아이디 입력 안내 메시지 표시
        if (storeID === "") {
            idMsg.innerHTML = "<span style='color:#F03F40; font-size:12px;'>아이디를 입력해주세요.</span>";
        }
    }
	 // 아이디 입력 시 메시지 제거
    let clearStoreIDMessage = () => {
        let idMsg = document.querySelector("#msg-storeID");
        idMsg.innerHTML = ""; // 메시지 지우기
    }
</script>