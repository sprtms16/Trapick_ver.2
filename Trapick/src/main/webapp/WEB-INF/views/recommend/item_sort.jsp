<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>

<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<title>TraPick</title>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" type="text/css"
	href="/resources/css/scheduler.css" />

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script type="text/javascript"
	src="http://maps.google.com/maps/api/js?key=AIzaSyCafdAtR2qeRHV-G6art-6-guHlmJBL_1s"></script>
<script type="text/javascript">
	var map;
	var testMarker = new Array();

	function initialize() {

		var mapOptions = {
			zoom : 6, // 지도를 띄웠을 때의 줌 크기
			mapTypeId : google.maps.MapTypeId.ROADMAP
		};

		map = new google.maps.Map(document.getElementById("map-canvas"), // div의 id과 값이 같아야 함. "map-canvas"
		mapOptions);

		var size_x = 40; // 마커로 사용할 이미지의 가로 크기
		var size_y = 40; // 마커로 사용할 이미지의 세로 크기

		// 마커로 사용할 이미지 주소
		var image = new google.maps.MarkerImage('주소 여기에 기입!',
				new google.maps.Size(size_x, size_y), '', '',
				new google.maps.Size(size_x, size_y));

	}
	google.maps.event.addDomListener(window, 'load', initialize);

	function addMarker(name, lat, lon) {
		var lat = parseFloat(lat);
		var lon = parseFloat(lon);
		var marker = new google.maps.Marker({
			title : name,
			position : {
				lat : lat,
				lng : lon
			},
			map : map
		});
		testMarker.push(marker)
		map.setCenter({
			lat : lat,
			lng : lon
		});
	}
</script>



