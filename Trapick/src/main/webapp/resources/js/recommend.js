$(function() {
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
          
          
          var basePoint = "";
          basePoint = $(this).find("#name").text();
                
          //4개 추천하기
          //landmark
         /*$.ajax({
             url : 'landmarkRecommend.json',
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
             url : 'itemRecommend.json',
             type : 'post',
             dataType : 'json',
             data :{city_name : '<c:out value="${city_name}"/>', name : basePoint} ,
             success : function(data){
                $('#recommendItem').empty();
                $.each(data, function(index, item){
                     var text = '<div class="row drag" ><div class="list_thumb" ><img class="img" src='
	                     +item.image+'></div><div class="list_detail"><div id = "name" class="row">'
	                     +item.name+'</div><div  style = "display : none"  id ="detail" class="row">'
	                     +item.detail+'<div  id="price" class="row">'
	                     +item.price+'</div></div>'
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
             url : 'restRecommend.json',
             type : 'post',
             dataType : 'json',
             data :{city_name : '<c:out value="${city_name}"/>', name : basePoint} ,
             success : function(data){
                $('#recommendRest').empty();
                $.each(data, function(index, item){
                     var text = '<div class="row drag" ><div class="list_thumb" ><img class="img" src='
                         +item.image+'></div><div class="list_detail"><div id = "name" class="row">'
                         +item.name+'</div><div  style = "display : none"  id ="detail" class="row">'
                         +item.detail+'<div  id="price" class="row">'
                         +item.price+'</div></div>'
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
             url : 'hotelRecommend.json',
             type : 'post',
             dataType : 'json',
             data :{city_name : '<c:out value="${city_name}"/>', name : basePoint} ,
             success : function(data){
                $('#recommendHotel').empty();
                $.each(data, function(index, item){
                     var text = '<div class="row drag" ><div class="list_thumb" ><img class="img" src='
                         +item.image+'></div><div class="list_detail"><div id = "name" class="row">'
                         +item.name+'</div><div  style = "display : none"  id ="detail" class="row">'
                         +item.detail+'<div  id="price" class="row">'
                         +item.price+'</div></div>'
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
                   url : 'landmarkDistSort.json',
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
                  url : 'hotelDistSort.json',
                  type : 'post',
                  dataType : 'json',
                  data :{city_name : '<c:out value="${city_name}"/>', name : basePoint} ,
                  success : function(data){
                     
                     $('#hotelList').empty();
                      $.each(data, function(index, item){
                         var text = '<div class="row drag" ><div class="list_thumb" ><img class="img" src='
	                     +item.image+'></div><div class="list_detail"><div id = "name" class="row">'
	                     +item.name+'</div><div  style = "display : none"  id ="detail" class="row">'
	                     +item.detail+'<div  id="price" class="row">'
	                     +item.price+'</div></div>'
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
                  url : 'restDistSort.json',
                  type : 'post',
                  dataType : 'json',
                  data :{city_name : '<c:out value="${city_name}"/>', name : basePoint} ,
                  success : function(data){
                     
                     $('#restList').empty();
                       $.each(data, function(index, item){
                          var text = '<div class="row drag" ><div class="list_thumb" ><img class="img" src='
	                     +item.image+'></div><div class="list_detail"><div id = "name" class="row">'
	                     +item.name+'</div><div  style = "display : none"  id ="detail" class="row">'
	                     +item.detail+'<div  id="price" class="row">'
	                     +item.price+'</div></div>'
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
                url : 'itemDistSort.json',
                type: 'post',
                dataType:'json',
                data :{city_name : '<c:out value="${city_name}"/>', name : basePoint} ,
                success : function(data){
                   
                   $('#itemList').empty();
                   $.each(data, function(index, item){
                         var text = '<div class="row drag" ><div class="list_thumb" ><img class="img" src='
	                     +item.image+'></div><div class="list_detail"><div id = "name" class="row">'
	                     +item.name+'</div><div  style = "display : none"  id ="detail" class="row">'
	                     +item.detail+'<div  id="price" class="row">'
	                     +item.price+'</div></div>'
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
         te = decodeURIComponent(te);
         alert(te);
         $.ajax({
              url : '/Rest/recommend/saveLandMark',
              type: 'post',
              dataType:'json',
              data :te ,
              success : function(data){
              	alert("성공");
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
                 alert("성공");
                 $.each(data, function(index, item){
              	  if(item.item_price == 0){
              		  var te = $('.select:eq('+index+')').attr('name');
              		   var text = '<button type="button" class="delete_schedule btn btn-default liveButton">x</button><input type ="button" class = "detailbt liveInput" value ="상세보기"><div class="list_thumb"><img src='
                            +item.image+' class ="img"></div><div class="list_detail" style ="display: none" id="landDetail"><div class="name" id="name">'
                            +item.item_name+'<div   class="detail"  id="detail">'
                            +item.item_detail+'</div>'
                            +'</div><input type = "hidden" name ="land_idx" value ="'+item.land_idx+'"/><input type = "hidden" name = "item_price" value = "0">'
                            +'<input type = "hidden" name ="item_name" value ="'+item.name+'"/>'
                            +'<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
                            +'<input type ="hidden" name ="item_image" value = '+item.image+'>'
                            +'<input type ="hidden" name ="item_detail" value = '+item.detail+'>'
                            +'<input type ="hidden" name ="longitude" value = "'+item.longitude+'">'
                            +'<input name = "position" type="hidden" value ="'+te+'"></div>';
                            
                            $('.select:eq('+index+')').empty().append(text); 
                            event();
              	  }else{
              		  var te = $('.select:eq('+index+')').attr('name');
              		  var text = '<button type="button" class="delete_schedule btn btn-default liveButton">x</button><input type ="button" class = "detailbt liveInput" value ="상세보기"><div class="list_thumb" ><img class="img" src='
                            +item.image+'><div class="list_detail" style ="display: none"><div id = "name" class="row">'
                            +item.item_name+'</div><div  style = "display : none"  id ="detail" class="row">'
                            +item.item_detail+'<div  id="price" class="row">'
                            +item.item_price+'</div></div>'
                            +'<input type = "hidden" name ="item_name" value ="'+item.item_name+'"/>'
                            +'<input type = "hidden" name ="item_price" value ="'+item.item_price+'"/>'
                            +'<input type = "hidden" name ="item_image" value ="'+item.image+'"/>'
                            +'<input type = "hidden" name ="item_detail" value ="'+item.item_detail+'"/>'
                            +'<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
                            +'<input type ="hidden" name ="longitude" value = "'+item.longitude+'">'
                            +'<input name = "position" type="hidden" value ="'+te+'"></div>';
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
                       +item.name+'</div><div  style = "display : none"  id ="detail" class="row">'
                       +item.detail+'<div  id="price" class="row">'
                       +item.price+'</div></div>'
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
                           +item.name+'</div><div  style = "display : none"  id ="detail" class="row">'
                           +item.detail+'<div  id="price" class="row">'
                           +item.price+'</div></div>'
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
                        +item.name+'</div><div  style = "display : none"  id ="detail" class="row">'
                        +item.detail+'<div  id="price" class="row">'
                        +item.price+'</div></div>'
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
               url : 'itemPriceSort',
               type: 'post',
               dataType:'json',
               data :{city_name : $('#city option:selected').val()} ,
               success : function(data){
                  
                  $('#itemList').empty();
                  $.each(data, function(index, item){
                     var text = '<div class="row drag" ><div class="list_thumb" ><img class="img" src='
                          +item.image+'></div><div class="list_detail"><div id = "name" class="row">'
                          +item.name+'</div><div  style = "display : none"  id ="detail" class="row">'
                          +item.detail+'<div  id="price" class="row">'
                          +item.price+'</div></div>'
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
               url : 'itemSalesSort',
               type: 'post',
               dataType:'json',
               data :{city_name : $('#city option:selected').val()} ,
               success : function(data){
                  
                  $('#itemList').empty();
                  $.each(data, function(index, item){
                     var text = '<div class="row drag" ><div class="list_thumb" ><img class="img" src='
                          +item.image+'></div><div class="list_detail"><div id = "name" class="row">'
                          +item.name+'</div><div  style = "display : none"  id ="detail" class="row">'
                          +item.detail+'<div  id="price" class="row">'
                          +item.price+'</div></div>'
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
               url : 'itemHitsSort',
               type: 'post',
               dataType:'json',
               data :{city_name : $('#city option:selected').val()} ,
               success : function(data){
                  
                  $('#itemList').empty();
                  $.each(data, function(index, item){
                     var text = '<div class="row drag" ><div class="list_thumb" ><img class="img" src='
                          +item.image+'></div><div class="list_detail"><div id = "name" class="row">'
                          +item.name+'</div><div  style = "display : none"  id ="detail" class="row">'
                          +item.detail+'<div  id="price" class="row">'
                          +item.price+'</div></div>'
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
                    url : 'restHitsSort',
                    type : 'post',
                    dataType : 'json',
                    data :{city_name : '<c:out value="${city_name}"/>'} ,
                    success : function(data){
                       
                       $('#restList').empty();
                         $.each(data, function(index, item){
                            var text = '<div class="row drag" ><div class="list_thumb" ><img class="img" src='
                                 +item.image+'></div><div class="list_detail"><div id = "name" class="row">'
                                 +item.name+'</div><div  style = "display : none"  id ="detail" class="row">'
                                 +item.detail+'<div  id="price" class="row">'
                                 +item.price+'</div></div>'
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
                                +item.price+'</div></div>'
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
                    url : 'hotelReviewSort',
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
                                +item.price+'</div></div>'
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
                                +'</div><input type = "hidden" name ="land_idx" value ="'+item.land_idx+'"/><input type = "hidden" name = "item_price" value = "0">'
                                +'<input type = "hidden" name ="item_name" value ="'+item.name+'"/>'
                                +'<input type ="hidden" name ="latitude" value = '+item.latitude+'>'
                                +'<input type ="hidden" name ="longitude" value = "'+item.longitude+'"></div>';

                           $('#landmarkDiv').append(text);
                         }) 
                         dragFun();
                    }
              });
         })
         //정렬 끝
      
      
      
	 
});
