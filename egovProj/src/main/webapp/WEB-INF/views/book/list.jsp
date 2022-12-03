<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- jQuery -->
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<!-- iamport.payment.js -->
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>

<div class="card">
	<div class="card-header">
		<h3 class="card-title">DataTable with default features</h3>
	</div>
	<div class="card-body">
		<div id="example1_wrapper" class="dataTables_wrapper dt-bootstrap4">
			<div class="row">
				<div class="col-sm-12">
					<table id="example1"
						class="table table-bordered table-striped dataTable dtr-inline"
						aria-describedby="example1_info">
						<thead>
							<tr>
								<th class="sorting" tabindex="0" aria-controls="example1"
									rowspan="1" colspan="1"
									aria-label="BookId: activate to sort column ascending">BookId</th>
								<th class="sorting sorting_asc" tabindex="0"
									aria-controls="example1" rowspan="1" colspan="1"
									aria-label="Title: activate to sort column descending"
									aria-sort="ascending">Title</th>
								<th class="sorting" tabindex="0" aria-controls="example1"
									rowspan="1" colspan="1"
									aria-label="Category: activate to sort column ascending">Category</th>
								<th class="sorting" tabindex="0" aria-controls="example1"
									rowspan="1" colspan="1"
									aria-label="Price: activate to sort column ascending">Price</th>
								<th class="sorting" tabindex="0" aria-controls="example1"
									rowspan="1" colspan="1"
									aria-label="Insert Date: activate to sort column ascending">Insert
									Date</th>
							</tr>
						</thead>
						<tbody>

							<c:forEach var="bookVO" items="${bookVOList}" varStatus="stat">
								<c:if test="${stat.count%2!=0}">
									<tr class="odd">
								</c:if>
								<c:if test="${stat.count%2==0}">
									<tr class="even">
								</c:if>
								<tr class="odd">
									<td class="dtr-control">${bookVO.bookId}</td>
									<td><a href="/book/detail?bookId=${bookVO.bookId}">${bookVO.title}</a>
									</td>
									<td>${bookVO.category}</td>
									<td><fmt:formatNumber value='${bookVO.price}'
											pattern='#,###' /></td>
									<td><fmt:formatDate value='${bookVO.insertDate}'
											pattern='yyyy-MM-dd' /></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-12 col-md-7">
					<div class="dataTables_paginate paging_simple_numbers"
						id="example1_paginate">
						<ul class="pagination">
							<li class="paginate_button page-item previous disabled"
								id="example1_previous"><a href="#" aria-controls="example1"
								data-dt-idx="0" tabindex="0" class="page-link">Previous</a></li>
							<li class="paginate_button page-item active"><a href="#"
								aria-controls="example1" data-dt-idx="1" tabindex="0"
								class="page-link">1</a></li>
							<li class="paginate_button page-item "><a href="#"
								aria-controls="example1" data-dt-idx="2" tabindex="0"
								class="page-link">2</a></li>
							<li class="paginate_button page-item "><a href="#"
								aria-controls="example1" data-dt-idx="3" tabindex="0"
								class="page-link">3</a></li>
							<li class="paginate_button page-item "><a href="#"
								aria-controls="example1" data-dt-idx="4" tabindex="0"
								class="page-link">4</a></li>
							<li class="paginate_button page-item "><a href="#"
								aria-controls="example1" data-dt-idx="5" tabindex="0"
								class="page-link">5</a></li>
							<li class="paginate_button page-item "><a href="#"
								aria-controls="example1" data-dt-idx="6" tabindex="0"
								class="page-link">6</a></li>
							<li class="paginate_button page-item next" id="example1_next"><a
								href="#" aria-controls="example1" data-dt-idx="7" tabindex="0"
								class="page-link">Next</a></li>
						</ul>
					</div>
				</div>
			</div>
			<div>
				<h2>IAMPORT 결제 데모</h2>
				<li>
					<button id="iamportPayment" type="button">결제테스트</button>
				</li>
			</div>
			<div class="card-body">
				<div style="float: right; margin: 0 10px 0 0;">
					<button type="button"
						class="btn btn-block bg-gradient-secondary btn-sm">
						<a href="/book/insert">등록 
					</button>

					</a>
				</div>
			</div>
		</div>
	</div>
	<script>
		//문서가 준비되면 제일 먼저 실행
$(document).ready(function(){ 
	$("#iamportPayment").click(function(){ 
		payment(); //버튼 클릭하면 호출 
    }); 
});


