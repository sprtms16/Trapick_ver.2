<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<header>

	<script type="text/javascript"
		src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.3.0/sockjs.js"></script>
	<script type="text/javascript">
		let sock = new SockJS("<c:url value="/echoHandshake"/>");
		sock.onmessage = onMessage;
		// 서버로부터 메시지를 받았을 때
		function onMessage(msg) {
			var data = msg.data;
			$('#alertCount span').text(data);
		}
	</script>
	<script type="text/javascript">
		$(function() {
			$('#myModal').on('show.bs.modal', function(event) {
				console.log("alert list load");
				var button = $(event.relatedTarget); // Button that triggered the modal
				var href = button.data('href'); // Extract info from data-* attributes
				var modal = $(this)
				$.ajax({
					url : href,
					method : 'POST',
					dataType : 'json',
					success : function(data) {
						console.log("alert list success");
						modal.find('.modal-body').html('');
						$.each(data, function(index, item) {
							var $formItem = $('<a>').attr("class","list-group-item list-group-item-action flex-column align-items-start")
							.attr("data-href","/feed/feed/"+item.feed.feed_idx)
							.attr("data-toggle","modal")
							.attr("data-target","#feedModal");
							if(item.alert_type==="U"){
								var title = item.feeder.id+" 님께서 "+item.feed.title+" (을)를 수정하셨습니다.";
							}else{
								var title = item.feeder.id+" 님께서 "+item.feed.title+" (을)를 작성하셨습니다.";
							}
							
							var $formTitle = $('<div>').attr("class","d-flex w-100 justify-content-between").append(
									$('<h5>').attr("class","mb-1").text(title)
							).append(
									$('<small>').text(item.feed.regdate)	
							);
							var $formBody = $('<p>').attr("class","mb-1").text(item.feed.contents);
							$formItem.append($formTitle).append($formBody);
							if(item.read == null){
								$formItem.addClass("active");
							}
							modal.find('.modal-body').append($formItem);
						})
						
					}
				});
				
			});
			$('#feedModal').on('show.bs.modal', function(event) {
				var button = $(event.relatedTarget); // Button that triggered the modal
				var href = button.data('href'); // Extract info from data-* attributes
				var modal = $(this);
				modal.find('.modal-body').load(href);
			});
			
			$("#myModal").appendTo("body");
			$("#feedModal").appendTo("body");
		});
	</script>
</header>
<nav class="navbar navbar-expand navbar-dark bg-info fixed-top">
	<a class="navbar-brand" href="/schedule/MainPage">Home</a> <a
		class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#navbarsExample02" aria-controls="navbarsExample02"
		aria-expanded="false" aria-label="Toggle navigation"> <span
		class="navbar-toggler-icon"></span>
	</a>

	<div class="collapse navbar-collapse" id="navbarsExample02">
		<ul class="navbar-nav mr-auto">
			<li class="nav-item active"><a class="nav-link"
				href="/feed/list">feedList <span class="sr-only">(current)</span></a>
			</li>

		</ul>

		<c:choose>
			<c:when test="${sessionScope.user_idx ne null}">
				<a class="nav-link text-light" href="/mypage/mypage">마이페이지</a>
				<a class="nav-link text-light" href="/sign/logout">로그아웃</a>
			</c:when>
			<c:otherwise>
				<a class="nav-link text-light" href="/sign/join">회원가입</a>
				<a class="nav-link text-light" href="/sign/login">로그인</a>
			</c:otherwise>
		</c:choose>

		<button class="btn" type="button" data-toggle="modal"
			data-href="/RestFeed/getAlertList/${user_idx }.json"
			data-target="#myModal">
			<i class="fas fa-bell" id="alertCount" style="font-size: 1.7em;"><span
				class="text-danger">${alertCount }</span></i>
		</button>

		<div class="search_menu">
			<form action="/feed/list" method="get">
				<aside style="float: right;">
					<input type="text" name="word" placeholder="검색">
					<button type="submit">확인</button>

				</aside>
			</form>
		</div>
	</div>
</nav>
<!-- The Modal -->
<div class="modal" id="myModal">
	<div class="modal-dialog">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">알람 목록</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>

			<!-- Modal body -->
			<div class="modal-body list-group" style="max-height: 300px;overflow-y: scroll;"></div>

			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
			</div>

		</div>
	</div>
</div>
<div class="modal" id="feedModal">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">피드</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>

			<!-- Modal body -->
			<div class="modal-body"></div>

			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
			</div>

		</div>
	</div>
</div>