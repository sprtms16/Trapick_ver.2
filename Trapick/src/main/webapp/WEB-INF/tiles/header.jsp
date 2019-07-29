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
			$('#alertCount').text(data);
		}
	</script>
	<script type="text/javascript">
		$(function() {
			$('#popover-content').on("mouseenter mouseleave",
					'.list-group-item', function(event) {
						$(this).toggleClass('active');
					});
			$("[data-toggle=popover]").popover({
				html : true,
				content : function() {
					return $('#popover-content').html();
				}
			});
		});
	</script>
</header>
<nav class="navbar navbar-expand navbar-dark bg-info fixed-top">
	<a class="navbar-brand" href="/schedule/MainPage">Home</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#navbarsExample02" aria-controls="navbarsExample02"
		aria-expanded="false" aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>

	<div class="collapse navbar-collapse" id="navbarsExample02">
		<ul class="navbar-nav mr-auto">
			<li class="nav-item active"><a class="nav-link"
				href="/feed/list">feedList <span class="sr-only">(current)</span></a>
			</li>

		</ul>

		<c:choose>
			<c:when test="${sessionScope.user_idx ne null}">
				<a class="nav-link text-light">${user_idx }</a>
				<a class="nav-link text-light" href="/sign/logout">로그아웃</a>
			</c:when>
			<c:otherwise>
				<a class="nav-link text-light" href="/sign/join">회원가입</a>
				<a class="nav-link text-light" href="/sign/login">로그인</a>
			</c:otherwise>
		</c:choose>

		<a data-placement="bottom" data-toggle="popover" data-container="body"
			data-placement="left" type="button" data-html="true" href="#"
			id="login" style="font-size: 1.7em;"> <i class="fas fa-bell"
			id="alertCount"><span style="font-size: 1rem; color: red"></span></i>
		</a>

		<div class="search_menu">
			<form action="/feed/list" method="get">
				<aside style="float: right;">
					<input type="text" name="word" placeholder="검색">
					<button type="submit">확인</button>

				</aside>
			</form>
		</div>
	</div>
	<div id="popover-content" class="d-none">
		<div class="list-group">
			<button type="button" class="list-group-item list-group-item-action">asdfasdf</button>
			<button type="button" class="list-group-item list-group-item-action">asdfasdf</button>
			<button type="button" class="list-group-item list-group-item-action">asdfasdf</button>
			<button type="button" class="list-group-item list-group-item-action">asdfasdf</button>
			<button type="button" class="list-group-item list-group-item-action">asdfasdf</button>
		</div>

	</div>
</nav>