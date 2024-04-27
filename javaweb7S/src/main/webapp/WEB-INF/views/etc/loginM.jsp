<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<title>loginM.jsp</title>
<script>
	'use strict';
	
	let idCheckSw = 0;
	
	function Check(){
		let mid = $("#mid").val();
		let pwd = $("#pwd").val();
		let pwd2 = $("#pwd2").val();
		let level = $("#level").val();
		
		if(mid == ""){
			alert("아이디를 입력해주세요");
			return memberInputform.mid.focus();
		}
		
		if(pwd != pwd2){
			alert("비밀번호를 일치시켜 주십시요");
			return memberInputform.pwd2.focus();
		}
		else if(pwd == ""){
			alert("비밀번호를 입력해주세요");
			return memberInputform.pwd1.focus();
		}
		else if(pwd2 == ""){
			alert("비밀번호확인을 입력해주세요");
			return memberInputform.pwd2.focus();
		}
		
		if(idCheckSw == 0){
			alert("아이디 중복체크버튼을 눌러주세요");
		}
		else memberInputform.submit();
	}
	
	function midCheck(){
		let mid = memberInputform.mid.value;
		if(mid == ""){
			alert("아이디를 입력해주세요");
			return memberInputform.mid.focus();
		}
		
		$.ajax({
			type	:	"post",
			url		:	"${ctp}/etc/midCheck",
			data	:	{mid : mid},
			success	:	function(res){
				if(res == "1"){
					alert("이미 사용중인 아이디입니다.");
					$("#mid").focus();
				}
				else{
					alert("사용 가능한 아이디 입니다.");
					idCheckSw = 1;
					$("#pwd1").focus();
				}
			},
			error	:	function(){
				alert("전송오류");
			}
		});
	}
	
	function loginDeleteCheck(idx){
		let ans = confirm("삭제하시겠습니까?");
		if(!ans) return false;
		
		$.ajax({
			type	:	"post",
			url		:	"${ctp}/etc/loginDelete",
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
	<br/>
	<h2>계정관리</h2>
	<p><br/></p>
	<input type="button" value="계정추가하기" class="btn btn-info m-2" data-toggle="modal" data-target="#memberInput" />
		<table class="table table-hover text-center">
			<tr class="table-dark">
				<th>번호</th>
				<th>아이디</th>
				<th>계정레벨</th>
				<th>비고</th>
			</tr>
			<c:forEach var="vo" items="${vos }" varStatus="st">
			<tr>
				<td>${st.count }</td>
				<td>${vo.mid }</td>
				<td>
					<c:if test="${vo.level == 2 }">농장주</c:if>
					<c:if test="${vo.level == 1 }">관리인</c:if>
				</td>
				<td>
					<input type="button" value="삭제" class="btn btn-danger btn-sm" onclick="loginDeleteCheck('${vo.idx}')" />
				</td>
			</tr>
			</c:forEach>
		</table>
	</div>
	
	<!-- 계정추가 모달 -->
	<!-- The Modal -->
	<div class="container">
		<form name="memberInputform" method="post" action="${ctp }/etc/memberInput">
		  	<div class="modal" id="memberInput">
		  		<div class="modal-dialog">
			    	<div class="modal-content">
			      
			        <!-- Modal Header -->
			        <div class="modal-header">
			          	<h4 class="modal-title">계정추가</h4>
			          	<button type="button" class="close" data-dismiss="modal">&times;</button>
			        </div>
			        
			        <!-- Modal body -->
			        <div class="modal-body">
						<div class="form-group">
							<div class="input-group mb-3">
					      		<label for="mid">아이디 : </label> &nbsp;
					      		<input type="text" class="form-control" id="mid" name="mid" required autofocus />
					      		<input type="button" value="중복확인" onclick="midCheck()" class="btn btn-info btn-sm" /> 
					    	</div>
			          	</div>
			          	
						<div class="form-group">
					      	<label for="pwd">비밀번호</label>
					      	<input type="password" class="form-control" name="pwd" id="pwd" required />
			          	</div>
			          	
						<div class="form-group">
					      	<label for="pwd2">비밀번호 확인</label>
					      	<input type="password" class="form-control" name="pwd2" id="pwd2" required />
			          	</div>
			          	
			          	<div class="form-group">
					      	<label for="level">권한레벨</label>
							<select id="level" name="level">
					      		<option value="1" selected>관리인</option>
					      		<option value="2">농장주</option>
					      	</select>
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
	</div>
</body>
</html>