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
<title>survey.jsp</title>
<script>
	'use strict';
	
	function survetDelete(idx){
		let ans = confirm("목록에서 삭제시키겠습니까?");
		if(!ans) return false;
		
		$.ajax({
			type	:	"post",
			url		:	"${ctp}/chart/surveyDelete",
			data	:	{idx : idx},
			success	:	function(){
				alert("삭제되었습니다.");
				location.reload();
			},
			error	:	function(){
				alert("설문삭제 전송실패");
			}
		});
	}
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<div class="container">
	<h2>설문관리</h2>
	<p><br/></p>
	<div class="row justify-content-end">
		<a href="${ctp }/chart/surveyInput">
			<input type="button" value="설문등록하기" class="btn btn-info m-2" />
		</a>
	</div>
		<table class="table table-hover table-bordered text-center">
			<tr class="table-dark">
				<th><font color="black">번호</font></th>
				<th><font color="black">제목</font></th>
				<th><font color="black">등록날짜</font></th>
				<th><font color="black">조회수</font></th>
				<th><font color="black">비고</font></th>
			</tr>
			<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}" />
			<c:forEach var="vo" items="${vos }">
			<tr>
				<td>${curScrStartNo }</td>
				<td>
					<a href="${ctp }/chart/surveyContent?idx=${vo.idx }" >${vo.STitle }</a>
				</td>
				<td>${fn:substring(vo.IYear, 0, 10) }</td>
				<td>${vo.readNum }</td>
				<td>
					<input type="button" value="삭제" class="btn btn-danger btn-sm" onclick="survetDelete('${vo.idx}')" />
				</td>
			</tr>
			<c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
			</c:forEach>
		</table>	
	</div>
	
<div class="container">
		  <!--페이징처리 -->
   <div class="text-center m-4">
	  <ul class="pagination justify-content-center">
	    <c:if test="${pageVO.page > 1}">
	    	<li class="page-item">
	    		<a class="page-link text-secondary" href="${ctp}/chart/survey?pageSize=${pageVO.pageSize}&page=1">
	    			첫페이지
	    		</a>
	    	</li>
	    </c:if>
	    <c:if test="${pageVO.curBlock > 0}">
	    	<li class="page-item">
	    		<a class="page-link text-secondary" href="${ctp}/chart/surveyM?pageSize=${pageVO.pageSize}&page=${(pageVO.curBlock-1)*pageVO.blockSize + 1}">
	    			이전블록
	    		</a>
	    	</li>
	    </c:if>
	    <c:forEach var="i" begin="${pageVO.curBlock*pageVO.blockSize + 1}" end="${pageVO.curBlock*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
	    	<c:if test="${i <= pageVO.totPage && i == pageVO.page}">
	    		<li class="page-item active">
	    			<a class="page-link text-white bg-secondary border-secondary" href="${ctp}/chart/surveyM?pageSize=${pageVO.pageSize}&page=${i}">
	    				${i}
	    			</a>
	    		</li>
	    	</c:if>
	    	<c:if test="${i <= pageVO.totPage && i != pageVO.page}">
	    		<li class="page-item">
	    			<a class="page-link text-secondary" href="${ctp}/chart/surveyM?pageSize=${pageVO.pageSize}&page=${i}">
	    				${i}
	    			</a>
	    		</li>
	    	</c:if>
	    </c:forEach>
	    <c:if test="${pageVO.curBlock < pageVO.lastBlock}">
	    	<li class="page-item">
	    		<a class="page-link text-secondary" href="${ctp}/chart/surveyM?pageSize=${pageVO.pageSize}&page=${(pageVO.curBlock+1)*pageVO.blockSize + 1}">
	    			다음블록
	    		</a>
	    	</li>
	    </c:if>
	    <c:if test="${pageVO.page < pageVO.totPage}">
	    	<li class="page-item">
	    		<a class="page-link text-secondary" href="${ctp}/chart/surveyM?pageSize=${pageVO.pageSize}&page=${pageVO.totPage}">
	    			마지막페이지
	    		</a>
	    	</li>
	    </c:if>
	  </ul>
  </div>
</div>
</body>
</html>