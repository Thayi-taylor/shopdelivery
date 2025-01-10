<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/style.css" />

<div class="nav">
	<a href="${contextPath}/order/orderInsertForm.do">주문작성</a>
	<a href="${contextPath}/order/orderList.do">주문리스트</a>
</div>