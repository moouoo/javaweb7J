<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<title>연습</title>
<style>
	 /* 스타일을 추가하여 폼 디자인을 변경할 수 있습니다. */
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
        }
        .survey-form {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .question {
            margin-bottom: 20px;
        }
</style>
<script>
	'use strict';
	
	   var questionCounter = 1;

	    function addQuestion() {
	      let questionContainer = document.getElementById("questionContainer");

	      var newQuestion = document.createElement("div");
	      newQuestion.className = "question";

	      // 항목 제목 입력란 추가
	      var titleLabel = document.createElement("label");
	      titleLabel.innerHTML = "항목 제목:";
	      var titleInput = document.createElement("input");
	      titleInput.type = "text";
	      titleInput.name = "title" + questionCounter;
	      titleInput.required = true;
	      newQuestion.appendChild(titleLabel);
	      newQuestion.appendChild(titleInput);

	      var questionSelect = document.createElement("select");
	      questionSelect.id = "category" + questionCounter;
	      questionSelect.name = "category" + questionCounter;

	      var option1 = document.createElement("option");
	      option1.value = "";
	      option1.innerHTML = "유형";
	      questionSelect.appendChild(option1);

	      var option2 = document.createElement("option");
	      option2.value = "주관식단답형";
	      option2.innerHTML = "주관식단답형";
	      questionSelect.appendChild(option2);

	      var option3 = document.createElement("option");
	      option3.value = "선호도형";
	      option3.innerHTML = "선호도형";
	      questionSelect.appendChild(option3);

	      questionSelect.addEventListener('change', function() {
	        // 기존에 추가된 요소들 삭제
	        while (newQuestion.childNodes.length > 2) {
	          newQuestion.removeChild(newQuestion.lastChild);
	        }

	        if (this.value === "주관식단답형") {
	          // 주관식단답형에 해당하는 요소 추가
	          var input = document.createElement("input");
	          input.type = "text";
	          input.className = "form-control";
	          input.name = "answer" + questionCounter;
	          input.placeholder = "답변을 입력해주세요";
	          newQuestion.appendChild(input);
	        } else if (this.value === "선호도형") {
	          // 선호도형에 해당하는 요소 추가
	          var input1 = document.createElement("input");
	          input1.type = "text";
	          input1.className = "form-control";
	          input1.id = "answer" + questionCounter + "1";
	          input1.name = "answer" + questionCounter + "1";
	          input1.placeholder = "예)싫다";
	          newQuestion.appendChild(input1);

	          var select1 = document.createElement("select");
	          select1.name = "answer" + questionCounter + "2";
	          var option1_1 = document.createElement("option");
	          option1_1.value = "1";
	          option1_1.innerHTML = "1";
	          select1.appendChild(option1_1);
	          // 추가적인 답변 옵션들도 추가 가능
	          newQuestion.appendChild(select1);

	          var textNode = document.createTextNode("~");
	          newQuestion.appendChild(textNode);

	          var select2 = document.createElement("select");
	          select2.id = "checkBox" + questionCounter;
	          select2.name = "checkBox" + questionCounter;
	          var option3_1 = document.createElement("option");
	          option3_1.value = "3";
	          option3_1.innerHTML = "3";
	          select2.appendChild(option3_1);
	          var option5 = document.createElement("option");
	          option5.value = "5";
	          option5.innerHTML = "5";
	          select2.appendChild(option5);
	          var option9 = document.createElement("option");
	          option9.value = "9";
	          option9.innerHTML = "9";
	          select2.appendChild(option9);
	          // 추가적인 체크박스 옵션들도 추가 가능
	          newQuestion.appendChild(select2);

	          var input2 = document.createElement("input");
	          input2.type = "text";
	          input2.className = "form-control";
	          input2.id = "answer" + questionCounter + "3"
	          input2.name = "answer" + questionCounter + "3";
	          input2.placeholder = "예)좋다";
	          newQuestion.appendChild(input2);
	        }
	      });

	      newQuestion.appendChild(questionSelect);

	      questionContainer.appendChild(newQuestion);

	      questionCounter++;
	    }
	    
	    function serveyInput(){
	    	let ans = confirm("설문지를 생성하시겠습니까?");
	    	if(!ans) return false;
	    	
	    	surveyInputform.submit();
	    }
    
	function surveyInputCheck(){
		let sTitle = $("#sTitle").val();
		let content = $("#content").val();
		
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
<div class="survey-form">
	<h2>설문조사</h2>
	<form id="surveyInputform" method="post" action="${ctp }/chart/surveyContent">
	    <div id="questionContainer">
	    <div>제목 : <input type="text" class="form-control" id="wTitle" name="wTitle" /></div>
	        <%-- <div class="question">
	            <label for="title">항목 제목</label>
	            <input type="text" name="title" id="title" required>
	        </div>
	
	        <div class="question">
	            <select id="category" name="category">
	            	<option value="">유형</option>
	            	<option value="주관식단답형" ${category == '주관식단답형' ? selected : '' }>주관식단답형</option>
	            	<option value="선호도형" ${category == '선호도형' ? selected : '' }>선호도형</option>
	            <c:if test="${category == '주관식단답형' }">
	            	<input type="text" class="form-control" palceholder="답변을 입력해주세요" />
	            </c:if>
	            <c:if test="${category == '선호도형' }">
	            	<input type="text" class="form-control" palceholder="예)싫다" />
	            	<select>
	            		<option value="1">1</option>
	            	</select>
	            	~
	            	<select id="checkBox" name="checkBox">
	            		<option value="3" ${checkBox == '3' ? selected : '' }>3</option>
	            		<option value="5" ${checkBox == '5' ? selected : '' }>5</option>
	            		<option value="9" ${checkBox == '9' ? selected : '' }>9</option>
	            	</select>
	            	<input type="text" class="form-control" palceholder="예)좋다" />
	            </c:if>
	            </select>
	        </div> --%>
	   </div>
	  <button onclick="addQuestion()">항목 추가</button>
	  <input type="button" value="생성하기" class="btn btn-info" onclick="serveyInput()" />
	</form>
</div>
</div>

<hr/> 

<div class="container">
	<h2>네이버설문조사이용하기</h2>
	<p><br/></p>
	<button type="button" class="btn btn-info" onclick="window.location.href='https://www.naver.com'">네이버</button>
</div>
<hr/>

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
	<p><hr/></p>
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