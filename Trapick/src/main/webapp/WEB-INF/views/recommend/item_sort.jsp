<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<meta charset="UTF-8">
<title>TraPick</title>
<link rel="stylesheet" type="text/css" href="../resources/css/scheduler.css" />
<link rel="stylesheet"
   href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet"
   href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript"
   src="http://maps.google.com/maps/api/js?key=AIzaSyDb_uxF2qi4zB5K51p-m6WDNrnTeTchSOw"></script>
   <script type="text/javascript">
 //Category Click Event
	$(function() {
	      $('#restList').hide();
	      $('#hotelList').hide();
	      $('#tab-1').addClass('selected');
	   });

	   $(function() {

	      $('#tab-2').click(function() {
	         $('#restList').show();
	         $('#hotelList').hide();
	         $('#itemList').hide();
	         $('#tab-1').removeClass('selected');
	         $('#tab-2').addClass('selected');
	         $('#tab-3').removeClass('selected');

	      });
	   });

	   $(function() {

	      $('#tab-3').click(function() {
	         $('#hotelList').show();
	         $('#itemList').hide();
	         $('#restList').hide();
	         $('#tab-1').removeClass('selected');
	         $('#tab-2').removeClass('selected');
	         $('#tab-3').addClass('selected');
	      });
	   });

	   $(function() {

	      $('#tab-1').click(function() {
	         $('#itemList').show();
	         $('#hotelList').hide();
	         $('#restList').hide();
	         $('#tab-1').addClass('selected');
	         $('#tab-2').removeClass('selected');
	         $('#tab-3').removeClass('selected');
	      });
	   });

   </script>
   
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
	            alert("Geocode was not successful for the following reason: " + status);
	        }
	        
	    });     
	}
	google.maps.event.addDomListener(window, 'load', initialize);
   </script>
<script>



   function hidePopup() {
      $("#popUp").hide();
   }
   
  
