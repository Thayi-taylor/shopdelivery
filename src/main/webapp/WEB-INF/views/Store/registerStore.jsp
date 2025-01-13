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
   
    <head>
    <!-- Favicon 설정 -->
    <link rel="icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon">
	</head>


<div class="container">
    <div class="text-center mt-5">
        <h2>매장 회원가입</h2>
    </div>
</div>
<div class="container">
    <div class="d-flex justify-content-center mt-5">
        <form  method="post" action="${contextPath}/Store/registerStorePro.do">
            <label class="mt-3">아이디</label> <!-- for="storeID" 추가 -->
            <div class="input-group mt-3">
                <input type="text" class="form-control" value="asdf1234" id="storeID" name="storeID" oninput="validateStoreID(event)" >
                <div id="msg-storeID"></div>
            </div>

            <label class="mt-3">비밀번호</label> <!-- for="storePW" 추가 -->
            <div class="input-group mt-3">
                <input type="password" class="form-control" value="Asdf1234!"  id="storePW" name="storePW" oninput="validateStorePW(event)" >
                <div id="msg-storePW"></div>
            </div>

            <label class="mt-3">매장명</label> <!-- for="storeName" 추가 -->
            <div class="input-group mt-3">
                <input type="text" class="form-control"  value="꽃집" id="storeName" name="storeName" oninput="validateStoreName(event)" >
                <div id="msg-storeName"></div>
            </div>

            <label class="mt-3" >매장 유선전화</label> <!-- for="storePhone1" 추가 -->
            <div class="input-group mt-3">
                <input type="text" class="form-control"  value="010" id="storePhone1" name="storePhone1" oninput="validateStorePhone(event)">
                -
                <input type="text" class="form-control"  value="1234" id="storePhone2" name="storePhone2" oninput="validateStorePhone(event)">
                -
                <input type="text" class="form-control"  value="1234" id="storePhone3" name="storePhone3" oninput="validateStorePhone(event)"> 
                <div id="msg-storePhone"></div>
            </div>

            <label class="mt-3">매장 휴대전화</label> <!-- for="storeMobile1" 추가 -->
            <div class="input-group mt-3">
                <input type="text" class="form-control"  value="010" id="storeMobile1" name="storeMobile1" oninput="validateStoreMobile(event)">
                -
                <input type="text" class="form-control"   value="1234" id="storeMobile2" name="storeMobile2" oninput="validateStoreMobile(event)">
                -
                <input type="text" class="form-control" value="1234" id="storeMobile3" name="storeMobile3" oninput="validateStoreMobile(event)">
                <div id="msg-storeMobile"></div>
            </div>

            <label class="mt-3">주문 가능 지역</label> <!-- for="storeMap" 추가 -->
            <div class="input-group mt-3">
                <input type="text" class="form-control" id="storeMap" name="storeMap" oninput="validateStoreMap(event)"> 
                <div id="msg-storeMap"></div>
            </div>

            <div class="mt-5" align="center">
                <input type="submit" value="회원가입" class="btn btn-info">
            </div>
        </form>
    </div>
</div>
<br>
<div class="container">
    <div class="d-flex justify-content-center mt-5">
        <a href="/storedelivery/index.do">메인화면</a>
    </div>
