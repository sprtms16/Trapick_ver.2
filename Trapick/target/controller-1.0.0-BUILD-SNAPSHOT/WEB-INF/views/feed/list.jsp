<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.0.10/css/all.css">

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="/resources/style/css/list.css" />
<link rel="stylesheet" type="text/css"
	href="/resources/style/css/scheduler.css" />
<script type="text/javascript">
	function pop($selector) {
		var url = ""; //팝업창 페이지 URL
		var winWidth = 700;
		var winHeight = 600;
		var popupOption = "width=" + winWidth + ", height=" + winHeight; //팝업창 옵션(optoin)
		var detail = $selector.parent().find('#detail').text();
		var name = $selector.parent().find('#name').text();
		var price = $selector.parent().find('#price').text();
		var img = $selector.parent().find('img').attr('src');
		var str = '<img src = "'+img+'"><br>이름 : ' + name + '<br>상세설명 : '
				+ detail + '<br>가격 : ' + price;
		window.open(url, "", popupOption).document.write(str);
	}

	function getQuerystring(paramName) {
		var _tempUrl = window.location.search.substring(1);
		var _tempArray = _tempUrl.split('&');
		if (_tempArray.length > 1) {
			for (var i = 0; _tempArray.length; i++) {
				var _keyValuePair = _tempArray[i].split('=');

				if (_keyValuePair[0] == paramName) {

					return _keyValuePair[1];
				}
			}
		}

	};

	$(function() {
		$('.replyList').submit(function(e) {
			var $this = $(this);
			alert(JSON.stringify($(this).serialize()));
			$.ajax({
				url : '/reply/new',
				type : 'POST',
				data : $(this).serialize(),
				//dataType : 'json',
				//contentType : "application/json; charset=utf-8",
				success : function(e) {
					alert(e);
					/* $.each(e, function(key,value){
						
						var $replyContainer = $this.siblings('.collapse');
						if ($replyContainer.hasClass('show')){
							$replyContainer.append($('<p>').text(value.contents));
						}
					}); */
				}
			})
			return false;
		})

	});

	$(function() {
		$(window).scroll(function() {
			if ($(this).scrollTop() > 500) {
				$('#MOVE_TOP_BTN').fadeIn();
			} else {
				$('#MOVE_TOP_BTN').fadeOut();
			}
		});

		$("#MOVE_TOP_BTN").click(function() {
			$('html, body').animate({
				scrollTop : 0
			}, 400);
			return false;
		});
	});

	function scrollMove(seq) {

		//id가 p로 시작하는 객체를 찾아서, 그곳까지 이동

		$('html, body').animate({
			scrollTop : $("#target" + seq).offset().top
		}, 1000);

	}
	$(function() {
		$('.fa-heart').click(function() {
			var href = $(this).parents('a').data("href");
			var $this = $(this);

			$.ajax({
				url : href,
				dataType : 'json',
				success : function(data) {
					$this.text(data);
					$this.toggleClass("far");
					$this.toggleClass("fas");
				}
			});
			return false;
		});
		$('.fa-thumbs-up').click(function() {
			var href = $(this).parents('a').data("href");
			var up = $(this);
			$.ajax({
				url : href,
				dataType : 'json',
				success : function(data) {
					up.text(data);
					up.toggleClass("far");
					up.toggleClass("fas");
				}
			});
			return false;
		});
		$('.fa-thumbs-down').click(function() {
			var href = $(this).parents('a').data("href");
			var down = $(this);
			$.ajax({
				url : href,
				dataType : 'json',
				success : function(data) {
					down.text(data);
					down.toggleClass("far");
					down.toggleClass("fas");
				}
			});
			return false;
		});
		$.each($('.hashtag'), function(index, data) {
			var content = $(data).text();
			var splitedArray = content.split(' ');
			var linkedContent = '';
			for ( var word in splitedArray) {
				word = splitedArray[word];
				if (word.indexOf('#') == 0) {
					var keyword = word.substring(1, word.length);
					word = '<a href=\'list?keyword=' + keyword + '\'>' + word
							+ '</a>';
				}
				linkedContent += word + ' ';
			}
			$(data).html(linkedContent);
		});
		$('.carousel-item').click(
				function(e) {
					var $img = $(this).children().clone().removeAttr("style")
							.removeClass().css({
								'width' : '100%',
								'height' : '100%',
								'object-fit' : 'contain'
							});
					$('#exampleModal').find('.modal-content').html($img);
					$('.modal-content').find('.detailbt').click(function() {
						pop($(this));
					});
					$('#exampleModal').modal('toggle');
				});

		$('.detailbt').click(function() {
			pop($(this));
		});
	});

	jQuery.event.add(window, "load", function() { //이미지가 모두 실행된 후 함수 실행
		var seq = getQuerystring("feed_idx");
		if (seq != null) {
			scrollMove();
		}
	});
</script>


</head>
<body>

	<div class="container">
		<a id="MOVE_TOP_BTN" href="#">TOP</a>


		<div class="search_menu">
			<form action="list" method="get">
				<aside style="float: right;">
					<input type="text" name="word" placeholder="검색어를 입력하시오">
					<button type="submit">검색</button>

				</aside>
			</form>
		</div>

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
								${feed.html }</div>
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
										id="contents" placeholder="내용을 입력해 주세요"></textarea>
								</div>
								<div>
									<button type="submit" class="btn btn-sm btn-primary insert"
										id="btnSave">작성</button>
									<a class="btn btn-sm btn-primary view" data-toggle="collapse"
										href="#collapseExample" role="button" aria-expanded="false"
										aria-controls="collapseExample"> <i class="fas fa-map"></i>
										모두보기
									</a>
								</div>
							</form>
						</div>
						<p></p>
						<div class="collapse" id="collapseExample">
							<div class="card card-body">

								<c:forEach var="reply" items="${feed.replys}">

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
								</c:forEach>
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

</body>
</html>