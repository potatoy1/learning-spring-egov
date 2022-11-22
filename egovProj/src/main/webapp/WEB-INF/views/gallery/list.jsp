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
							data-id="/resources/upload${attachVO.filename}"
							data-title="${bookVO.title}"
							data-userNo="${bookVO.bookId}"
							data-seq="${attachVO.seq}"
							data-filename="${attachVO.filename}" > <img
							src="/resources/upload${attachVO.filename}"
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
				<input type="hidden" id="txtUserNo" value="" />
				<input type="hidden" id="txtSeq" value="" />
				<input type="hidden" id="txtFilename" value="" />
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<div class="modal-body">
				<p id="body-content"></p>
			</div>

			<div class="modal-footer justify-content-between">
				<div style="float: left;">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
				<div style="float: right;">
					<!-- 일반모드 시작 -->
					<span id="spn1">
						<a class="btn btn-app" onclick="fn_download()">
							<i class="fas fa-save"></i> DOWNLOAD
						</a>
						<button type="button" id="edit" class="btn btn-primary">수정</button>
						<button type="button" id="delete" class="btn btn-danger">삭제</button>
					</span>
					<!-- 일반모드 끝 -->
					<!-- 수정모드 시작 -->
					<span id="spn2" style="display: none;">
						<div class="input-group justify-content-between">
							<div class="custom-file" style="float:left;">
								<input type="file" class="custom-file-input"
									id="uploadFile" name="uploadFile" style="width:200px;" /> 
									<label class="custom-file-label" for="exampleInputFile">Choose file</label>
							</div>
						<div style="float: right;">
							<button type="button" id ="uploadBtn" class="btn btn-success">확인</button>
							<button type="button" id="cancel" class="btn btn-warning">취소</button>
						</div>
						</div>
					</span>
					<!-- 수정모드 끝 -->
				</div>
			</div>
		</div>
	</div>
