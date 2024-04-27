<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<title>disease.jsp</title>
 <style>
    #td1,#td8,#td15,#td22,#td29,#td36 {color:red}
    #td7,#td14,#td21,#td28,#td35 {color:blue}
    .today {
      background-color: pink;
      color: #fff;
      font-weight: bolder;
    }
  </style>
  <script>
  'use strict';
  
  function Check(){
	  	let cNum1 = $("#cNum1").val();
		let cNum2 = $("#cNum2").val();
		let cNum3 = $("#cNum3").val();
		let cNum4 = $("#cNum4").val();
		diseaseform.cNum.value = cNum1 + "-" + cNum2 + "-" + cNum3 + "-" + cNum4;
		let dType = $("#dType").val();
		let etc = $("#content").val();
		let dBirth = $("#dBirth").val();
		
		if(cNum2 == "" || cNum3 == "" || cNum4 == "" || cNum1 == ""){
			alert("개체번호를 입력해주세요");
			diseaseform.cNum2.focus();
		}
		else {
			diseaseform.submit();
		}
  }
  
  
  
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="text-center">
	<div class="text-center">
     <button type="button" onclick="location.href='${ctp}/livestock/disease?yy=${yy-1}&mm=${mm}';" class="btn btn-secondary btn-sm" title="이전년도">◁◁</button>
     <button type="button" onclick="location.href='${ctp}/livestock/disease?yy=${yy}&mm=${mm-1}';" class="btn btn-secondary btn-sm" title="이전월">◀</button>
     <font size="5">${yy}년 ${mm+1}월</font>
     <button type="button" onclick="location.href='${ctp}/livestock/disease?yy=${yy}&mm=${mm+1}';" class="btn btn-secondary btn-sm" title="다음월">▶</button>
      <button type="button" onclick="location.href='${ctp}/livestock/disease?yy=${yy+1}&mm=${mm}';" class="btn btn-secondary btn-sm" title="다음년도">▷▷</button>
      &nbsp;&nbsp;
      <button type="button" onclick="location.href='${ctp}//livestock/disease';" class="btn btn-secondary btn-sm" title="오늘날짜">오늘</button>
	</div>
  <br/>
 <div class="text-center">
    <table class="table table-bordered" style="height:450px">
      <tr class="table-dark text-dark">
        <th style="width:14%; vertical-align:middle; color:red">일</th>
        <th style="width:14%; vertical-align:middle;">월</th>
        <th style="width:14%; vertical-align:middle;">화</th>
        <th style="width:14%; vertical-align:middle;">수</th>
        <th style="width:14%; vertical-align:middle;">목</th>
        <th style="width:14%; vertical-align:middle;">금</th>
        <th style="width:14%; vertical-align:middle; color:blue">토</th>
      </tr>
      <tr>
         <!-- 시작월 이전의 공백을 이던달의 날짜로 채워준다. -->
         <c:set var="cnt" value="${1}"/>
         <c:forEach var="prevDay" begin="${preLastDay - (startWeek - 2)}" end="${preLastDay}" varStatus="st">
           <td style="color:#ccc;font-size:0.6em; text-align:left;">${prevYear}-${prevMonth+1}-${prevDay}</td>
            <c:set var="cnt" value="${cnt + 1}"/>
         </c:forEach>
         
         <!-- 해당월에 대한 첫째주 날짜부터 출력하되, gap이 7이되면 줄바꿈한다. -->
         <c:forEach begin="1" end="${lastDay}" varStatus="st">
           <c:set var="todaySw" value="${toYear==yy && toMonth==mm && toDay==st.count ? 1 : 0}" />
           <td id="td${gap}" ${todaySw==1 ? 'class=today' : ''} style="text-align:left;vertical-align:top;height:90px">
           <c:set var="ymd" value="${yy }-${mm+1 }-${st.count }" />
             <a href="${ctp }/livestock/diseaseDetail?ymd=${ymd}">
                ${st.count}</a><br/>
                
                <!-- 해당날짜에 일정이 있다면 part를 출력하게 한다. -->
               <c:set var="tempPart" value=""/>
               <c:set var="tempCnt" value="0"/>
               <c:set var="tempSw" value="0"/>
               
               <c:forEach var="vo" items="${vos}">
                  <c:if test="${fn:substring(vo.DBirth,8,10)==st.count}">
                    <c:if test="${vo.DType != tempPart}">
                    	<c:if test="${tempSw != 0}">
                       		- ${tempPart}(${tempCnt})건<br/>
                       <c:set var="tempCnt" value="0"/>
                    </c:if>
                    <c:set var="tempPart" value="${vo.DType}"/>                  
                  </c:if>
                  <c:set var="tempSw" value="1"/>
                  <c:set var="tempCnt" value="${tempCnt + 1}"/>
                  </c:if>
                </c:forEach>
                <c:if test="${tempCnt != 0}">- ${tempPart}(${tempCnt})건</c:if>
             </a>
           </td>
           <c:if test="${cnt % 7 == 0}"></tr><tr></c:if> <!-- 한주가 꽉차면 줄바꾸기 한다. -->
           <c:set var="cnt" value="${cnt + 1}"/>
         </c:forEach>
         
         <!-- 마지막일 이후를 다음달의 시작일자부터 채워준다. -->
         <c:if test="${nextStartWeek != 1 }">
         	<c:forEach begin="${nextStartWeek}" end="7" varStatus="nextDay" >
            	<td style="color:#ccc;font-size:0.6em; text-align:left;">${nextYear}-${nextMonth+1}-${nextDay.count}</td>
         	</c:forEach>
         </c:if>
      </tr>
    </table>
  </div>
</div>

<div class="container">
  <!-- Button to Open the Modal -->
  <div class="row justify-content-center">
    <div class="col-auto">
      <!-- 등록하기 버튼 -->
      <input type="button" class="btn btn-primary m-2" value="등록하기" data-toggle="modal" data-target="#myModal">
    </div>
  </div>

<!-- 질병등록 -->
  <!-- The Modal -->
  <form name="diseaseform" method="post">
  <div class="modal" id="myModal">
    <div class="modal-dialog">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">질병등록</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
        	<div class="form-group">
				<div class="input-group mb-3">
		      		<label for="cNum">개체번호 : </label> &nbsp;
		      		<input type="text" class="form-control" name="cNum1" id="cNum1" value="002" maxlength=3 required autofocus />-
		      		<input type="text" class="form-control" name="cNum2" id="cNum2" maxlength=4 required />-
		      		<input type="text" class="form-control" name="cNum3" id="cNum3" maxlength=4 required />-
		      		<input type="text" class="form-control" name="cNum3" id="cNum4" maxlength=1 required />
		      		<input type="hidden" name="cNum" id="cNum" />
		    	</div>
          	</div>
        </div>
        
        <div class="form-group">
        	<label for="dType">질병타입</label>
        	<select class="form-control" id="dType" name="dType">
        		<option value="설사" selected >설사</option>
        		<option value="미열" >미열</option>
        		<option value="호흡기" >호흡기</option>
        		<option value="탈수" >탈수</option>
        		<option value="기타" >기타</option>
        	</select>
        </div>
        
        <div class="form-group">
	      <label for="content">상세사항</label>
	      <input type="text" class="form-control" name="content" id="content" />
       	</div>
       	
      	<div class="form-group">
	      <label for="dBirth">기록일</label>
	      <input type="date" class="form-control" name="dBirth" id="dBirth" value="<%=java.time.LocalDate.now() %>" required />
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