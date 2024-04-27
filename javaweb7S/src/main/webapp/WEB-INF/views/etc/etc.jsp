<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="/WEB-INF/views/include/bs3.jsp" />
  <title>home</title>
<style>
	/* 가로로 나눌 구역의 스타일 */
	.column {
  		float: left;
  		width: calc(50% - 20px); /* 20px는 각 구역의 좌우 마진 크기입니다 */
  		padding: 10px;
  		margin: 10px; /* 구역 사이의 빈 공간을 10px로 설정합니다 */
  		box-sizing: border-box; /* padding과 border 크기를 요소의 총 크기에 포함시킵니다 */
	}

	/* 구역의 테두리 스타일 */
	.row:after {
  		content: "";
  		display: table;
  		clear: both;
	}
</style>
<script>
	'use strict';
	
	function chatCheck(){
		let chat = $("#chat").val();
		
		if(chat == ""){
			alert("내용을 입력해주세요!");
			return false;
			$("#chat").focus();
		}
	
		$.ajax({
			type	:	"post",
			url		:	"${ctp}/etc/chatMessage",
			data	:	{chat : chat},
			success	:	function(){
				location.reload();
			},
			error	:	function(){
				alert("특이사항기록전송실패");
			}
		});
	}
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<br>

<div class="container">
<div class="row">
<!-- 첫 번째 구역 -->
<div class="column" style="background-color:#aaa;">
	<h2>오늘의 날씨</h2>
	<hr/>
	<c:forEach var="list" items="${list}" varStatus="st">
	<c:if test="${fn:substring(list.fcstTime, 0, 4) == '0200' || fn:substring(list.fcstTime, 0, 4) == '0500' || fn:substring(list.fcstTime, 0, 4) == '0800'
	 || fn:substring(list.fcstTime, 0, 4) == '1100' || fn:substring(list.fcstTime, 0, 4) == '1400' || fn:substring(list.fcstTime, 0, 4) == '1700' || fn:substring(list.fcstTime, 0, 4) == '2000' || fn:substring(list.fcstTime, 0, 4) == '2300'}">
		<c:if test="${fn:substring(list.category, 0, 3) == 'POP' }">
			${fn:substring(list.fcstTime,0,2)}시 강수확률은 ${list.fcstValue }% 로,
		</c:if>
		<c:if test="${fn:substring(list.category, 0, 3) == 'PTY' }">
			<c:choose>
				<c:when test="${list.fcstValue == 0}">
					비가 내리지 않습니다.
				</c:when>
				<c:when test="${list.fcstValue == 1}">
					'비'가 내립니다.
				</c:when>
				<c:when test="${list.fcstValue == 2}">
					'비/눈'이 내립니다.
				</c:when>
				<c:when test="${list.fcstValue == 3}">
					'눈'이 내립니다.
				</c:when>
				<c:when test="${list.fcstValue == 4}">
					'소나기'가 내릴 수 도 있습니다.
				</c:when>
			</c:choose>
		</c:if>
		<c:if test="${fn:substring(list.category, 0, 3) == 'SKY' }">
			<c:choose>
				<c:when test="${list.fcstValue == 1}">
					하늘은 무척 맑으며
				</c:when>
				<c:when test="${list.fcstValue == 3}">
					하늘은 구름이 많으며
				</c:when>
				<c:when test="${list.fcstValue == 4}">
					하늘은 흐리며
				</c:when>
			</c:choose>
		</c:if>
		<c:if test="${fn:substring(list.category, 0, 3) == 'PCP' }">
			시간 당 강수량은 [${list.fcstValue }] 예정 입니다.
		</c:if>
		<c:if test="${fn:substring(list.category, 0, 3) == 'SNO' }">
			시간 당 적설량은 [${list.fcstValue }] 예정 입니다.
		</c:if>
		<br/>
	</c:if>
	</c:forEach>
</div>

  <!-- 두 번째 구역 -->
<div class="column" style="background-color:#bbb;">
 	<h2>특이사항</h2>
    <div style="width:460px">
    	<form name="chatform" method="post" action="${ctp }/etc/chatMessage">
    		<label for="chat"><b>주변 특이사항을 기록하세요</b></label>
    		<jsp:include page="chatMessage.jsp" />
    		<iframe src="${ctp }/etc/chatMessage" width="100%" height="350px" class="border"></iframe>
    		<div class="input-group mt-1">
    			<input type="text" name="chat" id="chat" class="form-control" placeholder="주변 특이사항을 입력해주세요" autofocus />
    			<div class="input-group-append">
    				<input type="button" value="등록" class="btn btn-success" onclick="chatCheck()" />
    			</div>
    		</div>
    	</form>
    </div>
</div>
</div>
</div>

</body>
</html>
