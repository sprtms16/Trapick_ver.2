function pop($selector) {
	var url = ""; // 팝업창 페이지 URL
	var winWidth = 700;
	var winHeight = 600;
	var popupOption = "width=" + winWidth + ", height=" + winHeight; // 팝업창
	// 옵션(optoin)
	var detail = $selector.parent().find('#detail').text();
	var name = $selector.parent().find('#name').text();
	var price = $selector.parent().find('#price').text();
	var img = $selector.parent().find('img').attr('src');
	var str = '<img src = "' + img + '"><br>이름 : ' + name + '<br>상세설명 : '
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
			success : function(e) {
				alert(e);
			}
		})
		return false;
	})

});
$(function() {
	$('.getReplyList')
			.click(
					function(data) {
						var $reply = $(this);
						$
								.ajax({
									url : '/reply/replyList.json',
									type : 'GET',
									dataType : 'json',
									data : {
										feed_idx : $(this).data('href')
									},
									success : function(data) {
										var $replyContainer = $reply.closest(
												'.container').parent().find(
												'#collapseExample').find(
												'.card-body');
										$replyContainer.html("");
										if (!$reply.hasClass('.collapsed')) {
											$
													.each(
															data,
															function(key, reply) {
																console
																		.log(reply);
																$replyContainer
																		.append($(
																				'<div>')
																				.append(
																						$(
																								'<a>')
																								.text(
																										reply.contents))
																				.append(
																						$(
																								'<a>')
																								.attr(
																										"data-href",
																										"/RestFeed/replyLikeAction/"
																												+ reply.feed_idx
																												+ "/"
																												+ reply.reply_idx)
																								.append(
																										$(
																												'<i>')
																												.addClass(
																														"far")
																												.addClass(
																														"fa-thumbs-up")
																												.text(
																														reply.like)// <i
																								// class="fas
																								// fa-thumbs-up">${reply.like
																								// }</i>
																								))
																				.append(
																						$(
																								'<a>')
																								.attr(
																										"data-href",
																										"/RestFeed/replyDislikeAction/"
																												+ reply.feed_idx
																												+ "/"
																												+ reply.reply_idx)
																								.append(
																										$(
																												'<i>')
																												.addClass(
																														"far")
																												.addClass(
																														"fa-thumbs-down")
																												.text(
																														reply.dislike)// <i
																								// class="fas
																								// fa-thumbs-down">${reply.dislike
																								// }</i>
																								)));
																if (reply.isLike == 1) {
																	$replyContainer
																			.find(
																					'.fa-thumbs-up')
																			.toggleClass(
																					"far");
																	$replyContainer
																			.find(
																					'.fa-thumbs-up')
																			.toggleClass(
																					"fas");
																}
																if (reply.isDislike == 1) {
																	$replyContainer
																			.find(
																					'.fa-thumbs-down')
																			.toggleClass(
																					"far");
																	$replyContainer
																			.find(
																					'.fa-thumbs-down')
																			.toggleClass(
																					"fas");
																}
															});// each close
										}// if close
									}// success close
								});// ajax close
					});// click event close
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

	// id가 p로 시작하는 객체를 찾아서, 그곳까지 이동

	$('html, body').animate({
		scrollTop : $("#target" + seq).offset().top
	}, 1000);

}

$(function() {

	$('.follow').click(function() {
		var $this = $(this);
		var href = $this.data('href');
		$.ajax({
			url : href,
			dataType : 'json',
			success : function(data) {
				var idx = $this.data("idx");
				
				if ($this.text() == "구독") {
					$('.'+idx).text("구독중");
				} else {
					$('.'+idx).text("구독");
				}

			}
		});
	});

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
	$('.card.card-body').on('click', '.fa-thumbs-up', function() {
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
	$('.card.card-body').on('click', '.fa-thumbs-down', function() {
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

jQuery.event.add(window, "load", function() { // 이미지가 모두 실행된 후 함수 실행
	var seq = getQuerystring("feed_idx");
	if (seq != null) {
		scrollMove();
	}
});