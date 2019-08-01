<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script> -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="/resources/style/css/list.css" />
<link rel="stylesheet" type="text/css"
	href="/resources/css/scheduler.css" />
<script type="text/javascript" src="/resources/style/js/list.js"></script>
<script type="text/javascript">
	$(function() {
		$('.btn-group-fab').on('click', '.btn', function() {
			/* $('.btn-group-fab').toggleClass('active'); */

		});
		$('has-tooltip').tooltip();
	});
</script>

<style type="text/css">
.btn-group-fab {
	position: fixed;
	width: 50px;
	height: auto;
	right: 20px;
	bottom: 20px;
}

.btn-group-fab div {
	position: relative;
	width: 100%;
	height: auto;
}

.btn-group-fab .btn {
	position: absolute;
	bottom: 0;
	border-radius: 50%;
	display: block;
	margin-bottom: 4px;
	width: 40px;
	height: 40px;
	margin: 4px auto;
}

.btn-group-fab .btn-main {
	width: 50px;
	height: 50px;
	right: 50%;
	margin-right: -25px;
	z-index: 9;
}

.btn-group-fab .btn-sub {
	bottom: 0;
	z-index: 8;
	right: 50%;
	margin-right: -20px;
	-webkit-transition: all 2s;
	transition: all 0.5s;
}

.btn-group-fab.active .btn-sub:nth-child(2) {
	bottom: 60px;
}

.btn-group-fab.active .btn-sub:nth-child(3) {
	bottom: 110px;
}

.btn-group-fab.active .btn-sub:nth-child(4) {
	bottom: 160px;
}

.btn-group-fab .btn-sub:nth-child(5) {
	bottom: 210px;
}