<script type="text/javascript">
	$(function() {

		$('#hotelList').hide();
		$('#hotelPriceSort').hide();
		$('#hotelReviewSort').hide();
		$('#hotelDistSort').hide();
		$('#tab-1').addClass('selected');

		$('#tab-3').click(function() {
			$('#hotelList').show();
			$('#itemList').hide();
			$('#tab-1').removeClass('selected');
			$('#tab-3').addClass('selected');
			$('#hotelPriceSort').show();
			$('#hotelReviewSort').show();
			$('#hotelDistSort').show();
			$('#itemPriceSort').hide();
			$('#itemSalesSort').hide();
			$('#itemHitsSort').hide();
			$('#itemDistSort').hide();
		});

		$('#tab-1').click(function() {
			$('#itemList').show();
			$('#hotelList').hide();
			$('#tab-1').addClass('selected');
			$('#tab-3').removeClass('selected');
			$('#hotelList').hide();
			$('#hotelPriceSort').hide();
			$('#hotelReviewSort').hide();
			$('#hotelDistSort').hide();
			$('#itemPriceSort').show();
			$('#itemSalesSort').show();
			$('#itemHitsSort').show();
			$('#itemDistSort').show();
		});

		function hidePopup() {
			$("#popUp").hide();
		}

		//팝업 함수
		function pop($selector) {
			var url = ""; //팝업창 페이지 URL
			var winWidth = 700;
			var winHeight = 600;
			var popupOption = "width=" + winWidth + ", height=" + winHeight; //팝업창 옵션(optoin)
			var detail = $selector.parent().find('input[name=item_detail]')
					.val();
			var name = $selector.parent().find('input[name=item_name]').val();
			var price = $selector.parent().find('input[name=item_price]').val();
			var image = $selector.parent().find('input[name=item_image]').val();
			var str = '<img src = "'+image+'"><br>이름 : ' + name + '<br>상세설명 : '
					+ detail + '<br>가격 : ' + price;
			window.open(url, "", popupOption).document.write(str);
		}

		//삭제 상세보기 함수
		function event() {
			$("table .delete_schedule")
					.click(
							function() {
								for (var i = 0; i < testMarker.length; i++) {
									if ($(this).parents("td").find(
											'input[name=item_name]').val() == testMarker[i].title) {
										testMarker[i].setMap(null);
									}
								}

								$(this).parent().removeClass('select');
								$(this).parent().empty();
							})
			$('table .detailbt').click(function() {
				pop($(this));
			})

		}

		//드래그엔 드롭 함수
		var html = "";

		var dragFun = function() {
			$('.drag')
					.draggable(
							{
								helper : 'clone',
								opacity : 0.5,
								revert : true,
								start : function(e, ui) {
									html = "";
									html += '<button type="button" class="delete_schedule btn btn-danger liveButton">x</button>';
									html += '<img src="../resources/image/loupe.png" class="detailbt liveInput">'
									/* html += '<input type ="button" class = "detailbt liveInput" value ="상세보기">'; */
									html += $(this).html();
								},
								stop : function(e, ui) {
									event();
								}
							});
			$('.drag').mouseover(function() {
				$(this).css('background-color', '#E0ECF8');
			})
			$('.drag').mouseleave(function() {
				$(this).css('background-color', 'white');
			})
		}

		$('table td:not(.time)')
				.droppable(
						{
							accept : "div:not(.ho)",

							drop : function(event, ui) {

								var lon = $(ui.draggable).find(
										'input[name=longitude]').val();
								var lat = $(ui.draggable).find(
										'input[name=latitude]').val();
								var name = $(ui.draggable).find(
										'input[name=item_name]').val();

								addMarker(name, lat, lon);

								$(this).addClass('select');
								$(this).empty();
								var te = $(this).attr('name');
								html += '<input name = "position" type="hidden" value ="'+te+'">';
								$(this).append(html);
								html = "";

								var user_idx = 1;

								//4개 추천하기
								//landmark
								$
										.ajax({
											url : '/Rest/recommend/landmarkRecommend',
											type : 'post',
											dataType : 'json',
											data : {
												city_name : '<c:out value="${city_name}"/>',
												lat : lat,
												lon : lon
											},
											success : function(data) {
												$('#recommendLand').empty();
												$
														.each(
																data,
																function(index,
																		item) {
																	var text = '<div class="row drag"><div class="recommendList_thumb"><img src='
                                        +item.image+' class ="img"><span id = "category">명소<span></div><div class="recommendDetail" id="recommendDetailName"><div class="name" id="name">'
																			+ item.name
																			+ '</div><div   class="detail"  id="recommendDetail">'
																			+ item.detail
																			+ '</div>'
																			+ '</div><input type = "hidden" name ="land_idx" value ="'+item.land_idx+'"/><input type = "hidden" name = "item_price" value = "0">'
																			+ '<input type = "hidden" name ="item_name" value ="'+item.name+'"/>'
																			+ '<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
																			+ '<input type ="hidden" name ="item_image" value = '+item.image+'>'
																			+ '<input type ="hidden" name ="item_detail" value = '+item.detail+'>'
																			+ '<input type ="hidden" name ="longitude" value = "'+item.longitude+'"></div>';

																	$(
																			'#recommendLand')
																			.append(
																					text);
																})
												dragFun();
											}
										});

								//item
								$
										.ajax({
											url : '/Rest/recommend/itemRecommend.json',
											type : 'post',
											dataType : 'json',
											data : {
												city_name : '<c:out value="${city_name}"/>',
												lat : lat,
												lon : lon
											},
											success : function(data) {
												$('#recommendItem').empty();
												$
														.each(
																data,
																function(index,
																		item) {
																	var text = '<div class="row drag" ><div class="recommendList_thumb" ><img class="img" src='
                      +item.image+'><span id = "category">상품<span></div><div class="recommendDetail" id="recommendDetailName"><div class="name" id="name">'
																			+ item.name
																			+ '</div><div   class="detail"  id="recommendDetail">'
																			+ item.detail
																			+ '</div><div  id="price" class="row">'
																			+ item.price
																			+ '</div>'
																			+ '<input type = "hidden" name ="item_name" value ="'+item.name+'"/>'
																			+ '<input type = "hidden" name ="item_price" value ="'+item.price+'"/>'
																			+ '<input type = "hidden" name ="item_image" value ="'+item.image+'"/>'
																			+ '<input type = "hidden" name ="item_detail" value ="'+item.detail+'"/>'
																			+ '<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
																			+ '<input type ="hidden" name ="longitude" value = "'+item.longitude+'"></div>';

																	$(
																			'#recommendItem')
																			.append(
																					text);
																})
												dragFun();
											}
										});

								//Hotel
								$
										.ajax({
											url : '/Rest/recommend/hotelRecommend.json',
											type : 'post',
											dataType : 'json',
											data : {
												city_name : '<c:out value="${city_name}"/>',
												lat : lat,
												lon : lon
											},
											success : function(data) {
												$('#recommendHotel').empty();
												$
														.each(
																data,
																function(index,
																		item) {
																	var text = '<div class="row drag" ><div class="recommendList_thumb" ><img class="img" src='
                                                             +item.image+'><span id = "category">호텔<span></div><div class="recommendDetail" id="recommendDetailName"><div class="name" id="name">'
																			+ item.name
																			+ '</div><div   class="detail"  id="recommendDetail">'
																			+ item.detail
																			+ '</div><div  id="price" class="row">'
																			+ item.price
																			+ '</div>'
																			+ '<input type = "hidden" name ="item_name" value ="'+item.name+'"/>'
																			+ '<input type = "hidden" name ="item_price" value ="'+item.price+'"/>'
																			+ '<input type = "hidden" name ="item_image" value ="'+item.image+'"/>'
																			+ '<input type = "hidden" name ="item_detail" value ="'+item.detail+'"/>'
																			+ '<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
																			+ '<input type ="hidden" name ="longitude" value = "'+item.longitude+'"></div>';

																	$(
																			'#recommendHotel')
																			.append(
																					text);
																})
												dragFun();
											}
										});

								//거리 순 정렬
								//Landmark
								$('#landmarkDistSort')
										.on(
												'click',
												function() {
													$
															.ajax({
																url : '/Rest/recommend/landmarkDistSort.json',
																type : 'post',
																dataType : 'json',
																data : {
																	city_name : '<c:out value="${city_name}"/>',
																	lat : lat,
																	lon : lon
																},
																success : function(
																		data) {
																	$(
																			'#landmarkDiv')
																			.empty();
																	$
																			.each(
																					data,
																					function(
																							index,
																							item) {
																						var text = '<div class="row drag"><div class="list_thumb"><img src='
                             +item.image+' class ="img"></div><div class="list_detail" id="landDetail"><div class="name" id="name">'
																								+ item.name
																								+ '</div><div   class="detail"  id="detail">'
																								+ item.detail
																								+ '</div>'
																								+ '</div><input type = "hidden" name ="land_idx" value ="'+item.land_idx+'"/><input type = "hidden" name = "item_price" value = "0">'
																								+ '<input type = "hidden" name ="item_name" value ="'+item.name+'"/>'
																								+ '<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
																								+ '<input type ="hidden" name ="item_image" value = '+item.image+'>'
																								+ '<input type ="hidden" name ="item_detail" value = '+item.detail+'>'
																								+ '<input type ="hidden" name ="longitude" value = "'+item.longitude+'"></div>';

																						$(
																								'#landmarkDiv')
																								.append(
																										text);
																					})
																	dragFun();
																}
															})
												})

								//Hotel
								$('#hotelDistSort')
										.on(
												'click',
												function() {
													$
															.ajax({
																url : '/Rest/recommend/hotelDistSort.json',
																type : 'post',
																dataType : 'json',
																data : {
																	city_name : '<c:out value="${city_name}"/>',
																	lat : lat,
																	lon : lon
																},
																success : function(
																		data) {

																	$(
																			'#hotelList')
																			.empty();
																	$
																			.each(
																					data,
																					function(
																							index,
																							item) {
																						var text = '<div class="row drag" ><div class="list_thumb" ><img class="img" src='
                            +item.image+'></div><div class="list_detail"><div id = "name" class="row">'
																								+ item.name
																								+ '</div><div id ="detail" class="row">'
																								+ item.detail
																								+ '</div><div  id="price" class="row">'
																								+ item.price
																								+ '</div>'
																								+ '<input type = "hidden" name ="item_name" value ="'+item.name+'"/>'
																								+ '<input type = "hidden" name ="item_price" value ="'+item.price+'"/>'
																								+ '<input type = "hidden" name ="item_image" value ="'+item.image+'"/>'
																								+ '<input type = "hidden" name ="item_detail" value ="'+item.detail+'"/>'
																								+ '<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
																								+ '<input type ="hidden" name ="longitude" value = "'+item.longitude+'"></div>';
																						$(
																								'#hotelList')
																								.append(
																										text);
																					})
																	dragFun();
																}
															});
												})
								//아이템
								$('#itemDistSort')
										.on(
												'click',
												function() {
													$
															.ajax({
																url : '/Rest/recommend/itemDistSort.json',
																type : 'post',
																dataType : 'json',
																data : {
																	city_name : '<c:out value="${city_name}"/>',
																	lat : lat,
																	lon : lon
																},
																success : function(
																		data) {

																	$(
																			'#itemList')
																			.empty();
																	$
																			.each(
																					data,
																					function(
																							index,
																							item) {
																						var text = '<div class="row drag" ><div class="list_thumb" ><img class="img" src='
                         +item.image+'></div><div class="list_detail"><div id = "name" class="row">'
																								+ item.name
																								+ '</div><div id ="detail" class="row">'
																								+ item.detail
																								+ '</div><div  id="price" class="row">'
																								+ item.price
																								+ '</div>'
																								+ '<input type = "hidden" name ="item_name" value ="'+item.name+'"/>'
																								+ '<input type = "hidden" name ="item_price" value ="'+item.price+'"/>'
																								+ '<input type = "hidden" name ="item_image" value ="'+item.image+'"/>'
																								+ '<input type = "hidden" name ="item_detail" value ="'+item.detail+'"/>'
																								+ '<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
																								+ '<input type ="hidden" name ="longitude" value = "'+item.longitude+'"></div>';
																						$(
																								'#itemList')
																								.append(
																										text);
																					})
																	dragFun();
																}
															})
												});
							}//end drag
						}); //드래그앤 드롭 함수 끝
		$('#hotelTable td')
				.droppable(
						{
							accept : "div.ho",
							drop : function(event, ui) {

								var lon = $(ui.draggable).find(
										'input[name=longitude]').val();
								var lat = $(ui.draggable).find(
										'input[name=latitude]').val();
								var name = $(ui.draggable).find(
										'input[name=item_name]').val();

								addMarker(name, lat, lon);

								$(this).addClass('select');
								$(this).empty();
								var te = $(this).attr('name');
								html += '<input name = "position" type="hidden" value ="'+te+'">';
								$(this).append(html);
								html = "";

							}//end drag
						}); //드래그앤 드롭 함수 끝

		//일정 저장
		$('#save').on(
				"click",
				function() {
					var te = $('#savet').serialize() + "&"
							+ $('#courseData').serialize();
					te = encodeURI(te);
					alert(te);
					$.ajax({
						url : '/Rest/recommend/saveLandMark',
						type : 'post',
						dataType : 'json',
						data : te,
						success : function(data) {
							alert("일정저장성공");
						}
					})

				})//일정저장 끝

		//경로 추천
		$('#course')
				.on(
						"click",
						function() {
							var te = $('#courseData').serialize();
							te = encodeURI(te);
							alert(te);
							$
									.ajax({
										url : '/Rest/recommend/course',
										type : 'post',
										dataType : 'json',
										data : te,
										success : function(data) {
											alert("경로 추천 성공");
											$
													.each(
															data,
															function(index,
																	item) {
																if (item.item_price == 0) {
																	var te = $(
																			'.select:eq('
																					+ index
																					+ ')')
																			.attr(
																					'name');
																	var text = '<button type="button" class="delete_schedule btn btn-danger liveButton">x</button><img src="../resources/image/loupe.png" class="detailbt liveInput"><div class="list_thumb"><img src='
                            +item.image+' class ="img"></div><div class="list_detail"  id="landDetail"><div class="name" id="name">'
																			+ item.item_name
																			+ '</div><div   class="detail"  id="detail">'
																			+ item.item_detail
																			+ '</div>'
																			+ '</div><input type = "hidden" name ="land_idx" value ="'+item.land_idx+'"/><input type = "hidden" name = "item_price" value = "0">'
																			+ '<input type = "hidden" name ="item_name" value ="'+item.item_name+'"/>'
																			+ '<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
																			+ '<input type ="hidden" name ="item_image" value = '+item.image+'>'
																			+ '<input type ="hidden" name ="item_detail" value = '+item.item_detail+'>'
																			+ '<input type ="hidden" name ="longitude" value = "'+item.longitude+'">'
																			+ '<input name = "position" type="hidden" value ="'+te+'">';

																	$(
																			'.select:eq('
																					+ index
																					+ ')')
																			.empty()
																			.append(
																					text);
																	event();
																} else {
																	var te = $(
																			'.select:eq('
																					+ index
																					+ ')')
																			.attr(
																					'name');

																	var text = '<button type="button" class="delete_schedule btn btn-danger liveButton">x</button><img src="../resources/image/loupe.png" class="detailbt liveInput"><div class="list_thumb"><img src='
                                    +item.image+' class ="img"></div><div class="list_detail"  id="landDetail"><div class="name" id="name">'
																			+ item.item_name
																			+ '</div><div   class="detail"  id="detail">'
																			+ item.item_detail
																			+ '</div><div  id="price" class="row">'
																			+ item.item_price
																			+ '</div>'
																			+ '<input type = "hidden" name ="item_name" value ="'+item.item_name+'"/>'
																			+ '<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
																			+ '<input type = "hidden" name ="item_price" value ="'+item.item_price+'"/>'
																			+ '<input type ="hidden" name ="item_image" value = '+item.image+'>'
																			+ '<input type ="hidden" name ="item_detail" value = '+item.item_detail+'>'
																			+ '<input type ="hidden" name ="longitude" value = "'+item.longitude+'">'
																			+ '<input name = "position" type="hidden" value ="'+te+'">';
																	$(
																			'.select:eq('
																					+ index
																					+ ')')
																			.empty()
																			.append(
																					text);
																	event();
																}
															})
										},
										error : function(request, status, error) {
											alert("code = " + request.status
													+ " message = "
													+ request.responseText
													+ " error = " + error); // 실패 시 처리
										}
									})
							return false;
						}) //경로추천 끝

		//첫화면 ajax
		$
				.ajax({
					url : '/Rest/recommend/landMarkAjax.json',
					type : 'post',
					dataType : 'json',
					data : {
						city_name : '<c:out value="${city_name}"/>'
					},
					success : function(data) {

						$('#landmarkDiv').empty();
						$
								.each(
										data,
										function(index, item) {
											var text = '<div class="row drag"><div class="list_thumb"><img src='
                   +item.image+' class ="img"></div><div class="list_detail" id="landDetail"><div class="name" id="name">'
													+ item.name
													+ '</div><div   class="detail"  id="detail">'
													+ item.detail
													+ '</div>'
													+ '</div><input type = "hidden" name ="land_idx" value ="'+item.land_idx+'"/><input type = "hidden" name = "item_price" value = "0">'
													+ '<input type = "hidden" name ="item_name" value ="'+item.name+'"/>'
													+ '<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
													+ '<input type ="hidden" name ="item_image" value = '+item.image+'>'
													+ '<input type ="hidden" name ="item_detail" value = '+item.detail+'>'
													+ '<input type ="hidden" name ="longitude" value = "'+item.longitude+'"></div>';

											$('#landmarkDiv').append(text);
										})

						dragFun();
					}
				})
		$('landmarkDiv .cc').click(function() {
			alert("df");
		})

		$
				.ajax({
					url : '/Rest/recommend/itemAjax',
					type : 'post',
					dataType : 'json',
					data : {
						city_name : '<c:out value="${city_name}"/>'
					},
					success : function(data) {

						$('#itemList').empty();
						$
								.each(
										data,
										function(index, item) {

											var text = '<div class="row drag" ><div class="list_thumb" ><img class="img" src='
                    +item.image+'></div><div class="list_detail"><div id = "name" class="row">'
													+ item.name
													+ '</div><div id ="detail" class="row">'
													+ item.detail
													+ '</div><div  id="price" class="row">'
													+ item.price
													+ '</div>'
													+ '<input type = "hidden" name ="item_name" value ="'+item.name+'"/>'
													+ '<input type = "hidden" name ="item_price" value ="'+item.price+'"/>'
													+ '<input type = "hidden" name ="item_image" value ="'+item.image+'"/>'
													+ '<input type = "hidden" name ="item_detail" value ="'+item.detail+'"/>'
													+ '<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
													+ '<input type ="hidden" name ="longitude" value = "'+item.longitude+'"></div>';

											$('#itemList').append(text);
										})
						dragFun();
					}
				})
		//숙박 ajax
		$
				.ajax({
					url : '/Rest/recommend/hotelAjax',
					type : 'post',
					dataType : 'json',
					data : {
						city_name : '<c:out value="${city_name}"/>'
					},
					success : function(data) {

						$('#hotelList').empty();

						$
								.each(
										data,
										function(index, item) {

											var text = '<div class="row drag ho" ><div class="list_thumb" ><img class="img" src='
                     +item.image+'></div><div class="list_detail"><div id = "name" class="row">'
													+ item.name
													+ '</div><div id ="detail" class="row">'
													+ item.detail
													+ '</div><div  id="price" class="row">'
													+ item.price
													+ '</div>'
													+ '<input type = "hidden" name ="item_name" value ="'+item.name+'"/>'
													+ '<input type = "hidden" name ="item_price" value ="'+item.price+'"/>'
													+ '<input type = "hidden" name ="item_image" value ="'+item.image+'"/>'
													+ '<input type = "hidden" name ="item_detail" value ="'+item.detail+'"/>'
													+ '<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
													+ '<input type ="hidden" name ="longitude" value = "'+item.longitude+'"></div>';

											$('#hotelList').append(text);
										})
						dragFun();
					}
				})

		//사용자 기반 추천
		$
				.ajax({
					url : '/Rest/recommend/landmarkUserRecommend',
					type : 'post',
					dataType : 'json',
					data : {
						city_name : '<c:out value="${city_name}"/>',
						user_idx : 2
					},
					success : function(data) {
						$('#recommendUserLand').empty();
						$
								.each(
										data,
										function(index, item) {
											var text = '<div class="row drag" ><div class="recommendList_thumb" ><img class="img" src='
                                                             +item.image+'><span id = "category">명소<span></div><div class="recommendDetail" id="recommendDetailName"><div class="name" id="name">'
													+ item.name
													+ '</div><div   class="detail"  id="recommendDetail">'
													+ item.detail
													+ '</div>'
													+ '</div><input type = "hidden" name ="land_idx" value ="'+item.land_idx+'"/><input type = "hidden" name = "item_price" value = "0">'
													+ '<input type = "hidden" name ="item_name" value ="'+item.name+'"/>'
													+ '<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
													+ '<input type ="hidden" name ="item_image" value = '+item.image+'>'
													+ '<input type ="hidden" name ="item_detail" value = '+item.detail+'>'
													+ '<input type ="hidden" name ="longitude" value = "'+item.longitude+'"></div>';

											$('#recommendUserLand')
													.append(text);
										})
						dragFun();
					}
				});

		//item
		$
				.ajax({
					url : '/Rest/recommend/itemUserRecommend.json',
					type : 'post',
					dataType : 'json',
					data : {
						city_name : '<c:out value="${city_name}"/>',
						user_idx : 2
					},
					success : function(data) {
						$('#recommendUserItem').empty();
						$
								.each(
										data,
										function(index, item) {
											var text = '<div class="row drag" ><div class="recommendList_thumb" ><img class="img" src='
                                                             +item.image+'><span id = "category">상품<span></div><div class="recommendDetail" id="recommendDetailName"><div class="name" id="name">'
													+ item.name
													+ '</div><div   class="detail"  id="recommendDetail">'
													+ item.detail
													+ '</div><div  id="price" class="row">'
													+ item.price
													+ '</div>'
													+ '<input type = "hidden" name ="item_name" value ="'+item.name+'"/>'
													+ '<input type = "hidden" name ="item_price" value ="'+item.price+'"/>'
													+ '<input type = "hidden" name ="item_image" value ="'+item.image+'"/>'
													+ '<input type = "hidden" name ="item_detail" value ="'+item.detail+'"/>'
													+ '<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
													+ '<input type ="hidden" name ="longitude" value = "'+item.longitude+'"></div>';

											$('#recommendUserItem')
													.append(text);
										})
						dragFun();
					}
				});

		//Hotel
		$
				.ajax({
					url : '/Rest/recommend/hotelUserRecommend.json',
					type : 'post',
					dataType : 'json',
					data : {
						city_name : '<c:out value="${city_name}"/>',
						user_idx : 2
					},
					success : function(data) {
						$('#recommendUserHotel').empty();
						$
								.each(
										data,
										function(index, item) {
											var text = '<div class="row drag" ><div class="recommendList_thumb" ><img class="img" src='
                                                             +item.image+'><span id = "category">호텔<span></div><div class="recommendDetail" id="recommendDetailName"><div class="name" id="name">'
													+ item.name
													+ '</div><div   class="detail"  id="recommendDetail">'
													+ item.detail
													+ '</div><div  id="price" class="row">'
													+ item.price
													+ '</div>'
													+ '<input type = "hidden" name ="item_name" value ="'+item.name+'"/>'
													+ '<input type = "hidden" name ="item_price" value ="'+item.price+'"/>'
													+ '<input type = "hidden" name ="item_image" value ="'+item.image+'"/>'
													+ '<input type = "hidden" name ="item_detail" value ="'+item.detail+'"/>'
													+ '<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
													+ '<input type ="hidden" name ="longitude" value = "'+item.longitude+'"></div>';

											$('#recommendUserHotel').append(
													text);
										})
						dragFun();
					}
				});

		//도시선택시 ajax 구동
		$('#city_search')
				.on(
						"click",
						function() {
							//랜드마크 ajax
							$
									.ajax({
										url : '/Rest/recommend/landMarkAjax.json',
										type : 'post',
										dataType : 'json',
										data : {
											city_name : $(
													'#city option:selected')
													.val()
										},
										success : function(data) {

											$('#landmarkDiv').empty();

											$
													.each(
															data,
															function(index,
																	item) {

																var text = '<div class="row drag"><div class="list_thumb"><img src='
                       +item.image+' class ="img"></div><div class="list_detail" id="landDetail"><div class="name" id="name">'
																		+ item.name
																		+ '</div><div   class="detail"  id="detail">'
																		+ item.detail
																		+ '</div>'
																		+ '</div><input type = "hidden" name ="land_idx" value ="'+item.land_idx+'"/><input type = "hidden" name = "item_price" value = "0">'
																		+ '<input type = "hidden" name ="item_name" value ="'+item.name+'"/>'
																		+ '<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
																		+ '<input type ="hidden" name ="item_image" value = '+item.image+'>'
																		+ '<input type ="hidden" name ="item_detail" value = '+item.detail+'>'
																		+ '<input type ="hidden" name ="longitude" value = "'+item.longitude+'"></div>';

																$(
																		'#landmarkDiv')
																		.append(
																				text);
															})
											dragFun();
										}
									})
							//아이템 ajax
							$
									.ajax({
										url : '/Rest/recommend/itemAjax',
										type : 'post',
										dataType : 'json',
										data : {
											city_name : $(
													'#city option:selected')
													.val()
										},
										success : function(data) {

											$('#itemList').empty();

											$
													.each(
															data,
															function(index,
																	item) {

																var text = '<div class="row drag" ><div class="list_thumb" ><img class="img" src='
                       +item.image+'></div><div class="list_detail"><div id = "name" class="row">'
																		+ item.name
																		+ '</div><div id ="detail" class="row">'
																		+ item.detail
																		+ '</div><div  id="price" class="row">'
																		+ item.price
																		+ '</div>'
																		+ '<input type = "hidden" name ="item_name" value ="'+item.name+'"/>'
																		+ '<input type = "hidden" name ="item_price" value ="'+item.price+'"/>'
																		+ '<input type = "hidden" name ="item_image" value ="'+item.image+'"/>'
																		+ '<input type = "hidden" name ="item_detail" value ="'+item.detail+'"/>'
																		+ '<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
																		+ '<input type ="hidden" name ="longitude" value = "'+item.longitude+'"></div>';

																$('#itemList')
																		.append(
																				text);
															})
											dragFun();
										}
									})
							//숙박 ajax
							$
									.ajax({
										url : '/Rest/recommend/hotelAjax',
										type : 'post',
										dataType : 'json',
										data : {
											city_name : $(
													'#city option:selected')
													.val()
										},
										success : function(data) {

											$('#hotelList').empty();

											$
													.each(
															data,
															function(index,
																	item) {

																var text = '<div class="row drag ho" ><div class="list_thumb" ><img class="img" src='
                        +item.image+'></div><div class="list_detail"><div id = "name" class="row">'
																		+ item.name
																		+ '</div><div id ="detail" class="row">'
																		+ item.detail
																		+ '</div><div  id="price" class="row">'
																		+ item.price
																		+ '</div>'
																		+ '<input type = "hidden" name ="item_name" value ="'+item.name+'"/>'
																		+ '<input type = "hidden" name ="item_price" value ="'+item.price+'"/>'
																		+ '<input type = "hidden" name ="item_image" value ="'+item.image+'"/>'
																		+ '<input type = "hidden" name ="item_detail" value ="'+item.detail+'"/>'
																		+ '<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
																		+ '<input type ="hidden" name ="longitude" value = "'+item.longitude+'"></div>';

																$('#hotelList')
																		.append(
																				text);
															})
											dragFun();
										}
									})
						})//도시선택 ajax 끝

		//정렬 
		$('#itemPriceSort')
				.on(
						'click',
						function() {
							$
									.ajax({
										url : '/Rest/recommend/itemPriceSort',
										type : 'post',
										dataType : 'json',
										data : {
											city_name : $(
													'#city option:selected')
													.val()
										},
										success : function(data) {

											$('#itemList').empty();
											$
													.each(
															data,
															function(index,
																	item) {
																var text = '<div class="row drag" ><div class="list_thumb" ><img class="img" src='
                          +item.image+'></div><div class="list_detail"><div id = "name" class="row">'
																		+ item.name
																		+ '</div><div id ="detail" class="row">'
																		+ item.detail
																		+ '</div><div  id="price" class="row">'
																		+ item.price
																		+ '</div>'
																		+ '<input type = "hidden" name ="item_name" value ="'+item.name+'"/>'
																		+ '<input type = "hidden" name ="item_price" value ="'+item.price+'"/>'
																		+ '<input type = "hidden" name ="item_image" value ="'+item.image+'"/>'
																		+ '<input type = "hidden" name ="item_detail" value ="'+item.detail+'"/>'
																		+ '<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
																		+ '<input type ="hidden" name ="longitude" value = "'+item.longitude+'"></div>';

																$('#itemList')
																		.append(
																				text);
															})
											dragFun();
										}
									})
						});
		//판매량 순
		$('#itemSalesSort')
				.on(
						'click',
						function() {
							$
									.ajax({
										url : '/Rest/recommend/itemSalesSort',
										type : 'post',
										dataType : 'json',
										data : {
											city_name : $(
													'#city option:selected')
													.val()
										},
										success : function(data) {

											$('#itemList').empty();
											$
													.each(
															data,
															function(index,
																	item) {
																var text = '<div class="row drag" ><div class="list_thumb" ><img class="img" src='
                          +item.image+'></div><div class="list_detail"><div id = "name" class="row">'
																		+ item.name
																		+ '</div><div id ="detail" class="row">'
																		+ item.detail
																		+ '</div><div  id="price" class="row">'
																		+ item.price
																		+ '</div>'
																		+ '<input type = "hidden" name ="item_name" value ="'+item.name+'"/>'
																		+ '<input type = "hidden" name ="item_price" value ="'+item.price+'"/>'
																		+ '<input type = "hidden" name ="item_image" value ="'+item.image+'"/>'
																		+ '<input type = "hidden" name ="item_detail" value ="'+item.detail+'"/>'
																		+ '<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
																		+ '<input type ="hidden" name ="longitude" value = "'+item.longitude+'"></div>';

																$('#itemList')
																		.append(
																				text);
															})
											dragFun();
										}
									})
						});

		//인기순
		$('#itemHitsSort')
				.on(
						'click',
						function() {
							$
									.ajax({
										url : '/Rest/recommend/itemHitsSort',
										type : 'post',
										dataType : 'json',
										data : {
											city_name : $(
													'#city option:selected')
													.val()
										},
										success : function(data) {

											$('#itemList').empty();
											$
													.each(
															data,
															function(index,
																	item) {
																var text = '<div class="row drag" ><div class="list_thumb" ><img class="img" src='
                          +item.image+'></div><div class="list_detail"><div id = "name" class="row">'
																		+ item.name
																		+ '</div><div id ="detail" class="row">'
																		+ item.detail
																		+ '</div><div  id="price" class="row">'
																		+ item.price
																		+ '</div>'
																		+ '<input type = "hidden" name ="item_name" value ="'+item.name+'"/>'
																		+ '<input type = "hidden" name ="item_price" value ="'+item.price+'"/>'
																		+ '<input type = "hidden" name ="item_image" value ="'+item.image+'"/>'
																		+ '<input type = "hidden" name ="item_detail" value ="'+item.detail+'"/>'
																		+ '<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
																		+ '<input type ="hidden" name ="longitude" value = "'+item.longitude+'"></div>';

																$('#itemList')
																		.append(
																				text);
															})
											dragFun();
										}
									})
						});

		//호텔
		//가격순
		$('#hotelPriceSort')
				.on(
						'click',
						function() {
							$
									.ajax({
										url : '/Rest/recommend/hotelPriceSort',
										type : 'post',
										dataType : 'json',
										data : {
											city_name : '<c:out value="${city_name}"/>'
										},
										success : function(data) {

											$('#hotelList').empty();
											$
													.each(
															data,
															function(index,
																	item) {
																var text = '<div class="row drag ho" ><div class="list_thumb" ><img class="img" src='
                                +item.image+'></div><div class="list_detail"><div id = "name" class="row">'
																		+ item.name
																		+ '</div><div id ="detail" class="row">'
																		+ item.detail
																		+ '</div><div  id="price" class="row">'
																		+ item.price
																		+ '</div>'
																		+ '<input type = "hidden" name ="item_name" value ="'+item.name+'"/>'
																		+ '<input type = "hidden" name ="item_price" value ="'+item.price+'"/>'
																		+ '<input type = "hidden" name ="item_image" value ="'+item.image+'"/>'
																		+ '<input type = "hidden" name ="item_detail" value ="'+item.detail+'"/>'
																		+ '<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
																		+ '<input type ="hidden" name ="longitude" value = "'+item.longitude+'"></div>';

																$('#hotelList')
																		.append(
																				text);
															})
											dragFun();
										}
									});
						})

		//Review
		$('#hotelReviewSort')
				.on(
						'click',
						function() {
							$
									.ajax({
										url : '/Rest/recommend/hotelReviewSort',
										type : 'post',
										dataType : 'json',
										data : {
											city_name : '<c:out value="${city_name}"/>'
										},
										success : function(data) {

											$('#hotelList').empty();
											$
													.each(
															data,
															function(index,
																	item) {
																var text = '<div class="row drag ho" ><div class="list_thumb" ><img class="img" src='
                                +item.image+'></div><div class="list_detail"><div id = "name" class="row">'
																		+ item.name
																		+ '</div><div id ="detail" class="row">'
																		+ item.detail
																		+ '</div><div  id="price" class="row">'
																		+ item.price
																		+ '</div>'
																		+ '<input type = "hidden" name ="item_name" value ="'+item.name+'"/>'
																		+ '<input type = "hidden" name ="item_price" value ="'+item.price+'"/>'
																		+ '<input type = "hidden" name ="item_image" value ="'+item.image+'"/>'
																		+ '<input type = "hidden" name ="item_detail" value ="'+item.detail+'"/>'
																		+ '<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
																		+ '<input type ="hidden" name ="longitude" value = "'+item.longitude+'"></div>';

																$('#hotelList')
																		.append(
																				text);
															})
											dragFun();
										}
									});
						})
		//인기순
		$('#landmarkHitsSort')
				.on(
						'click',
						function() {
							$
									.ajax({
										url : '/Rest/recommend/landmarkHitsSort.json',
										type : 'post',
										dataType : 'json',
										data : {
											city_name : '<c:out value="${city_name}"/>'
										},
										success : function(data) {

											$('#landmarkDiv').empty();
											$
													.each(
															data,
															function(index,
																	item) {
																var text = '<div class="row drag"><div class="list_thumb"><img src='
                                +item.image+' class ="img"></div><div class="list_detail" id="landDetail"><div class="name" id="name">'
																		+ item.name
																		+ '</div><div   class="detail"  id="detail">'
																		+ item.detail
																		+ '</div>'
																		+ '</div><input type = "hidden" name ="land_idx" value ="'+item.land_idx+'"/><input type = "hidden" name = "item_price" value = "0">'
																		+ '<input type = "hidden" name ="item_name" value ="'+item.name+'"/>'
																		+ '<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
																		+ '<input type ="hidden" name ="item_image" value = '+item.image+'>'
																		+ '<input type ="hidden" name ="item_detail" value = '+item.detail+'>'
																		+ '<input type ="hidden" name ="longitude" value = "'+item.longitude+'"></div>';

																$(
																		'#landmarkDiv')
																		.append(
																				text);
															})
											dragFun();
										}
									});
						})
		//정렬 끝

	})

	/* function wrapWindowByMask() {
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

	function wrapWindowByloading() {
		//화면의 높이와 너비를 구한다.
		var maskHeight = $(document).height();
		var maskWidth = $(window).width();

		//마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
		$('#loadingImage').css({
			'width' : maskWidth,
			'height' : maskHeight
		});
	}

	$(document).ready(function() {
		$('#Progress_Loading').hide(); //첫 시작시 로딩바를 숨겨준다.
		$('#mask').hide();
	}).ajaxStart(function() {
		$('#Progress_Loading').show(); //ajax실행시 로딩바를 보여준다.
		wrapWindowByMask();
	}).ajaxStop(function() {
		$('#Progress_Loading').hide(); //ajax종료시 로딩바를 숨겨준다.
		$('#mask').hide();
	}); */
