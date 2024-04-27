<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<title>surveyInput.jsp</title>
<script>
	'use strict';
	
	function surveyInputCheck(){
		let sTitle = $("#sTitle").val();
		let content = $("#content").val();
		
		if(sTitle == ""){
			alert("설문지의 제목을 입력해주세요");
			return false;
			$("#sTitle").focus();
		}
		
		if(content == ""){
			alert("내용은 사용방법 7번을 참고하셔서 작성 바랍니다.");
			return false;
		}
		
		let ans = confirm("제목과 내용을 올바르게 입력하셨습니까? \n만약 잘못 만들었을 경우 설문관리에서 삭제가 가능합니다.");
		if(!ans) return false;
		
		let query = {
				sTitle	:	sTitle,
				content	:	content
		}
		
		$.ajax({
			type	:	"post",
			url		:	"${ctp}/chart/surveyInputOk",
			data	:	query,
			success	:	function(){
				alert("등록되었습니다.");
				location.reload();
			},
			error	:	function(){
				alert("설문전송실패");
			}
		});
	}

	function openSurveyForm() {
		 window.open('https://office.naver.com/#%7B%22section%22%3A%22template%22%2C%22type%22%3A%22form%22%7D', '_blank');
	}
	
	function openSurveyResultForm(){
		window.open('https://mybox.naver.com/#/my', '_blank');
	}
	
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container">
	<h2>설문조사지 생성하기</h2>
	<p><br/></p>
	<div> 제목 : &nbsp;
		<input type="text" id="sTitle" name="sTitle" class="form-control" placeholder="설문조사지의 제목을 입력하세요" />
	</div>
	<div> 내용 : &nbsp;
		<input type="text" id="content" name="content" class="form-control" placeholder="붙여넣기를 사용해주세요 (사용방법 7번 참고)" />
	</div>
	<div class="text-right">
		<input type="button" value="등록하기" class="btn btn-primary m-2" onclick="surveyInputCheck()" />
	</div>
	<p></p>
	<hr/>
	<button type="button" class="btn btn-info" onclick="openSurveyForm()">설문조사지 생성하기</button>
	<button type="button" class="btn btn-secondary" onclick="openSurveyResultForm()">설문조사 결과보기</button>
	<hr/>
	<p>본 설문조사지 생성은 '네이버 오피스'를 이용하고 있습니다.</p>
	<br/>
	<p><b>사용방법</b></p>
	<p>1. 【설문조사지 생성하기】를 클릭한다.</p>
	<p>2. 네이버 로그인을 실행한다.</p>
	<p>3. 중앙상단에 폼을 누른 뒤 원하는 설문조사 폼을 클릭하여 설문조사지를 만든다.</p>
	<p>4. 필요한 설문조사지를 완성시켰다면 중앙상단의 폼 보내기를 클릭하고 웹페이지에 삽입을 누른다.</p>
	<p>5. 이때 네이버box에 저장하라는 팝업창이 뜨는데 기본으로 생성되어있는 '내 문서'에 저장한다. (나중에 네이버box안에 폴더를 생성하여 거기에 저장도 가능하다.)</p>
	<p>6. ④를 반복하면 작성한 내용이 복사되었다는 팝업창이 뜬다.</p>
	<p>7. 다시 이 페이지로 돌아와서 제목 부분에 설문조사지의 제목을, 내용에 붙여넣기(빈칸에 마우스 오른쪽 클릭 -> 붙여넣기)를 입력한다.</p>
	<p>8. 등록하기를 눌러준다.</p>
	<p><hr/><p>
	<p><b>설문결과 결과보는 방법</b></p>
	<p>1. 【설문조사 결과보기】를 클릭한다.</p>
	<p>2. 상단에 'MYBOX바로가기'를 클릭한 후 네이버 로그인을 한다.</p>
	<p>3. 설문조사지를 저장한 폴더를 찾아 들어간다. (사용방법을 따라 했으면 '내 문서'에 저장이 되어있을 것이다.)</p>
	<p>4. 보고자 하는 설문지를 클릭하여 결과를 본다.</p>
	<br/><br/>
</div>
</body>
</html>