<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<title>facility.jsp</title>
<script>
	'use strict';
	
	function facilityInput(){
		let title = $("#title").val();
		let content = $("#content").val();
		let price = $("#price").val();
		let pYear = $("#pYear").val();
		
		if(title == ""){
			alert("시설(장비) 명을 채워주세요");
			return false;
			$("#titile").focus();
		}
		if(price == ""){
			alert("총 가격을 입력해주세요");
			return false;
			$("#price").focus();
		}
		if(pYear == ""){
			alert("구입날짜를 선택해주세요");
			return false;
			$("#pYear").focus();
		}
		
		facilityInputform.submit();
		
	}
	
	function facilityDeleteCheck(idx){
		let ans = confirm("기록을 삭제하시겠습니까?");
		if(!ans) return false;
		
		$.ajax({
			type	:	"post",
			url		:	"${ctp}/asset/facilityDelete",
			data	:	{idx : idx},
			success	:	function(){
				alert("삭제되었습니다.");
				location.reload();
			},
			error	:	function(){
				alert("삭제 전송실패");
			}
		});
	}
	
	function facilityUpdateCheck(idx, title, content, price, pYear){
		let facilityInput = '<div id="facilityUpdateform ' + idx + '">';
		facilityInput += '<form name="updateform' + idx + '">';
		facilityInput += '<table class="table table-bordered">';
		facilityInput += '<tr><th>시설(장비) 명</th><td>';
		facilityInput += '<input type="text" name="title" id="title'+idx+'" class="form-control" reqeired />';
		facilityInput += '</td></tr>';
		facilityInput += '<tr><th>설명</th><td>';
		facilityInput += '<textarea name="content" id="content'+idx+'" row="4" class="form-control">'+content.replaceAll("<br/>", "<br>")+'</textarea>';
		facilityInput += '</td></tr>';
		facilityInput += '<tr><th>총 비용</th><td>';
		facilityInput += '<input type="number" class="form-control" name="price" id="price' + idx + '" required />';
		facilityInput += '</td></tr>';
		facilityInput += '<tr><th>구입날짜</th><td>';
		facilityInput += '<input type="date" class="form-control" name="pYear" id="pYear' + idx + '" required />';
		facilityInput += '</td></tr>';
		facilityInput += '<tr><td colspan="2" class="text-center">';
		facilityInput += '<span class="row">';
		facilityInput += '<span class="col"><input type="button" value="수정하기" onclick="facilityUpdateOk('+idx+')" class="btn btn-success form-control" /></span>';
		facilityInput += '<span class="col"><input type="button" value="수정창닫기" onclick="facilityUpdateClose('+idx+')" class="btn btn-warning form-control" /></span>';
		facilityInput += '</span>';
		facilityInput += '</table>';
		facilityInput += '</form></div>';
		
		$("#facilityUpdateOpen"+idx).hide();
		$("#updateDemo"+idx).slideDown(500);
		$("#updateDemo"+idx).html(facilityInput);
	}
	
	// 수정창닫기
	function facilityUpdateClose(idx){
		$("#facilityUpdateOpen"+idx).show();
		$("#updateDemo"+idx).slideUp(500);
	}
	
	// 내용 수정하기
	function facilityUpdateOk(idx){
		let title = $("#title"+idx).val();
		let content = $("#content"+idx).val();
		let price = $("#price"+idx).val();
		let pYear = $("#pYear"+idx).val();
		
		let query = {
				idx		:	idx,
				title	:	title,
				content	:	content,
				price	:	price,
				pYear	:	pYear
		}
		
		$.ajax({
			type	:	"post",
			url		:	"${ctp}/asset/facilityUpdate",
			data	:	query,
			success	:	function(){
				alert("수정이 완료되었습니다.");
				location.reload();
			},
			error	:	function(){
				alert("수정 전송실패");
			}
		});
	}
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<div class="container">
		<h2>시설기록</h2>
		<p><br></p>
		<input type="button" value="등록하기" class="btn btn-primary m-2" data-toggle="modal" data-target="#facilityInput" />
		<table class="table table-hover text-center">
			<tr>
				<th>번호</th>
				<th>시설(장비)명</th>
				<th>내용</th>
				<th>비용</th>
				<th>날짜</th>
				<th>비고</th>
			</tr>
			<c:forEach var="vo" items="${vos }" varStatus="st" >
			<tr>
				<td>${st.count }</td>
				<td>${vo.title }</td>
				<td>${vo.content }</td>
				<td>
					<script>
						var price = ${vo.price }
						document.write(price.toLocaleString('en'));
					</script>
				</td>
				<td>${fn:substring(vo.PYear, 0, 10) }</td>
				<td>
					<input type="button" value="수정" class="btn btn-info btn-sm" onclick="facilityUpdateCheck('${vo.idx}', '${vo.title }', '${fn:replace(vo.content, newLine, '<br/>') }', '${vo.price }', '${vo.PYear }')" id="facilityUpdateOpen${vo.idx }" />
					<input type="button" value="삭제" class="btn btn-danger btn-sm" onclick="facilityDeleteCheck('${vo.idx}')" />
				</td>
			</tr>
			<tr>
				<td colspan="6" class="m-0 p-0">
					<div id="updateDemo${vo.idx }"></div>
				</td>
			</tr>
			</c:forEach>
			<tr>
				<td colspan="6" class="m-0 p-0"></td>
			</tr>
		</table>
	</div>
	
	<!-- 약품추가 모달창 -->
	<!-- The Modal -->
	<div class="modal" id="facilityInput">
		<div class="modal-dialog">
	    	<div class="modal-content">
	
	      	<!-- Modal Header -->
			<form name="facilityInputform" method="post" action="${ctp }/asset/facilityInput">
		      	<div class="modal-header">
		        	<h4 class="modal-title">시설등록</h4>
		        	<button type="button" class="close" data-dismiss="modal">&times;</button>
		      	</div>
		
		      	<!-- Modal body -->
		      	<div class="modal-body">
		        	<div class="form-group">
						<label for="title">시설(장비) 명: </label>
						<input type="text" class="form-control" name="title" id="title" autofocus required/>
					</div>
					
					<div class="form-group">
						<label for="content">설명 : </label>
						<input type="text" class="form-control" name="content" id="content" />
					</div>
					
					<div class="form-group">
						<label for="price"> 총 비용: </label>
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
		        	<input type="button" class="btn btn-secondary" value="등록하기" onclick="facilityInput()" /> 
		      	</div>
	      	</form>
	
	    	</div>
	  	</div>
	</div>
</body>
</html>