<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<c:set var="level" value="${sLevel }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<title>semen.jsp</title>
<script>
	'use strict';
	function semenInputCheck(){
		let sNum1 = $("#sNum1").val();
		let sNum2 = $("#sNum2").val();
		semenInputform.sNum.value = sNum1 + "-" + sNum2;
		let nTank = $("#nTank").val();
		let EMA = $("#EMA").val();
		let MS = $("#MS").val();
		let BF = $("#BF").val();
		let CW = $("#CW").val();
		
		if(sNum2 == ""){
			alert("정액번호를 입력해주세요");
			return false;
		}
		if(nTank == ""){
			alert("정액을 보관할 정액통 이름을 입력해주세요");
			return false;
		}
		if(EMA == "" || MS == "" || BF == "" || CW == ""){
			alert("정액능력을 전부 채워주새요");
			return false;
		}
		semenInputform.submit();
	}
	
	function semenDeleteCheck(idx) {
		let ans = confirm("삭제하시겠습니까?");
		if(!ans) return false;
		
		$.ajax({
			type	:	"post",
			url		:	"${ctp}/asset/semenDelete",
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
	
	$(document).ready(function() {
		$('#semenPlus').on('show.bs.modal', function(event) {
			var button = $(event.relatedTarget);
			var data = button.data('id');
			$('#sNum3').val(data);
		});
	});
	
	function semenPlusCheck(){
		let purchase = $("#purchase").val();
		let price = $("#price").val();
		let pYear = $("#pYear").val();
		let sNum = $("#sNum3").val();
		
		if(purchase == ""){
			alert("구입량을 입력해주세요");
			return false;
		}
		else if(price == ""){
			alert("가격을 입력해주세요");
			return false;
		}
		else if(pYear == ""){
			alert("구입일자를 입력해주세요");
		}
		
		semenPlusform.submit();
	}
	
	function useCheck(sNum, stock){
		let ans = confirm(sNum + "을 사용하셨습니까?");
		if(!ans) return false;
		
		let query ={
				sNum	:	sNum,
				stock	:	stock
		}
		
		$.ajax({
			type	:	"post",
			url		:	"${ctp}/asset/semenUse",
			data	:	query,
			success	:	function(){
				location.reload();
			},
			error	:	function(){
				alert("전송실패");
			}
		});
	}
	
	function semenACheck(){
		let semenA = $("#semenA").val();
		location.href="${ctp}/asset/semenArr?semenA="+semenA;
	}
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<div class="container">
		<h2>정액관리</h2>
		<p><br/></p>
		<div style="display: flex; justify-content: space-between;">
			<div>
				<select name="semenA" id="semenA" onchange="semenACheck()">
					<option value="">분류</option>
					<option value="EMA" ${semenA == 'EMA'? 'selected' : '' }>EMA</option>
					<option value="MS" ${semenA == 'MS'? 'selected' : '' }>MS</option>
					<option value="BF" ${semenA == 'BF'? 'selected' : '' }>BF</option>
					<option value="CW" ${semenA == 'CW'? 'selected' : '' }>CW</option>
				</select>
			</div>
			<div>
				<c:if test="${level == 2 }">
					<input type="button" value="정액등록"  class="btn btn-primary" data-toggle="modal" data-target="#semenInput" />
				</c:if>
			</div>
		</div>
		<p></p>
		<table class="table table-hover text-center">
			<tr>
				<th>번호</th>
				<th>정액번호</th>
				<th>질소통</th>
				<th>배최장근 단면적</th>
				<th>근내지방도</th>
				<th>등지장두께</th>
				<th>도체중</th>
				<th>재고량</th>
				<th>비고</th>
			</tr>
			<c:forEach var="vo" items="${vos }" varStatus="st">
			<tr>
				<td>${st.count }</td>
				<td>${vo.SNum }</td>
				<td>${vo.NTank }</td>
				<td>${vo.EMA }</td>
				<td>${vo.MS }</td>
				<td>${vo.BF }</td>
				<td>${vo.CW }</td>
				<td>${vo.stock }</td>
				<td>
					<input type="button" value="소비" class="btn btn-success btn-sm" onclick="useCheck('${vo.SNum}', '${vo.stock }')" />
					<c:if test="${level == 2 }">
						<input type="button" value="입고" class="btn btn-info btn-sm" data-toggle="modal" data-id="${vo.SNum }" data-target="#semenPlus" />
						<input type="button" value="삭제" class="btn btn-danger btn-sm" onclick="semenDeleteCheck('${vo.idx}')" />
					</c:if>
				</td>
			</tr>
			</c:forEach>
		</table> 
	</div>
	
	<!-- 정액관리 : 정액등록 -->
	<!-- The Modal -->
	<div class="modal" id="semenInput">
  		<div class="modal-dialog">
    		<div class="modal-content">

			<form name="semenInputform" method="post" action="${ctp }/asset/semenInput">
	      		<!-- Modal Header -->
	      		<div class="modal-header">
	        		<h4 class="modal-title">정액등록</h4>
	        		<button type="button" class="close" data-dismiss="modal">&times;</button>
	      		</div>
	
	      		<!-- Modal body -->
	      		<div class="modal-body">
	        		<div class="form-group">
		        		<label for="sNum">정액번호</label>
		      			<input type="text" class="form-control" name="sNum1" id="sNum1" value="KPN" maxlength=3 readonly /> - 
						<input type="text" class="form-control" name="sNum2" id="sNum2" maxlength=5 required autofocus />
						<input type="hidden" id="sNum" name="sNum" />
		        	</div>
		        	
		        	<div class="form-group">
        				<label for="nTank">질소통</label>
        				<input type="text" class="form-control" id="nTank" name="nTank" required />
        			</div>
        			
        			<div class="form-group">
        				<label for="EMA">배최장근 단면적</label>
        				<input type="number" class="form-control" name="EMA" id="EMA" required />
        			</div>
        			
        			<div class="form-group">
        				<label for="MS">근내지방도</label>
        				<input type="number" class="form-control" name="MS" id="MS" required />
        			</div>
        			
        			<div class="form-group">
        				<label for="BF">등지방두께</label>
        				<input type="number" class="form-control" name="BF" id="BF" required />
        			</div>
        			
        			<div class="form-group">
        				<label for="CW">도체중</label>
        				<input type="number" class="form-control" name="CW" id="CW" required />
        			</div>
        			
	      		</div>
	
	      		<!-- Modal footer -->
	      		<div class="modal-footer">
	        		<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
	        		<input type="button" class="btn btn-primary" value="등록하기" onclick="semenInputCheck()" />
	      		</div>
			</form>
			
    		</div>
  		</div>
	</div>
	
	<!-- 정액관리 : 정액입고 -->
	<!-- The Modal -->
	<div class="modal" id="semenPlus">
  		<div class="modal-dialog">
    		<div class="modal-content">

			<form name="semenPlusform" method="post" action="${ctp }/asset/semenPlus">
	      		<!-- Modal Header -->
	      		<div class="modal-header">
	        		<h4 class="modal-title">정액입고</h4>
	        		<button type="button" class="close" data-dismiss="modal">&times;</button>
	      		</div>
	
	      		<!-- Modal body -->
	      		<div class="modal-body">
	        		<div class="form-group">
		        		<label for="sNum">정액번호</label>
		      			<input type="text" class="form-control" name="sNum3" id="sNum3" readonly />
		        	</div>
		        	
		        	<div class="form-group">
        				<label for="purchase">구입량</label>
        				<input type="number" class="form-control" id="purchase" name="purchase" required />
        			</div>
        			
        			<div class="form-group">
        				<label for="price">가격</label>
        				<input type="number" class="form-control" name="price" id="price" required />
        			</div>
        			
        			<div class="form-group">
        				<label for="pYear">구입날짜</label>
        				<input type="date" class="form-control" name="pYear" id="pYear" required />
        			</div>
	      		</div>
	
	      		<!-- Modal footer -->
	      		<div class="modal-footer">
	        		<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
	        		<input type="button" class="btn btn-primary" value="입고하기" onclick="semenPlusCheck()" />
	      		</div>
			</form>
			
    		</div>
  		</div>
	</div>
</body>
</html>