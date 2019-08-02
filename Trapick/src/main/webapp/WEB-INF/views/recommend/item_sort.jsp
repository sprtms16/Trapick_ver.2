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
	src="http://maps.google.com/maps/api/js?key=AIzaSyDGyRrd85ODEF9Dt6D_qPLIpHMEKSq6GZg"></script>
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
      $('#tabRe-1').addClass('selected');
      $('#recommend').hide();
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
      $('#tabRe-1').click(function() {
         $('#tabRe-1').addClass('selected');
         $('#tabRe-3').removeClass('selected');
         $('#recommendUser').show();
         $('#recommend').hide();
      });
      $('#tabRe-3').click(function() {
         $('#tabRe-3').addClass('selected');
         $('#tabRe-1').removeClass('selected');
         $('#recommendUser').hide();
         $('#recommend').show();
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
      
      
      function setMapOnAll(map) {
        for (var i = 0; i < testMarker.length; i++) {
          testMarker[i].setMap(map);
        }
      }
      
      function clearMarkers() {
        setMapOnAll(null);
      }
      
      function deleteMarkers() {
          clearMarkers();
          testMarker = [];
        }
      
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
            	if(!$('input[name=title]').val()){
            		alert("제목을 입력하세요");
            		return false;
            	}else{
	               var te = $('#savet').serialize() + "&"
	                     + $('#courseData').serialize();
	               /* te = encodeURI(te); */
	               $.ajax({
	                  url : '/Rest/recommend/saveLandMark',
	                  type : 'post',
	                  dataType : 'json',
	                  data : te,
	                  success : function(data) {
	                     alert("일정저장성공");
	                  }
	               })
	               return true;
            	}
            })//일정저장 끝
      //경로 추천
      $('#course')
            .on(
                  "click",
                  function() {
                     var te = $('#courseData').serialize();
                     /* te = encodeURI(te); */
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
      $('#allClear').click(function() {	
         $('td:not(.time)').empty();
         deleteMarkers();
      })
   })
</script>
<script type="text/javascript">
var formData = new FormData();
    $(function() {
		$.each($('.select'), function(index, data) {
			var name= data.attr("name");
			var item_name = data.find('input[name=item_name]').val();
			var item = {
					'name' : name,
					'item_name' : itme_name
			}
			formData.append(index, item);
		});
   }) ;
</script>
<title>여행상품</title>
</head>
<body>
	<p id="subject">Travel Scheduler</p>
	<br>
	<br>
	<div id="asdf">
		<select id="city" name="city_name" class="form-control">
			<c:forEach var="cityList" items="${cityList }">
				<option value="${cityList }">${cityList }</option>
			</c:forEach>
		</select>
		<button id="city_search" class="btn btn-link">
			<span
				style="font-weight: bold; font-family: sans-serif; font-size: 1.4em; color: #585858;">
				<i class="fas fa-search"></i> 검색
			</span>
		</button>
	</div>
	<div id="asdf2">
		<button id="itemPriceSort" name="price" class="btn btn-link">
			<span
				style="font-weight: bold; font-family: sans-serif; font-size: 1.4em; color: #585858;">
				<i class="fas fa-tags"></i> 가격순
			</span>
		</button>
		<button id="itemSalesSort" name="price" class="btn btn-link">
			<span
				style="font-weight: bold; font-family: sans-serif; font-size: 1.4em; color: #585858;">
				<i class="fas fa-credit-card"></i> 판매순
			</span>
		</button>
		<button id="itemDistSort" name="price" class="btn btn-link">
			<span
				style="font-weight: bold; font-family: sans-serif; font-size: 1.4em; color: #585858;">
				<i class="fas fa-train"></i> 거리순
			</span>
		</button>
		<button id="hotelPriceSort" name="price" class="btn btn-link">
			<span
				style="font-weight: bold; font-family: sans-serif; font-size: 1.4em; color: #585858;">
				<i class="fas fa-tags"></i> 가격순
			</span>
		</button>
		<button id="hotelReviewSort" name="price" class="btn btn-link">
			<span
				style="font-weight: bold; font-family: sans-serif; font-size: 1.4em; color: #585858;">
				<i class="fas fa-pencil-alt"></i> 리뷰순
			</span>
		</button>
		<button id="hotelDistSort" name="price" class="btn btn-link">
			<span
				style="font-weight: bold; font-family: sans-serif; font-size: 1.4em; color: #585858;">
				<i class="fas fa-train"></i> 거리순
			</span>
		</button>
		<button id="landmarkDistSort" name="price" class="btn btn-link">
			<span
				style="font-weight: bold; font-family: sans-serif; font-size: 1.4em; color: #585858;">
				<i class="fas fa-subway"></i> 거리순
			</span>
		</button>
		<button id="landmarkHitsSort" name="price" class="btn btn-link">
			<span
				style="font-weight: bold; font-family: sans-serif; font-size: 1.4em; color: #585858;">
				<i class="far fa-thumbs-up"></i> 인기순
			</span>
		</button>
		<!--<button id="itemHitsSort" name="price" class="btn btn-info">상품 인기순</button> -->
	</div>
	<div class="container">

		<div id="map-po" class="row fix-gutters">
			<div class="col-md-5">
				<!-- Temp_Scheduler -->
				<form id="courseData" action="/mypage/mypage" method="post">
					<div id="schedule_title">
						<input type="text" name="title" class="form-control"
							id="titleSche" placeholder="일정 제목">
					</div>
					<button id="course" class="btn btn-link">
						<span
							style="font-weight: bold; font-family: sans-serif; font-size: 1.4em; color: #585858;">
							<i class="fas fa-map-signs"></i> 경로 추천
						</span>
					</button>
					<button id="save" class="btn btn-link">
						<span
							style="font-weight: bold; font-family: sans-serif; font-size: 1.4em; color: #585858;">
							<i class="fas fa-save"></i> 일정 저장
						</span>
					</button>
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
				<img src="../resources/image/del.png" id="allClear">
			</div>
			<div class="col-md-3" id="city_List">
				<div id="landMarkList">
					<ul id="landUl">
						<li><a id="land"><i class="fas fa-university"></i> 관광지</a></li>
					</ul>
					<div id="landmarkDiv"></div>
				</div>
			</div>
			<!-- sort button -->
			<div class="col-md-3">
				<div id="tabs">
					<ul>
						<li><a href="#" id="tab-1"><i class="fas fa-map"></i> 상품</a></li>
						<li><a href="#" id="tab-3"><i class="fas fa-building"></i>
								숙박</a></li>
					</ul>
					<div id="tabs-1">
						<div id="itemList"></div>
					</div>
					<div id="tabs-3">
						<div id="hotelList"></div>
					</div>
				</div>
				<div id="map-canvas" style="width: 530px; height: 240px" title="지도"></div>
			</div>
			<div id="tabs2">
				<ul>
					<li><a href="javascript:;" id="tabRe-1"><i
							class="fas fa-users"></i> 사용자 맞춤 추천</a></li>
					<li><a href="javascript:;" id="tabRe-3"><i
							class="fas fa-plane"></i> Trapick 추천</a></li>
				</ul>
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
			</div>

		</div>
	</div>
</body>
</html>