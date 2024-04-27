<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<c:set var="level" value="${sLevel }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<title>medicine.jsp</title>
<style>
	.imageSet{
		display: flex;
    	justify-content: center;
    	align-items: center;
    	width: 290px;
    	height: 300px;
    	object-fit: cover;
	}
	.custom-card {
  		height: 550px; /* 원하는 높이 설정 */
  		width: 300px;
  		padding: 3px;
	}
</style>
<script>
	'use strict';
	
	function medicineInput(){
		let title = $("#title").val();
		let purchase = $("#purchase").val();
		let price = $("#price").val();
		let pYear = $("#pYear").val();
		let content = $("#content").val();
		
		let maxSize = 1024 * 1024 * 5 // 업로드 최대크기 5MByte
		let fName = medicineInputform.fName.value;
		let ext = fName.substring(fName.lastIndexOf(".")+1).toUpperCase();
		
		if(title == ""){
			alert("약품명을 입력해주세요");
			medicineInputform.title.focus();
			return false;
		}
		else if(purchase.trim() == ""){
			alert("구입량을 입력해주세요");
			medicineInputform.purchase.focus();
			return false;
		}
		else if(price.trim() == ""){
			alert("개 당 가격을 입력해주세요");
			medicineInputform.price.focus();
			return false;
		}
		else if(content == ""){
			alert("사용 용도를 입력해주세요");
			medicineInputform.content.focus();
			return false;
		}
		else if(pYear == ""){
			alert("구입일자를 입력해주세요");
			return false;
		}
		
		if(fName.trim() == ""){
			alert("사진을 등록해주세요!");
			return false;
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
		medicineInputform.submit();
	}
	
	// 재입고 모달창에 약품명 데이터를 넣기 위한 작업
	$(document).ready(function() {
		$('#restock').on('show.bs.modal', function(event) {
			var button = $(event.relatedTarget);
			var data = button.data('id');
			$('#title2').val(data);
		});
	});
	
	// 재입고 확인
	function restockCheck(){
		let ans = confirm("재입고 하시겠습니까?");
		if(!ans)return false;
		
		restockform.submit();
	}
	
	// 사용표시 누르면 재고량 1 감소
	function useCheck(title, stock){
		let ans = confirm(title + " 를 사용하셨습니까?");
		if(!ans) return false;
		
		let query ={
				title	:	title,
				stock	:	stock
		}
		
		$.ajax({
			type	:	"post",
			url		:	"${ctp}/asset/medicineUseCheck",
			data	:	query,
			success	:	function(){
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
   	<h2>약품관리</h2>
   	<p><hr/></p>
   	<div style="text-align: right;">
   		<c:if test="${level == 2 }">
	   		<input type="button" class="btn btn-success m-2" value="약품등록" data-toggle="modal" data-target="#medicineInput" /><p></p>
   		</c:if>
   	</div>
   	<div class="card-deck">
   	<c:forEach var="vo" items="${vos }" varStatus="st">
   		<div class="row">
        	<div class="col-3">
          		<div class="card custom-card m-2">
            		<div class="card-header">
              			${vo.title }
            		</div>
            		<img src="${ctp}/resources/asset/medicine/${vo.photo }" alt="" class="imageSet text-center" />
            		<div class="card-body">
            			<form class="form-inline">
              				<h5 class="card-title">사용 : </h5>&nbsp;&nbsp; 
							<input type="button" class="btn btn-info" onclick="useCheck('${vo.title}', '${vo.stock }')" value="💊" style="display: inline-block;" />
						</form>
              			<p class="card-title">재고량 : &nbsp;${vo.stock }</p>
              			<p>용도: &nbsp;${vo.content }</p>
              		</div>
            		<div class="card-footer">
            			<div style="text-align: right;">
            				<c:if test="${level == 2 }">
	            				<a href="#" data-toggle="modal" data-target="#restock" data-id="${vo.title }" data-photo="${vo.photo }" class="btn btn-primary" style="text-align: right">재입고</a>
            				</c:if>
            			</div>
            		</div>
            	</div>
            	<c:if test="${st.index % 3 == 2}">
            	</c:if>
        	</div>
      	</div>
      	</c:forEach>
      	</div>
   	</div>

	<!-- 약품추가 모달창 -->
	<!-- The Modal -->
	<div class="modal" id="medicineInput">
		<div class="modal-dialog">
	    	<div class="modal-content">
	
	      	<!-- Modal Header -->
			<form name="medicineInputform" method="post" action="${ctp }/asset/medicineInput" enctype="multipart/form-data">
		      	<div class="modal-header">
		        	<h4 class="modal-title">약품등록</h4>
		        	<button type="button" class="close" data-dismiss="modal">&times;</button>
		      	</div>
		
		      	<!-- Modal body -->
		      	<div class="modal-body">
		        	<div class="form-group">
						<label for="title">약품 명: </label>
						<input type="text" class="form-control" name="title" id="title" autofocus required/>
					</div>
					
					<div class="form-group">
						<label for="purchase">구입량: </label>
						<input type="number" class="form-control" name="purchase" id="purchase" required />
					</div>
					
					<div class="form-group">
						<label for="price">개 당 가격: </label>
						<input type="number" class="form-control" name="price" id="price" required />
					</div>
					
					<div class="form-group">
						<label for="content">사용용도 </label>
						<input type="text" class="form-control" name="content" id="content" required />
					</div>
					
					<div class="form-group">
						사진 :
				    	<input type="file" class="form-control-file border" name="fName" id="file" required />
				      	<input type="hidden" name="photo" />
					</div>
					
					<div class="form-group">
						<label for="pYear">구입날짜</label>
					    <input type="date" class="form-control" name="pYear" id="pYear" required />
					</div>
					
		      	</div>
	
		     	<!-- Modal footer -->
		      	<div class="modal-footer">
		        	<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
		        	<input type="button" class="btn btn-secondary" value="등록하기" onclick="medicineInput()" /> 
		      	</div>
	      	</form>
	
	    	</div>
	  	</div>
	</div>
	
	<!-- 재입고 모달창 -->
  	<!-- The Modal -->
  	<div class="modal" id="restock">
    	<div class="modal-dialog" role="document">
      		<div class="modal-content">
      		
      		<form name="restockform" method="post" action="${ctp }/asset/medicineRestock" enctype="multipart/form-data">
	        	<!-- Modal Header -->
	        	<div class="modal-header">
	          		<h4 class="modal-title">재입고</h4>
	          		<button type="button" class="close" data-dismiss="modal">&times;</button>
	        	</div>
	        
	        	<!-- Modal body -->
	        	<div class="modal-body">
	          		<div class="form-group">
						<label for="purchase">구입량: </label>
						<input type="number" class="form-control" name="purchase" id="purchase" required />
					</div>
					
					<div class="form-group">
						<label for="price">개 당 가격: </label>
						<input type="number" class="form-control" name="price" id="price" required />
					</div>
					
					<div class="form-group">
						<label for="pYear">구입년도</label>
					    <input type="date" class="form-control" name="pYear" id="pYear" required />
					</div>
					<input type="hidden" id="title2" name="title2" />
	        	</div>
	        
	        	<!-- Modal footer -->
	        	<div class="modal-footer">
	          		<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
	          		<input type="button" class="btn btn-secondary" value="재입고" onclick="restockCheck()" />
	        	</div>
        	</form>
        	
      		</div>
    	</div>
	</div>
  
</body>
</html>