<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<c:set var="level" value="${sLevel }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<title>feed.jsp</title>
<script>
	'use strict';
	
	function feedInputCheck(){
		let bIdx = $("#bIdx").val();
		let stages = $("#stages").val();
		let dIntake = $("#dIntake").val();
		let bFeeding = $("#bFeeding").val();
		
		if(bIdx == ""){
			alert("동 이름을 지어주세요");
			return false;
		}
		else if(stages == ""){
			alert("동의 사육단계를 입력해주세요");
			return false;
		}
		else if(dIntake == ""){
			alert("두 당 일일 섭취량을 정해주세요");
			return false;
		}
		else if(bFeeding == ""){
			alert("현재 '+bIdx+' 동의 사육두수를 입력해주세요");
			return false;
		}
		
		let ans = confirm("동 이름은 한번 결정하면 취소 할 수 없습니다.");
		if(!ans) return false;
		
		feedInputform.submit();
	}
	
	$(document).ready(function() {
		$('#feedUpdate').on('show.bs.modal', function(event) {
			var button = $(event.relatedTarget);
			var dIdx = button.data('id');
			var stages = button.data('stages1');
			var dIntake = button.data('id2');
			var bFeeding = button.data('id3');
			var idx = button.data('id4');
			$('#dIdx1').val(dIdx);
			$('#stages1').val(stages);
			$('#dIntake1').val(dIntake);
			$('#bFeeding1').val(bFeeding);
			$('idx1').val(idx);
		});
	});
	
	function feedUpdateCheck(){
		let dIdx = $("#dIdx1").val();
		let stages = $("#stages1").val();
		let dIntake = $("#dIntake1").val();
		let bFeeding = $("#bFeeding1").val();
		let idx = $("#idx1").val();
		
		if(dIdx == ""){
			alert("동 이름을 지어주세요");
			return false;
		}
		else if(stages == ""){
			alert("동의 사육단계를 입력해주세요");
			return false;
		}
		else if(dIntake == ""){
			alert("두 당 일일 섭취량을 정해주세요");
			return false;
		}
		else if(bFeeding == ""){
			alert("현재 '+dIdx+' 동의 사육두수를 입력해주세요");
			return false;
		}
		else feedUpdateform.submit();
	}
	
	$(document).ready(function() {
		$('#feedOlder').on('show.bs.modal', function(event) {
			var button = $(event.relatedTarget);
			var dIdx = button.data('id');
			var stages = button.data('id1');
			$('#dIdx2').val(dIdx);
			$('#stages2').val(stages);
		});
	});
			
	function feedOlderCheck(){
		let tKg = $("#tKg").val();
		let price = $("#price").val();
		let pYear = $("#pYear").val();
		
		if(tKg == ""){
			alert("총 요구되는 사료량을 입력해주세요");
			return false;
		}
		else if(price == ""){
			alert("kg당 가격을 입력해주세요");
			return false;
		}
		else if(pYear == ""){
			alert("구입날짜를 입력해주세요");
			return false;
		}
		
		let ans = confirm("기록은 한번 입력하면 수정 할 수 없습니다. \\n 입력하신 데이터가 정확하십니까?");
		if(!ans) return false;
		
		feedOlderform.submit();
	}
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<div class="container">
		<h2>사료관리</h2>
		<p><br/></p>
		<div style="text-align: right;">
		<c:if test="${level == 2 }">
			<input type="button" value="동 추가하기" class="btn btn-info" data-toggle="modal" data-target="#feedInput" />
		</c:if>
		</div>
		<p></p>
		 <table class="table text-center">
   			 <thead class="thead-dark">
   			 	<tr>
   			 		<th>동 이름</th>
   			 		<th>사육단계</th>
   			 		<th>재고량(kg)</th>
   			 		<th>필요량(kg)</th>
   			 		<th>비고</th>
   			 	</tr>
   			 </thead>
   			 <tbody>
   			 	<c:forEach var="vo" items="${vos }" varStatus="st">
   			 	<tr>
   			 		<td>${vo.DIdx } 동</td>
   			 		<td>${vo.stages }</td>
   			 		<td>${sKgList[st.index] }</td>
   			 		<td>${nKgList[st.index] }</td>
   			 		<td>
   			 			<input type="button" class="btn btn-warning btn-sm" value="수정" data-toggle="modal" 
   			 				data-id="${vo.DIdx }" data-stages1="${vo.stages }" data-id2="${vo.DIntake }"
   			 				data-id3="${vo.BFeeding }" data-id4="${vo.idx }" data-target="#feedUpdate" />
   			 			<c:if test="${level == 2 }">
   			 				<input type="button" class="btn btn-primary btn-sm" value="사료주문기록" data-id="${vo.DIdx }" data-id1="${vo.stages }" data-toggle="modal" data-target="#feedOlder" />
   			 			</c:if>
   			 		</td>
   			 	</tr>
   			 	</c:forEach>
   			 </tbody>
		</table>
	</div>
	
	<!-- 사료관리 모달창 -->
	<!-- The Modal -->
	<div class="modal" id="feedInput">
  		<div class="modal-dialog">
    		<div class="modal-content">

			<form name="feedInputform" method="post" action="${ctp }/asset/feedInput">
	      		<!-- Modal Header -->
	      		<div class="modal-header">
	        		<h4 class="modal-title">동 추가하기</h4>
	        		<button type="button" class="close" data-dismiss="modal">&times;</button>
	      		</div>
	
	      		<!-- Modal body -->
	      		<div class="modal-body">
	        		<div class="form-group">
		        		<label for="dIdx">동 이름</label>
		      			<input type="text" class="form-control" name="dIdx" id="dIdx" required autofocus />
		        	</div>
		        	
		        	 <div class="form-group">
        				<label for="stages">사육단계</label>
        				<select class="form-control" id="stages" name="stages">
        					<option value="" selected >선택</option>
        					<option value="번식우" >번식우</option>
        					<option value="송아지" >송아지</option>
        					<option value="육성우" >육성우</option>
        					<option value="비육전기" >비육전기</option>
        					<option value="비육후기" >비육후기</option>
        				</select>
        			</div>
        			
        			<div class="form-group">
		        		<label for="dIntake">두 당 섭취량(kg) / 일</label>
		      			<input type="number" class="form-control" name="dIntake" id="dIntake" required />
		        	</div>
		        	
		        	<div class="form-group">
		        		<label for="bFeeding">동 당 사육두수 / 일</label>
		      			<input type="number" class="form-control" name="bFeeding" id="bFeeding" required />
		        	</div>
		        	
	      		</div>
	
	      		<!-- Modal footer -->
	      		<div class="modal-footer">
	        		<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
	        		<input type="button" class="btn btn-primary" value="추가하기" onclick="feedInputCheck()" />
	      		</div>
			</form>
			
    		</div>
  		</div>
	</div>
	
	<!-- 사료관리 - 수정 모달창 -->
	<!-- The Modal -->
	<div class="modal" id="feedUpdate">
  		<div class="modal-dialog">
    		<div class="modal-content">

			<form name="feedUpdateform" method="post" action="${ctp }/asset/feedUpdate">
	      		<!-- Modal Header -->
	      		<div class="modal-header">
	        		<h4 class="modal-title">동 추가하기</h4>
	        		<button type="button" class="close" data-dismiss="modal">&times;</button>
	      		</div>
	
	      		<!-- Modal body -->
	      		<div class="modal-body">
	        		<div class="form-group">
		        		<label for="dIdx1">동 이름</label>
		      			<input type="text" class="form-control" readonly name="dIdx1" id="dIdx1" required autofocus />
		        	</div>
		        	
		        	 <div class="form-group">
        				<label for="stages">사육단계</label>
        				<select class="form-control" id="stages1" name="stages1">
        					<option value="" selected >선택</option>
        					<option value="번식우" >번식우</option>
        					<option value="송아지" >송아지</option>
        					<option value="육성우" >육성우</option>
        					<option value="비육전기" >비육전기</option>
        					<option value="비육후기" >비육후기</option>
        				</select>
        			</div>
        			
        			<div class="form-group">
		        		<label for="dIntake1">두 당 섭취량(kg) / 일</label>
		      			<input type="number" class="form-control" name="dIntake1" id="dIntake1" required />
		        	</div>
		        	
		        	<div class="form-group">
		        		<label for="bFeeding1">동 당 사육두수 / 일</label>
		      			<input type="number" class="form-control" name="bFeeding1" id="bFeeding1" required />
		        	</div>
	      		</div>
	
	      		<!-- Modal footer -->
	      		<div class="modal-footer">
	        		<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
	        		<input type="button" class="btn btn-primary" value="수정하기" onclick="feedUpdateCheck()" />
	      		</div>
			</form>
			
    		</div>
  		</div>
	</div>
	
	<!-- 사료관리 : 사료주문 -->
	<!-- The Modal -->
	<div class="modal" id="feedOlder">
  		<div class="modal-dialog">
    		<div class="modal-content">

			<form name="feedOlderform" method="post" action="${ctp }/asset/feedOlder">
	      		<!-- Modal Header -->
	      		<div class="modal-header">
	        		<h4 class="modal-title">주문기록</h4>
	        		<button type="button" class="close" data-dismiss="modal">&times;</button>
	      		</div>
	
	      		<!-- Modal body -->
	      		<div class="modal-body">
	        		<div class="form-group">
		        		<label for="dIdx1">동 이름</label>
		      			<input type="text" class="form-control" readonly name="dIdx2" id="dIdx2" required autofocus />
		        	</div>
		        	
		        	 <div class="form-group">
        				<label for="stages">사육단계</label>
        				<input type="text" class="form-control" id="stages2" name="stages2" readonly>
        			</div>
        			
        			<div class="form-group">
		        		<label for="tKg">총 사료량</label>
		      			<input type="number" class="form-control" name="tKg" id="tKg" required />
		        	</div>
		        	
		        	<div class="form-group">
		        		<label for="price">kg 당 가격</label>
		      			<input type="number" class="form-control" name="price" id="price" required />
		        	</div>
		        	
		        	<div class="form-group">
		        		<label for="pYear">주문날짜</label>
		      			<input type="date" class="form-control" name="pYear" id="pYear" value="<%=java.time.LocalDate.now() %>" required />
		        	</div>
	      		</div>
	
	      		<!-- Modal footer -->
	      		<div class="modal-footer">
	        		<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
	        		<input type="button" class="btn btn-primary" value="주문기록" onclick="feedOlderCheck()" />
	      		</div>
			</form>
			
    		</div>
  		</div>
	</div>
</body>
</html>