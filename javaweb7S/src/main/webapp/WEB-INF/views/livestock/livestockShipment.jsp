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
<title>livestockShipment.jsp</title>
<script>
	'use strict';
	
	function Check(){
			let cNum1 = $("#cNum1").val();
			let cNum2 = $("#cNum2").val();
			let cNum3 = $("#cNum3").val();
			let cNum4 = $("#cNum4").val();
			shipmentform.cNum.value = cNum1 + "-" + cNum2 + "-" + cNum3 + "-" + cNum4;
			let price = $("#price").val();
			let sYear = $("#sYear").val();
			
			if(cNum2 == "" || cNum3 == "" || cNum4 == "" || cNum1 == ""){
				alert("개체번호를 입력해주세요");
				shipmentform.cNum2.focus();
			}
			else {
				shipmentform.submit();
			}
		}
	
	
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container">
<p><br/></p>
<h2>출하관리</h2>
<br/>
  <!-- Button to Open the Modal -->
  <div class="row justify-content-end">
    <div class="col-auto">
      <!-- 등록하기 버튼 -->
      <input type="button" class="btn btn-primary m-2" value="등록하기" data-toggle="modal" data-target="#myModal">
    </div>
  </div>
	<table class="table">
		<tr>
			<th>번호</th>
			<th>개체번호</th>
			<th>가격</th>
			<th>출하년도</th>
		</tr>
		<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}" />
		<c:forEach var="vo" items="${vos }" varStatus="st" >
		<tr>
			<td>${curScrStartNo }</td>
			<td>${vo.CNum }</td>
			<td>
				<script>
					var price = ${vo.price}
					document.write(price.toLocaleString('en'));
				</script>
			</td>
			<td>${fn:substring(vo.SYear, 0, 10) }</td>
		</tr>
		<c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
		</c:forEach>
	</table>
</div>

<div class="container">

<!-- 질병등록 -->
  <!-- The Modal -->
  <form name="shipmentform" method="post">
  <div class="modal" id="myModal">
    <div class="modal-dialog">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">출하</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
        	<div class="form-group">
				<div class="input-group mb-3">
		      		<label for="cNum">개체번호 : </label> &nbsp;
		      		<input type="text" class="form-control" name="cNum1" id="cNum1" value="002" maxlength=3 required autofocus />-
		      		<input type="text" class="form-control" name="cNum2" id="cNum2" maxlength=4 required />-
		      		<input type="text" class="form-control" name="cNum3" id="cNum3" maxlength=4 required />-
		      		<input type="text" class="form-control" name="cNum3" id="cNum4" maxlength=1 required />
		      		<input type="hidden" name="cNum" id="cNum" />
		    	</div>
          	</div>
        </div>
        
        <div class="form-group">
        	<label for="price">가격</label>
        	<input type="number" class="form-control" name="price" id="price">
        </div>
        
      	<div class="form-group">
	      <label for="sYear">출하년도</label>
	      <input type="date" class="form-control" name="sYear" id="sYear" value="<%=java.time.LocalDate.now() %>" required />
      	</div>
       	
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
          <input type="button" value="등록하기" onclick="Check()" class="btn btn-primary" />
        </div>
      </div>
    </div>
  </div>
  </form>
</div>

  <!--페이징처리 -->
   <div class="text-center m-4">
	  <ul class="pagination justify-content-center">
	    <c:if test="${pageVO.page > 1}">
	    	<li class="page-item">
	    		<a class="page-link text-secondary" href="${ctp}/livestock/livestockShipment?pageSize=${pageVO.pageSize}&page=1">
	    			첫페이지
	    		</a>
	    	</li>
	    </c:if>
	    <c:if test="${pageVO.curBlock > 0}">
	    	<li class="page-item">
	    		<a class="page-link text-secondary" href="${ctp}/livestock/livestockShipment?pageSize=${pageVO.pageSize}&page=${(pageVO.curBlock-1)*pageVO.blockSize + 1}">
	    			이전블록
	    		</a>
	    	</li>
	    </c:if>
	    <c:forEach var="i" begin="${pageVO.curBlock*pageVO.blockSize + 1}" end="${pageVO.curBlock*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
	    	<c:if test="${i <= pageVO.totPage && i == pageVO.page}">
	    		<li class="page-item active">
	    			<a class="page-link text-white bg-secondary border-secondary" href="${ctp}/livestock/livestockShipment?pageSize=${pageVO.pageSize}&page=${i}">
	    				${i}
	    			</a>
	    		</li>
	    	</c:if>
	    	<c:if test="${i <= pageVO.totPage && i != pageVO.page}">
	    		<li class="page-item">
	    			<a class="page-link text-secondary" href="${ctp}/livestock/livestockShipment?pageSize=${pageVO.pageSize}&page=${i}">
	    				${i}
	    			</a>
	    		</li>
	    	</c:if>
	    </c:forEach>
	    <c:if test="${pageVO.curBlock < pageVO.lastBlock}">
	    	<li class="page-item">
	    		<a class="page-link text-secondary" href="${ctp}/livestock/livestockShipment?pageSize=${pageVO.pageSize}&page=${(pageVO.curBlock+1)*pageVO.blockSize + 1}">
	    			다음블록
	    		</a>
	    	</li>
	    </c:if>
	    <c:if test="${pageVO.page < pageVO.totPage}">
	    	<li class="page-item">
	    		<a class="page-link text-secondary" href="${ctp}/livestock/livestockShipment?pageSize=${pageVO.pageSize}&page=${pageVO.totPage}">
	    			마지막페이지
	    		</a>
	    	</li>
	    </c:if>
	  </ul>
  </div>
  
</body>
</html>