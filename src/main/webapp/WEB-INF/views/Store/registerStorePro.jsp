<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:if test="${check==-1 }">
	<script>
		alert("아이디중복");
		//location.href="${contextPath}/Store/registerStore.do";
	</script>
</c:if>
<c:if test="${check==1 }">
	<script>
		alert("회원가입을 축하합니다");
		//location.href="${contextPath}/User/login.do";
	</script>
</c:if>