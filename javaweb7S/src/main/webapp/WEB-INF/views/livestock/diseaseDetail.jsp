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
<title>diseaseDetail.jsp</title>
<script>
	'use strict';
	
	// 수정하기
	function updateCheck(idx, dType, content){
		let diseaseInput = '<div id = "diseaseUpdateForm' + idx + '">';
		diseaseInput += '<form name="updateForm'+idx+'">';
		diseaseInput += '<table class="table table-bordered">';
		diseaseInput += '<tr><th>분류</th><td>';
		diseaseInput += '<select name="dType" id="dType'+idx+'" class="form-control">';
		diseaseInput += '<option value="설사">설사</option>';
		diseaseInput += '<option value="미열">미열</option>';
		diseaseInput += '<option value="호흡기">호흡기</option>';
		diseaseInput += '<option value="탈수">탈수</option>';
		diseaseInput += '<option value="기타">기타</option>';
		diseaseInput += '<option value="'+dType+'" selected>'+dType+'</option>';
		diseaseInput += '</select>';
		diseaseInput += '</td></tr>';
		diseaseInput += '<tr><th>내용</th><td>';
		diseaseInput += '<textarea name="content" id="content'+idx+'" row="4" class="form-control">'+content.replaceAll("<br/>", "<br>")+'</textarea>';
		diseaseInput += '</td></tr>';
		diseaseInput += '<tr><td colspan="2" class="text-center">';
		diseaseInput += '<span class="row">';
		diseaseInput += '<span class="col"><input type="button" value="수정하기" onclick="diseaseUpdateOk('+idx+')" class="btn btn-success form-control" /></span>';
		diseaseInput += '<span class="col"><input type="button" value="수정창닫기" onclick="diseaseUpdateClose('+idx+')" class="btn btn-warning form-control" /></span>';
		diseaseInput += '</span>';
		diseaseInput += '</td></tr>';
		diseaseInput += '</table>';
		diseaseInput += '</form></div>';
		
		$("#diseaseUpdateOpen"+idx).hide();
		$("#updateDemo"+idx).slideDown(500);
		$("#updateDemo"+idx).html(diseaseInput);
	}
	
	// 수정창닫기
	function diseaseUpdateClose(idx){
		$("#diseaseUpdateOpen"+idx).show();
		$("#updateDemo"+idx).slideUp(500);
	}
	
	// 내용 수정하기
	function diseaseUpdateOk(idx){
		let dType = $("#dType"+idx).val();
		let content = $("#content"+idx).val();
		
		let query = {
				idx		:	idx,
				dType	:	dType,
				content	:	content
		}
		
		$.ajax({
			type	:	"post",
			url		:	"${ctp}/livestock/diseaseUpdateOk",
			data	:	query,
			success	:	function(){
				alert("수정완료");
				location.reload();
			},
			error	:	function(){
				alert("전송실패");
			}
		});
	}
	
	// 내용 삭제하기
	function deleteCheck(idx) {
		let ans = confirm("내용을 삭제하시겠습니까?");
		if(!ans) return false;
		
		$.ajax({
			type	:	"post",
			url		:	"${ctp}/livestock/diseaseDeleteOk",
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
	<p>오늘의 일정은 총 ${scheduleCnt }건 입니다.</p>
	<div>
		<input type="button" value="돌아가기" onclick="location.href='${ctp}/livestock/disease?yy=${fn:split(ymd, '-')[0] }&mm=${fn:split(ymd, '-')[1]-1}';" class="btn btn-danger float-right m-2" />
	</div>
	<div id="demo"></div>
	<hr/>
	<c:if test="${scheduleCnt != 0 }">
	<table class="table table-hover text-center">
		<tr class="table-dark text-dark">
			<td>번호</td>
			<td>개체번호</td>
			<td>분류</td>
			<td>내용</td>
			<td>비고</td>
		</tr>
		<c:forEach var="vo" items="${vos }" varStatus="st" >
		<tr>
			<td>${st.count }</td>
			<td>${vo.CNum }</td>
			<td>${vo.DType }</td>
			<td>${vo.content }</td>
			<td>
				<input type="button" value="수정" onclick="updateCheck('${vo.idx}', '${vo.DType }', '${fn:replace(vo.content, newLine, '<br/>') }')" id="diseaseUpdateOpen${vo.idx }" class="btn btn-warning btn-sm" />
				<input type="button" value="삭제" onclick="deleteCheck(${vo.idx})" class="btn btn-danger btn-sm" />
			</td>
		</tr>
		<tr>
			<td colspan="5" class="m-0 p-0">
				<div id="updateDemo${vo.idx }"></div>
			</td>
		</tr>
		</c:forEach>
		<tr>
			<td colspan="5" class="m-0 p-0"></td>
		</tr>
	</table>
	</c:if>
</div>


</body>
</html>