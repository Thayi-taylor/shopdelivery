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
     <style>
        
     
      </style>
</head>
<body>
    
  <div class="container mt-5" style="margin-bottom: 5px;">
    <div class="row">

      <!-- 인수증 -->
      <div class="col-md-6 border p-4">
        <h4 class="text-center">인 수 증</h4>
      <!--
        <p><strong>경조화환, 동양란, 서양란 전문</strong>
          <br>
          서울 영등포구 여의대방로27길 5 <br>
          1층 5004플라워
          <br>Tel: 1588-5422
      -->
      <!-- 
        <input type="text" name="storeLocation" class="storeLocation">
        <br><br>
        T : / M : 
       </p>
      -->
        <hr>
        <table class="table table-bordered">
            <tr>
              <th class="text-center">품명</th>
              <td><input type="text" name="productName" class="form-control form-control-sm" value="${order.productName}" readonly="readonly"></td>
              <th>수량</th>
              <td><input type="number" name="productCount" class="form-control form-control-sm" value="${order.productCount}" readonly="readonly"></td>
            </tr>
            <tr>
              <th class="text-center">경조사어</th>
              <td colspan="3"><input type="text" name="occasionPhrase" class="form-control form-control-sm" value="${order.occasionPhrase}" readonly="readonly"></td>
            </tr>
            <tr>
              <th class="text-center">보내는이</th>
              <td colspan="3"><input type="text" name="senderName" class="form-control form-control-sm" value="${order.senderName}" readonly="readonly"></td>
            </tr>
            <tr>
              <th class="text-center">배달장소</th>
              <td colspan="3">
                <input type="text" id="input-deliveryAddress1" name="deliveryAddress1" class="form-control form-control-sm me-2" style="margin-bottom: 3px;" value="${order.deliveryAddress1}" readonly="readonly">
                <input type="text" id="input-deliveryAddress2" name="deliveryAddress2" class="form-control form-control-sm" value="${order.deliveryAddress2}" readonly="readonly">
                <br>
              <div class="d-flex gap-2">
                TEL : 
                  <input type="text" class="form-control" maxlength="3" style="width: 55px;" value="${order.receiverNumber1}" readonly="readonly">
                  -
                  <input type="text" class="form-control" maxlength="4" style="width: 65px;" value="${order.receiverNumber2}" readonly="readonly">
                  -
                  <input type="text" class="form-control" maxlength="4" style="width: 65px;" value="${order.receiverNumber3}" readonly="readonly">
              </div>
              <br>
              <div class="d-flex gap-2">
                휴대폰 : 
                <input type="text" class="form-control" maxlength="3" style="width: 55px;" value="${order.receiverPhoneNumber1}" readonly="readonly">
                  -
                <input type="text" class="form-control" maxlength="4" style="width: 65px;" value="${order.receiverPhoneNumber2}" readonly="readonly">
                  -
                <input type="text" class="form-control" maxlength="4" style="width: 65px;" value="${order.receiverPhoneNumber3}" readonly="readonly">
              </div>
              </td>
            </tr>
            <tr>
              <th class="text-center">배달일시</th>
              <td colspan="3"><input type="datetime" name="deliveryDatetime" class="form-control form-control-sm" value="${order.deliveryDatetime}" readonly="readonly"></td>
            </tr>
            <tr>
              <th class="text-center">참고사항</th>
              <td colspan="3">
                <textarea name="orderNote" class="form-control form-control-sm" style="width: 100%; height: 150px;" readonly>${order.orderNote}</textarea>
                <br>
                주문일시 : 
                <input type="datetime" name="orderDatetime" class="form-control form-control-sm" value="${order.orderDatetime}" readonly="readonly">
                <br>
                받는 분 : 
                <input type="text" name="recipientName" class="form-control form-control-sm" value="${order.recipientName}" readonly="readonly">
              </td>
            </tr>
            <tr>
              <th class="text-center" style="width: 20%;">
              	인수<br>하신 분
              </th>
             <td colspan="3" style="padding: 0;">
             	<table style="width: 100%; border-collapse: collapse;">
             		<tr>
             			<td class="text-start" style="width: 50%; border-right: 1px solid #dee2e6; font-size: smaller; padding: 5px; verical-align: top;">
              				<span style="color: #848484;">(반드시 성명으로 기록바랍니다)</span>
             			</td>
             <td style="width: 50%; padding: 0;">
             	<table style="width: 100%; height: 100%; border-collapse: collapse;">
             		<tr>
             		<td class="text-center" style="width: 50%; border-right: 1px solid #dee2e6;">
             			인수시간
             		</td>
             		<td class="text-center" style="width: 50%; padding: 5px;">
             			___시 ___분
             		</td>
             		</tr>
             		<tr>
             		<td colspan="2" class="text-center" style="border-top: 1px solid #dee2e6; padding-top: 5px;">
             		 (서명)
             		</td>
             	</tr>
            	</table>
             </td>
            </tr>
           </table>
           </td>
           </tr>
        </table>
        <!--
          <p class="text-center">
            <br>
            <strong>온라인 계좌번호</strong>
            <br>
            국민 : _____<br>우리 : _____<br>농협 : _____
          </p>
        -->
        <p>
          <strong>매장 계좌번호</strong>
          <input type="text" name="storeAccountNumber" class="form-control form-control-sm">
        </p> 

      </div>