</div>
<script>
	let validateStoreID = (event) => {
	    let storeID = event.target.value; // 입력된 값 가져오기
	    let idMsg = document.querySelector("#msg-storeID"); // 오류 메시지를 표시할 div
	    let idRegExp = /^[A-Za-z0-9_\-]{6,16}$/; // 유효성 검사 정규식
	
	    // 입력값이 없을 경우
	    if (storeID === "") {
	    	idMsg.innerHTML = "<span style='color:#F03F40; font-size:12px;'>아이디를 입력해주세요.</span>";
	        return; // 유효성 검사 종료
	    }
	    
	    // 정규식으로 유효성 검사
	    if (!idRegExp.test(storeID)) {
	    	idMsg.innerHTML = "<span style='color:#F03F40; font-size:12px;'>아이디는 6자 이상 16자 이하로 영문, 숫자만 가능합니다.</span>";
	        return; // 유효성 검사 종료
	    }
	
	    // 유효한 아이디일 경우 메시지 비우기
	    idMsg.innerHTML = "";
	}
	
	//비밀번호 
	let validateStorePW= (event) =>{
		let storePW= event.target.value;
		let pwMsg= document.getElementById("msg-storePW");
	    let pwRegExp = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^*()\-_=+\\\|\[\]{};:\'",.<>\/?]).{8,16}$/;
	    if (storePW===""){
	    	pwMsg.innerHTML = "<span style='color:#F03F40; font-size:12px;'>비밀번호를 입력해주세요.</span>";
	    }
	    if (!pwRegExp.test(storePW)){
	    	pwMsg.innerHTML="<span style='color:#F03F40; font-size:12px;'>비밀번호는 대소문자, 숫자, 특수문자를 포함한 8~16자여야 합니다.</span>";
	    	return;
	    }
	    pwMsg.innerHTML="";
	}
	//매장명
	let validateStoreName= (event)=>{
		let storeName= event.target.value;
		let nameMsg= document.getElementById("msg-storeName");
		let nameRegExp= /^[가-힣]{2,6}$/;
		if (storeName===""){
			nameMsg= "<span style='color:#F03F40; font-size:12px;'>매장명을 입력해주세요.</span>";
		}
		if (!nameRegExp.test(storeName)){
			nameMsg.innerHTML="<span style='color:#F03F40; font-size:12px;'>매장명은 2~6글자의 한글만 입력 가능합니다.</span>";
		}
		nameMsg.innerHTML="";
	}
	//매장 유선번호
	let validateStorePhone = (event) => {
	    // 각 입력 필드의 값을 가져옵니다.
	    let phone1 = document.getElementById("storePhone1").value;
	    let phone2 = document.getElementById("storePhone2").value;
	    let phone3 = document.getElementById("storePhone3").value;
	    let msgStorePhone = document.querySelector("#msg-storePhone");
	
	    // 숫자만 입력되도록 처리
	    phone1 = phone1.replace(/\D/g, '');
	    phone2 = phone2.replace(/\D/g, '');
	    phone3 = phone3.replace(/\D/g, '');
	
	    // 각 부분의 길이 제한 (첫 번째는 최대 3자리, 나머지는 최대 4자리)
	    if (phone1.length > 3) phone1 = phone1.substring(0, 3);
	    if (phone2.length > 4) phone2 = phone2.substring(0, 4);
	    if (phone3.length > 4) phone3 = phone3.substring(0, 4);
	
	    // 각 입력 필드에 숫자만 남기고 다시 값 설정
	    document.getElementById("storePhone1").value = phone1;
	    document.getElementById("storePhone2").value = phone2;
	    document.getElementById("storePhone3").value = phone3;
	
	    // 전화번호 형식: 01012341234
	    let fullPhone = phone1 + phone2 + phone3;
	    
	    // 전화번호 유효성 검사 정규식
	    let phoneRegExp = /^\d{2,3}\d{3,4}\d{4}$/;
	
	    // 전화번호의 모든 부분이 입력되었는지 확인
	    if (phone1 === "" || phone2 === "" || phone3 === "") {
	        msgStorePhone.innerHTML = "<span style='color:#F03F40; font-size:12px;'>전화번호의 모든 부분을 입력해주세요.</span>";
	        return;
	    }
	
	    // 전화번호 형식 검사
	    if (!phoneRegExp.test(fullPhone)) {
	        msgStorePhone.innerHTML = "<span style='color:#F03F40; font-size:12px;'>전화번호는 지역번호-0000-0000 형식이어야 합니다.</span>";
	        return;
	    }
	
	    // 유효하면 메시지 비우기
	    msgStorePhone.innerHTML = "";
	};
	//매장 휴대전화 
	let validateStoreMobile = (event) => {
	    // 각 입력 필드의 값을 가져옵니다.
	    let mobile1 = document.getElementById("storeMobile1").value;
	    let mobile2 = document.getElementById("storeMobile2").value;
	    let mobile3 = document.getElementById("storeMobile3").value;
	    let msgStoreMobile = document.querySelector("#msg-storeMobile");
	
	    // 숫자만 입력되도록 처리
	    mobile1 = mobile1.replace(/\D/g, '');
	    mobile2 = mobile2.replace(/\D/g, '');
	    mobile3 = mobile3.replace(/\D/g, '');
	
	    // 각 부분의 길이 제한 (첫 번째는 최대 3자리, 나머지는 최대 4자리)
	    if (mobile1.length > 3) mobile1 = mobile1.substring(0, 3);
	    if (mobile2.length > 4) mobile2 = mobile2.substring(0, 4);
	    if (mobile3.length > 4) mobile3 = mobile3.substring(0, 4);
	
	    // 각 입력 필드에 숫자만 남기고 다시 값 설정
	    document.getElementById("storeMobile1").value = mobile1;
	    document.getElementById("storeMobile2").value = mobile2;
	    document.getElementById("storeMobile3").value = mobile3;
	
	    // 전화번호 형식: 01012341234
	    let fullMobile = mobile1 + mobile2 + mobile3;
	    
	    // 전화번호 유효성 검사 정규식
	    let mobileRegExp = /^\d{2,3}\d{3,4}\d{4}$/;
	
	    // 전화번호의 모든 부분이 입력되었는지 확인
	    if (mobile1 === "" || mobile2 === "" || mobile3 === "") {
	        msgStoreMobile.innerHTML = "<span style='color:#F03F40; font-size:12px;'>휴대전화의 모든 부분을 입력해주세요.</span>";
	        return;
	    }
	
	    // 전화번호 형식 검사
	    if (!mobileRegExp.test(fullMobile)) {
	        msgStoreMobile.innerHTML = "<span style='color:#F03F40; font-size:12px;'>휴대전화는 010-0000-0000 형식이어야 합니다.</span>";
	        return;
	    }
	
	    // 유효하면 메시지 비우기
	    msgStoreMobile.innerHTML = "";
	};
	//주문 가능 지역
	let validateStoreMap = (event) => {
	    let storeID = event.target.value; // 입력된 값 가져오기
	    let mapMsg = document.querySelector("#msg-storeMap"); // 오류 메시지를 표시할 div
	    let mapRegExp = /^[가-힣]{2,6}$/;
	
	    // 입력값이 없을 경우
	    if (storeMap === "") {
	    	mapMsg.innerHTML = "<span style='color:#F03F40; font-size:12px;'> 주문가능지역을 입력해주세요.</span>";
	        return; // 유효성 검사 종료
	    }
	    
	    // 정규식으로 유효성 검사
	    if (!mapRegExp.test(storeID)) {
	    	mapMsg.innerHTML = "<span style='color:#F03F40; font-size:12px;'>주문 가능 지역은 2글자 이상의 한글만 입력 가능합니다.</span>";
	        return; // 유효성 검사 종료
	    }
	
	    // 유효한 아이디일 경우 메시지 비우기
	    mapMsg.innerHTML = "";
	}

