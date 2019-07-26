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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<title>TraPick</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" type="text/css" href="../resources/css/scheduler.css" />

<link rel="stylesheet"
   href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script type="text/javascript"
   src="http://maps.google.com/maps/api/js?key=AIzaSyCafdAtR2qeRHV-G6art-6-guHlmJBL_1s"></script>
   <script type="text/javascript">
   
   function initialize() {
       
       var mapOptions = {
                           zoom: 18, // 지도를 띄웠을 때의 줌 크기
                           mapTypeId: google.maps.MapTypeId.ROADMAP
                       };
        
        
       var map = new google.maps.Map(document.getElementById("map-canvas"), // div의 id과 값이 같아야 함. "map-canvas"
                                   mapOptions);
        
       var size_x = 40; // 마커로 사용할 이미지의 가로 크기
       var size_y = 40; // 마커로 사용할 이미지의 세로 크기
    
       // 마커로 사용할 이미지 주소
       var image = new google.maps.MarkerImage( '주소 여기에 기입!',
                                                   new google.maps.Size(size_x, size_y),
                                                   '',
                                                   '',
                                                   new google.maps.Size(size_x, size_y));
        
       // Geocoding ******
       var address = "파타야";
       var marker = null;
       var geocoder = new google.maps.Geocoder();

       geocoder.geocode( { 'address': address}, function(results, status) {
           if (status == google.maps.GeocoderStatus.OK) {
               map.setCenter(results[0].geometry.location);
               marker = new google.maps.Marker({
                               map: map,
                               icon: image, // 마커로 사용할 이미지(변수)
                               title: '한밭도서관', // 마커에 마우스 포인트를 갖다댔을 때 뜨는 타이틀
                               position: results[0].geometry.location
                           });

               var content = "위치"; // 말풍선 안에 들어갈 내용
            
               var infowindow = new google.maps.InfoWindow({ content: content});
               google.maps.event.addListener(marker, "click", function() {infowindow.open(map,marker);});
           } else {
           }
           
       });     
   }
   google.maps.event.addDomListener(window, 'load', initialize);
   </script>



<script type="text/javascript">

