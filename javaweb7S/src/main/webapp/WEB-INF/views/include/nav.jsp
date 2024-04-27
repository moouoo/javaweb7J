<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<c:set var="level" value="${sLevel }" />
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  <!-- Brand -->
  <a class="navbar-brand" href="${ctp }/etc/etc">그린농장</a>

  <!-- Links -->
  <ul class="navbar-nav">
  
    <!-- Dropdown -->
    <li class="nav-item dropdown">
      <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
        가축관리
      </a>
      <div class="dropdown-menu">
        <a class="dropdown-item" href="${ctp }/livestock/registrationList">가축목록</a>
        <a class="dropdown-item" href="${ctp }/livestock/disease">질병관리</a>
        <a class="dropdown-item" href="${ctp }/livestock/estrus">발정관리</a>
        <a class="dropdown-item" href="${ctp }/livestock/birth">출산예정일</a>
        <a class="dropdown-item" href="${ctp }/livestock/livestockShipment">출하관리</a>
      </div>
    </li>
    <li class="nav-item dropdown">
      <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
        자원관리
      </a>
      <div class="dropdown-menu">
        <a class="dropdown-item" href="${ctp }/asset/feed">사료관리</a>
        <a class="dropdown-item" href="${ctp }/asset/semen">정액관리</a>
        <a class="dropdown-item" href="${ctp }/asset/medicine">약품관리</a>
        <c:if test="${level == 2 }">
	        <a class="dropdown-item" href="${ctp }/asset/memberList">인력관리</a>
        </c:if>
        <a class="dropdown-item" href="${ctp }/asset/facility">시설기록</a>
      </div>
    </li>
    <li class="nav-item dropdown mr-3">
      <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
        경영관리
      </a>
      <div class="dropdown-menu">
        <a class="dropdown-item" href="${ctp }/chart/chart">차트</a>
        <a class="dropdown-item" href="${ctp }/chart/surveyM">설문관리</a>
      </div>
    </li>
    <c:if test="${level == 2 }">
	    <li class="nav-item">
	          <a class="nav-link" href="${ctp }/etc/loginM">계정관리</a>
	    </li>
    </c:if>
    <li class="nav-item">
		<a class="nav-link" href="${ctp }/chart/survey">설문조사</a>
	</li>
    <li class="nav-item">
          <a class="nav-link" href="${ctp }/etc/logout">로그아웃</a>
    </li>
    <%-- <li class="nav-item">
          <a class="nav-link" href="${ctp }/etc/aaa">연습</a>
    </li> --%>
  </ul>
</nav>