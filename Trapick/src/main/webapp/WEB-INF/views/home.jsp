<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>

<body>
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
		<input type = "hidden" name = "day" value = "5">
		<input type="submit" value="생성">
	</form>
	
	<form action="mypage/list">
		<button id="mypage">MyPage</button>
	</form>
</body>
</html>
