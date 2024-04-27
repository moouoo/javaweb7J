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
<title>registration.jsp</title>
<style>
	.hover:hover{
		color: red;
		cursor: pointer;
	}
</style>
<script>
	'use strict';

	function Check(){
		let cNum1 = $("#cNum1").val();
		let cNum2 = $("#cNum2").val();
		let cNum3 = $("#cNum3").val();
		let cNum4 = $("#cNum4").val();
		insertform.cNum.value = cNum1 + "-" + cNum2 + "-" + cNum3 + "-" + cNum4;
		let birthday = $("#birthday").val();
		let etc = $("#etc").val();
		let gender = $("#gender").val();
		
		if(cNum2 == "" || cNum3 == "" || cNum4 == "" || cNum1 == ""){
			alert("개체번호를 입력해주세요");
			insertform.cNum2.focus();
		}
		else {
			insertform.submit();
		}
	}

	function detailCheck(cNum, gender){
		$("#detailModal").on("show.bs.modal", function(e){
    		$(".modal-body #cNum").html(cNum);
    		$(".modal-body #gender").html(gender);
    	});
	}
	
  	function searchCheck() {
    	let searchString = $("#searchString").val();
    	
    	if(searchString.trim() == "") {
    		alert("찾고자하는 검색어를 입력하세요!");
    		searchForm.searchString.focus();
    	}
    	else {
    		searchForm.submit();
    	}
  	}
  	
  	function registrationDelete(idx){
  		let ans = confirm("삭제하시겠습니까?");
  		if(!ans) return false;
  		
  		$.ajax({
  			type	:	"post",
  			url		:	"${ctp}/livestock/registrationDelete",
  			data	:	{idx, idx},
  			success	:	function(){
  				alert("삭제완료");
  				location.reload()
  			},
  			error	:	function(){
  				alert("전송실패");
  			}
  		}); 
  	}
  	
  	function registrationUpdate(birthday, gender, etc, idx){
  		let registrationInput = '<div id = "registrationUpdateform' + idx + '">';
  		registrationInput += '<form name = "Updateform'+idx+'">';
  		registrationInput += '<table class="table table-bordered">';
  		registrationInput += '<tr><th>출생일</th><td>';
  		registrationInput += '<input type="date" name="birthday" id="birthday'+idx+'" class="form-control">';
  		registrationInput += '</td></tr>';
  		registrationInput += '<tr><th>수 / 암</th><td>';
  		registrationInput += '<select name="gender" id="gender'+idx+'" class="form-control">';
  		registrationInput += '<option value="수">수</option>';
  		registrationInput += '<option value="암">암</option>';
  		registrationInput += '<option value="'+gender+'" selected>'+gender+'</option>';
  		registrationInput += '</select>';
  		registrationInput += '</td></tr>';
  		registrationInput += '<tr><th>기타사항</th><td>';
  		registrationInput += '<textarea name="etc" id="etc'+idx+'" row="4" class="form-control">'+etc.replaceAll("<br/>", "<br>")+'</textarea>';
  		registrationInput += '</td></tr>';
  		registrationInput += '<tr><th>가격</th><td>';
  		registrationInput += '<input type="number" name="price" id="price'+idx+'" class="form-control">';
  		registrationInput += '</td></tr>';
  		registrationInput += '<tr><td colspan="2" class="text-center">';
  		registrationInput += '<span class="row">';
  		registrationInput += '<span class="col"><input type="button" value="수정하기" onclick="registrationUpdateOk('+idx+')" class="btn btn-success form-control" /></span>';
  		registrationInput += '<span class="col"><input type="button" value="수정창닫기" onclick="registrationUpdateClose('+idx+')" class="btn btn-warning form-control" /></span>';
  		registrationInput += '</span>';
  		registrationInput += '</td></tr>';
  		registrationInput += '</table>';
  		registrationInput += '</form></div>';
  		
  		$("#registrationUpdateOpen"+idx).hide();
		$("#updateDemo"+idx).slideDown(500);
		$("#updateDemo"+idx).html(registrationInput);
  	}
  	
  	// 수정창닫기
	function registrationUpdateClose(idx){
		$("#registrationUpdateOpen"+idx).show();
		$("#updateDemo"+idx).slideUp(500);
	}
  	
	// 내용 수정하기
	function registrationUpdateOk(idx){
		let birthday = $("#birthday"+idx).val();
		let gender = $("#gender"+idx).val();
		let etc = $("#etc"+idx).val();
		let price = $("#price"+idx).val();
		
		let query = {
				idx			:	idx,
				gender		:	gender,
				birthday	:	birthday,
				etc			:	etc,
				price		:	price
		}
		
		$.ajax({
			type	:	"post",
			url		:	"${ctp}/livestock/registrationUpdateOk",
			data	:	query,
			success	:	function(){
				alert("수정이 완료되었습니다.");
				location.reload();
			},
			error	:	function(){
				alert("기타사항을 제외한 모든 항목을 채우셔야합니다.");
			}
		});
	}
  	