</div>
<iframe id="ifrm" name="ifrm" style="display:none;"></iframe>
<!-- Default Modal 끝 -->
<script type="text/javascript">
	$(function() {
		//data-id........
		$(".btn-modal").click(
				function() {
					let data = $(this).data("id");
// 					console.log("data: " + data);
					let title = $(this).data("title");
					//userId랑 seq는 ATTACH 테이블의 복합키(composite key)로써의 기본키(primary key, 식별키)
					let userNo = $(this).data("userno");
					let seq = $(this).data("seq");
					let filename = $(this).data("filename");
					
					//세션 스토리지 활요
					sessionStorage.setItem("filename",filename);
					
					console.log("data: " + data, "title: " + title + "userNo: " + userNo + ", seq : " + seq + "filename : " + filename );

					$("#body-content").html(
							"<img src='" + data + "' style='width:100%' />");
					//modal은 하나이고, modal-title 클래스 또한 하나이다.
					$(".modal-title").text(title);
					$("#txtUserNo").val(userNo);
					$("#txtSeq").val(seq);
					$("#txtFilename").val(filename);
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
// 					console.log("item.bookId: " + item.bookId);
// 					console.log("item.title: " + item.title);

					if (item.bookId == currentBookId) {
						sel = "selected='selected'";
					} else {
						sel = "";
					}
					//option항목 추가
					$(".custom-select").append(
							"<option value='"+item.bookId+"' "+sel+">"
									+ item.title + "</option>");
				});
			}
		});
		//custom-select가 바뀌면 목록을 다시 가져옴
		$(".custom-select").on("change", function() {
			//선택된 option의 value를 가져와보자
			let bookId = $(this).val();
// 			console.log("bookId: " + bookId);

			location.href = "/gallery/list?bookId=" + bookId;
		});

		//수정버튼 클릭->spn1:hidden / spn2:block
		$("#edit").on("click", function() {
			$("#spn1").css("display", "none");
			$("#spn2").css("display", "block");
		});

		//취소버튼 클릭->spn1:block / spn2:hidden
		$("#cancle").on("click", function() {
			$("#spn1").css("display", "block");
			$("#spn2").css("display", "none");
		});

		//ajax 파일 업로드 구현 시작
		//이미지 체킹
		let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$"); //정규식
		let maxSize = 5242880; //5MB
		
		function checkExtension(fileName, fileSize){//확장자, 크기 체킹
			if(fileSize >= maxSize){
				alert("파일 사이즈가 초과되었습니다.");
				//함수 종료 
				return false;
			}
			//fileName : 개똥이.zip
			if(regex.test(fileName)){
				alert("해당 종류의 파일은 업로드할 수 없습니다.");
				return false;
			}
			return true;
		}
		
		
		//e: 클릭 이벤트
		$("#uploadBtn").on("click",function(e){
			//가상의 form태그 생성 <form></form>
			let formData = new FormData();
			//<input type="file" name="uploadFile"...
			let inputFile = $("input[name='uploadFile']");
			//파일 object 안에 이미지를 가져와보자
			//inputFile[0] : input type="file"
			//.files : 그 안에 들어있는 이미지
			let files = inputFile[0].files;
			//files : [object FileList]
			console.log("files : " + files);
			
			//가상의 form인 formData object에 filedata를 추가해보자.
			for(let i=0;i<files.length;i++){
				//파일 확장자/크기 체킹(확장자가 exe, sh, zip, alz이니? 안되는데..)
				if(!checkExtension(files[i].name, files[i].size)){
					//반복문 종료 및 함수 종료
					return false;
				}
				
				//<form><input type='file' name='uploadFile' /></form>
				formData.append("uploadFile",files[i]);
			}
			/*
				<form>
					<input typd="file" name="uploadFile" />
					<input typd="text" name="userNo" value="3" />
					<input typd="text" name="seq" value="5" />
				</form>
			*/
			formData.append("userNo",$("#txtUserNo").val());
			formData.append("seq",$("#txtSeq").val());
			
			console.log("formData : " + formData);
			
			//아작났어유ㅠㅠ 피씨다타써
			$.ajax({
				url:"/gallery/updatePost",
				processData:false,
				contentType:false,
				data:formData,
				dataType:"json",
				type:"post",
				success:function(result){
					console.log("result : " + JSON.stringify(result));
					console.log("uploaded");
					let filename = result.filename;
					alert("이미지 변경 성공!");
					location.href="/gallery/list?bookId=${param.bookId}";
// 					$("#body-content img").attr("src","/resources/upload"+filename);
				}
			});
		});
		//ajax 파일 업로드 구현 끝
		
		//이미지 미리보기 시작////////////////////////
		let sel_file = [];
		$("#uploadFile").on("change",handleImgFileSelect);
		//e: onchange 이벤트 객체
		function handleImgFileSelect(e){
			//이벤트가 발생된 타겟 안에 들어있는 이미지 파일들을 가져와보자
			let files = e.target.files;
			//이미지가 여러개가 있을 수 있으므로 이미지들을 각각 분리해서 배열로 만듦
			let fileArr = Array.prototype.slice.call(files);
			
			fileArr.forEach(function(f){
				if(!f.type.match("image.*")){
					alert("이미지 확장자만 가능합니다.");
					//함수 종료
					return;
				}
				//이미지 객체를 전역 배열타입 변수에 넣자
				sel_file.push(f);
				//이미지 객체를 읽을 자바스크립트의 reaader 객체 생성
				let reader = new FileReader();
				reader.onload = function(e){
					let img_html = "<img src=\"" + e.target.result + "\" style='width:100%;'/>";
					//p 사이에 이미지가 렌더링되어 화면에 보임
					//객체.append : 누적, .html : 새로고침, innerHTML: J/S
					$("#body-content").html(img_html);
				}
				//f : 이미지 파일 객체를 읽은 후 다음 이미지 파일(f)을 위해 초기화 함
				reader.readAsDataURL(f);
			});//end forEach
			
		}
		//이미지 미리보기 끝////////////////////////
		
		//이미지 삭제 시작////////////////////////
		$("#delete").on("click",function(){
			let userNo = $("#txtUserNo").val();
			let seq = $("#txtSeq").val();
			
			console.log("userNo: " + userNo + ", seq : " + seq);
			
			let data ={"userNo":userNo,"seq":seq};
			
			console.log("data: "  +JSON.stringify(data));
			
			//아작났어유..피씨다타써
			//contentType : 보내는 타입
			//dataType : 응답 데이터 타입
			$.ajax({
				url:"/gallery/deletePost",
				contentType:"application/json;charset=utf-8",
				data:JSON.stringify(data),
				dataType :"json",
				type:"post",
				success:function(result){
					console.log("result: " + JSON.stringify(result))
					//1 또는 0이 str변수에 할당됨
					let str = result.result;
					//result가 0보다 크면 성공, 아니면 실패.
					//성공 시 : /gallery/list?bookId=3 / 실패 시: 실패 메시지 alert
					if(str>0){
						location.href="/gallery/list?bookId=${param.bookId}"
					}else{
						alert("삭제가 되지 않았습니다.");
					}
					
				}
			})
		});
		//이미지 삭제 끝////////////////////////
	});
	//파일 다운로드 함수
	function fn_download(){
		//세션 스토리지 활용
		let filename = sessionStorage.getItem("filename");
		console.log("filename : " +  filename);
		//<iframe id="ifrm" name="ifrm" style="display:none;"></iframe>
		let vIfrm = document.getElementById("ifrm");
		vIfrm.src = "/download?fileName="+filename;
	}
</script>