$(function(){
	$('#restList').hide();
	$('#hotelList').hide();
	$('#tab-1').addClass('selected');
	
	$('#tab-2').click(function() {
		$('#restList').show();
		$('#hotelList').hide();
		$('#itemList').hide();
		$('#tab-1').removeClass('selected');
		$('#tab-2').addClass('selected');
		$('#tab-3').removeClass('selected');
		
	});
	
	$('#tab-3').click(function() {
		$('#hotelList').show();
		$('#itemList').hide();
		$('#restList').hide();
		$('#tab-1').removeClass('selected');
		$('#tab-2').removeClass('selected');
		$('#tab-3').addClass('selected');
	});
	
	$('#tab-1').click(function() {
		$('#itemList').show();
		$('#hotelList').hide();
		$('#restList').hide();
		$('#tab-1').addClass('selected');
		$('#tab-2').removeClass('selected');
		$('#tab-3').removeClass('selected');
	});
	
	function hidePopup() {
	      $("#popUp").hide();
	   }
	
	//팝업 함수
    function pop($selector){
        var url= "";    //팝업창 페이지 URL
         var winWidth = 700;
          var winHeight = 600;
          var popupOption= "width="+winWidth+", height="+winHeight;    //팝업창 옵션(optoin)
          var detail = $selector.parent().find('#detail').text();
          var name = $selector.parent().find('#name').text();
          var price = $selector.parent().find('#price').text();
          var image = $selector.parent().find('img').attr('src');
          var str = '<img src = "'+image+'"><br>이름 : '+name+'<br>상세설명 : '+detail+'<br>가격 : '+price;
         window.open(url,"",popupOption).document.write(str);
     }
    
    //삭제 상세보기 함수
    function event(){
        $("table .delete_schedule").click(function(){
              $(this).parent().removeClass('select');
                $(this).parent().empty();
             })
             $('table .detailbt').click(function(){
                pop($(this));
           })
     }
    
    //드래그엔 드롭 함수
    var html = "";

    var dragFun = function(){
       $('.drag').draggable({
            helper: 'clone',
            opacity: 0.5,
            revert: true,
            start : function(e,ui){
               html = "";
             html += '<button type="button" class="delete_schedule btn btn-default liveButton">x</button>';
             html += '<input type ="button" class = "detailbt liveInput" value ="상세보기">';
               html += $(this).html();
            },
            stop : function(e,ui){
               event();
            }
          }); 
    }
      
      $('table td:not(.time)').droppable({
           accept: "div",
           drop: function(event, ui) {
              $(this).addClass('select');
              $(this).empty();
              var te = $(this).attr('name');
              html += '<input name = "position" type="hidden" value ="'+te+'">';
          $(this).append(html);
          html = "";
          
          
         /*  var basePoint = "";
          basePoint = $(this).find("#name").text();
                
          //4개 추천하기
          //landmark
         $.ajax({
             url : '/Rest/recommend/landmarkRecommend.json',
             type : 'post',
             dataType : 'json',
             data :{city_name : '<c:out value="${city_name}"/>', name : basePoint} ,
             success : function(data){
                $('#recommendLand').empty();
                $.each(data, function(index, item){
                	var text = '<div class="row drag"><div class="list_thumb"><img src='
                        +item.image+' class ="img"></div><div class="list_detail" id="landDetail"><div class="name" id="name">'
                        +item.name+'</div><div   class="detail"  id="detail">'
                        +item.detail+'</div>'
                        +'</div><input type = "hidden" name ="land_idx" value ="'+item.land_idx+'"/><input type = "hidden" name = "item_price" value = "0">'
                        +'<input type = "hidden" name ="item_name" value ="'+item.name+'"/>'
                        +'<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
                        +'<input type ="hidden" name ="item_image" value = '+item.image+'>'
                        +'<input type ="hidden" name ="item_detail" value = '+item.detail+'>'
                        +'<input type ="hidden" name ="longitude" value = "'+item.longitude+'"></div>';
                      
                      $('#recommendLand').append(text);
             })
             dragFun();
             }
         });
          
          //item
          $.ajax({
             url : '/Rest/recommend/itemRecommend.json',
             type : 'post',
             dataType : 'json',
             data :{city_name : '<c:out value="${city_name}"/>', name : basePoint} ,
             success : function(data){
                $('#recommendItem').empty();
                $.each(data, function(index, item){
                	var text = '<div class="row drag" ><div class="list_thumb" ><img class="img" src='
                        +item.image+'></div><div class="list_detail"><div id = "name" class="row">'
                        +item.name+'</div><div id ="detail" class="row">'
                        +item.detail+'</div><div  id="price" class="row">'
                        +item.price+'</div>'
                        +'<input type = "hidden" name ="item_name" value ="'+item.name+'"/>'
                        +'<input type = "hidden" name ="item_price" value ="'+item.price+'"/>'
                        +'<input type = "hidden" name ="item_image" value ="'+item.image+'"/>'
                        +'<input type = "hidden" name ="item_detail" value ="'+item.detail+'"/>'
                        +'<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
                        +'<input type ="hidden" name ="longitude" value = "'+item.longitude+'"></div>';
                      
                      $('#recommendItem').append(text);
             })
             dragFun();
             }
         });
          
          //rest
          $.ajax({
             url : '/Rest/recommend/restRecommend.json',
             type : 'post',
             dataType : 'json',
             data :{city_name : '<c:out value="${city_name}"/>', name : basePoint} ,
             success : function(data){
                $('#recommendRest').empty();
                $.each(data, function(index, item){
                	var text = '<div class="row drag" ><div class="list_thumb" ><img class="img" src='
                        +item.image+'></div><div class="list_detail"><div id = "name" class="row">'
                        +item.name+'</div><div id ="detail" class="row">'
                        +item.detail+'</div><div  id="price" class="row">'
                        +item.price+'</div>'
                        +'<input type = "hidden" name ="item_name" value ="'+item.name+'"/>'
                        +'<input type = "hidden" name ="item_price" value ="'+item.price+'"/>'
                        +'<input type = "hidden" name ="item_image" value ="'+item.image+'"/>'
                        +'<input type = "hidden" name ="item_detail" value ="'+item.detail+'"/>'
                        +'<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
                        +'<input type ="hidden" name ="longitude" value = "'+item.longitude+'"></div>';
                      
                      $('#recommendRest').append(text);
             })
             dragFun();
             }
         });
          
          //Hotel
          $.ajax({
             url : '/Rest/recommend/hotelRecommend.json',
             type : 'post',
             dataType : 'json',
             data :{city_name : '<c:out value="${city_name}"/>', name : basePoint} ,
             success : function(data){
                $('#recommendHotel').empty();
                $.each(data, function(index, item){
                	var text = '<div class="row drag" ><div class="list_thumb" ><img class="img" src='
                        +item.image+'></div><div class="list_detail"><div id = "name" class="row">'
                        +item.name+'</div><div id ="detail" class="row">'
                        +item.detail+'</div><div  id="price" class="row">'
                        +item.price+'</div>'
                        +'<input type = "hidden" name ="item_name" value ="'+item.name+'"/>'
                        +'<input type = "hidden" name ="item_price" value ="'+item.price+'"/>'
                        +'<input type = "hidden" name ="item_image" value ="'+item.image+'"/>'
                        +'<input type = "hidden" name ="item_detail" value ="'+item.detail+'"/>'
                        +'<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
                        +'<input type ="hidden" name ="longitude" value = "'+item.longitude+'"></div>';
                      
                      $('#recommendHotel').append(text);
             })
             dragFun();
             }
         }); 
                      
                      
         //거리 순 정렬
          //Landmark
          $('#landmarkDistSort').on('click',function(){
           $.ajax({
                   url : '/Rest/recommend/landmarkDistSort.json',
                   type : 'post',
                   dataType : 'json',
                   data :{city_name : '<c:out value="${city_name}"/>', name : basePoint} ,
                   success : function(data){
                      $('#landmarkDiv').empty();
                       $.each(data, function(index, item){
                    	   var text = '<div class="row drag"><div class="list_thumb"><img src='
                               +item.image+' class ="img"></div><div class="list_detail" id="landDetail"><div class="name" id="name">'
                               +item.name+'</div><div   class="detail"  id="detail">'
                               +item.detail+'</div>'
                               +'</div><input type = "hidden" name ="land_idx" value ="'+item.land_idx+'"/><input type = "hidden" name = "item_price" value = "0">'
                               +'<input type = "hidden" name ="item_name" value ="'+item.name+'"/>'
                               +'<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
                               +'<input type ="hidden" name ="item_image" value = '+item.image+'>'
                               +'<input type ="hidden" name ="item_detail" value = '+item.detail+'>'
                               +'<input type ="hidden" name ="longitude" value = "'+item.longitude+'"></div>';
                          
                          $('#landmarkDiv').append(text);
                        }) 
                        dragFun();
                   }
           })
        })  
        
        //Hotel
       $('#hotelDistSort').on('click', function() {
          $.ajax({
                  url : '/Rest/recommend/hotelDistSort.json',
                  type : 'post',
                  dataType : 'json',
                  data :{city_name : '<c:out value="${city_name}"/>', name : basePoint} ,
                  success : function(data){
                     
                     $('#hotelList').empty();
                      $.each(data, function(index, item){
                    	  var text = '<div class="row drag" ><div class="list_thumb" ><img class="img" src='
                              +item.image+'></div><div class="list_detail"><div id = "name" class="row">'
                              +item.name+'</div><div id ="detail" class="row">'
                              +item.detail+'</div><div  id="price" class="row">'
                              +item.price+'</div>'
                              +'<input type = "hidden" name ="item_name" value ="'+item.name+'"/>'
                              +'<input type = "hidden" name ="item_price" value ="'+item.price+'"/>'
                              +'<input type = "hidden" name ="item_image" value ="'+item.image+'"/>'
                              +'<input type = "hidden" name ="item_detail" value ="'+item.detail+'"/>'
                              +'<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
                              +'<input type ="hidden" name ="longitude" value = "'+item.longitude+'"></div>';
                         $('#hotelList').append(text);
                      }) 
                       dragFun();
                  }
            });
       })
       
       //음식
        $('#restDistSort').on('click', function() {
          $.ajax({
                  url : '/Rest/recommend/restDistSort.json',
                  type : 'post',
                  dataType : 'json',
                  data :{city_name : '<c:out value="${city_name}"/>', name : basePoint} ,
                  success : function(data){
                     
                     $('#restList').empty();
                       $.each(data, function(index, item){
                    	   var text = '<div class="row drag" ><div class="list_thumb" ><img class="img" src='
                               +item.image+'></div><div class="list_detail"><div id = "name" class="row">'
                               +item.name+'</div><div id ="detail" class="row">'
                               +item.detail+'</div><div  id="price" class="row">'
                               +item.price+'</div>'
                               +'<input type = "hidden" name ="item_name" value ="'+item.name+'"/>'
                               +'<input type = "hidden" name ="item_price" value ="'+item.price+'"/>'
                               +'<input type = "hidden" name ="item_image" value ="'+item.image+'"/>'
                               +'<input type = "hidden" name ="item_detail" value ="'+item.detail+'"/>'
                               +'<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
                               +'<input type ="hidden" name ="longitude" value = "'+item.longitude+'"></div>';
                          $('#restList').append(text);
                       }) 
                       dragFun();
                  }
            });
       })
    
          //아이템
       $('#itemDistSort').on('click', function() {
          $.ajax({
                url : '/Rest/recommend/itemDistSort.json',
                type: 'post',
                dataType:'json',
                data :{city_name : '<c:out value="${city_name}"/>', name : basePoint} ,
                success : function(data){
                   
                   $('#itemList').empty();
                   $.each(data, function(index, item){
                	   var text = '<div class="row drag" ><div class="list_thumb" ><img class="img" src='
                           +item.image+'></div><div class="list_detail"><div id = "name" class="row">'
                           +item.name+'</div><div id ="detail" class="row">'
                           +item.detail+'</div><div  id="price" class="row">'
                           +item.price+'</div>'
                           +'<input type = "hidden" name ="item_name" value ="'+item.name+'"/>'
                           +'<input type = "hidden" name ="item_price" value ="'+item.price+'"/>'
                           +'<input type = "hidden" name ="item_image" value ="'+item.image+'"/>'
                           +'<input type = "hidden" name ="item_detail" value ="'+item.detail+'"/>'
                           +'<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
                           +'<input type ="hidden" name ="longitude" value = "'+item.longitude+'"></div>';
                      $('#itemList').append(text);
                   })
                   dragFun();
                }
             })
       }); */
           }//end drag
       }); //드래그앤 드롭 함수 끝
      
      
    //일정 저장
      $('#save').on("click", function(){
         var te = $('#savet').serialize();
         te = decodeURI(te);
         alert(te);
         $.ajax({
              url : '/Rest/recommend/saveLandMark',
              type: 'post',
              dataType:'json',
              data :te ,
              success : function(data){
              	alert("일정저장성공");
              }
           })  
        
      })//일정저장 끝
      
      //경로 추천
        $('#course').on("click",function(){
         var te = $('#savet').serialize();
         /* te = decodeURIComponent(te); */
         te = decodeURI(te);
         alert(te);
          $.ajax({
              url : '/Rest/recommend/course',
              type: 'post',
              dataType:'json',
              data :te ,
              success : function(data){
                 alert("경로 추천 성공");
                 $.each(data, function(index, item){
              	  if(item.item_price == 0){
              		  var te = $('.select:eq('+index+')').attr('name');
              		   var text = '<button type="button" class="delete_schedule btn btn-default liveButton">x</button><input type ="button" class = "detailbt liveInput" value ="상세보기"><div class="list_thumb"><img src='
                            +item.image+' class ="img"></div><div class="list_detail"  id="landDetail"><div class="name" id="name">'
                            +item.item_name+'</div><div   class="detail"  id="detail">'
                            +item.item_detail+'</div>'
                            +'</div><input type = "hidden" name ="land_idx" value ="'+item.land_idx+'"/><input type = "hidden" name = "item_price" value = "0">'
                            +'<input type = "hidden" name ="item_name" value ="'+item.item_name+'"/>'
                            +'<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
                            +'<input type ="hidden" name ="item_image" value = '+item.image+'>'
                            +'<input type ="hidden" name ="item_detail" value = '+item.item_detail+'>'
                            +'<input type ="hidden" name ="longitude" value = "'+item.longitude+'">'
                            +'<input name = "position" type="hidden" value ="'+te+'">';
                            
                            
                            $('.select:eq('+index+')').empty().append(text); 
                            event();
              	  }else{
              		  var te = $('.select:eq('+index+')').attr('name');
                            
                                
                                var text = '<button type="button" class="delete_schedule btn btn-default liveButton">x</button><input type ="button" class = "detailbt liveInput" value ="상세보기"><div class="list_thumb"><img src='
                                    +item.image+' class ="img"></div><div class="list_detail"  id="landDetail"><div class="name" id="name">'
                                    +item.item_name+'</div><div   class="detail"  id="detail">'
                                    +item.item_detail+'</div><div  id="price" class="row">'
                                    +item.item_price+'</div>'
                                    +'<input type = "hidden" name ="item_name" value ="'+item.item_name+'"/>'
                                    +'<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
                                    +'<input type = "hidden" name ="item_price" value ="'+item.item_price+'"/>'
                                    +'<input type ="hidden" name ="item_image" value = '+item.image+'>'
                                    +'<input type ="hidden" name ="item_detail" value = '+item.item_detail+'>'
                                    +'<input type ="hidden" name ="longitude" value = "'+item.longitude+'">'
                                    +'<input name = "position" type="hidden" value ="'+te+'">';
              		  $('.select:eq('+index+')').empty().append(text); 
              		  event();
              	  }
                 })
              },
              error:function(request,status,error){
                  alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
                 }
           }) 
           return false;
      })  //경로추천 끝
	
	 //첫화면 ajax
  $.ajax({
        url : '/Rest/recommend/landMarkAjax.json',
        type: 'post',
        dataType:'json',
        data :{city_name :'<c:out value="${city_name}"/>'} ,
        success : function(data){
           
           $('#landmarkDiv').empty();
           $.each(data, function(index, item){
              var text = '<div class="row drag"><div class="list_thumb"><img src='
                   +item.image+' class ="img"></div><div class="list_detail" id="landDetail"><div class="name" id="name">'
                   +item.name+'</div><div   class="detail"  id="detail">'
                   +item.detail+'</div>'
                   +'</div><input type = "hidden" name ="land_idx" value ="'+item.land_idx+'"/><input type = "hidden" name = "item_price" value = "0">'
                   +'<input type = "hidden" name ="item_name" value ="'+item.name+'"/>'
                   +'<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
                   +'<input type ="hidden" name ="item_image" value = '+item.image+'>'
                   +'<input type ="hidden" name ="item_detail" value = '+item.detail+'>'
                   +'<input type ="hidden" name ="longitude" value = "'+item.longitude+'"></div>';

              $('#landmarkDiv').append(text);
        })

           dragFun();
        }
     })
     
     $.ajax({
         url : 'itemAjax',
         type: 'post',
         dataType:'json',
         data :{city_name : '<c:out value="${city_name}"/>'} ,
         success : function(data){
            
            $('#itemList').empty();
            $.each(data, function(index, item){
    
               var text = '<div class="row drag" ><div class="list_thumb" ><img class="img" src='
                    +item.image+'></div><div class="list_detail"><div id = "name" class="row">'
                    +item.name+'</div><div id ="detail" class="row">'
                    +item.detail+'</div><div  id="price" class="row">'
                    +item.price+'</div>'
                    +'<input type = "hidden" name ="item_name" value ="'+item.name+'"/>'
                    +'<input type = "hidden" name ="item_price" value ="'+item.price+'"/>'
                    +'<input type = "hidden" name ="item_image" value ="'+item.image+'"/>'
                    +'<input type = "hidden" name ="item_detail" value ="'+item.detail+'"/>'
                    +'<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
                    +'<input type ="hidden" name ="longitude" value = "'+item.longitude+'"></div>';
                    
                $('#itemList').append(text);
            })
           dragFun();
         }
      })
      //식당 ajax
       $.ajax({
           url : 'restAjax',
           type : 'post',
           dataType : 'json',
           data :{city_name : '<c:out value="${city_name}"/>'} ,
           success : function(data){
              
              $('#restList').empty();
                $.each(data, function(index, item){
                
                	var text = '<div class="row drag" ><div class="list_thumb" ><img class="img" src='
                        +item.image+'></div><div class="list_detail"><div id = "name" class="row">'
                        +item.name+'</div><div id ="detail" class="row">'
                        +item.detail+'</div><div  id="price" class="row">'
                        +item.price+'</div>'
                        +'<input type = "hidden" name ="item_name" value ="'+item.name+'"/>'
                        +'<input type = "hidden" name ="item_price" value ="'+item.price+'"/>'
                        +'<input type = "hidden" name ="item_image" value ="'+item.image+'"/>'
                        +'<input type = "hidden" name ="item_detail" value ="'+item.detail+'"/>'
                        +'<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
                        +'<input type ="hidden" name ="longitude" value = "'+item.longitude+'"></div>';
                        
                    $('#restList').append(text);
                }) 
                dragFun();
           }
     })
     //숙박 ajax
    $.ajax({
       url : 'hotelAjax',
       type : 'post',
       dataType : 'json',
       data :{city_name : '<c:out value="${city_name}"/>'} ,
       success : function(data){
           
           $('#hotelList').empty();
           
             $.each(data, function(index, item){
    
            	 var text = '<div class="row drag" ><div class="list_thumb" ><img class="img" src='
                     +item.image+'></div><div class="list_detail"><div id = "name" class="row">'
                     +item.name+'</div><div id ="detail" class="row">'
                     +item.detail+'</div><div  id="price" class="row">'
                     +item.price+'</div>'
                     +'<input type = "hidden" name ="item_name" value ="'+item.name+'"/>'
                     +'<input type = "hidden" name ="item_price" value ="'+item.price+'"/>'
                     +'<input type = "hidden" name ="item_image" value ="'+item.image+'"/>'
                     +'<input type = "hidden" name ="item_detail" value ="'+item.detail+'"/>'
                     +'<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
                     +'<input type ="hidden" name ="longitude" value = "'+item.longitude+'"></div>';
                     
                 $('#hotelList').append(text);
             }) 
             dragFun();
        }
     })
      
      //도시선택시 ajax 구동
      $('#city_search').on("click",function(){
         //랜드마크 ajax
         $.ajax({
            url : '/Rest/recommend/landMarkAjax.json',
            type: 'post',
            dataType:'json',
            data :{city_name : $('#city option:selected').val()} ,
            success : function(data){
               
               $('#landmarkDiv').empty();
               
               $.each(data, function(index, item){
          
            	   var text = '<div class="row drag"><div class="list_thumb"><img src='
                       +item.image+' class ="img"></div><div class="list_detail" id="landDetail"><div class="name" id="name">'
                       +item.name+'</div><div   class="detail"  id="detail">'
                       +item.detail+'</div>'
                       +'</div><input type = "hidden" name ="land_idx" value ="'+item.land_idx+'"/><input type = "hidden" name = "item_price" value = "0">'
                       +'<input type = "hidden" name ="item_name" value ="'+item.name+'"/>'
                       +'<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
                       +'<input type ="hidden" name ="item_image" value = '+item.image+'>'
                       +'<input type ="hidden" name ="item_detail" value = '+item.detail+'>'
                       +'<input type ="hidden" name ="longitude" value = "'+item.longitude+'"></div>';

                  $('#landmarkDiv').append(text);
               })
               dragFun();
            }
         })
         //아이템 ajax
         $.ajax({
            url : '/Rest/recommend/itemAjax',
            type: 'post',
            dataType:'json',
            data :{city_name : $('#city option:selected').val()} ,
            success : function(data){
               
               $('#itemList').empty();
               
               $.each(data, function(index, item){
                  
            	   var text = '<div class="row drag" ><div class="list_thumb" ><img class="img" src='
                       +item.image+'></div><div class="list_detail"><div id = "name" class="row">'
                       +item.name+'</div><div id ="detail" class="row">'
                       +item.detail+'</div><div  id="price" class="row">'
                       +item.price+'</div>'
                       +'<input type = "hidden" name ="item_name" value ="'+item.name+'"/>'
                       +'<input type = "hidden" name ="item_price" value ="'+item.price+'"/>'
                       +'<input type = "hidden" name ="item_image" value ="'+item.image+'"/>'
                       +'<input type = "hidden" name ="item_detail" value ="'+item.detail+'"/>'
                       +'<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
                       +'<input type ="hidden" name ="longitude" value = "'+item.longitude+'"></div>';
                       
                  $('#itemList').append(text);
               })
               dragFun();
            }
         })
         //식당 ajax
          $.ajax({
              url : '/Rest/recommend/restAjax',
              type : 'post',
              dataType : 'json',
              data :{city_name : $('#city option:selected').val()} ,
              success : function(data){
                 
                 $('#restList').empty();
                 
                   $.each(data, function(index, item){
                      
                	   var text = '<div class="row drag" ><div class="list_thumb" ><img class="img" src='
                           +item.image+'></div><div class="list_detail"><div id = "name" class="row">'
                           +item.name+'</div><div id ="detail" class="row">'
                           +item.detail+'</div><div  id="price" class="row">'
                           +item.price+'</div>'
                           +'<input type = "hidden" name ="item_name" value ="'+item.name+'"/>'
                           +'<input type = "hidden" name ="item_price" value ="'+item.price+'"/>'
                           +'<input type = "hidden" name ="item_image" value ="'+item.image+'"/>'
                           +'<input type = "hidden" name ="item_detail" value ="'+item.detail+'"/>'
                           +'<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
                           +'<input type ="hidden" name ="longitude" value = "'+item.longitude+'"></div>';
                           
                      $('#restList').append(text);
                   }) 
                   dragFun();
              }
        })
        //숙박 ajax
       $.ajax({
          url : '/Rest/recommend/hotelAjax',
          type : 'post',
          dataType : 'json',
          data :{city_name : $('#city option:selected').val()} ,
          success : function(data){
              
              $('#hotelList').empty();
              
                $.each(data, function(index, item){
                   
                	var text = '<div class="row drag" ><div class="list_thumb" ><img class="img" src='
                        +item.image+'></div><div class="list_detail"><div id = "name" class="row">'
                        +item.name+'</div><div id ="detail" class="row">'
                        +item.detail+'</div><div  id="price" class="row">'
                        +item.price+'</div>'
                        +'<input type = "hidden" name ="item_name" value ="'+item.name+'"/>'
                        +'<input type = "hidden" name ="item_price" value ="'+item.price+'"/>'
                        +'<input type = "hidden" name ="item_image" value ="'+item.image+'"/>'
                        +'<input type = "hidden" name ="item_detail" value ="'+item.detail+'"/>'
                        +'<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
                        +'<input type ="hidden" name ="longitude" value = "'+item.longitude+'"></div>';
                        
                   $('#hotelList').append(text);
                }) 
                dragFun();
           }
        })
      })//도시선택 ajax 끝
      
      
      //정렬 
      $('#itemPriceSort').on('click', function() {
         $.ajax({
               url : '/Rest/recommend/itemPriceSort',
               type: 'post',
               dataType:'json',
               data :{city_name : $('#city option:selected').val()} ,
               success : function(data){
                  
                  $('#itemList').empty();
                  $.each(data, function(index, item){
                	  var text = '<div class="row drag" ><div class="list_thumb" ><img class="img" src='
                          +item.image+'></div><div class="list_detail"><div id = "name" class="row">'
                          +item.name+'</div><div id ="detail" class="row">'
                          +item.detail+'</div><div  id="price" class="row">'
                          +item.price+'</div>'
                          +'<input type = "hidden" name ="item_name" value ="'+item.name+'"/>'
                          +'<input type = "hidden" name ="item_price" value ="'+item.price+'"/>'
                          +'<input type = "hidden" name ="item_image" value ="'+item.image+'"/>'
                          +'<input type = "hidden" name ="item_detail" value ="'+item.detail+'"/>'
                          +'<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
                          +'<input type ="hidden" name ="longitude" value = "'+item.longitude+'"></div>';
                          
                     $('#itemList').append(text);
                  })
                  dragFun();
               }
            })
      });
      //판매량 순
      $('#itemSalesSort').on('click', function() {
         $.ajax({
               url : '/Rest/recommend/itemSalesSort',
               type: 'post',
               dataType:'json',
               data :{city_name : $('#city option:selected').val()} ,
               success : function(data){
                  
                  $('#itemList').empty();
                  $.each(data, function(index, item){
                	  var text = '<div class="row drag" ><div class="list_thumb" ><img class="img" src='
                          +item.image+'></div><div class="list_detail"><div id = "name" class="row">'
                          +item.name+'</div><div id ="detail" class="row">'
                          +item.detail+'</div><div  id="price" class="row">'
                          +item.price+'</div>'
                          +'<input type = "hidden" name ="item_name" value ="'+item.name+'"/>'
                          +'<input type = "hidden" name ="item_price" value ="'+item.price+'"/>'
                          +'<input type = "hidden" name ="item_image" value ="'+item.image+'"/>'
                          +'<input type = "hidden" name ="item_detail" value ="'+item.detail+'"/>'
                          +'<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
                          +'<input type ="hidden" name ="longitude" value = "'+item.longitude+'"></div>';
                          
                     $('#itemList').append(text);
                  })
                  dragFun();
               }
            })
      });
      
      //인기순
      $('#itemHitsSort').on('click', function() {
         $.ajax({
               url : '/Rest/recommend/itemHitsSort',
               type: 'post',
               dataType:'json',
               data :{city_name : $('#city option:selected').val()} ,
               success : function(data){
                  
                  $('#itemList').empty();
                  $.each(data, function(index, item){
                	  var text = '<div class="row drag" ><div class="list_thumb" ><img class="img" src='
                          +item.image+'></div><div class="list_detail"><div id = "name" class="row">'
                          +item.name+'</div><div id ="detail" class="row">'
                          +item.detail+'</div><div  id="price" class="row">'
                          +item.price+'</div>'
                          +'<input type = "hidden" name ="item_name" value ="'+item.name+'"/>'
                          +'<input type = "hidden" name ="item_price" value ="'+item.price+'"/>'
                          +'<input type = "hidden" name ="item_image" value ="'+item.image+'"/>'
                          +'<input type = "hidden" name ="item_detail" value ="'+item.detail+'"/>'
                          +'<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
                          +'<input type ="hidden" name ="longitude" value = "'+item.longitude+'"></div>';
                          
                     $('#itemList').append(text);
                  })
                  dragFun();
               }
            })
      });
      
         //인기순
         $('#restHitsSort').on('click', function() {
            $.ajax({
                    url : '/Rest/recommend/restHitsSort',
                    type : 'post',
                    dataType : 'json',
                    data :{city_name : '<c:out value="${city_name}"/>'} ,
                    success : function(data){
                       
                       $('#restList').empty();
                         $.each(data, function(index, item){
                        	 var text = '<div class="row drag" ><div class="list_thumb" ><img class="img" src='
                                 +item.image+'></div><div class="list_detail"><div id = "name" class="row">'
                                 +item.name+'</div><div id ="detail" class="row">'
                                 +item.detail+'</div><div  id="price" class="row">'
                                 +item.price+'</div>'
                                 +'<input type = "hidden" name ="item_name" value ="'+item.name+'"/>'
                                 +'<input type = "hidden" name ="item_price" value ="'+item.price+'"/>'
                                 +'<input type = "hidden" name ="item_image" value ="'+item.image+'"/>'
                                 +'<input type = "hidden" name ="item_detail" value ="'+item.detail+'"/>'
                                 +'<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
                                 +'<input type ="hidden" name ="longitude" value = "'+item.longitude+'"></div>';
                                 
                           $('#restList').append(text);
                         }) 
                         dragFun();
                    }
              });
         })
      
         //호텔
         //가격순
          $('#hotelPriceSort').on('click', function() {
            $.ajax({
                    url : '/Rest/recommend/hotelPriceSort',
                    type : 'post',
                    dataType : 'json',
                    data :{city_name : '<c:out value="${city_name}"/>'} ,
                    success : function(data){
                       
                       $('#hotelList').empty();
                        $.each(data, function(index, item){
                        	var text = '<div class="row drag" ><div class="list_thumb" ><img class="img" src='
                                +item.image+'></div><div class="list_detail"><div id = "name" class="row">'
                                +item.name+'</div><div id ="detail" class="row">'
                                +item.detail+'</div><div  id="price" class="row">'
                                +item.price+'</div>'
                                +'<input type = "hidden" name ="item_name" value ="'+item.name+'"/>'
                                +'<input type = "hidden" name ="item_price" value ="'+item.price+'"/>'
                                +'<input type = "hidden" name ="item_image" value ="'+item.image+'"/>'
                                +'<input type = "hidden" name ="item_detail" value ="'+item.detail+'"/>'
                                +'<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
                                +'<input type ="hidden" name ="longitude" value = "'+item.longitude+'"></div>';
                                
                           $('#hotelList').append(text);
                        }) 
                         dragFun();
                    }
              });
         })
         
         //Review
          $('#hotelReviewSort').on('click', function() {
            $.ajax({
                    url : '/Rest/recommend/hotelReviewSort',
                    type : 'post',
                    dataType : 'json',
                    data :{city_name : '<c:out value="${city_name}"/>'} ,
                    success : function(data){
                       
                       $('#hotelList').empty();
                        $.each(data, function(index, item){
                        	var text = '<div class="row drag" ><div class="list_thumb" ><img class="img" src='
                                +item.image+'></div><div class="list_detail"><div id = "name" class="row">'
                                +item.name+'</div><div id ="detail" class="row">'
                                +item.detail+'</div><div  id="price" class="row">'
                                +item.price+'</div>'
                                +'<input type = "hidden" name ="item_name" value ="'+item.name+'"/>'
                                +'<input type = "hidden" name ="item_price" value ="'+item.price+'"/>'
                                +'<input type = "hidden" name ="item_image" value ="'+item.image+'"/>'
                                +'<input type = "hidden" name ="item_detail" value ="'+item.detail+'"/>'
                                +'<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
                                +'<input type ="hidden" name ="longitude" value = "'+item.longitude+'"></div>';
                                
                           $('#hotelList').append(text);
                        }) 
                         dragFun();
                    }
              });
         })
         //인기순
          $('#landmarkHitsSort').on('click', function() {
            $.ajax({
                    url : '/Rest/recommend/landmarkHitsSort.json',
                    type : 'post',
                    dataType : 'json',
                    data :{city_name : '<c:out value="${city_name}"/>'} ,
                    success : function(data){
                       
                       $('#landmarkDiv').empty();
                        $.each(data, function(index, item){
                        	var text = '<div class="row drag"><div class="list_thumb"><img src='
                                +item.image+' class ="img"></div><div class="list_detail" id="landDetail"><div class="name" id="name">'
                                +item.name+'</div><div   class="detail"  id="detail">'
                                +item.detail+'</div>'
                                +'</div><input type = "hidden" name ="land_idx" value ="'+item.land_idx+'"/><input type = "hidden" name = "item_price" value = "0">'
                                +'<input type = "hidden" name ="item_name" value ="'+item.name+'"/>'
                                +'<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
                                +'<input type ="hidden" name ="item_image" value = '+item.image+'>'
                                +'<input type ="hidden" name ="item_detail" value = '+item.detail+'>'
                                +'<input type ="hidden" name ="longitude" value = "'+item.longitude+'"></div>';

                           $('#landmarkDiv').append(text);
                         }) 
                         dragFun();
                    }
              });
         })
         //정렬 끝
	
	   
})

