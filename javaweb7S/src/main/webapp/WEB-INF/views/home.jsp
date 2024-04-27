<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<title>homeLogin.jsp</title>
</head>
<body>
<br/>
<br/>
<br/>
<br/>
<p><br/></p>
<div class="container">
  <div class="modal-dialog">
	  <div class="modal-content p-4">
		  <h2 class="text-center">관리자 로그인</h2>
		  <p class="text-center">(등록되어있는 관리자 아이디와 비밀번호를 입력해 주세요)</p>
		  <form name="myform" method="post">
		    <div class="form-group">
		      <label for="mid">관리자 아이디</label>
		      <input type="text" class="form-control" name="mid" id="mid" placeholder="아이디를 입력하세요." required autofocus />
		      <div class="valid-feedback">Ok!!!</div>
		      <div class="invalid-feedback">아이디를 입력해 주세요.</div>
		    </div>
		    <div class="form-group">
		      <label for="pwd">비밀번호</label>
		      <input type="password" class="form-control" name="pwd" id="pwd" placeholder="비밀번호를 입력하세요" required />
		      <div class="valid-feedback">Ok!!!</div>
		      <div class="invalid-feedback">비밀번호를 입력해 주세요.</div>
		    </div>
		    <div class="form-group text-center">
		    	<input type="submit" value="로그인" class="btn btn-primary mr-1" />
		    	<input type="reset" value="다시입력" class="btn btn-warning">
		    </div>
		  </form>
	  </div>
  </div>
</div>
<p><br/></p>
</body>
</html>