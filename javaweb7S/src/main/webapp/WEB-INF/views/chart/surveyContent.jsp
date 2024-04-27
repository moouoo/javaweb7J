<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<title>surveyContent.jsp</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<div class="container">
		<h2>설문조사내용</h2>
		<p><br/></p>
		<table class="table table-bordered">
		<c:forEach var="vo" items="${vos }">
			<tr>
				<th>제목</th>
				<td colspan="3">${vo.STitle }</td>
			</tr>
			<tr>
				<th>등록날짜</th>
				<td>${fn:substring(vo.IYear, 0, 10) }</td>
				<th>조회수</th>
				<td>${vo.readNum }</td>
			</tr>
			<tr>
				<td colspan="4">${vo.content }</td>
			</tr>
		</c:forEach>
		</table>
	</div>
</body>
</html>