</script>
<script type="text/javascript">
   //Item 정렬
   //가격 순
   $(function() {
	   $('#itemPriceSort').on('click', function() {
		   $.ajax({
	            url : 'itemPriceSort',
	            type: 'post',
	            dataType:'json',
	            data :{city_name : $('#city option:selected').val()} ,
	            success : function(data){
	               
	               $('#itemList').empty();
	               $.each(data, function(index, item){
	                     var text = '<div class="row drag" ><div class="list_thumb" ><img class="img" src='
	                         +item.img+'></div><div class="list_detail"><div id = "name" class="row">'
	                         +item.name+'</div><div  style = "display : none"  id ="detail" class="row">'
	                         +item.detail+'<div  id="price" class="row">'
	                         +item.price+'</div></div></div>';
	                  $('#itemList').append(text);
	               })
	               dragFun();
	            }
	         })
		});
	   //판매량 순
	   $('#itemSalesSort').on('click', function() {
		   alert("itemSalesSort");
		   $.ajax({
	            url : 'itemSalesSort',
	            type: 'post',
	            dataType:'json',
	            data :{city_name : $('#city option:selected').val()} ,
	            success : function(data){
	               
	               $('#itemList').empty();
	               $.each(data, function(index, item){
	                     var text = '<div class="row drag" ><div class="list_thumb" ><img class="img" src='
	                         +item.img+'></div><div class="list_detail"><div id = "name" class="row">'
	                         +item.name+'</div><div  style = "display : none"  id ="detail" class="row">'
	                         +item.detail+'<div  id="price" class="row">'
	                         +item.price+'</div></div></div>';
	                  $('#itemList').append(text);
	               })
	               dragFun();
	            }
	         })
		});
	   
	   //인기순
	   $('#itemHitsSort').on('click', function() {
		   alert("itemHitsSort");
		   $.ajax({
	            url : 'itemHitsSort',
	            type: 'post',
	            dataType:'json',
	            data :{city_name : $('#city option:selected').val()} ,
	            success : function(data){
	               
	               $('#itemList').empty();
	               $.each(data, function(index, item){
	                     var text = '<div class="row drag" ><div class="list_thumb" ><img class="img" src='
	                         +item.img+'></div><div class="list_detail"><div id = "name" class="row">'
	                         +item.name+'</div><div  style = "display : none"  id ="detail" class="row">'
	                         +item.detail+'<div  id="price" class="row">'
	                         +item.price+'</div></div></div>';
	                  $('#itemList').append(text);
	               })
	               dragFun();
	            }
	         })
		});
	   
	   //거리순
	   /*
	   $('#itemDistSort').on('click', function() {
		   alert("itemDistSort");
		   $.ajax({
	            url : 'itemDistSort',
	            type: 'post',
	            dataType:'json',
	            data :{city_name : $('#city option:selected').val()} ,
	            success : function(data){
	               
	               $('#itemList').empty();
	               $.each(data, function(index, item){
	                     var text = '<div class="row drag" ><div class="list_thumb" ><img class="img" src='
	                         +item.img+'></div><div class="list_detail"><div id = "name" class="row">'
	                         +item.name+'</div><div  style = "display : none"  id ="detail" class="row">'
	                         +item.detail+'<div  id="price" class="row">'
	                         +item.price+'</div></div></div>';
	                  $('#itemList').append(text);
	               })
	               dragFun();
	            }
	         })
		});
	   */
	   //음식
	   /*
	   //거리순
	   $('#restDistSort').on('click', function() {
		   alert("restDistSort");
		   $.ajax({
	              url : 'restDistSort',
	              type : 'post',
	              dataType : 'json',
	              data :{city_name : '<c:out value="${city_name}"/>'} ,
	              success : function(data){
	                 
	                 $('#restList').empty();
	                   $.each(data, function(index, item){
	                      var text = '<div class="row drag" ><div class="list_thumb" ><img class="img" src='
	                           +item.img+'></div><div class="list_detail"><div id = "name" class="row">'
	                           +item.name+'</div><div  style = "display : none"  id ="detail" class="row">'
	                           +item.detail+'</div></div></div>';
	                      $('#restList').append(text);
	                   }) 
	                   dragFun();
	              }
	        });
	   })
	   */
		   //인기순
		   $('#restHitsSort').on('click', function() {
			   alert("restHitsSort");
			   $.ajax({
		              url : 'restHitsSort',
		              type : 'post',
		              dataType : 'json',
		              data :{city_name : '<c:out value="${city_name}"/>'} ,
		              success : function(data){
		                 
		                 $('#restList').empty();
		                   $.each(data, function(index, item){
		                      var text = '<div class="row drag" ><div class="list_thumb" ><img class="img" src='
		                           +item.img+'></div><div class="list_detail"><div id = "name" class="row">'
		                           +item.name+'</div><div  style = "display : none"  id ="detail" class="row">'
		                           +item.detail+'</div></div></div>';
		                      $('#restList').append(text);
		                   }) 
		                   dragFun();
		              }
		        });
		   })
		
		   //호텔
		   //가격순
		    $('#hotelPriceSort').on('click', function() {
		    	alert("hotelPriceSort");
			   $.ajax({
		              url : 'hotelPriceSort',
		              type : 'post',
		              dataType : 'json',
		              data :{city_name : '<c:out value="${city_name}"/>'} ,
		              success : function(data){
		                 
		            	  $('#hotelList').empty();
		                  $.each(data, function(index, item){
		                     var text = '<div class="row drag" ><div class="list_thumb" ><img class="img" src='
		                          +item.image+'></div><div class="list_detail"><div id = "name" class="row">'
		                          +item.name+'</div><div  style = "display : none"  id ="detail" class="row">'
		                          +item.detail+'<div  id="price" class="row">'
		                          +item.price+'</div></div></div>';
		                     $('#hotelList').append(text);
		                  }) 
		                   dragFun();
		              }
		        });
		   })
	   
		   //star
		    $('#hotelStarSort').on('click', function() {
		    	alert("hotelStarSort");
			   $.ajax({
		              url : 'hotelStarSort',
		              type : 'post',
		              dataType : 'json',
		              data :{city_name : '<c:out value="${city_name}"/>'} ,
		              success : function(data){
		                 
		            	  $('#hotelList').empty();
		                  $.each(data, function(index, item){
		                     var text = '<div class="row drag" ><div class="list_thumb" ><img class="img" src='
		                          +item.image+'></div><div class="list_detail"><div id = "name" class="row">'
		                          +item.name+'</div><div  style = "display : none"  id ="detail" class="row">'
		                          +item.detail+'<div  id="price" class="row">'
		                          +item.price+'</div></div></div>';
		                     $('#hotelList').append(text);
		                  }) 
		                   dragFun();
		              }
		        });
		   })
		   /*
		   //거리순
		    $('#hotelDistSort').on('click', function() {
		    	alert("hotelDistSort");
			   $.ajax({
		              url : 'hotelDistSort',
		              type : 'post',
		              dataType : 'json',
		              data :{city_name : '<c:out value="${city_name}"/>'} ,
		              success : function(data){
		                 
		            	  $('#hotelList').empty();
		                  $.each(data, function(index, item){
		                     var text = '<div class="row drag" ><div class="list_thumb" ><img class="img" src='
		                          +item.image+'></div><div class="list_detail"><div id = "name" class="row">'
		                          +item.name+'</div><div  style = "display : none"  id ="detail" class="row">'
		                          +item.detail+'<div  id="price" class="row">'
		                          +item.price+'</div></div></div>';
		                     $('#hotelList').append(text);
		                  }) 
		                   dragFun();
		              }
		        });
		   })
		   */
		 /*  
		   //명소
		   //거리순
		    $('#landmarkDistSort').on('click', function() {
		    	alert("랜드마크")
			   $.ajax({
		              url : 'landmarkDistSort.json',
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
		                     +'</div><input type = "hidden" name ="land_idx" value ="'+item.land_idx+'"/></div>';
		                     
		                     $('#landmarkDiv').append(text);
		                   }) 
		                   dragFun();
		              }
		        });
		   })
*/
			//인기순
		    $('#landmarkHitsSort').on('click', function() {
			   $.ajax({
		              url : 'landmarkHitsSort.json',
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
		                     +'</div><input type = "hidden" name ="land_idx" value ="'+item.land_idx+'"/></div>';
		                     
		                     $('#landmarkDiv').append(text);
		                   }) 
		                   dragFun();
		              }
		        });
		   })
		   
		   
	   
});