function wrapWindowByMask(){
    //화면의 높이와 너비를 구한다.
    var maskHeight = $(document).height();  
    var maskWidth = $(window).width();  
   
    //마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
    $('#mask').css({'width':maskWidth,'height':maskHeight});  
   
    //애니메이션 효과
    $('#mask').fadeIn(1000);      
    $('#mask').fadeTo("slow",0.8);    
}

function wrapWindowByloading(){
    //화면의 높이와 너비를 구한다.
    var maskHeight = $(document).height();  
    var maskWidth = $(window).width();  
   
    //마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
    $('#loadingImage').css({'width':maskWidth,'height':maskHeight});  
}


$(document).ready(function(){
     $('#Progress_Loading').hide(); //첫 시작시 로딩바를 숨겨준다.
     $('#mask').hide();
})
.ajaxStart(function(){
   $('#Progress_Loading').show(); //ajax실행시 로딩바를 보여준다.
   wrapWindowByMask();
})
.ajaxStop(function(){
   $('#Progress_Loading').hide(); //ajax종료시 로딩바를 숨겨준다.
   $('#mask').hide();
});


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
   #loadingImage{
     position:absolute;  
  left:0;
  top:0;
  z-index:300;  
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
<title>여행상품</title>
</head>
<body>
<div id="mask"></div>
    <div>
      <progress value="0" max="100" id="jb"></progress>
   </div>
