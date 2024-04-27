<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<title>Status.jsp</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container">
	<h2>가축현황</h2>
	<br/>
	<c:forEach var="vo" items="${vos }" varStatus="st">
		<h3>1동</h3><p>(사육단계)</p>
		<br/>
		<table class="table table-hover">
			<tr>
				<th>전체칸수</th>
				<th>가축수</th>
			</tr>
			<tr>
				<td>${vo.TCount }</td>
				<td>${vo.LCount }</td>
			</tr>
		</table>
	</c:forEach>
</div>
</body>
</html>