<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 부트스트랩 5.2.3 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
    crossorigin="anonymous"></script> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
 
  
    <div class="container">
    	<div class="text-center mt-5">
    		<h2>기사 회원가입</h2>
    	</div>
    </div>
    <div class="container">
    	<div class="d-flex justify-content-center mt-5">
    		<form method="post" action="${contextPath }/Driver/registerDriverPro.do">
    			<label class="mt-3">아이디</label>
    			<div class="input-group mt-3">
    				<input type="text" class="form-control" id="driverID" name="driverID" oninput="validateDriverID(event)">
    				<div id="msg-driverID"></div>
    			</div>
    			<label class="mt-3">비밀번호</label>
    			<div class="input-group mt-3">
    				<input type="password" class="form-control" id="driverPW" name="driverPW" oninput="validateDriverPW(event)">
    				<div id="msg-driverPW"></div>
    			</div>
    			<label class="mt-3">이름</label>
    			<div class="input-group mt-3">
    				<input type="text" class="form-control" id="driverName" name="driverName" oninput="validateDriverName(event)">
    				<div id="msg-driverName"></div>
    			</div>
    			<label class="mt-3">휴대폰</label>
    			<div class="input-group mt-3">
    				<input type="text" class="form-control" id="driverMobile1" name="driverMobile1" oninput="validateDriverMobile(event)">
    				-
    				<input type="text" class="form-control" id="driverMobile2" name="driverMobile2" oninput="validateDriverMobile(event)">
    				-
    				<input type="text" class="form-control" id="driverMobile3" name="driverMobile3" oninput="validateDriverMobile(event)">
    				<div id="msg-driverMobile"></div>
    			</div>
    			<label class="mt-3">배달가능지역</label>
    			<div class="input-group mt-3">
    				<input type="text" class="form-control" id="driverAvailableArea" name="driverAvailableArea" oninput="validateDriverAvailableArea(event)">
    				<div id="msg-driverAvailableArea"></div>
    			</div>
    			<div class="mt-5" align="center">
					<button type="submit" class="btn btn-info">회원가입</button>
				</div>
    		</form>
    	</div>
    </div>
    <div class="container">
    	<div class="d-flex justify-content-center mt-5">
    		<a href="${contextPath }/index">메인화면</a>
    	</div>
    </div>
    
    <script>
	let validateDriverID = (event) => {
	    let driverID = event.target.value; // 입력된 값 가져오기
	    let idMsg = document.querySelector("#msg-driverID"); // 오류 메시지를 표시할 div
	    let idRegExp = /^[A-Za-z0-9_\-]{6,16}$/; // 유효성 검사 정규식
	
	    // 입력값이 없을 경우
	    if (driverID === "") {
	    	idMsg.innerHTML = "<span style='color:#F03F40; font-size:12px;'>아이디를 입력해주세요.</span>";
	        return; // 유효성 검사 종료
	    }
	      
	    // 정규식으로 유효성 검사
	    if (!idRegExp.test(driverID)) {
	    	idMsg.innerHTML = "<span style='color:#F03F40; font-size:12px;'>아이디는 6자 이상 16자 이하로 영문, 숫자만 가능합니다.</span>";
	        return; // 유효성 검사 종료
	    }
	
	    // 유효한 아이디일 경우 메시지 비우기
	    idMsg.innerHTML = "";
	}
	
	// 비밀번호
	let validateDriverPW = (event) => {
		let driverPW = event.target.value;
		let pwMsg = document.getElementById("msg-driverPW");
	    let pwRegExp = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^*()\-_=+\\\|\[\]{};:\'",.<>\/?]).{8,16}$/;
	    
	    if (driverPW === "") {
	    	pwMsg.innerHTML = "<span style='color:#F03F40; font-size:12px;'>비밀번호를 입력해주세요.</span>";
	    }
	    
	    if (!pwRegExp.test(driverPW)) {
	    	pwMsg.innerHTML = "<span style='color:#F03F40; font-size:12px;'>비밀번호는 대소문자, 숫자, 특수문자를 포함한 8~16자여야 합니다.</span>";
	    	return;
	    }
	    pwMsg.innerHTML = "";
	}
	
	// 기사명
	let validateDriverName = (event) => {
		let driverName = event.target.value;
		let nameMsg = document.getElementById("msg-driverName");
		let nameRegExp = /^[가-힣]{2,6}$/;
		
		if (driverName === "") {
			nameMsg.innerHTML = "<span style='color:#F03F40; font-size:12px;'>기사명을 입력해주세요.</span>";
		} else if (!nameRegExp.test(driverName)) {
			nameMsg.innerHTML = "<span style='color:#F03F40; font-size:12px;'>기사명은 2~6글자의 한글만 입력 가능합니다.</span>";
		} else {
			nameMsg.innerHTML = "";
		}
	}
	
	// 기사휴대폰
	let validateDriverMobile = (event) => {
	    // 각 입력 필드의 값을 가져옵니다.
	    let mobile1 = document.getElementById("driverMobile1").value;
	    let mobile2 = document.getElementById("driverMobile2").value;
	    let mobile3 = document.getElementById("driverMobile3").value;
	    let msgDriverMobile = document.querySelector("#msg-driverMobile");
	
	    // 숫자만 입력되도록 처리
	    mobile1 = mobile1.replace(/\D/g, '');
	    mobile2 = mobile2.replace(/\D/g, '');
	    mobile3 = mobile3.replace(/\D/g, '');
	
	    // 각 부분의 길이 제한 (첫 번째는 최대 3자리, 나머지는 최대 4자리)
	    if (mobile1.length > 3) mobile1 = mobile1.substring(0, 3);
	    if (mobile2.length > 4) mobile2 = mobile2.substring(0, 4);
	    if (mobile3.length > 4) mobile3 = mobile3.substring(0, 4);
	
	    // 각 입력 필드에 숫자만 남기고 다시 값 설정
	    document.getElementById("driverMobile1").value = mobile1;
	    document.getElementById("driverMobile2").value = mobile2;
	    document.getElementById("driverMobile3").value = mobile3;
	
	    // 전화번호 형식: 01012341234
	    let fullPhone = mobile1 + mobile2 + mobile3;
	    
	    // 전화번호 유효성 검사 정규식
	    let mobileRegExp = /^\d{3}\d{3,4}\d{4}$/;
	
	    // 전화번호의 모든 부분이 입력되었는지 확인
	    if (mobile1 === "" || mobile2 === "" || mobile3 === "") {
	    	msgDriverMobile.innerHTML = "<span style='color:#F03F40; font-size:12px;'>전화번호의 모든 부분을 입력해주세요.</span>";
	        return;
	    }
	
	    // 전화번호 형식 검사
	    if (!mobileRegExp.test(fullPhone)) {
	    	msgDriverMobile.innerHTML = "<span style='color:#F03F40; font-size:12px;'>전화번호는 지역번호-0000-0000 형식이어야 합니다.</span>";
	        return;
	    }
	
	    // 유효하면 메시지 비우기
	    msgDriverMobile.innerHTML = "";
	};
	
	// 배달 가능 지역
	let validateDriverAvailableArea = (event) => {
	    let driverAvailableArea = event.target.value; // 입력된 값 가져오기
	    let driverAvailableAreaMsg = document.querySelector("#msg-driverAvailableArea"); // 오류 메시지를 표시할 div
	    let driverAvailableAreaRegExp = /^[가-힣]{2,6}$/;
	
	    // 입력값이 없을 경우
	    if (driverAvailableArea === "") {
	    	driverAvailableAreaMsg.innerHTML = "<span style='color:#F03F40; font-size:12px;'>배달가능지역을 입력해주세요.</span>";
	        return; // 유효성 검사 종료
	    }
	      
	    // 정규식으로 유효성 검사
	    if (!driverAvailableAreaRegExp.test(driverAvailableArea)) {
	    	driverAvailableAreaMsg.innerHTML = "<span style='color:#F03F40; font-size:12px;'>주문 가능 지역은 2글자 이상의 한글만 입력 가능합니다.</span>";
	        return; // 유효성 검사 종료
	    }
	
	    // 유효한 아이디일 경우 메시지 비우기
	    driverAvailableAreaMsg.innerHTML = "";
	}
</script>
    