</script>

</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container">
  <h2>가축목록</h2>
  <br/>
  
  <!-- 등록하기 -->
  <table>
  	<tr>
  		<td>
  			<div class="container">
			  <!-- Button to Open the Modal -->
			  <button type="button" class="btn btn-primary m-2" data-toggle="modal" data-target="#myModal">
			    개체등록
			  </button>
			 	&nbsp;&nbsp;가축등록 시 자가 송아지라면 가격표시를 <font color="green"><b>0</b></font>으로 입력한다.
			  
			  <!-- The Modal -->
				<form name="insertform" method="post">
				  	<div class="modal" id="myModal">
				  		<div class="modal-dialog">
					    	<div class="modal-content">
					      
					        <!-- Modal Header -->
					        <div class="modal-header">
					          	<h4 class="modal-title">개체번호등록</h4>
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
					          	
								<div class="form-group">
							      <label for="birthday">출생일</label>
							      <input type="date" class="form-control" name="birthday" id="birthday" value="<%=java.time.LocalDate.now() %>" required />
					          	</div>
					          	
					          	 <div class="form-group">
							      <div class="form-check-inline">
							        <span class="input-group-text">성별 :</span> &nbsp; &nbsp;
							        <label class="form-check-label">
							          <input type="radio" class="form-check-input" name="gender" value="수" checked>수
							        </label>
							      </div>
							      <div class="form-check-inline">
							        <label class="form-check-label">
							          <input type="radio" class="form-check-input" name="gender" value="암">암
							        </label>
							      </div>
							    </div>
					          	
					          	<div class="form-group">
							      <label for="etc">기타사항</label>
							      <input type="text" class="form-control" name="etc" id="etc" />
					          	</div>
					          	
					          	<div class="form-group">
							      <label for="price">가격</label>
							      <input type="number" class="form-control" name="price" id="price" />
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
  		</td>
  	</tr>
  </table>
  
  <!-- 개체상세보기 -->
   <div class="modal fade" id="detailModal" style="width:690px;">
  <div class="modal-dialog">
    <div class="modal-content" style="width:600px;">
    
      <!-- Modal Header -->
      <div class="modal-header" style="width:600px;">
        <h4 class="modal-title">☆ 개체 상세정보 ☆</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      
      <!-- Modal body -->
      <div class="modal-body" style="width:600px;height:400px;overflow:auto;">
        <table class="table table-bordered" style="font-size:10pt">
          <tr>
          	<th colspan="1">개체번호</th>
          	<td colspan="2" id="cNum"></td>
          	<th colspan="1">암 / 수</th>
          	<td colspan="2" id="gender"></td>
          </tr>
          <tr>
          	<th>질병관리</th>
          	<td></td>
          </tr>
          <tr>
          	<th>발정관리</th>
          	<td colspan="4"></td>
          </tr>
          <tr>
          	<th>출산관리</th>
          	<td colspan="4"></td>
          </tr>
        </table>
      </div>
      
      <!-- Modal footer -->
      <div class="modal-footer" style="width:600px;">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
      </div>
      
    </div>
  </div>