/*
function checkJoin2() {
    // 각 필드의 값을 가져옵니다.
   	let id= document.querySelector("#storeID");
	let pw= document.querySelector("#storePW");
	let name= document.querySelector("#storeName");
	let phone1=document.querySelector("#storePhone1");
	let phone2= document.querySelector("#storePhone2");
	let phone3= document.querySelector("#storePhone3");
	let mobile1= document.querySelector("#storeMobile1");
	let mobile2= document.querySelector("#storeMobile2");
	let mobile3= document.querySelector("#storeMobile3");
	let map= document.querySelector("#storeMap");
	

	let valid = true;  // 초기 값은 true (유효)

    // 아이디 유효성 검사
    let idMsg = document.getElementById("msg-storeID");
    let idRegExp = /^[A-Za-z0-9_\-]{6,16}$/;
    if (id.value === "") {
        alert("아이디를 입력해주세요.");
        valid = false;
    } else if (!idRegExp.test(id.value)) {
        idMsg.innerHTML = "<span style='color:#F03F40; font-size:12px;'>아이디는 6자 이상 16자 이하로 영문, 숫자만 가능합니다.</span>";
       	id.value="";
        valid = false;
    } else {
        idMsg.innerHTML = "";
    }
    //비밀번호 유효성 검사 
    
    let pwMsg= document.getElementById("msg-storePW");
    let pwRegExp = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^*()\-_=+\\\|\[\]{};:\'",.<>\/?]).{8,16}$/;
    if (pw.value===""){
    	alert("비밀번호를 입력해주세요.");
    	pw.focus();
    	valid=false;
    }else if (!pwRegExp.test(pw.value)){
    	pwMsg.innerHTML="<span style='color:#F03F40; font-size:12px;'>비밀번호는 대소문자, 숫자, 특수문자를 포함한 8~16자여야 합니다.</span>";
    	valid=false;
    }else{
    	pwMsg.innerHTML="";
    }
    //이름 유효성 검사 
    let nameMsg= document.getElementById("msg-storeName");
    let nameRegExp= /^[가-힣]{2,6}$/;
    if (name.value===""){
 		alert("이름을 입력해주세요");
 		valid.false;
    }else if (!nameRegExp.test(name.value)){
    	nameMsg.innerHTML="<span style='color:#F03F40; font-size:12px;'>매장명은 2~6글자의 한글만 입력 가능합니다.</span>";
    	valid.false;
    }else{
    	nameMsg.innerHTML="";
    }
    //전화번호 유효성 검사 
    let phoneMsg= document.getElementById("msg-storePhone");
    let phoneRegExp=/^[0-9]{3,4}$/;
    if (phone1.value===""||phone2.value===""||phone3.value===""){
    	alert("매장 유선전화를 모두 입력하세요");
    	valid.false;
    }else if (!phoneRegExp.test(phone1.value)||!phoneRegExp.test(phone2.value)||!phoneRegExp.test(phone3.value)){
    	 phoneMsg.innerHTML = "<span style='color:#F03F40; font-size:12px;'>매장 유선전화는 숫자만 입력 가능하며 각 부분은 2자리 또는 3자리 또는 4자리여야 합니다.</span>";
         valid = false;
    }else{
    	phoneMsg.innerHTML="";
    }
    //핸드폰 유효성 검사 
    let MobileMsg= document.getElementById("msg-storeMobile");
    let mobileRegExp=/^[0-9]{3,4}$/;
    if (mobile1.value===""||mobile2.value===""||mobile3.value===""){
    	alert("매장 휴대전화를 모두 입력하세요");
    	value=false;
    }else if (!mobileRegExp.test(mobile1.value)||!mobileRegExp.test(mobile2.value)||!mobileRegExp.test(mobile3.value)){
    	MobileMsg.innerHTML = "<span style='color:#F03F40; font-size:12px;'>매장 휴대전화는 숫자만 입력 가능하며 각 부분은 3자리 또는 4자리여야 합니다.</span>";
    }else{
    	MobileMsg.innerHTML="";
    }
    //주문 가능 지역 유효성 검사 
    let mapMsg= document.getElementById("msg-storeMap");
    let mapRegExp=/^[가-힣]{2,6}$/;
    if (map.value===""){
    	alert("주문 가능 지역을 입력하세요");
    	valid.false;
    }else if (!mapRegExp.test(map.value)){
    	mapMsg.innerHTML="<span style='color:#F03F40; font-size:12px;'>주문 가능 지역은 2글자 이상의 한글만 입력 가능합니다.</span>";
		valid.false;
    }else{
    	mapMsg.innerHTML="";
    }
    
    if (valid){
    	let formData= document.querySelector(".formData");
    	formData.submit();
    }
}
	*/
		
	
</script>