// //버튼 클릭하면 실행
// function payment(data) {
//     IMP.init('imp71272843');//아임포트 관리자 콘솔에서 확인한 '가맹점 식별코드' 입력
//     IMP.request_pay({// param
//         pg: "kakaopay.TC0ONETIME", //pg사명 or pg사명.CID (잘못 입력할 경우, 기본 PG사가 띄워짐)
//         pay_method: "card", //지불 방법
//         merchant_uid: "iamport_test_id", //가맹점 주문번호 (아임포트를 사용하는 가맹점에서 중복되지 않은 임의의 문자열을 입력)
//         name: "도서", //결제창에 노출될 상품명
//         amount: 13700, //금액
//         buyer_email : "testiamport@naver.com", 
//         buyer_name : "홍길동",
//         buyer_tel : "01012341234"
//     }, function (rsp) { // callback
//         if (rsp.success) {
//             alert("완료 -> imp_uid : "+rsp.imp_uid+" / merchant_uid(orderKey) : " +rsp.merchant_uid);
//         } else {
//             alert("실패 : 코드("+rsp.error_code+") / 메세지(" + rsp.error_msg + ")");
//         }
//     });
// }


	var IMP = window.IMP; // 생략 가능
	IMP.init("imp71272843"); // 예: imp00000000
	function payment() {
		IMP.init('imp71272843'); //iamport 대신 자신의 "가맹점 식별코드"를 사용
		IMP.request_pay({
			pg : "html5_inicis.INIpayTest",
			pay_method : "card",
			merchant_uid : 'merchant_' + new Date().getTime(),
			name : '결제테스트',
			amount : 140,
			buyer_email : 'iamport@siot.do',
			buyer_name : '구매자',
			buyer_tel : '010-1234-5678',
			buyer_addr : '서울특별시 강남구 삼성동',
			buyer_postcode : '123-456'
		}, function(rsp) {
			console.log(rsp);
			if (rsp.success) {
				var msg = '결제가 완료되었습니다.';
				alert(msg);
				location.href = "결제 완료 후 이동할 페이지 url"
			} else {
				var msg = '결제에 실패하였습니다.';
				msg += '에러내용 : ' + rsp.error_msg;
				alert(msg);
			}
		});
	}

		// 		var IMP = window.IMP; // 생략 가능
		// 		IMP.init("imp40766870"); // 예: imp00000000

		// 		function payment() {
		// 			IMP.request_pay({
		// 				pg : 'danal_tpay',
		// 				pay_method : 'card', // 'card'만 지원됩니다.
		// 				merchant_uid : "order_monthly_0001", // 상점에서 관리하는 주문 번호
		// 				name : '최초인증결제',
		// 				amount : 0, // 결제창에 표시될 금액. 실제 승인이 이뤄지지는 않습니다. (PC에서는 가격이 표시되지 않음)
		// 				customer_uid : 'your-customer-unique-id', // 필수 입력.
		// 				buyer_email : 'iamport@siot.do',
		// 				buyer_name : '아임포트',
		// 				buyer_tel : '02-1234-1234',
		// 				m_redirect_url : '{모바일에서 결제 완료 후 리디렉션 될 URL}' // 예: https://www.my-service.com/payments/complete/mobile
		// 			}, function(rsp) {
		// 				if (rsp.success) {
		// 					alert('빌링키 발급 성공');
		// 				} else {
		// 					alert('빌링키 발급 실패');
		// 				}
		// 			});
		// 		}
		// function payment(){
		// 		//가맹점 식별코드
		// 		IMP.init('imp40766870');
		// 		IMP.request_pay({
		// 		    pg : 'kcp',
		// 		    pay_method : 'card',
		// 		    merchant_uid : 'merchant_' + new Date().getTime(),
		// 		    name : '상품1' , //결제창에서 보여질 이름
		// 		    amount : 100, //실제 결제되는 가격
		// 		    buyer_email : 'iamport@siot.do',
		// 		    buyer_name : '구매자이름',
		// 		    buyer_tel : '010-1234-5678',
		// 		    buyer_addr : '서울 강남구 도곡동',
		// 		    buyer_postcode : '123-456'
		// 		}, function(rsp) {
		// 			console.log(rsp);
		// 		    if ( rsp.success ) {
		// 		    	var msg = '결제가 완료되었습니다.';
		// 		        msg += '고유ID : ' + rsp.imp_uid;
		// 		        msg += '상점 거래ID : ' + rsp.merchant_uid;
		// 		        msg += '결제 금액 : ' + rsp.paid_amount;
		// 		        msg += '카드 승인번호 : ' + rsp.apply_num;
		// 		    } else {
		// 		    	 var msg = '결제에 실패하였습니다.';
		// 		         msg += '에러내용 : ' + rsp.error_msg;
		// 		    }
		// 		    alert(msg);

		// });
		// }
	</script>