</script>

<script type="text/javascript">
//호텔 , 음식점 스크립트
   $(function() {
      $('#restList').hide();
      $('#hotelList').hide();
      $('#tab-1').addClass('selected');
   });

   $(function() {

      $('#tab-2').click(function() {
         $('#restList').show();
         $('#hotelList').hide();
         $('#itemList').hide();
         $('#tab-1').removeClass('selected');
         $('#tab-2').addClass('selected');
         $('#tab-3').removeClass('selected');

      });
   });

   $(function() {

      $('#tab-3').click(function() {
         $('#hotelList').show();
         $('#itemList').hide();
         $('#restList').hide();
         $('#tab-1').removeClass('selected');
         $('#tab-2').removeClass('selected');
         $('#tab-3').addClass('selected');
      });
   });

   $(function() {

      $('#tab-1').click(function() {
         $('#itemList').show();
         $('#hotelList').hide();
         $('#restList').hide();
         $('#tab-1').addClass('selected');
         $('#tab-2').removeClass('selected');
         $('#tab-3').removeClass('selected');
      });
   });

//호텔 음식점 스크립트 끝


   $(function(){
      //첫화면 ajax
      $.ajax({
           url : '/Ajax/landMarkAjax.json',
           type: 'post',
           dataType:'json',
           data :{city_name :'<c:out value="${city_name}"/>'} ,
           success : function(data){
              
              $('#landmarkDiv').empty();
              $.each(data, function(index, item){
                  
                 $('#landmarkDiv').append(
                  $('<div>').addClass("row drag")
                     .append(
                        $('<div>').addClass("list_thumb").append(
                           $('<img>').attr("src",item.image).addClass("img")))
                     .append(
                        $('<div>').addClass("list_detail")
                           .append(
                              $('<div>').addClass("name").attr("id","name").text(item.name))
                           .append(
                              $('<div>').addClass("detail").attr("id","detail").text(item.detail))
                     ).append(
                        $('<input>').attr("type","hidden").attr("name","land_idx").val(item.land_idx)
                     )
               );
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
       
                     $('#itemList').append(
                           $('<div>').addClass("row drag")
                              .append(
                                 $('<div>').addClass("list_thumb").append(
                                    $('<img>').attr("src",item.image).addClass("img")))
                              .append(
                                 $('<div>').addClass("list_detail")
                                    .append(
                                       $('<div>').addClass("name").attr("id","name").text(item.name))
                                    .append(
                                       $('<div>').addClass("detail").attr("id","detail").text(item.detail))
                                    .append(
                                       $('<div>').addClass("price").attr("id","price").text(item.price))
                              )
                     );
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
                   
                      $('#restList').append(
                             $('<div>').addClass("row drag")
                                .append(
                                   $('<div>').addClass("list_thumb").append(
                                      $('<img>').attr("src",item.image).addClass("img")))
                                .append(
                                   $('<div>').addClass("list_detail")
                                      .append(
                                         $('<div>').addClass("name").attr("id","name").text(item.name))
                                      .append(
                                         $('<div>').addClass("detail").attr("id","detail").text(item.detail))
                                )
                       );
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
       
                      $('#hotelList').append(
                          $('<div>').addClass("row drag")
                             .append(
                                $('<div>').addClass("list_thumb").append(
                                   $('<img>').attr("src",item.image).addClass("img")))
                             .append(
                                $('<div>').addClass("list_detail")
                                   .append(
                                      $('<div>').addClass("name").attr("id","name").text(item.name))
                                   .append(
                                      $('<div>').addClass("detail").attr("id","detail").text(item.detail))
                                   .append(
                                      $('<div>').addClass("price").attr("id","price").text(item.price))
                             )
                    );
                }) 
                dragFun();
           }
        })
      
      
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
      
      function event(){
         $("table .delete_schedule").click(function(){
               $(this).parent().removeClass('select');
                 $(this).parent().empty();
              })
              $('table .detailbt').click(function(){
                 pop($(this));
            })
      }
      
      var html = "";

      var dragFun = function(){
         $('.drag').draggable({
              helper: 'clone',
              opacity: 0.5,
              revert: true,
              start : function(e,ui){
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
             }
         });
        
    	//거리 순 정렬
        $('td').on('click', function() {
			var item_name = "";
			item_name = $(this).find('#name').text();
			//Landmark
			alert(item_name);
			$('#landmarkDistSort').on('click',function(){
			   $.ajax({
		              url : 'landmarkDistSort.json',
		              type : 'post',
		              dataType : 'json',
		              data :{city_name : '<c:out value="${city_name}"/>', name : item_name} ,
		              success : function(data){
		            	  $('#landmarkDiv').empty();
		                  $.each(data, function(index, item){
		                     var text = '<div class="row drag"><div class="list_thumb"><img src='
		                     +item.image+' class ="img"></div><div class="list_detail" id="landDetail"><div class="name" id="name">'
		                     +item.name+'</div><div   class="detail"  id="detail">'
		                     +item.detail+'</div>'
		                     +'</div><input type = "hidden" name ="land_idx" value ="'+item.land_idx+'"/></div>';
		                     
		                     $('#landmarkDiv').append(text);
		                   }) 
		                   dragFun();
		              }
			   })
		   })
		   
		  //Hotel
			$('#hotelDistSort').on('click', function() {
		    	alert("hotelDistSort");
			   $.ajax({
		              url : 'hotelDistSort.json',
		              type : 'post',
		              dataType : 'json',
		              data :{city_name : '<c:out value="${city_name}"/>', name : item_name} ,
		              success : function(data){
		                 
		            	  $('#hotelList').empty();
		                  $.each(data, function(index, item){
		                     var text = '<div class="row drag" ><div class="list_thumb" ><img class="img" src='
		                          +item.image+'></div><div class="list_detail"><div id = "name" class="row">'
		                          +item.name+'</div>'
		                          +'<div>'+item.dist+'</div>'+
		                          '<div  style = "display : none"  id ="detail" class="row">'
		                          +item.detail+'<div  id="price" class="row">'
		                          +item.price+'</div></div></div>';
		                     $('#hotelList').append(text);
		                  }) 
		                   dragFun();
		              }
		        });
		   })
		 
		//음식
		 $('#restDistSort').on('click', function() {
		   alert("restDistSort");
		   $.ajax({
	              url : 'restDistSort.json',
	              type : 'post',
	              dataType : 'json',
	              data :{city_name : '<c:out value="${city_name}"/>', name : item_name} ,
	              success : function(data){
	                 
	                 $('#restList').empty();
	                   $.each(data, function(index, item){
	                      var text = '<div class="row drag" ><div class="list_thumb" ><img class="img" src='
	                           +item.img+'></div><div class="list_detail"><div id = "name" class="row">'
	                           +item.name+'</div><div  style = "display : none"  id ="detail" class="row">'
	                           +item.detail+'</div></div></div>';
	                      $('#restList').append(text);
	                   }) 
	                   dragFun();
	              }
	        });
	   })
	   
	   $('#itemDistSort').on('click', function() {
		   alert("itemDistSort");
		   $.ajax({
	            url : 'itemDistSort.json',
	            type: 'post',
	            dataType:'json',
	            data :{city_name : '<c:out value="${city_name}"/>', name : item_name} ,
	            success : function(data){
	               
	               $('#itemList').empty();
	               $.each(data, function(index, item){
	                     var text = '<div class="row drag" ><div class="list_thumb" ><img class="img" src='
	                         +item.img+'></div><div class="list_detail"><div id = "name" class="row">'
	                         +item.name+'</div><div  style = "display : none"  id ="detail" class="row">'
	                         +item.detail+'<div  id="price" class="row">'
	                         +item.price+'</div></div></div>';
	                  $('#itemList').append(text);
	               })
	               dragFun();
	            }
	         })
		});
		   
		   
		});//end click
		  
      //일정 저장
      $('#save').on("click", function(){
        var title = $('#title').val();
          $('#saveSchedule input[name=title]').val(title).parent().submit(); 
         var te = $('#savet').serialize();
         alert(te);
        $.ajax({
              url : '/Ajax/saveLandMark',
              type: 'post',
              dataType:'json',
              data :te ,
              success : function(data){
                 
              }
           }) 
        
      })
      
      //도시선택시 ajax 구동
      $('#city_search').on("click",function(){
         //랜드마크 ajax
         $.ajax({
            url : '/Ajax/landMarkAjax.json',
            type: 'post',
            dataType:'json',
            data :{city_name : $('#city option:selected').val()} ,
            success : function(data){
               
               $('#landmarkDiv').empty();
               
               $.each(data, function(index, item){
          
                  $('#landmarkDiv').append(
                        $('<div>').addClass("row drag")
                           .append(
                              $('<div>').addClass("list_thumb").append(
                                 $('<img>').attr("src",item.image).addClass("img")))
                           .append(
                              $('<div>').addClass("list_detail")
                                 .append(
                                    $('<div>').addClass("name").attr("id","name").text(item.name))
                                 .append(
                                    $('<div>').addClass("detail").attr("id","detail").text(item.detail))
                           ).append(
                              $('<input>').attr("type","hidden").attr("name","land_idx").val(item.land_idx)
                           )
                     );
               })
               dragFun();
            }
         })
         //아이템 ajax
         $.ajax({
            url : 'itemAjax',
            type: 'post',
            dataType:'json',
            data :{city_name : $('#city option:selected').val()} ,
            success : function(data){
               
               $('#itemList').empty();
               
               $.each(data, function(index, item){
                  
                  $('#itemList').append(
                          $('<div>').addClass("row drag")
                             .append(
                                $('<div>').addClass("list_thumb").append(
                                   $('<img>').attr("src",item.image).addClass("img")))
                             .append(
                                $('<div>').addClass("list_detail")
                                   .append(
                                      $('<div>').addClass("name").attr("id","name").text(item.name))
                                   .append(
                                      $('<div>').addClass("detail").attr("id","detail").text(item.detail))
                                   .append(
                                      $('<div>').addClass("price").attr("id","price").text(item.price))
                             )
                    );
               })
               dragFun();
            }
         })
         //식당 ajax
          $.ajax({
              url : 'restAjax',
              type : 'post',
              dataType : 'json',
              data :{city_name : $('#city option:selected').val()} ,
              success : function(data){
                 
                 $('#restList').empty();
                 
                   $.each(data, function(index, item){
                      
                      $('#restList').append(
                                $('<div>').addClass("row drag")
                                   .append(
                                      $('<div>').addClass("list_thumb").append(
                                         $('<img>').attr("src",item.image).addClass("img")))
                                   .append(
                                      $('<div>').addClass("list_detail")
                                         .append(
                                            $('<div>').addClass("name").attr("id","name").text(item.name))
                                         .append(
                                            $('<div>').addClass("detail").attr("id","detail").text(item.detail))
                                   )
                          );
                   }) 
                   dragFun();
              }
        })
        //숙박 ajax
       $.ajax({
          url : 'hotelAjax',
          type : 'post',
          dataType : 'json',
          data :{city_name : $('#city option:selected').val()} ,
          success : function(data){
              
              $('#hotelList').empty();
              
                $.each(data, function(index, item){
                   
                   $('#hotelList').append(
                          $('<div>').addClass("row drag")
                             .append(
                                $('<div>').addClass("list_thumb").append(
                                   $('<img>').attr("src",item.image).addClass("img")))
                             .append(
                                $('<div>').addClass("list_detail")
                                   .append(
                                      $('<div>').addClass("name").attr("id","name").text(item.name))
                                   .append(
                                      $('<div>').addClass("detail").attr("id","detail").text(item.detail))
                                   .append(
                                      $('<div>').addClass("price").attr("id","price").text(item.price))
                             )
                    );
                }) 
                dragFun();
           }
        })
         /* return false; */
      })
   })

</script>	
<style type="text/css">
table td {
   height: 100px;
   width: 100px;
}

.drag {
   width: 200px;
   height: 200px;
}
</style>

<title>여행상품</title>
</head>
<body>
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
               <div>
               <form id = "savet" action="saveLandMarkt" method="post">
                  <table id="mySheduleTable" border=2>
                     <tr>
                        <th>일정</th>
                        <c:forEach begin="1" end = "${day }" varStatus="index">
                           <th> ${index.count }일차</th>
                        </c:forEach>
                     </tr>
                     <tr>
                        <td class="time">06:00<br>
                        <br>&nbsp;&nbsp; ~ 09:00
                        </td>
                        <c:forEach begin="1" end = "${day }" varStatus="index">
                           <td name = "${index.count }-1"></td>
                        </c:forEach>
                     </tr>
                     <tr>
                        <td class="time">09:00<br>
                        <br>&nbsp;&nbsp; ~ 12:00
                        </td>
                        <c:forEach begin="1" end = "${day }" varStatus="index">
                           <td name = "${index.count }-2"></td>
                        </c:forEach>
                     </tr>
                     <tr>
                        <td class="time">12:00<br>
                        <br>&nbsp;&nbsp; ~ 15:00
                        </td>
                        <c:forEach begin="1" end = "${day }" varStatus="index">
                           <td name = "${index.count }-3"></td>
                        </c:forEach>
                     </tr>
                     <tr>
                        <td class="time">15:00<br>
                        <br>&nbsp;&nbsp; ~ 18:00
                        </td>
                        <c:forEach begin="1" end = "${day }" varStatus="index">
                           <td name = "${index.count }-4"></td>
                        </c:forEach>
                     </tr>
                     <tr>
                        <td class="time">18:00<br>
                        <br>&nbsp;&nbsp; ~ 21:00
                        </td>
                        <c:forEach begin="1" end = "${day }" varStatus="index">
                           <td name = "${index.count }-5"></td>
                        </c:forEach>
                     </tr>
                     <tr>
                        <td class="time">21:00<br>
                        <br>&nbsp;&nbsp; ~ 24:00
                        </td>
                        <c:forEach begin="1" end = "${day }" varStatus="index">
                           <td name = "${index.count }-6"></td>
                        </c:forEach>
                     </tr>
                  </table>
                  <input type ="hidden" name = "schd_idx" value = "${schd_idx }">
                  </form>
               </div>
            <br>
            <label>일정제목</label>
            <input type = "text" id = "title">
            <button id="save" class="btn btn-secondary btn-lg">일정 저장</button>
            <br>
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
         <!-- sort button -->
		<div  id="asdf2">
	      <button id = "itemPriceSort" name="price" class="btn btn-primary">상품 가격순</button>
		  <button id = "itemSalesSort" name="price" class="btn btn-primary">상품 판매순</button>
	      <button id = "itemHitsSort" name="price" class="btn btn-primary">상품 인기순</button>
	      <button id = "itemDistSort" name="price" class="btn btn-primary">상품 거리순</button>
	      <button id = "restDistSort" name="price" class="btn btn-primary">음식 거리순</button>
	      <button id = "restHitsSort" name="price" class="btn btn-primary">음식 인기순</button>
	      <button id = "hotelPriceSort" name="price" class="btn btn-primary">숙박 가격순</button>
	      <button id = "hotelStarSort" name="price" class="btn btn-primary">숙박 몇성순</button>
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