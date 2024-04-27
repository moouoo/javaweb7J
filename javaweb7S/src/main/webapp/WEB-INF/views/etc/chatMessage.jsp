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
<title>chatMessage.jsp</title>
<script>
	$(document).ready(function(){
		document.body.scrollIntoView(false);	// 스크롤바를 강제로 body태그의 마지막으로 위치시킨다.
	});
</script>
</head>
<body>
	<div class="container">
		<table class="tables">
			<c:forEach var="vo" items="${vos }">
			<tr>
				<td>[${fn:substring(vo.CYear, 0, 10) }]  ${vo.mid }: ${vo.chat }<td>
			</tr>
			</c:forEach>
		</table>
	</div>
</body>
</html>