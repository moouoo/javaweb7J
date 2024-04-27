<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<title>chart.jsp</title>
<script>
	'use strict';
	
	function chartChange(){
		let part = document.getElementById("part").value;
		location.href = '${ctp}/chart/chart?part='+part;
	}
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<div class="container">
		<h2>통계</h2>
		<p><br/></p>
		<div>
			<p>차트를 선택하세요
				<select name="part" id="part" onchange="chartChange()">
					<option value="">선택</option>
					<option value="opt1" ${part == 'opt1'? 'selected' : '' }>총수익 / 총비용</option>
					<option value="opt2" ${part == 'opt2'? 'selected' : '' }>년도 별 수익 / 비용</option>
					<option value="opt3" ${part == 'opt3'? 'selected' : '' }>비용 별 퍼센트</option>
				</select>
			</p>
			<hr/>
			<div>
				<c:if test="${part == 'opt1' }"><jsp:include page="opt1.jsp" /></c:if>
				<c:if test="${part == 'opt2' }"><jsp:include page="opt2.jsp" /></c:if>
				<c:if test="${part == 'opt3' }"><jsp:include page="opt3.jsp" /></c:if>
			</div>
		</div>
	</div>
</body>
</html>