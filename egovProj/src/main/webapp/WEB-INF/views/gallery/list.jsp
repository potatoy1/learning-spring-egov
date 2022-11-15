<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<div class="col-12">
	<div class="card card-primary">
		<div class="card-header">
			<!-- 도서 선택 시작 -->
			<!-- ajax를 통해 append <option value="1">검은개똥이</option>
			-->
			<select class="custom-select">
			</select>
		</div>
		<!-- 도서 선택 끝-->
		<div class="card-body">
			<div class="row">

				<!--모달을 띄우는 방법
					1. button으로 띄우기
					 <button type="button" class="btn btn-default" 
					data-toggle="modal" data-target="#modal-default">
					Launch Default Modal
					</button> 		
					2. a 태그로 띄우기
					<a data-toggle="modal" href="#modal-default">Open Modal</a>
					3. 기타요소로 띄우기
					<p data-toggle="modal" data-target="#modal-default">Open Modal</p>
					-->
				<c:forEach var="attachVO" items="${bookVO.attachVOList}"
					varStatus="stat">
					<div class="col-sm-2">
						<a class="btn btn-modal" data-toggle="modal" href="#modal-default"
							data-id="/resources/upload/${attachVO.filename}"
							data-title="${bookVO.title}"> <img
							src="/resources/upload/${attachVO.filename}"
							class="img-fluid mb-2" alt="white sample">
						</a>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</div>
<!-- Default Modal 시작 -->
<div class="modal fade" id="modal-default" style="display: none;"
	aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title"></h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<div class="modal-body">
				<p id="body-content"></p>
			</div>
			<div class="modal-footer justify-content-between">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<button type="button" class="btn btn-primary">Save changes</button>
			</div>
		</div>
	</div>
</div>
<!-- Default Modal 끝 -->
<script type="text/javascript">
$(function() {
	//data-id........
	$(".btn-modal").click(
			function() {
				let data = $(this).data("id");
				console.log("data: " + data);
				let title = $(this).data("title");
				console.log("data: " + data, "title: " + title);

				$("#body-content").html(
						"<img src='" + data + "' style='width:100%' />");
				//modal은 하나이고, modal-title 클래스 또한 하나이다.
				$(".modal-title").text(title);
			});
	
	
	//el 정보를 j/s 변수에 담음
	let currentBookId = "${param.bookId}"; //?bookId=2
	let sel = "";
	
	//도서 목록 가져와서 select에 추가하기
	//datatype : 응답 데이터 타입
	//아작났어유..피씨다타써..
	$.ajax({
		url : "/gallery/bookList",
		datatype : "json",
		type : "get",
		success : function(data) {
			//data : List<BookVO>
			//console.log("data: " + JSON.stringify(data))
			//item : BookVO
			$.each(data, function(index, item) {
				console.log("item.bookId: " + item.bookId);
				console.log("item.title: " + item.title);
				
				if(item.bookId == currentBookId){
					sel = "selected='selected'";
				}else{
					sel="";
				}
				//option항목 추가
				$(".custom-select").append("<option value='"+item.bookId+"' "+sel+">"+item.title+"</option>");
			});
		}
	});
	//custom-select가 바뀌면 목록을 다시 가져옴
	$(".custom-select").on("change",function(){
		//선택된 option의 value를 가져와보자
		let bookId = $(this).val();
		console.log("bookId: " + bookId);
		
		location.href="/gallery/list?bookId="+bookId;
	});
});
</script>