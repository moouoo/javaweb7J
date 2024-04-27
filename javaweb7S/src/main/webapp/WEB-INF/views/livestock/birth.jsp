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
<title>birth.jsp</title>
<script>
	'use strict';
	
	function Check(){
		let cNum1 = $("#cNum1").val();
		let cNum2 = $("#cNum2").val();
		let cNum3 = $("#cNum3").val();
		let cNum4 = $("#cNum4").val();
		birthInputform.cNum.value = cNum1 + "-" + cNum2 + "-" + cNum3 + "-" + cNum4;
		let dBirth = $("#dBirth").val();
		let etc = $("#etc").val();
		
		if(cNum2 == "" || cNum3 == "" || cNum4 == "" || cNum1 == ""){
			alert("개체번호를 입력해주세요");
			insertform.cNum2.focus();
		}
		else if(dBirth == ""){
			alert("출산예정일을 입력해주세요");
		}
		else {
			birthInputform.submit();
		}
	}
	
	function birthDelete(idx, cNum){
		let ans = confirm("[" + cNum + "] 가 출산을 하였습니까?");
		if(!ans) return false;
		
		$.ajax({
			type	:	"post",
			url		:	"${ctp}/livestock/birthDelete",
			data	:	{idx : idx},
			success	:	function(){
				alert("삭제되었습니다.");
				location.reload();
			},
			error	:	function(){
				alert("전송실패");
			}
		});
	}
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<div class="container">
		<h2>출산예정일</h2>
		<p><br/></p>
		<input type="button" value="등록하기" class="btn btn-primary m-2" data-toggle="modal" data-target="#birthInput" />
		<table class="table text-center">
			<tr>
				<th>번호</th>
				<th>개체번호</th>
				<th>기타사항</th>
				<th>출산예정일</th>
				<th>비고</th>
			</tr>
			<c:forEach var="vo" items="${vos }" varStatus="st">
			<tr>
				<td>${st.count }</td>
				<td>${vo.CNum }</td>
				<td>${vo.etc }</td>
				<td>${fn:substring(vo.DBirth, 0, 10) }</td>
				<td>
					<input type="button" value="출산" class="btn btn-info btn-sm" onclick="birthDelete('${vo.idx}', '${vo.CNum }')" />
				</td>
			</tr>
			</c:forEach>
		</table>	
	</div>
	
	<!-- The Modal -->
	<form name="birthInputform" method="post" action="${ctp }/livestock/birthInput">
	  	<div class="modal" id="birthInput">
	  		<div class="modal-dialog">
		    	<div class="modal-content">
		      
		        <!-- Modal Header -->
		        <div class="modal-header">
		          	<h4 class="modal-title">출산예정일등록</h4>
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
		          	
					<div class="form-group">
				      <label for="dBirth">출생예정일</label>
				      <input type="date" class="form-control" name="dBirth" id="dBirth" required />
		          	</div>
		          	
		          	<div class="form-group">
				      <label for="etc">기타사항</label>
				      <input type="text" class="form-control" name="etc" id="etc" />
		          	</div>
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
	
	<div class="container">
		<!--페이징처리 -->
	   	<div class="text-center m-4">
			<ul class="pagination justify-content-center">
		    <c:if test="${pageVO.page > 1}">
		    	<li class="page-item">
		    		<a class="page-link text-secondary" href="${ctp}/livestock/birth?pageSize=${pageVO.pageSize}&page=1">
		    			첫페이지
		    		</a>
		    	</li>
		    	</c:if>
		    <c:if test="${pageVO.curBlock > 0}">
		    	<li class="page-item">
		    		<a class="page-link text-secondary" href="${ctp}/livestock/birth?pageSize=${pageVO.pageSize}&page=${(pageVO.curBlock-1)*pageVO.blockSize + 1}">
		    			이전블록
		    		</a>
		    	</li>
		    </c:if>
		    <c:forEach var="i" begin="${pageVO.curBlock*pageVO.blockSize + 1}" end="${pageVO.curBlock*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
		    	<c:if test="${i <= pageVO.totPage && i == pageVO.page}">
		    		<li class="page-item active">
		    			<a class="page-link text-white bg-secondary border-secondary" href="${ctp}/livestock/birth?pageSize=${pageVO.pageSize}&page=${i}">
		    				${i}
		    			</a>
		    		</li>
		    	</c:if>
		    	<c:if test="${i <= pageVO.totPage && i != pageVO.page}">
		    		<li class="page-item">
		    			<a class="page-link text-secondary" href="${ctp}/livestock/birth?pageSize=${pageVO.pageSize}&page=${i}">
		    				${i}
		    			</a>
		    		</li>
		    	</c:if>
		    </c:forEach>
		    <c:if test="${pageVO.curBlock < pageVO.lastBlock}">
		    	<li class="page-item">
		    		<a class="page-link text-secondary" href="${ctp}/livestock/birth?pageSize=${pageVO.pageSize}&page=${(pageVO.curBlock+1)*pageVO.blockSize + 1}">
		    			다음블록
		    		</a>
		    	</li>
		    </c:if>
		    <c:if test="${pageVO.page < pageVO.totPage}">
		    	<li class="page-item">
		    		<a class="page-link text-secondary" href="${ctp}/livestock/birth?pageSize=${pageVO.pageSize}&page=${pageVO.totPage}">
		    			마지막페이지
		    		</a>
		    	</li>
		    </c:if>
		  </ul>
	  </div>
  </div>
	
</body>
</html>