</script>
<script type="text/javascript">
	/*
	 $(document).ready(function() {
	 setTimeout(function() {
	 document.getElementById( 'jb' ).value = '10';
	 },1000);
	 setTimeout(function() {
	 document.getElementById( 'jb' ).value = '20';
	 },2000);
	 setTimeout(function() {
	 document.getElementById( 'jb' ).value = '30';
	 },3000);
	 setTimeout(function() {
	 document.getElementById( 'jb' ).value = '40';
	 },4000);
	 setTimeout(function() {
	 document.getElementById( 'jb' ).value = '50';
	 },5000);
	 setTimeout(function() {
	 document.getElementById( 'jb' ).value = '60';
	 },6000);
	 setTimeout(function() {
	 document.getElementById( 'jb' ).value = '70';
	 },7000);
	 setTimeout(function() {
	 document.getElementById( 'jb' ).value = '80';
	 },8000);
	 setTimeout(function() {
	 document.getElementById( 'jb' ).value = '90';
	 },9000);
	 setTimeout(function() {
	 document.getElementById( 'jb' ).value = '100';
	 },10000);
	 });
	 */
</script>
<style type="text/css">
#loadingImage {
	position: absolute;
	left: 0;
	top: 0;
	z-index: 300;
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		$('#loadingImage').hide();
		$('#jb').hide();
		/*    setTimeout(function(){
		 $('#loadingImage').hide();
		 $('#jb').hide();
		 }, 10000); */
	});
