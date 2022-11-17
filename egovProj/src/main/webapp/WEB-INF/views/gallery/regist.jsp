<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<section class="content">
	<div class="row">
		<div class="col-md-6">
			<div class="card card-primary">
				<div class="card-header">
					<h3 class="card-title">도서정보</h3>
					<div class="card-tools">
						<button type="button" class="btn btn-tool"
							data-card-widget="collapse" title="Collapse">
							<i class="fas fa-minus"></i>
						</button>
					</div>
				</div>
				<div class="card-body">
					<div class="form-group">
						<div style="clear: both;">
							<label for="title">제목</label>
						</div>
						<div style="width: 70%; float: left;">
							<input type="text" id="title" name="title" class="form-control" />
						</div>
						<!-- 
						1)button
							data-toggle="modal" data-target="샾modal-lg"
						2)a 
							data-toggle="modal" href="샾modal-lg"
						3)기타
							data-toggle="modal" data-target="샾modal-lg"
						 -->
						<div style="width: 30%; float: right;">
							<button type="button"
								class="btn btn-outline-info btn-block btn-flat"
								data-toggle="modal" data-target="#modal-lg">
								<i class="fa fa-book"></i>책 검색
							</button>
						</div>
					</div>
					<div class="form-group">
						<label for="category">카테고리</label> <select id="category"
							name="category" class="form-control custom-select">
							<option value="a0101" selected>소설</option>
							<option value="a0102">에세이</option>
							<option value="a0103">어린이</option>
							<option value="a0104">요리</option>
							<option value="a0105">수험서</option>
							<option value="a0106">자격증</option>
						</select>
					</div>
					<div class="form-group">
						<label for="price">가격</label> <input type="text" id="price"
							name="price" class="form-control" />
					</div>
					<div class="form-group">
						<label for="insertDate">입력 일자</label> <input type="text"
							id="insertDate" name="insertDate" class="form-control" />
					</div>
					<div class="form-group">
						<label for="content">책 내용</label>
						<textarea id="content" name="content" class="form-control"
							rows="4"></textarea>
					</div>
				</div>

			</div>

		</div>
		<div class="col-md-6">
			<div class="card card-secondary">
				<div class="card-header">
					<h3 class="card-title">이미지 정보</h3>
					<div class="card-tools">
						<button type="button" class="btn btn-tool"
							data-card-widget="collapse" title="Collapse">
							<i class="fas fa-minus"></i>
						</button>
					</div>
				</div>
				<div class="card-body">
					<div class="form-group">
						<label for="inputEstimatedBudget">Estimated budget</label> <input
							type="number" id="inputEstimatedBudget" class="form-control">
					</div>
					<div class="form-group">
						<label for="inputSpentBudget">Total amount spent</label> <input
							type="number" id="inputSpentBudget" class="form-control">
					</div>
					<div class="form-group">
						<label for="inputEstimatedDuration">Estimated project
							duration</label> <input type="number" id="inputEstimatedDuration"
							class="form-control">
					</div>
				</div>

			</div>

		</div>
	</div>
	<div class="row">
		<div class="col-12">
			<a href="#" class="btn btn-secondary">Cancel</a> <input type="submit"
				value="Create new Project" class="btn btn-success float-right">
		</div>
	</div>
</section>
<!-- 검색 모달 시작 -->
<!-- 검색 영역 시작-->
<div class="modal fade" id="modal-lg">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">책 검색</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-md-8 offset-md-2">
						<form action="simple-results.html">
							<div class="input-group">
								<input type="search" id="search"
									class="form-control form-control-lg"
									placeholder="Type your keywords here">
								<div class="input-group-append">
									<button type="button" class="btn btn-lg btn-default"
										id="btnSearch">
										<i class="fa fa-search"></i>
									</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
			<!-- 검색 영역 끝 -->
			<!-- 결과 영역 시작 -->
			<div class="row mt-3">
				<div class="col-md-10 offset-md-1">
					<div class="list-group">
					</div>
				</div>
			</div>
			<!-- 결과 영역 끝 -->
			<div class="modal-footer justify-content-between">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<button type="button" class="btn btn-primary">Save changes</button>
			</div>
		</div>
	</div>
</div>
<!-- 검색 모달 끝 -->
<script type="text/javascript">
	CKEDITOR.replace("content");
</script>
<script type="text/javascript">
$(function(){
	$("#btnSearch").on("click",function(){
		let str = $(".form-control-lg").val();
		
		let data = {"title":str};
		console.log("data: " + JSON.stringify(str));
		
		//아작났어유....피씨다타써
		//content Type : 가즈아
		//dataType : 드루와
		$.ajax({
			url:"/gallery/registPost",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			dataType:"json",
			type:"post",
			success:function(result){
				//console.log("result: " + JSON.stringify(result));
				
				$.each(result,function(index,item){
		               console.log("bookId : " + item.bookId);
		               console.log("title : " + item.title);
		               
		               //result => List<BookVO>, item=> BookVO
		               //volist => List<AttachVO>
		               let volist = item.attachVOList;
		               let filename = "/noimage.jpg";
		               if(volist.length>0){
		            	   console.log("attachVOList: " + item.attachVOList);
		            	   //volist => List<AttachVO>, item => AttachVO
		            	   $.each(volist,function(index,item){
		            		   //책 이미지가 1이상이면 이미지 경로를 변수에 대입
		            		   filename = item.filename;
		            	   });
		               }
		               
		               let dt = new Date(item.insertDate);
		               let dtYY = dt.getFullYear();
		               let dtMM = dt.getMonth();
		               let dtDD = dt.getDate();
		               let dtHH = dt.getHours();
		               let dtMI = dt.getMinutes();
		               let dtResult = dtYY + "-" + dtMM + "-" + dtDD + " " + dtHH + ":" + dtMI;
		               console.log("insertDate : " + dtResult);
		               //내용이 길어서 50자로 해보자
		               let cont = item.content + "...";
		               
		               let content = "";
		               content += "<div class='list-group-item'><div class='row'><div class='col-auto'>";
		               content += "<img class='img-fluid' src='/resources/upload"+filename+"' alt='Photo' style='max-height: 160px;'></div>";
		               content += "<div class='col px-4'><div>";
		               content += "<div class='float-right'>"+dtResult+"</div>";
		               content += "<h3><a href='javascript:fn_go("+item.bookId+")'"+item.title+"</h3>";
		               content += "<p class='mb-0'>"+cont+"</p>";
		               content += "</div></div></div></div>";
		               
		               $(".list-group").append(content);   
		               
		               
		            });
			}
		});
	});
});
</script>
<script type="text/javascript">
function fn_go(geta){
	let str = geta;
	console.log("str: " + str);
	
	
	
	$.each(bookVOList,function(index, item){
		let bookId = item.bookId;
	})if(str==bookId){
		console.log("item : " + JSON.stringify(item));
		
		//제목
		$("#title").val(item.title);
		//카테고리
		$("#category").val(item.category);
		//가격
		$("#price").val(item.price);
		//입력 일자
		$("#insertDate").val(item.insertDate);
		//책 내용
		CKEDITOR.instances.content.setData(item.content);
		return;
	}
}
</script>