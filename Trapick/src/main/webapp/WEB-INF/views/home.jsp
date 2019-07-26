<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<meta http-equiv="refresh" content="50; url=http://www.netmarble.net/">
<html>
<head>
<title>Home</title>

<script>
	function jbFunc() {
		setTimeout(function jbFunc() {
			document.getElementById('jb').value = '10';
		}, 1000);

		setTimeout(function jbFunc() {
			document.getElementById('jb').value = '20';
		}, 2000);

		setTimeout(function jbFunc() {
			document.getElementById('jb').value = '30';
		}, 3000);

		setTimeout(function jbFunc() {
			document.getElementById('jb').value = '40';
		}, 4000);
		setTimeout(function jbFunc() {
			document.getElementById('jb').value = '50';
		}, 5000);

		setTimeout(function jbFunc() {
			document.getElementById('jb').value = '60';
		}, 6000);

		setTimeout(function jbFunc() {
			document.getElementById('jb').value = '70';
		}, 7000);

		setTimeout(function jbFunc() {
			document.getElementById('jb').value = '80';
		}, 8000);
		setTimeout(function jbFunc() {
			document.getElementById('jb').value = '90';
		}, 9000);

		setTimeout(function jbFunc() {
			document.getElementById('jb').value = '100';
		}, 10000);
	}
</script>
<style>
#jb {
	width: 100%;
	height: 50px;
}

#mask {
	position: absolute;
	left: 0;
	top: 0;
	z-index: 9000;
	background-color: #000;
	display: none;
}
</style>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	function wrapWindowByMask() {
		//화면의 높이와 너비를 구한다.
		var maskHeight = $(document).height();
		var maskWidth = $(window).width();

		//마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
		$('#mask').css({
			'width' : maskWidth,
			'height' : maskHeight
		});

		//애니메이션 효과
		$('#mask').fadeIn(1000);
		$('#mask').fadeTo("slow", 0.8);
	}
	$(document).ready(function() {
		//검은 막 띄우기
		$('.openMask').click(function(e) {
			e.preventDefault();
			wrapWindowByMask();
		});

		//닫기 버튼을 눌렀을 때
		$('.window .close').click(function(e) {
			//링크 기본동작은 작동하지 않도록 한다.
			e.preventDefault();
			$('#mask, .window').hide();
		});

		//검은 막을 눌렀을 때
		$('#mask').click(function() {
			$(this).hide();
			$('.window').hide();
		});
	});
</script>
</head>
<body>
	<h1>Hello world!</h1>

	<P>The time on the server is ${serverTime}.</P>
<body>

	<div id="mask"></div>
	<div>
		<progress value="0" max="100" id="jb"></progress>
	</div>
	<button onclick="jbFunc()">Click</button>
	<a href="#" class="openMask">검은 막 띄우기</a>

	<form action="recommend/scheduleDetail" method="post">
		<p id="main_title">TraPick</p>
		<div id="container">
			<div id="contents">
				<input id="target" type="text" name="country_name">
				<!-- <input id="target2" type="text" name="city"> -->
				<select id="target2" name="city_name">
					<option value="시카고">시카고</option>
					<option value="베이징">베이징</option>
				</select> <label for="sta   rt_time">출발일 : </label> <input type="text"
					name="start_time" id="start_time" autocomplete=off> ~ <label
					for="end_time">도착일 : </label> <input type="text" name="end_time"
					id="end_time" autocomplete=off> <input id="submit"
					type="submit" value="생성">
				<div id="target3_weather">
					<a id="target3"></a><br>
					<p id="weather"></p>
					<img src="" id="weatherIcon" style="display: none;" />
				</div>
			</div>
		</div>
		<input type="hidden" name="day" value="5"> <input
			type="submit" value="생성">
	</form>

	<a href="mypage/list">ddasdf</a>
</body>
</html>
