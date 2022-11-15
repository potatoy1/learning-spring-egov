<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
											pattern='#,###' />
									</td>
									<td><fmt:formatDate value='${bookVO.insertDate}'
											pattern='yyyy-MM-dd' />
									</td>
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