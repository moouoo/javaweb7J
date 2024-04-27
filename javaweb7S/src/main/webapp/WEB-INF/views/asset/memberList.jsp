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
<title>memberList.jsp</title>
<script>
	'use strict';
	
	function memberInput(){
		let name = $("#name").val();
		let gender = $("#gender").val();
		let country = $("#country").val();
		let sTerm = $("#sTerm").val();
		let eTerm = $("#eTerm").val();
		let salary = $("#salary").val();
		let cYear = $("#cYear").val();
		
		let maxSize = 1024 * 1024 * 5 // 업로드 최대크기 5MByte
		let fName = memberform.fName.value;
		let ext = fName.substring(fName.lastIndexOf(".")+1).toUpperCase();
		
		
		if(fName.trim() == ""){
			memberform.photo.value = "noimage.jpeg";
		}
		else{
			let fileSize = document.getElementById("file").files[0].size;
			
			if(ext != "JPG" && ext != "GIF" && ext != "PNG" && ext != "JPEG"){
				alert("업로드 가능한 확장자는 JPG/GIF/PNG/JPEG 입니다.");
				return false;
			}
			else if(fName.indexOf(" ") != -1){
				alert("파일명에 공백이 포함할 수 없습니다.");
				return false;
			}
			else if(fileSize > maxSize){
				alert("업로드할 파일은 최대 5MByte입니다. 파일의 크기를 확인해주세요.");
				return false;
			}
		}
		memberform.submit();
		
	}
	
	function memberUpdate(name, gender, country, sTerm, eTerm, salary, cYear, file, idx){
		$('#MemberUpdate').modal('show'); 
		$(".modal-body #name").val(name);
		$(".modal-body #gender").val(gender);
		$(".modal-body #country").val(country);
		$(".modal-body #sTerm").val(sTerm);
		$(".modal-body #eTerm").val(eTerm);
		$(".modal-body #salary").val(salary);
		$(".modal-body #cYear").val(cYear);
		$(".modal-body #file").val(file);
		$(".modal-body #idx").val(idx);
	}
	
	function memberUpdateCheck(){
		let name = $("#name").val();
		let gender = $("#gender").val();
		let country = $("#country").val();
		let sTerm = $("#sTerm").val();
		let eTerm = $("#eTerm").val();
		let salary = $("#salary").val();
		let cYear = $("#cYear").val();
		let idx = $("#idx").val();
		
		let maxSize = 1024 * 1024 * 5 // 업로드 최대크기 5MByte
		let fName = memberUpdateform.fName.value;
		let ext = fName.substring(fName.lastIndexOf(".")+1).toUpperCase();
		
		
		if(fName.trim() == ""){
			memberUpdateform.photo.value = "noimage.jpeg";
		}
		else{
			let fileSize = document.getElementById("file").files[0].size;
			
			if(ext != "JPG" && ext != "GIF" && ext != "PNG" && ext != "JPEG"){
				alert("업로드 가능한 확장자는 JPG/GIF/PNG/JPEG 입니다.");
				return false;
			}
			else if(fName.indexOf(" ") != -1){
				alert("파일명에 공백이 포함할 수 없습니다.");
				return false;
			}
			else if(fileSize > maxSize){
				alert("업로드할 파일은 최대 5MByte입니다. 파일의 크기를 확인해주세요.");
				return false;
			}
		}
		memberUpdateform.submit();
		
	} 
	
	function memberDelete(idx){
		let ans = confirm("삭제하시겠습니까?");
		if(!ans) return false;
		
		$.ajax ({
			type	:	"post",
			url		:	"${ctp}/asset/memberDelete",
			data	:	{idx : idx},
			success	:	function(){
				alert("삭제가 완료되었습니다.");
				location.reload();
			},
			error	:	function(){
				alert("삭제전송실패");
			}
		});
	}

	
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container">
	<h2>인력목록</h2>
	<hr/>
	<input type="button" value="등록하기" class="btn btn-info row justify-content-right" data-toggle="modal" data-target="#MemberList" />
	
	<form name="memberform" method="post" enctype="multipart/form-data">
		<!-- The Modal -->
		<div class="modal" id="MemberList">
			<div class="modal-dialog">
		    	<div class="modal-content">
		
		      	<!-- Modal Header -->
		      	<div class="modal-header">
		        	<h4 class="modal-title">인력등록</h4>
		        	<button type="button" class="close" data-dismiss="modal">&times;</button>
		      	</div>
		
		      	<!-- Modal body -->
		      	<div class="modal-body">
		        	<div class="form-group">
		        		<label for="name">이름</label>
		      			<input type="text" class="form-control" name="name" id="name" required autofocus />
		        	</div>
		        	
		        	<div class="form-group">
			      		<div class="form-check-inline">
			        		<span class="input-group-text">성별 :</span> &nbsp; &nbsp;
			        		<label class="form-check-label">
			          			<input type="radio" class="form-check-input" name="gender" value="남자" checked>남자
			        		</label>
			      		</div>
			      		<div class="form-check-inline">
			        		<label class="form-check-label">
			          			<input type="radio" class="form-check-input" name="gender" value="여자">여자
			        		</label>
			      		</div>
			    	</div>
			    	
			    	<div class="form-group">
			    		<label for="country">국적</label>
		      			<input type="text" class="form-control" name="country" id="country" required />
			    	</div>
			    	
			    	<div class="form-group">
			    		<label for="sTerm">시작일</label>
			    		<input type="date" class="form-control" name="sTerm" id="sTerm" required />
			    	</div>
			    	
			    	<div class="form-group">
			    		<label for="eTerm">종료일</label>
			    		<input type="date" class="form-control" name="eTerm" id="eTerm" required />
			    	</div>
			    	
			    	<div class="form-group">
			    		<label for="salary">월급</label>
			    		<input type="number" class="form-control" name="salary" id="salary" required />
			    	</div>
			    	
			    	<div class="form-group">
			    		<label for="cYear">계약년도</label>
		      			<input type="date" class="form-control" name="cYear" id="cYear" value="<%=java.time.LocalDate.now() %>" required />
			    	</div>
			    	
			    	<div class="form-group">
			    		사진 :
		      			<input type="file" class="form-control-file border" name="fName" id="file" required />
		      			<input type="hidden" name="photo" />
			    	</div>
			    	
			    </div>
		
		      	<!-- Modal footer -->
		      	<div class="modal-footer">
		        	<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
		        	<input type="button" class="btn btn-info" value="등록" onclick="memberInput()" />
		      	</div>
		
		    	</div>
		 	</div>
		</div>
	</form>
	
	<table class="table table-hover">
    <thead>
      <tr class="text-center">
        <th>번호</th>
        <th>이름</th>
        <th>성별</th>
        <th>국적</th>
        <th>월급</th>
        <th>계약일</th>
        <th>계약기간</th>
        <th>계약종료일</th>
        <th>사진</th>
        <th>비고</th>
      </tr>
    </thead>
    <tbody>
    <c:forEach var="vo" items="${vos}" varStatus="st">
      <tr class="text-center">
        <td>${st.count }</td>
        <td>${vo.name }</td>
        <td>${vo.gender }</td>
        <td>${vo.country }</td>
        <td>
        	<script>
				var price = ${vo.salary }
				document.write(price.toLocaleString('en'));
			</script>
        </td>
        <td>${fn:substring(vo.CYear, 0, 10) }</td>
        <td>${vo.diff }일</td>
        <td>${vo.ETerm }</td>
        <td><img src="${ctp}/resources/asset/member/${vo.photo }" width="100px" /></td>
        <td>
        	<%-- <input type="button" value="수정" class="btn btn-success btn-sm"
        		onclick="memberUpdate('${vo.name }', '${vo.gender }', '${vo.country }', '${vo.salary }', '${vo.CYear }', '${vo.ETerm }', '${vo.STerm }', '${vo.photo }', '${vo.idx }')" /> --%>
        	<input type="button" value="삭제" class="btn btn-danger btn-sm" onclick="memberDelete('${vo.idx}')" />
        </td>
      </tr>
      </c:forEach>
    </tbody>
  </table>
	
