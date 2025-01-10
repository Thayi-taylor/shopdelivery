<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <!-- 부트스트랩 5.2.3 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
        crossorigin="anonymous"></script>    
    <!-- 부트스트랩 5.2.3 -->   
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
     <style>
        #ul-productList {
        	list-style-type: none;
        	padding: 0;
        	margin: 0;
        	position: absolute;	/* 위치를 절대적으로 설정 */
        	background-color: white;
        	border: 1px solid #ccc;
        	max-height: 200px;
        	overflow-y: auto;	/* 내용이 넘칠 경우 스크롤 */
        	z-index: 1000;	/* 다른 요소들 위에 표시 */
        	top: 100%;	/* input-productName 바로 밑에 표시되도록 설정 */
        	left: 0;
        }
        
        #ul-productList li {
        	padding: 5px;
        	cursor: pointer;
        }
        
        #ul-productList li:hover {
        	background-color: #f1f1f1;	/* 항목 위에 마우스를 올리면 배경색 변경 */
        }
     
      </style>
</head>
<body>
      <div class="container mt-5">
    <div class="row justify-content-center">
      
      <!-- 주문 의뢰서 -->
      <div class="col-md-6 border p-3">
        <h4 class="text-center">주문 의뢰서</h4>

        <form onsubmit="return inputorderInsertProClick(event)" class="orderData" method="post" action="${contextPath}/order/orderInsert.do">

          <table class="table table-bordered">
            <tr>
              <th class="text-center">* 회사명</th>
              <td colspan="3"><input type="text" name="storeName" class="form-control form-control-sm"></td>
            </tr>
          <tr>
            <th class="text-center">* 품명</th>
            <td colspan="3">
            <div class="d-flex align-items-center" style="position: relative;">
            <input type="text" id="input-productName" name="productName" class="form-control form-control-sm me-2" onkeyup="searchProducts()" autocomplete="off">
            <!-- 드롭다운 리스트 -->
            <ul id="ul-productList"></ul>
            <button onclick="" class="form-control form-control-sm" style="width: 90px;">품목검색</button>
            </div>
            </td>
          </tr>
          <tr>
            <th class="text-center">* 단가</th>
            <td><input type="number" id="input-productUnitPrice" name="productUnitPrice" class="form-control form-control-sm" readonly></td>
            <th class="text-center">* 수량</th>
            <td><input type="number" id="input-productCount" min="1" name="productCount" class="form-control form-control-sm" oninput="calculateAmount()"></td>
            <!--
              <th class="text-center">발주자</th>
              <td><input type="text" name="orderStoreName" class="form-control form-control-sm"></td>
              -->
              </tr>
            <tr>
              <th class="text-center">* 금액</th>
              <td><input type="text" id="input-orderAmount" name="orderAmount" class="form-control form-control-sm"></td>
            </tr>
            <tr>
              <th class="text-center">* 주문일시</th>
              <td colspan="3">
                <input type="datetime-local" id="input-orderDatetime" name="orderDatetime" class="form-control form-control-sm">
              </td>
            </tr>
            <tr>
              <th class="text-center">* 배달일시</th>
              <td colspan="3"><input type="datetime-local" id="input-deliveryDatetime" name="deliveryDatetime" class="form-control form-control-sm"></td>
            </tr>
            <tr>
              <th class="text-center">* 배달장소</th>
              <td colspan="3">
              <div class="d-flex align-items-center mb-1">
                <input type="text" id="input-deliveryAddress1" name="deliveryAddress1" class="form-control form-control-sm me-2">
                  <button type="button" onclick="execDaumPostcode()" class="form-control form-control-sm" style="width: 90px;">주소검색</button>
                </div>
                <div class="mb-3">
                  <input type="text" id="input-deliveryAddress2" name="deliveryAddress2" class="form-control form-control-sm">
                </div>
                * 받는 분 : <input type="text" id="input-recipientName" name="recipientName" class="form-control form-control-sm">
                <br>
                <div class="d-flex gap-2 mb-2">
                  TEL : 
                  <select name="receiverNumber1" class="form-control form-control-sm" style="width: 45px;">
                    <option value="02">02</option>
                    <option value="031">031</option>
                    <option value="032">032</option>
                    <option value="033">033</option>
                    <option value="070">070</option>
                    <option value="080">080</option>
                  </select>
                  -
                  <input type="text" id="input-receiverNumber2" class="form-control" name="receiverNumber2" maxlength="4" style="width: 65px;">
                  -
                  <input type="text" id="input-receiverNumber3" class="form-control" name="receiverNumber3" maxlength="4" style="width: 65px;">
                </div>
                <h5 id="msg-tel_phone" style="font-size: 13px; margin-bottom: 2%; color: rgb(197, 197, 197);"></h5>
                <br>
                <div class="d-flex gap-2">
                  * 휴대폰 : 
                 <select name="receiverPhoneNumber1" class="form-control form-control-sm" style="width: 45px;">
                    <option value="010">010</option>
                    <option value="011">011</option>
                    <option value="016">016</option>
                    <option value="017">017</option>
                    <option value="018">018</option>
                    <option value="019">019</option>
                  </select>
                 -
                 <input type="text" id="input-receiverPhoneNumber2" class="form-control" name="receiverPhoneNumber2" maxlength="4" style="width: 65px;">
                 -
                 <input type="text" id="input-receiverPhoneNumber3" class="form-control" name="receiverPhoneNumber3" maxlength="4" style="width: 65px;">
                </div>
                
              </td>
              <tr>  
                <th class="text-center">* 내용</th>
                <td colspan="3">
                경조사어 : <input type="text" id="input-occasionPhrase" name="occasionPhrase" class="form-control form-control-sm">
                  <br>
                보내는 이 : <input type="text" id="input-senderName" name="senderName" class="form-control form-control-sm">
              </td>
            </tr>
            <tr>
              <th class="text-center">참고</th>
              <td colspan="3">
                <textarea id="textarea-orderNote" name="orderNote" class="form-control form-control-sm" style="width: 100%; height: 150px;"></textarea>
              </td>
            </tr>
          </table>
            <input id="input-productIndex" name="productIndex" type="hidden">
            <input id="input-orderInsertPro" class="form-control" type="submit" value="작성 완료">
        </form>

        </div>
      </div>
    </div>  
      
      <script>
      
      // tel/휴대폰 유효성검사
          let inputreceiverNumber2Input = (event) =>{
            let $msgTel_Phone = document.querySelector("#msg-tel_phone");

            let regExp = RegExp(/^([0-9]{3,4})$/);
            if(regExp.test($inputreceiverNumber2.value)) {
              $msgTel_Phone.innerHTML = "";
            }else{
              $msgTel_Phone.innerHTML = "3-4자리의 전화번호를 입력해주세요.";
            }
          }
          let inputreceiverNumber3Input = (event) =>{
            let $msgTel_Phone = document.querySelector("#msg-tel_phone");
            
            let regExp = RegExp(/^([0-9]{4})$/);
            if(regExp.test($inputreceiverNumber3.value)) {
              $msgTel_Phone.innerHTML = "";
            }else{
              $msgTel_Phone.innerHTML = "4자리의 전화번호 입력해주세요.";
            }
          } 

          let inputreceiverPhoneNumber2Input = (event) =>{
            let $msgTel_Phone = document.querySelector("#msg-tel_phone");

            let regExp = RegExp(/^([0-9]{3,4})$/);
            if(regExp.test($inputreceiverPhoneNumber2.value)) {
              $msgTel_Phone.innerHTML = "";
            }else{
              $msgTel_Phone.innerHTML = "3-4자리의 휴대폰번호를 입력해주세요.";
            }
          }
          let inputreceiverPhoneNumber3Input = (event) =>{
            let $msgTel_Phone = document.querySelector("#msg-tel_phone");

            let regExp = RegExp(/^([0-9]{4})$/);
            if(regExp.test($inputreceiverPhoneNumber3.value)) {
              $msgTel_Phone.innerHTML = "";
            }else{
              $msgTel_Phone.innerHTML = "4자리의 휴대폰번호를 입력해주세요.";
            }
          }
     

          // 필수항목(*) 공백확인
          let inputorderInsertProClick = (event) => {
            
            let regExp3 = RegExp(/^([0-9]{3,4})$/);
            let regExp4 = RegExp(/^([0-9]{4})$/);

            event.preventDefault();

            /*
            if($inputstoreName.value == "") {
              $inputstoreName.focus();
              alert("회사명을 입력해주세요 :)");
              return false;
            }
            */
            if($inputproductName.value == "") {
              $inputproductName.focus();
              alert("품명을 입력해주세요 :)");
              return false;
            }
            if($inputproductUnitPrice.value == "") {
              $inputproductUnitPrice.focus();
              alert("단가를 입력해주세요 :)");
              return false;
            }
            if($inputproductCount.value == "") {
              $inputproductCount.focus();
              alert("수량을 입력해주세요 :)");
              return false;
            }
            if($inputorderAmount.value == "") {
              $inputorderAmount.focus();
              alert("금액을 입력해주세요 :)");
              return false;
            }
            if($inputorderDatetime.value == "") {
              $inputorderDatetime.focus();
              alert("주문일시를 입력해주세요 :)");
              return false;
            }
            if($inputdeliveryDatetime.value == "") {
              $inputdeliveryDatetime.focus();
              alert("배달일시를 입력해주세요 :)");
              return false;
            }
            if($inputdeliveryAddress1.value == "") {
              $inputdeliveryAddress1.focus();
              alert("본주소를 입력해주세요 :)");
              return false;
            }
            if($inputdeliveryAddress2.value == "") {
              $inputdeliveryAddress2.focus();
              alert("상세주소를 입력해주세요 :)");
              return false;
            }
            if($inputrecipientName.value == "") {
              $inputrecipientName.focus();
              alert("받는 분을 입력해주세요 :)");
              return false;
            }
            
            
     		if($inputreceiverNumber2.value != ""){ 			
    	        if(!regExp3.test($inputreceiverNumber2.value)){
    	          $inputreceiverNumber2.focus();
    	          alert("전화번호 형식을 확인해주세요 :)");
    	          return false;
    	        }
     		}
     		if($inputreceiverNumber2.value != ""){ 			
    	        if(!regExp4.test($inputreceiverNumber3.value)){
    	          $inputreceiverNumber3.focus();
    	       	  alert("전화번호 형식을 확인해주세요 :)");
    	          return false;
    	        }
     		}
            if($inputreceiverPhoneNumber2.value == "") {
              $inputreceiverPhoneNumber2.focus();
              alert("휴대폰번호 앞자리를 입력해주세요 :)");
              return false;
            }
    	    if(!regExp3.test($inputreceiverPhoneNumber2.value)){
    	      $inputreceiverPhoneNumber2.focus();
    	      alert("휴대폰번호 형식을 확인해주세요 :)");
    	      return false;
    	    }
            if($inputreceiverPhoneNumber3.value == "") {
              $inputreceiverPhoneNumber3.focus();
              alert("휴대폰번호 뒷자리를 입력해주세요 :)");
              return false;
            }
    	   	if(!regExp4.test($inputreceiverPhoneNumber3.value)){
    	   	  $inputreceiverPhoneNumber3.focus();
    	      alert("휴대폰번호 형식을 확인해주세요 :)");
    	      return false;
    	    }
            
    	   	
            if($inputoccasionPhrase.value == "") {
              $inputoccasionPhrase.focus();
              alert("경조사어를 입력해주세요 :)");
              return false;
            }
            if($inputsenderName.value == "") {
              $inputsenderName.focus();
              alert("보내는 이를 입력해주세요 :)");
              return false;
            }
            
            document.querySelector("form.orderData").submit();
            return true;
          };
          
    //---------------------------------------------------------------------------------------------------
      	/* 우편번호 검색 기능 */
      	let execDaumPostcode = (event) => {
      		new daum.Postcode( {
      			oncomplete: function(data) {
      				document.querySelector("#input-deliveryAddress1").value = data.address;
      				
      				document.querySelector("#input-deliveryAddress2").focus();
      			}
      		}).open();
      	}
      	
      	/* 품목명 검색 함수 */
      	function searchProducts() {
      		let productName = document.getElementById('input-productName').value;
          	
          	if(productName.length < 2) {
          		document.getElementById('ul-productList').innerHTML = '';
          		return;
          	}
          	
          	// 서버에 품목명 검색 요청
      		fetch('${contextPath}/order/searchProducts.do?productName=' + productName)
          		.then(response => response.json())
          		.then(data => {
          			let productListHtml = '';
          			data.forEach(product => {
          				let productIndex = product.productIndex;
          				let productName = product.productName;
          				let productUnitPrice = product.productUnitPrice;
          				
          				console.log(productIndex, productName, productUnitPrice);
          				console.log(`\${productName}-\${productUnitPrice}`);
          				
          				// "품목명-단가" 형식으로 드롭다운 항목을 추가
          				productListHtml += `<li onclick="selectProduct('\${productIndex}', '\${productName}', \${productUnitPrice})">\${productName}-\${productUnitPrice}</li>`;
          			});
          			
          			document.getElementById('ul-productList').innerHTML = productListHtml;
          			
          			let inputWidth = document.getElementById('input-productName').offsetWidth;
          			document.getElementById('ul-productList').style.width = inputWidth + 'px';
          		});
	      }
	      	
	      // 드롭다운에서 항목을 선택했을 때 호출되는 함수
	      function selectProduct(productIndex, productName, productUnitPrice) {
	      	// 선택된 품목명과 단가를 입력 칸에 채움
	      	document.getElementById('input-productIndex').value = productIndex;
	      	document.getElementById('input-productName').value = productName;
	      	document.getElementById('input-productUnitPrice').value = productUnitPrice;
	      	
	      	document.getElementById('ul-productList').innerHTML = '';	// 리스트 비우기
	      	document.getElementById('ul-productList').style.display = 'none';	// 드롭다운 숨기기
	      }
	      
	      // 단가와 수량을 기반으로 금액을 자동으로 계산하는 함수
	      function calculateAmount() {
	    	  let unitPrice = parseInt(document.getElementById('input-productUnitPrice').value);
	    	  let quantity = parseInt(document.getElementById('input-productCount').value);
	    	  
	    	  let amount = unitPrice * quantity;
	    	  
	    	  // 금액을 금액 칸에 출력
	    	  document.getElementById('input-orderAmount').value = amount;
	      }
    
      	
      	//----------------------------------------------------------------------------------
      	
      	let $inputreceiverNumber2 = document.querySelector("#input-receiverNumber2");
      $inputreceiverNumber2.addEventListener("input", inputreceiverNumber2Input);

      let $inputreceiverNumber3 = document.querySelector("#input-receiverNumber3");
      $inputreceiverNumber3.addEventListener("input", inputreceiverNumber3Input);
      
      let $inputreceiverPhoneNumber2 = document.querySelector("#input-receiverPhoneNumber2")
      $inputreceiverPhoneNumber2.addEventListener("input", inputreceiverPhoneNumber2Input);
      
      let $inputreceiverPhoneNumber3 = document.querySelector("#input-receiverPhoneNumber3")
      $inputreceiverPhoneNumber3.addEventListener("input", inputreceiverPhoneNumber3Input);

      let $inputorderInsertPro = document.querySelector("#input-orderInsertPro");
      $inputorderInsertPro.addEventListener("click", inputorderInsertProClick);
      
      let $inputstoreName = document.querySelector("#input-storeName");
      let $inputproductName = document.querySelector("#input-productName");
      let $inputproductUnitPrice = document.querySelector("#input-productUnitPrice");
      let $inputproductCount = document.querySelector("#input-productCount");
      let $inputorderAmount = document.querySelector("#input-orderAmount");
      let $inputorderDatetime = document.querySelector("#input-orderDatetime");
      let $inputdeliveryDatetime = document.querySelector("#input-deliveryDatetime");
      let $inputdeliveryAddress1 = document.querySelector("#input-deliveryAddress1");
      let $inputdeliveryAddress2 = document.querySelector("#input-deliveryAddress2");
      let $inputrecipientName = document.querySelector("#input-recipientName");
      let $inputoccasionPhrase = document.querySelector("#input-occasionPhrase");
      let $inputsenderName = document.querySelector("#input-senderName");
   
      </script>
    
  </body>
  </html>