</script>
<script type="text/javascript">
	$(function() {
		var floatPosition = parseInt($("#map-canvas").css('top'));

		$(window).scroll(function() {
			var scrollTop = $(window).scrollTop();
			var newPosition = scrollTop + floatPosition + "px";

			$("#map-canvas").css('top', newPosition);

		}).scroll();

	})
</script>
<title>여행상품</title>
</head>
<body>
	<div id="mask"></div>
	<div>
		<progress value="0" max="100" id="jb"></progress>
	</div>
	<div id="Progress_Loading">
		<!-- 로딩바 -->
		<img src="../resources/image/Progress_Loading.gif" id="progress" />
	</div>
	<div id="loadingImage">
		<img src="../resources/image/loading.jpg" id="im" />
	</div>
	<p id="subject">Travel Scheduler</p>
	<br>
	<br>
	<div id="asdf">
		<select id="city" name="city_name" class="form-control">
			<c:forEach var="cityList" items="${cityList }">
				<option value="${cityList }">${cityList }</option>
			</c:forEach>
		</select>
		<button id="city_search" class="btn btn-info">검색</button>
	</div>
	<div id="asdf2">
		<button id="itemPriceSort" name="price" class="btn btn-info btn-lg">가격순</button>
		<button id="itemSalesSort" name="price" class="btn btn-info btn-lg">판매순</button>
		<button id="itemDistSort" name="price" class="btn btn-info btn-lg">거리순</button>
		<button id="hotelPriceSort" name="price" class="btn btn-info btn-lg">가격순</button>
		<button id="hotelReviewSort" name="price" class="btn btn-info btn-lg">리뷰순</button>
		<button id="hotelDistSort" name="price" class="btn btn-info btn-lg">거리순</button>
		<button id="landmarkDistSort" name="price" class="btn btn-info btn-lg">거리순</button>
		<button id="landmarkHitsSort" name="price" class="btn btn-info btn-lg">인기순</button>
		<!--<button id="itemHitsSort" name="price" class="btn btn-info">상품 인기순</button> -->
	</div>
	<div class="container">

		<div id="map-po" class="row fix-gutters">
			<div class="col-md-5">
				<!-- Temp_Scheduler -->
				<form id="courseData" action="/mypage/list" method="get">
					<div id="schedule_title">
						<input type="text" name="title" class="form-control"
							id="titleSche" placeholder="일정 제목">
					</div>
					<button id="course" class="btn btn-info btn-lg">경로 추천</button>
					<button id="save" class="btn btn-info btn-lg">일정 저장</button>
					<table id="mySheduleTable" border=2>
						<tr>
							<th>일정</th>
							<th>06:00 ~ 09:00</th>
							<th>09:00 ~ 12:00</th>
							<th>12:00 ~ 15:00</th>
							<th>15:00 ~ 18:00</th>
							<th>18:00 ~ 21:00</th>
						</tr>
						<c:forEach begin="1" end="${day }" varStatus="index">
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


					<input type="hidden" name="schd_idx" value="${schd_idx }">
					<input type="hidden" name="start_time" value="${start_time }">
					<input type="hidden" name="end_time" value="${end_time }">
				</form>
			</div>

			<div class="col-md-1">
				<form id="savet">
					<table id="hotelTable" border=2>
						<tr>
							<th>숙소</th>
						</tr>
						<c:forEach begin="1" end="${day }" varStatus="index">
							<tr>
								<td class="ho" name="ho-${index.count }"></td>
							</tr>
						</c:forEach>
					</table>
				</form>
			</div>
			<div class="col-md-3" id="city_List">
				<div id="landMarkList">
					<ul id="landUl">
						<li><a id="land">관광지</a></li>
					</ul>
					<div id="landmarkDiv"></div>
				</div>
			</div>
			<!-- sort button -->
			<div class="col-md-3">
				<div id="tabs">
					<ul>
						<li><a href="#" id="tab-1">상품</a></li>
						<li><a href="#" id="tab-3">숙박</a></li>
					</ul>
					<div id="tabs-1">
						<div id="itemList"></div>
					</div>
					<div id="tabs-3">
						<div id="hotelList"></div>
					</div>
				</div>
			</div>
			<div id="recommend">
				<ul id="recommendUl">
					<li id="recommendLand"></li>
					<li id="recommendItem"></li>
					<li id="recommendHotel"></li>
				</ul>
			</div>
			<div id="recommendUser">
				<ul id="recommendUserUl">
					<li id="recommendUserLand"></li>
					<li id="recommendUserItem"></li>
					<li id="recommendUserHotel"></li>
				</ul>
			</div>
			<div id="map-canvas" style="width: 250px; height: 250px" title="지도"></div>
		</div>
	</div>
</body>
</html>