</div>

<form name="memberUpdateform" method="post" enctype="multipart/form-data" action="${ctp }/asset/memberUpdate">
		<!-- The Modal -->
		<div class="modal" id="MemberUpdate">
			<div class="modal-dialog">
		    	<div class="modal-content">
		
		      	<!-- Modal Header -->
		      	<div class="modal-header">
		        	<h4 class="modal-title">인력수정</h4>
		        	<button type="button" class="close" data-dismiss="modal">&times;</button>
		      	</div>
		
		      	<!-- Modal body -->
		      	<div class="modal-body">
		        	<div class="form-group">
		        		<label for="name">이름</label>
		      			<input type="text" class="form-control" name="name" id="name" required autofocus />
		        	</div>
		        	
		        	<div class="form-group">
			      		<div class="form-check-inline">
			        		<span class="input-group-text">성별 :</span> &nbsp; &nbsp;
			        		<label class="form-check-label">
			          			<input type="radio" class="form-check-input" name="gender" value="남자" checked>남자
			        		</label>
			      		</div>
			      		<div class="form-check-inline">
			        		<label class="form-check-label">
			          			<input type="radio" class="form-check-input" name="gender" value="여자">여자
			        		</label>
			      		</div>
			    	</div>
			    	
			    	<div class="form-group">
			    		<label for="country">국적</label>
		      			<input type="text" class="form-control" name="country" id="country" required />
			    	</div>
			    	
			    	<div class="form-group">
			    		<label for="sTerm">시작일</label>
			    		<input type="date" class="form-control" name="sTerm" id="sTerm" required />
			    	</div>
			    	
			    	<div class="form-group">
			    		<label for="eTerm">종료일</label>
			    		<input type="date" class="form-control" name="eTerm" id="eTerm" required />
			    	</div>
			    	
			    	<div class="form-group">
			    		<label for="salary">월급</label>
			    		<input type="number" class="form-control" name="salary" id="salary" required />
			    	</div>
			    	
			    	<div class="form-group">
			    		<label for="cYear">계약년도</label>
		      			<input type="date" class="form-control" name="cYear" id="cYear" value="<%=java.time.LocalDate.now() %>" required />
			    	</div>
			    	
			    	<div class="form-group">
			    		사진 :
		      			<input type="file" class="form-control-file border" name="fName" id="file" />
		      			<input type="hidden" name="photo" />
		        		<input type="hidden" id="idx" />
			    	</div>
			    	
			    </div>
		
		      	<!-- Modal footer -->
		      	<div class="modal-footer">
		        	<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
		        	<input type="button" class="btn btn-info" value="수정하기" onclick="memberUpdateCheck()"/>
		      	</div>
		
		    	</div>
		 	</div>
		</div>
	</form>


  <!--페이징처리 -->
   <div class="text-center m-4">
	  <ul class="pagination justify-content-center">
	    <c:if test="${pageVO.page > 1}">
	    	<li class="page-item">
	    		<a class="page-link text-secondary" href="${ctp}/asset/memberList?pageSize=${pageVO.pageSize}&page=1">
	    			첫페이지
	    		</a>
	    	</li>
	    </c:if>
	    <c:if test="${pageVO.curBlock > 0}">
	    	<li class="page-item">
	    		<a class="page-link text-secondary" href="${ctp}/asset/memberList?pageSize=${pageVO.pageSize}&page=${(pageVO.curBlock-1)*pageVO.blockSize + 1}">
	    			이전블록
	    		</a>
	    	</li>
	    </c:if>
	    <c:forEach var="i" begin="${pageVO.curBlock*pageVO.blockSize + 1}" end="${pageVO.curBlock*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
	    	<c:if test="${i <= pageVO.totPage && i == pageVO.page}">
	    		<li class="page-item active">
	    			<a class="page-link text-white bg-secondary border-secondary" href="${ctp}/asset/memberList?pageSize=${pageVO.pageSize}&page=${i}">
	    				${i}
	    			</a>
	    		</li>
	    	</c:if>
	    	<c:if test="${i <= pageVO.totPage && i != pageVO.page}">
	    		<li class="page-item">
	    			<a class="page-link text-secondary" href="${ctp}/asset/memberList?pageSize=${pageVO.pageSize}&page=${i}">
	    				${i}
	    			</a>
	    		</li>
	    	</c:if>
	    </c:forEach>
	    <c:if test="${pageVO.curBlock < pageVO.lastBlock}">
	    	<li class="page-item">
	    		<a class="page-link text-secondary" href="${ctp}/asset/memberList?pageSize=${pageVO.pageSize}&page=${(pageVO.curBlock+1)*pageVO.blockSize + 1}">
	    			다음블록
	    		</a>
	    	</li>
	    </c:if>
	    <c:if test="${pageVO.page < pageVO.totPage}">
	    	<li class="page-item">
	    		<a class="page-link text-secondary" href="${ctp}/asset/memberList?pageSize=${pageVO.pageSize}&page=${pageVO.totPage}">
	    			마지막페이지
	    		</a>
	    	</li>
	    </c:if>
	  </ul>
  </div>

</body>
</html>