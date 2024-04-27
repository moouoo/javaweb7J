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
<title>estrusDetail.jsp</title>
<script>
	'use strict';
	
	// 수정하기
	function updateCheck(idx, eCheck, etc, eBirth){
		let estrusInput = '<div id = "estrusUpdateform' + idx + '">';
		estrusInput += '<form name="updateForm'+idx+'">';
		estrusInput += '<table class="table table-bordered">';
		estrusInput += '<tr><th>발정일</th><td>';
		estrusInput += '<input type="date" name="sBirth" id="sBirth'+idx+'" class="form-control" required>';
		estrusInput += '</td></tr>';
		estrusInput += '<tr><th>시작시간</th><td>';
		estrusInput += '<input type="text" name="eTime" id="eTime'+idx+'" class="form-control">';
		estrusInput += '</td></tr>';
		estrusInput += '<tr><th>기타</th><td>';
		estrusInput += '<textarea name="etc" id="etc'+idx+'" row="4" class="form-control">'+etc.replaceAll("<br/>", "<br>")+'</textarea>';
		estrusInput += '</td></tr>';
		estrusInput += '<tr><td colspan="2" class="text-center">';
		estrusInput += '<span class="row">';
		estrusInput += '<span class="col"><input type="button" value="수정하기" onclick="estrusUpdateOk('+idx+')" class="btn btn-success form-control" /></span>';
		estrusInput += '<span class="col"><input type="button" value="수정창닫기" onclick="estrusUpdateClose('+idx+')" class="btn btn-warning form-control" /></span>';
		estrusInput += '</span>';
		estrusInput += '</td></tr>';
		estrusInput += '</table>';
		estrusInput += '</form></div>';
		
		$("#estrusUpdateOpen"+idx).hide();
		$("#updateDemo"+idx).slideDown(500);
		$("#updateDemo"+idx).html(estrusInput);
	}
	
	// 수정창닫기
	function estrusUpdateClose(idx){
		$("#estrusUpdateOpen"+idx).show();
		$("#updateDemo"+idx).slideUp(500);
	}
	
	// 내용 수정하기
	function estrusUpdateOk(idx){
		let eCheck = $("#eCheck"+idx).val();
		let etc = $("#etc"+idx).val();
		let sBirth = $("#sBirth"+idx).val();
		let eTime = $("#eTime"+idx).val();
		
		let query = {
				idx		:	idx,
				eCheck	:	eCheck,
				etc		:	etc,
				sBirth	:	sBirth,
				eTime	:	eTime
		}
		
		$.ajax({
			type	:	"post",
			url		:	"${ctp}/livestock/estrusUpdateOk",
			data	:	query,
			success	:	function(){
				alert("수정이 완료되었습니다.");
				location.reload();
			},
			error	:	function(){
				alert("빈칸이 있는지 확인해 주세요!");
			}
		});
	}
	
	// 내용 삭제하기
	function deleteCheck(idx) {
		let ans = confirm("내용을 삭제하시겠습니까?");
		if(!ans) return false;
		
		$.ajax({
			type	:	"post",
			url		:	"${ctp}/livestock/estrusDeleteOk",
			data	:	{idx : idx},
			success	:	function(){
				alert("삭제완료");
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
	<h4>${ymd }의 일정입니다.</h4>
	<p>오늘의 일정은 총 ${estrusCnt }건 입니다.</p>
	<p>보통 수정은 발정시작으로부터 12시간 뒤에 실시합니다.</p>
	<div>
		<input type="button" value="돌아가기" onclick="location.href='${ctp}/livestock/estrus?yy=${fn:split(ymd, '-')[0] }&mm=${fn:split(ymd, '-')[1]-1}';" class="btn btn-danger float-right m-2" />
	</div>
	<div id="demo"></div>
	<hr/>
	<c:if test="${scheduleCnt != 0 }">
	<table class="table table-hover text-center">
		<tr class="table-dark text-dark">
			<th>번호</th>
			<th>개체번호</th>
			<th>발정일</th>
			<th>시작시간</th>
			<th>예상출산일</th>
			<th>기타</th>
			<th>비고</th>
		</tr>
		<c:forEach var="vo" items="${vos }" varStatus="st" >
		<tr>
			<td>${st.count }</td>
			<td>${vo.CNum }</td>
			<td>${fn:substring(vo.SBirth, 0, 10) }</td>
			<td>${vo.ETime }</td>
			<td>${fn:substring(vo.DBirth, 0, 10) }</td>
			<td>${vo.etc }</td>
			<td>
				<input type="button" value="수정" onclick="updateCheck('${vo.idx}', '${vo.ECheck }', '${fn:replace(vo.etc, newLine, '<br/>') }', '${vo.SBirth }', '${vo.ETime }')" id="estrusUpdateOpen${vo.idx }" class="btn btn-warning btn-sm" />
				<input type="button" value="삭제" onclick="deleteCheck(${vo.idx})" class="btn btn-danger btn-sm" />
			</td>
		</tr>
		<tr>
			<td colspan="7" class="m-0 p-0">
				<div id="updateDemo${vo.idx }"></div>
			</td>
		</tr>
		</c:forEach>
		<tr>
			<td colspan="7" class="m-0 p-0"></td>
		</tr>
	</table>
	</c:if>
</div>


</body>
</html>