<!-- ================================================================== -->

      <!-- 주문 의뢰서 -->
      <div class="col-md-6 border p-4">
        <h4 class="text-center">주문 의뢰서</h4>
        <table class="table table-bordered">
            <tr>
              <th class="text-center">회사명</th>
              <td colspan="3"><input type="text" name="storeName" class="form-control form-control-sm"></td>
            </tr>
            <tr>
              <th class="text-center">품명</th>
              <td colspan="3"><input type="text" name="productName" class="form-control form-control-sm" value="${order.productName}" readonly="readonly"></td>
            </tr>
            <tr>
              <th class="text-center">단가</th>
              <td><input type="text" name="productUnitPrice" class="form-control form-control-sm" value="${order.productUnitPrice}" readonly="readonly"></td>
              <th class="text-center">수량</th>
              <td><input type="number" name="productCount" class="form-control form-control-sm" value="${order.productCount}" readonly="readonly"></td>
              <!--
                <th class="text-center">발주자</th>
                <td><input type="text" name="orderStoreName" class="form-control form-control-sm"></td>
                -->
                </tr>
              <tr>
                <th class="text-center">금액</th>
                <td><input type="text" name="orderAmount" class="form-control form-control-sm" value="${order.orderAmount}" readonly="readonly"></td>
              </tr>
            <tr>
              <th class="text-center">주문일시</th>
              <td colspan="3"><input type="datetime" name="orderDatetime" class="form-control form-control-sm" value="${order.orderDatetime}" readonly="readonly"></td>
            </tr>
            <tr>
              <th class="text-center">배달일시</th>
              <td colspan="3"><input type="datetime" name="deliveryDatetime" class="form-control form-control-sm" value="${order.deliveryDatetime}" readonly="readonly"></td>
            </tr>
            <tr>
              <th class="text-center">배달장소</th>
              <td colspan="3">
                <input type="text" id="input-deliveryAddress1" name="deliveryAddress1" class="form-control form-control-sm me-2" style="margin-bottom: 3px;" value="${order.deliveryAddress1}" readonly="readonly">
                <input type="text" id="input-deliveryAddress2" name="deliveryAddress2" class="form-control form-control-sm" value="${order.deliveryAddress2}" readonly="readonly">
                <br>
                받는 분 : <input type="text" name="recipientName" class="form-control form-control-sm" value="${order.recipientName}" readonly="readonly">
                <br>
                <div class="d-flex gap-2">
                  TEL : 
                   <input type="text" class="form-control" name="receiverNumber1" maxlength="3" style="width: 55px;" value="${order.receiverNumber1}" readonly="readonly">
                   -
                   <input type="text" class="form-control" name="receiverNumber2" maxlength="4" style="width: 65px;" value="${order.receiverNumber2}" readonly="readonly">
                   -
                   <input type="text" class="form-control" name="receiverNumber3" maxlength="4" style="width: 65px;" value="${order.receiverNumber3}" readonly="readonly">
                </div>
               <br>
               <div class="d-flex gap-2">
                  휴대폰 : 
                  <input type="text" class="form-control" name="receiverPhoneNumber1" maxlength="3" style="width: 55px;" value="${order.receiverPhoneNumber1}" readonly="readonly">
                  -
                  <input type="text" class="form-control" name="receiverPhoneNumber2" maxlength="4" style="width: 65px;" value="${order.receiverPhoneNumber2}" readonly="readonly">
                  -
                  <input type="text" class="form-control" name="receiverPhoneNumber3" maxlength="4" style="width: 65px;" value="${order.receiverPhoneNumber3}" readonly="readonly">
               </div>
              </td>
            <tr>  
              <th class="text-center">내용</th>
              <td colspan="3">
                경조사어 : <input type="text" name="occasionPhrase" class="form-control form-control-sm" value="${order.occasionPhrase}" readonly="readonly">
                <br>
                보내는 이 : <input type="text" name="senderName" class="form-control form-control-sm" value="${order.senderName}" readonly="readonly">
              </td>
            </tr>
            <tr>
              <th class="text-center">참고</th>
              <td colspan="3">
                <textarea name="orderNote" class="form-control form-control-sm" style="width: 100%; height: 150px;" readonly>${order.orderNote}</textarea>
              </td>
            </tr>
        </table>
      </div>
    </div>
  </div>
  
  </body>
  </html>