<div id = "Progress_Loading"><!-- 로딩바 -->
<img src="../resources/image/Progress_Loading.gif" id = "progress"/>
</div>
<div id="loadingImage">
   <img src="../resources/image/loading.jpg" id="im"/>
</div>
   <p id="subject">Travel Scheduler</p>
   <div  id="asdf">
      <select id="city" name="city_name">
         <c:forEach var="cityList" items="${cityList }">
            <option value="${cityList }">${cityList }</option>
         </c:forEach>
      </select>
      <button id="city_search">검색</button>
   </div>
   <div class="container">

      <div class="row">
         <div class="col-6">
            <!-- Temp_Scheduler -->
            <form id="savet" action="/Rest/recommend/saveLandMarkt"
               method="post">
               <div>
                   <table id="mySheduleTable" border=2>
                     <tr>
                        <th>일정</th>
                        <th>06:00 ~ 09:00</th>
						<th>09:00 ~ 12:00</th>
						<th>12:00 ~ 15:00</th>
						<th>15:00 ~ 18:00</th>
						<th>18:00 ~ 21:00</th>
						<th>21:00 ~ 24:00</th>
                     </tr>
					 <c:forEach begin="1" end="${day }" varStatus="index">
						 <tr>
							<td>${index.count} 일차</td>
							<td name="${index.count }-1"></td>
							<td name="${index.count }-2"></td>
							<td name="${index.count }-3"></td>
							<td name="${index.count }-4"></td>
							<td name="${index.count }-5"></td>
							<td name="${index.count }-6"></td>
						 </tr>
					 </c:forEach>
                  </table>

                  <br> <label>일정제목</label> <input type="text" name="title">
                  <button id="course" class="btn btn-secondary btn-lg">경로
                     추천</button>
                  <button id="save" class="btn btn-secondary btn-lg">일정 저장</button>
                  <input type="hidden" name="schd_idx" value="${schd_idx }">
                  <input type="hidden" name="start_time" value="${start_time }">
                  <input type="hidden" name="end_time" value="${end_time }">
            </form>
         </div>

         <div class="col-3" id="city_List">
            <div id="landMarkList">
               <ul>
                  <li><a id="land">관광지</a></li>
               </ul>
               <div id="landmarkDiv">
               </div>
            </div>
         </div> 
         

               <div id="asdasfdfasdfadsf">
                  <div id="recommendLand">
                  </div>
                  <div id="recommendItem">
                  </div>
                  <div id="recommendRest">
                  </div>
                  <div id="recommendHotel">
                  </div>                  
               </div>
               
         <!-- sort button -->
      <div  id="asdf2">
         <button id = "itemPriceSort" name="price" class="btn btn-primary">상품 가격순</button>
        <button id = "itemSalesSort" name="price" class="btn btn-primary">상품 판매순</button>
         <button id = "itemHitsSort" name="price" class="btn btn-primary">상품 인기순</button>
         <button id = "itemDistSort" name="price" class="btn btn-primary">상품 거리순</button>
         <button id = "restDistSort" name="price" class="btn btn-primary">음식 거리순</button>
         <button id = "restHitsSort" name="price" class="btn btn-primary">음식 인기순</button>
         <button id = "hotelPriceSort" name="price" class="btn btn-primary">숙박 가격순</button>
         <button id = "hotelReviewSort" name="price" class="btn btn-primary">숙박 리뷰순</button>
         <button id = "hotelDistSort" name="price" class="btn btn-primary">숙박 거리순</button>
         <button id = "landmarkDistSort" name="price" class="btn btn-primary">명소 거리순</button>
         <button id = "landmarkHitsSort" name="price" class="btn btn-primary">명소 인기순</button>
        </div> 
        


            <div id="tabs">
               <ul>
                  <li><a href="#" id="tab-1">상품</a></li>
                  <li><a href="#" id="tab-2">음식</a></li>
                  <li><a href="#" id="tab-3">숙박</a></li>
               </ul>
               <div id="tabs-1">
                  <div id="itemList">
                  </div>
               </div>
               <div id="tabs-2">
                  <div id="restList">
                  </div>
               </div>
               <div id="tabs-3">
                  <div id="hotelList">
                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>
   

   <form id = "saveSchedule" action="/recommend/saveSchedule" method="post">
      <input type = "hidden" name = "title" value = "">
      <input type = "hidden" name = "schd_idx" value = ${schd_idx }>
   </form>
    <div class="row">
      <div id="map-canvas" style="width: 40%; height: 340px" title="지도"
         id="Map"></div>
   </div>
</body>
</html>