<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>registrationSearch.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />

</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container">
  <h2 class="text-center">검 색 리 스 트</h2>
  <div class="text-center">
  	(<font color="blue">${searchTitle}</font>(으)로 <font color="red">${pageVO.searchString}</font>(을)를 검색한 결과 <font color="blue"><b>${pageVO.totRecCnt}</b></font>건이 검색되었습니다.)
  </div>
  <br/>
  <table class="table table-borderless m-0 p-0">
    <tr>
      <td><a href="${ctp}/livestock/registrationList?pag=${pageVO.page}&pageSize=${pageVO.pageSize}" class="btn btn-info btn-sm">돌아가기</a></td>
    </tr>
  </table>
  <table class="table table-hover text-center">
    <tr class="table-dark text-dark">
      <th>번호</th>
      <th>개체번호</th>
      <th>출생일</th>
      <th>성별</th>
      <th>기타사항</th>
    </tr>
    <c:set var="searchCount" value="${pageVO.curScrStartNo}"/>
    <c:forEach var="vo" items="${vos}" varStatus="st">
      <tr>
        <td>${searchCount}</td>
       <td>
        	<a data-toggle="modal" data-target="#detailModal" onclick="detailCheck('${vo.CNum}', '${vo.gender }')" class="hover">${vo.CNum }</a>
        </td>
        <td>${fn:substring(vo.birthday, 0, 10) }</td>
        <td>${vo.gender }</td>
        <td>${vo.etc }</td>
      </tr>
      <c:set var="searchCount" value="${searchCount - 1}"/>
    </c:forEach>
  </table>
  
   <!--페이징처리 -->
   <div class="text-center m-4">
	  <ul class="pagination justify-content-center">
	    <c:if test="${pageVO.page > 1}">
	    	<li class="page-item">
	    		<a class="page-link text-secondary" href="${ctp}/livestock/registrationList?pageSize=${pageVO.pageSize}&page=1">
	    			첫페이지
	    		</a>
	    	</li>
	    </c:if>
	    <c:if test="${pageVO.curBlock > 0}">
	    	<li class="page-item">
	    		<a class="page-link text-secondary" href="${ctp}/livestock/registrationList?pageSize=${pageVO.pageSize}&page=${(pageVO.curBlock-1)*pageVO.blockSize + 1}">
	    			이전블록
	    		</a>
	    	</li>
	    </c:if>
	    <c:forEach var="i" begin="${pageVO.curBlock*pageVO.blockSize + 1}" end="${pageVO.curBlock*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
	    	<c:if test="${i <= pageVO.totPage && i == pageVO.page}">
	    		<li class="page-item active">
	    			<a class="page-link text-white bg-secondary border-secondary" href="${ctp}/livestock/registrationList?pageSize=${pageVO.pageSize}&page=${i}">
	    				${i}
	    			</a>
	    		</li>
	    	</c:if>
	    	<c:if test="${i <= pageVO.totPage && i != pageVO.page}">
	    		<li class="page-item">
	    			<a class="page-link text-secondary" href="${ctp}/livestock/registrationList?pageSize=${pageVO.pageSize}&page=${i}">
	    				${i}
	    			</a>
	    		</li>
	    	</c:if>
	    </c:forEach>
	    <c:if test="${pageVO.curBlock < pageVO.lastBlock}">
	    	<li class="page-item">
	    		<a class="page-link text-secondary" href="${ctp}/livestock/registrationList?pageSize=${pageVO.pageSize}&page=${(pageVO.curBlock+1)*pageVO.blockSize + 1}">
	    			다음블록
	    		</a>
	    	</li>
	    </c:if>
	    <c:if test="${pageVO.page < pageVO.totPage}">
	    	<li class="page-item">
	    		<a class="page-link text-secondary" href="${ctp}/livestock/registrationList?pageSize=${pageVO.pageSize}&page=${pageVO.totPage}">
	    			마지막페이지
	    		</a>
	    	</li>
	    </c:if>
	  </ul>
  </div>
  
 
</div>
<p><br/></p>
</body>
</html>