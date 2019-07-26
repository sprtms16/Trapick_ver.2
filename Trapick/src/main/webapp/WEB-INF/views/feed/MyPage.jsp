<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, height=device-height, 
                     minimum-scale=1.0, maximum-scale=1.0, initial-scale=1.0">

<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>


<style type="text/css">
div {
	width: 100%;
	height: 900px;
	border: 1px solid #000;
}

div.left {
	width: 70%;
	float: left;
	box-sizing: border-box;
	text-align: center;
	background: lightgray;
}

div.right {
	width: 30%;
	float: right;
	box-sizing: border-box;
	text-align: center;
	background: white;
}
</style>
<script type="text/javascript">
	$(function() {
		$.getJSON('RestFeed/myFeedList', function(data) {
			$.each(data, function(index, item) {
				$('#MyFeedList').append(
						$('<tr>').append(
								$('<td>').append(
										$('<a>').attr(
												"href",
												"list?feed_idx="
														+ item.feed_idx).text(
												item.title))))
			});
		});

		$.getJSON('../FeedData/mySchdList', function(data) {
			$.each(data, function(index, item) {
				$('#MySchdList').append(
						$('<tr>').append(
								$('<td>').append(
										$('<a>').attr(
												"href",
												"feedInsertForm?schd_idx="
														+ item.schd_idx).text(
												item.title))))
			});
		});

	});
</script>
</head>
<body>
	<h1>My Page</h1>
	<div>

		<div class="left">
			<h3>나의 일정목록</h3>
			<table>
				<thead>
					<th>일정표 title</th>
				</thead>
				<tbody id="MySchdList">

				</tbody>

			</table>
		</div>


		<div class="right">
			<h4>나의 게시글 목록</h4>
			<table>
				<thead>
					<th>피드 제목</th>
				</thead>
				<tbody id="MyFeedList">

				</tbody>
			</table>
		</div>

	</div>

</body>
</html>