.dropdown {
	margin-left: 700px;
	margin-top: 70px;
}
</style>
</head>
<body>

	<div class="container">
		<a id="MOVE_TOP_BTN" href="#">TOP</a>


		<div class="dropdown">
			<button type="button" class="btn btn-primary dropdown-toggle"
				data-toggle="dropdown">정렬</button>
			<div class="dropdown-menu">
				<a class="dropdown-item" href="list">최신 순</a> <a
					class="dropdown-item" href="list?odb=pop&sc=up">인기 순↑</a> <a
					class="dropdown-item" href="list?odb=pop&sc=down">인기 순↓</a> <a
					class="dropdown-item" href="list?odb=rep&sc=up">댓글 순↑</a> <a
					class="dropdown-item" href="list?odb=rep&sc=down">댓글 순↓</a>
				<div class="dropdown-divider"></div>

			</div>
		</div>
	</div>
	<div class="container-fluid">
		<c:forEach var="feed" items="${list}">
			<div id="target${feed.feed_idx }" class="mt-5">
				<div class="card text-center">
					<div id="carouselExampleControls${feed.feed_idx }"
						class="carousel slide" data-ride="carousel">
						<div class="carousel-inner">
							<div class="carousel-item active"
								style="width: 100%; height: 500px; overflow: hidden; position: relative;">
								<div class="SheduleTable row"
									data-href="/RestFeed/getSelectedItem/${feed.schd_idx }">
									<table id="mySheduleTable" border=2 class="col-9" >
										<tr>
											<th>일정</th>
											<th>06:00 ~ 09:00</th>
											<th>09:00 ~ 12:00</th>
											<th>12:00 ~ 15:00</th>
											<th>15:00 ~ 18:00</th>
											<th>18:00 ~ 21:00</th>
										</tr>
										<c:forEach begin="1" end="${feed.travelDates }"
											varStatus="index">
											<tr>
												<td class="time">${index.count}일차</td>
												<td name="${index.count }-1"></td>
												<td name="${index.count }-2"></td>
												<td name="${index.count }-3"></td>
												<td name="${index.count }-4"></td>
												<td name="${index.count }-5"></td>
											</tr>
										</c:forEach>
									</table>
									<table id="hotelTable" border=2 class="col-3" >
										<tr>
											<th>숙소</th>
										</tr>
										<c:forEach begin="1" end="${feed.travelDates }"
											varStatus="index">
											<tr>
												<td class="ho" name="ho-${index.count }"></td>
											</tr>
										</c:forEach>
									</table>
								</div>

							</div>
							<c:forEach var="img" items="${feed.url }" varStatus="status">
								<div class="carousel-item"
									style="width: 100%; height: 500px; overflow: hidden; position: relative;">
									<img src="/resources/upload/${img }" class="d-block w-100"
										style="position: absolute; left: 50%; top: 50%; width: 100%; height: auto; -webkit-transform: translate(-50%, -50%); -ms-transform: translate(-50%, -50%); transform: translate(-50%, -50%);">
								</div>
							</c:forEach>
							<a class="carousel-control-prev"
								href="#carouselExampleControls${feed.feed_idx }" role="button"
								data-slide="prev"> <span class="carousel-control-prev-icon"
								aria-hidden="true"></span> <span class="sr-only">Previous</span>
							</a> <a class="carousel-control-next"
								href="#carouselExampleControls${feed.feed_idx }" role="button"
								data-slide="next"> <span class="carousel-control-next-icon"
								aria-hidden="true"></span> <span class="sr-only">Next</span>
							</a>
						</div>
					</div>
					<div class="card-body">
						<h5 class="card-title">${feed.title }</h5>
						<hr>
						<div class="hashtag">${feed.contents }</div>

						<div class="container" role="main">
							<form method="post" class="replyList">
								<div class="mb-3">

									<input type="hidden" name="feed_idx" value="${feed.feed_idx}" />
									<textarea class="form-control" rows="1" name="contents"
										id="contents" placeholder="내용을 입력하세요"></textarea>
								</div>
								<div>
									<button type="submit" class="btn btn-sm btn-primary insert"
										id="btnSave">작성</button>
									<a class="btn btn-sm btn-primary view getReplyList"
										data-href="${feed.feed_idx}" data-toggle="collapse"
										href="#collapseExample${feed.feed_idx }" role="button"
										aria-expanded="false"
										aria-controls="collapseExample${feed.feed_idx }"> <i
										class="fas fa-map"></i> 모두보기
									</a>
									<c:if test="${feed.user_idx ne user_idx }">
										<c:choose>
											<c:when test="${feed.issubs eq 1}">
												<button
													class="btn btn-sm btn-primary ${feed.user_idx} follow"
													data-idx="${feed.user_idx}"
													data-href="/RestFeed/followAction/${feed.user_idx}">구독중</button>
											</c:when>
											<c:otherwise>
												<button
													class="btn btn-sm btn-primary ${feed.user_idx} follow"
													data-idx="${feed.user_idx}"
													data-href="/RestFeed/followAction/${feed.user_idx}">구독</button>
											</c:otherwise>
										</c:choose>
									</c:if>
								</div>
							</form>
						</div>
						<p></p>
						<div class="collapse" id="collapseExample${feed.feed_idx }">
							<div class="card card-body">

								<%-- <c:forEach var="reply" items="${feed.replys}">

									<div>${reply.contents}
										<a
											data-href="/RestFeed/replyLikeAction/${reply.feed_idx}/${reply.reply_idx}">
											<c:choose>
												<c:when test="${reply.isLike eq 1}">
													<i class="fas fa-thumbs-up">${reply.like }</i>
												</c:when>
												<c:otherwise>
													<i class="far fa-thumbs-up">${reply.like }</i>
												</c:otherwise>
											</c:choose>
										</a> <a
											data-href="/RestFeed/replyDislikeAction/${reply.feed_idx}/${reply.reply_idx}">
											<c:choose>
												<c:when test="${reply.isDislike eq 1}">
													<i class="fas fa-thumbs-down">${reply.dislike }</i>
												</c:when>
												<c:otherwise>
													<i class="far fa-thumbs-down">${reply.dislike }</i>
												</c:otherwise>
											</c:choose>
										</a>
									</div>
								</c:forEach> --%>
							</div>
						</div>
					</div>
					<div class="card-footer text-muted">
						<div class="row">
							<div class="col">
								<a href="modify?feed_idx=${feed.feed_idx }"><i
									class="fas fa-edit"></i></a>
							</div>
							<div class="col">
								<a href="remove?feed_idx=${feed.feed_idx }"><i
									class="fas fa-trash-alt"></i></a>
							</div>
							<div class="col">
								<a id="heart" data-href="/RestFeed/hearAction/${feed.feed_idx}">
									<c:choose>
										<c:when test="${feed.islike eq 1}">
											<i class="fas fa-heart">${feed.heart }</i>
										</c:when>
										<c:otherwise>
											<i class="far fa-heart">${feed.heart }</i>
										</c:otherwise>
									</c:choose>

								</a>
							</div>
						</div>
					</div>


				</div>
			</div>
		</c:forEach>
	</div>

	<div class="modal fade bs-example-modal-lg" id="exampleModal"
		tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
		aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content"></div>
		</div>
	</div>
	<div class="btn-group-fab" role="group" aria-label="FAB Menu">
		<div>
			<button type="button" class="btn btn-main btn-primary has-tooltip"
				data-placement="left" title="Menu">
				<i class="fa fa-bars"></i>
			</button>
		</div>
	</div>


</body>

</html>