</div>
  
  <!-- 목록 -->
  <table class="table table-hover">
    <thead>
      <tr class="text-center">
        <th>번호</th>
        <th>개체번호</th>
        <th>출생일</th>
        <th>암 / 수</th>
        <th>기타사항</th>
        <th>가격</th>
        <th>비고</th>
      </tr>
    </thead>
    <tbody>
    <c:set var="curScrStartNo" value="${pageVO.curScrStartNo}" />
    <c:forEach var="vo" items="${vos }" varStatus="st" >
   	<tr class="text-center">
       	<td>${curScrStartNo }</td>
       	<td>
       		<%-- <a data-toggle="modal" data-target="#detailModal" onclick="detailCheck('${vo.CNum}', '${vo.gender }')" class="hover"> --%>${vo.CNum }<!-- </a> -->
       	</td>
       	<td>${fn:substring(vo.birthday, 0, 10) }</td>
       	<td>${vo.gender }</td>
       	<td>${vo.etc }</td>
       	<td>
       		<script>
				var price = ${vo.price}
				document.write(price.toLocaleString('en'));
			</script>
       	</td>
       	<td>
       		<input type="button" class="btn btn-warning btn-sm" value="수정" onclick="registrationUpdate('${vo.birthday}', '${vo.gender }', '${fn:replace(vo.etc, newLine, '<br/>') }', '${vo.idx }', '${vo.price }')" id="registrationUpdateOpen${vo.idx }" />
       		<input type="button" class="btn btn-danger btn-sm" value="삭제" onclick="registrationDelete('${vo.idx}')" />
       	</td>
    </tr>
    <tr>
    	<td colspan="7" class="m-0 p-0">
    		<div id="updateDemo${vo.idx }"></div>
    	</td>
    </tr>
    <c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
    </c:forEach>
     <tr>
     	<td colspan="7" class="m-0 p-0"></td>
     </tr>
    </tbody>
  </table>
  
  <!--페이징처리 -->
   <div class="text-center m-4">
	  <ul class="pagination justify-content-center">
	    <c:if test="${pageVO.page > 1}">
	    	<li class="page-item">
	    		<a class="page-link text-secondary" href="${ctp}/livestock/registrationList?pageSize=${pageVO.pageSize}&page=1">
	    			첫페이지
	    		</a>
	    	</li>
	    </c:if>
	    <c:if test="${pageVO.curBlock > 0}">
	    	<li class="page-item">
	    		<a class="page-link text-secondary" href="${ctp}/livestock/registrationList?pageSize=${pageVO.pageSize}&page=${(pageVO.curBlock-1)*pageVO.blockSize + 1}">
	    			이전블록
	    		</a>
	    	</li>
	    </c:if>
	    <c:forEach var="i" begin="${pageVO.curBlock*pageVO.blockSize + 1}" end="${pageVO.curBlock*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
	    	<c:if test="${i <= pageVO.totPage && i == pageVO.page}">
	    		<li class="page-item active">
	    			<a class="page-link text-white bg-secondary border-secondary" href="${ctp}/livestock/registrationList?pageSize=${pageVO.pageSize}&page=${i}">
	    				${i}
	    			</a>
	    		</li>
	    	</c:if>
	    	<c:if test="${i <= pageVO.totPage && i != pageVO.page}">
	    		<li class="page-item">
	    			<a class="page-link text-secondary" href="${ctp}/livestock/registrationList?pageSize=${pageVO.pageSize}&page=${i}">
	    				${i}
	    			</a>
	    		</li>
	    	</c:if>
	    </c:forEach>
	    <c:if test="${pageVO.curBlock < pageVO.lastBlock}">
	    	<li class="page-item">
	    		<a class="page-link text-secondary" href="${ctp}/livestock/registrationList?pageSize=${pageVO.pageSize}&page=${(pageVO.curBlock+1)*pageVO.blockSize + 1}">
	    			다음블록
	    		</a>
	    	</li>
	    </c:if>
	    <c:if test="${pageVO.page < pageVO.totPage}">
	    	<li class="page-item">
	    		<a class="page-link text-secondary" href="${ctp}/livestock/registrationList?pageSize=${pageVO.pageSize}&page=${pageVO.totPage}">
	    			마지막페이지
	    		</a>
	    	</li>
	    </c:if>
	  </ul>
  </div>
  
  <!-- 검색기 처리 -->
    <div class="container text-center">
    <form name="searchForm" method="get" action="${ctp }/livestock/registrationSearch">
      <b>검색 : </b>
      <select name="search">
        <option value="cNum" selected>개체번호</option>
        <option value="birthday">출생일</option>
      </select>
      <input type="text" name="searchString" id="searchString"/>
      <input type="button" value="검색" onclick="searchCheck()" class="btn btn-secondary"/>
      <input type="hidden" name="page" value="${pageVO.page}"/>
      <input type="hidden" name="pageSize" value="${pageVO.pageSize}"/>
    </form>
  </div>
  
</div>
</body>
</html>