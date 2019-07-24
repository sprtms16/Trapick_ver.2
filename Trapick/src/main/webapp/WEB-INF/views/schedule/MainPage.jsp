<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	if (session.getAttribute("user_idx") != null) {
		session.removeAttribute("user_idx");
	}
	session.setAttribute("user_idx", 1);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link
   href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
   rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/resources/style/css/main_insert_css.css" />
<script
   src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script
   src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js"></script>

<link rel="stylesheet"
   href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<script
   src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/i18n/datepicker-ko.js"></script>
<script type="text/javascript" src="/resources/style/js/Main_js.js"></script>
<script type="text/javascript">
/* var country = {};
var city = {}; */
   $(function() {
      //날짜 선택기능
      $(".datepicker").datepicker();
      //
      var availableTags = [];
      var uniqueAvailableTags = [];
      $.getJSON('/schedule/country', function(data) {
         $.each(data, function(index, item) {
            availableTags.push(item.name);
         });
         $.each(availableTags, function(i, el) {
            if ($.inArray(el, uniqueAvailableTags) === -1)
               uniqueAvailableTags.push(el);
         });
      });
      var availableTags2 = [];
      var uniqueAvailableTags2 = [];

       $("#target").autocomplete({
         source : uniqueAvailableTags,
         select : function(e, ui) {
            $.getJSON('city_name?country_name=' + $(this).val(), function(data) {
               $.each(data, function(index, item) {availableTags2.push(item.name);
               });
               $('#target2').empty();
               $.each(availableTags2, function(i, el) {
                  if ($.inArray(el, uniqueAvailableTags2) === -1) {
                  uniqueAvailableTags2.push(el);
                  $('#target2').append("<option value =" + availableTags2[i] + ">" + availableTags2[i] + "</opeion>");
                  }
               });

               
            });
            
            $.ajax({
            	url : 'country_iso?country_name=' + $(this).val(),
            	datatype : "text",
            	success : function(data) {
	                 $.getJSON("https://quotation-api-cdn.dunamu.com/v1/forex/recent?codes=FRX.KRW" + data, function(d) {
	                       $.each(d,function(index,i) {
	                          $('#target3').text(i.currencyName + " : " + i.currencyUnit + " || " + "환율 : " + i.openingPrice    + "원");
	                       });
                	 });
            		}
           	});
         }

      }); 
       $("#target2").autocomplete({
       source : uniqueAvailableTags2
       });  

      $("#today").text(new Date().toLocaleDateString());
      $.datepicker.setDefaults($.datepicker.regional['ko']);
      

       $('#target2').change(
                  function() {
                     var city = $('#target2 option:selected').val();
                     if (city == '')
                        return false;
                     $.ajax({
                              url : 'city_ename?city_name=' + city,
                              dataType : "text",
                              type : "get",
                              success : function(data) {
                                 var apiKey = "615c02abafdf24271fbe093a8aa7d138";
                                 var apiURI = "http://api.openweathermap.org/data/2.5/weather?q="
                                       + data + "&appid=" + apiKey;
                                 $.ajax({
									url : apiURI,
									dataType : "json",
									type : "GET",
									async : "false",
									success : function(resp) {
										 var imgURL = "http://openweathermap.org/img/w/"
									     + resp.weather[0].icon + ".png";
										 $("#weatherIcon").show();
										 $("#weatherIcon").attr("src", imgURL);
										 $("#weather").html('도시이름 : ' + resp.name + '<br>'
										 + '현재온도 : ' + Math.round(resp.main.temp - 273.15)
										 + '°C' + '<br>' + '현재습도 : ' + resp.main.humidity
										 + '%' + '<br>' + '날씨 : ' + resp.weather[0].main);
                                          }
                                 });
                              }
                       });

                });  
       
       $('#start_time').datepicker({
	         showOn : "both",
	         buttonImage : "/resources/style/img/calander.png",
	         buttonImageOnly : true,
	         dateFormat : "yy-mm-dd",
	         changeMonth : true,
	         minDate : 0,
	         onClose : function(selectDate) {
	            var stxt = selectDate.split("-");
	            stxt[1] = stxt[1] - 1;
	            var sdate = new Date(stxt[0], stxt[1], stxt[2]);
	            var mdate = new Date(stxt[0], stxt[1], stxt[2]);
	            mdate.setDate(sdate.getDate() + 4);
	            $("#end_time").datepicker("option", "minDate", sdate);
	            $("#end_time").datepicker("option", "maxDate", mdate);
	         }
	      });

	    $('#end_time').datepicker({
	         showOn : "both",
	         buttonImage : "/resources/style/img/calander.png",
	         buttonImageOnly : true,
	         dateFormat : "yy-mm-dd",
	         changeMonth : true,
	         onClose : function(selectDate) {
	            var stxt = selectDate.split("-");
	            stxt[1] = stxt[1] - 1;
	            var sdate = new Date(stxt[0], stxt[1], stxt[2]);
	            var mdate = new Date(stxt[0], stxt[1], stxt[2]);
	            mdate.setDate(sdate.getDate() - 4);
	            $("#start_time").datepicker("option", "maxDate", sdate);
	            $("#start_time").datepicker("option", "minDate", mdate);
	         	} 
	         });	    $('#submit').click(function(){
	  	  var start = $('#start_time').datepicker('getDate');
	  		var end = $('#end_time').datepicker('getDate');
	  		var cDay = 24*60*60*1000;
	  		var days = ((end - start)/cDay) + 1;
	  		$('input[name=day]').val(days);
	    }) 
   });
  
	  
</script>
</head>
<body>
	<div id="slideshow">
		<div>
			<img src="https://cms.hostelworld.com/hwblog/wp-content/uploads/sites/2/2017/08/girlgoneabroad-1170x805.jpg">
		</div>
		<div>
			<img src="https://www.eslstarter.com/admin/resources/full-width/spain-countryre-w1440h800.jpg">
		</div>
		<div>
			<img src="https://media.allure.com/photos/5bf1b1502ab5072a91e1853a/16:9/w_1600%2Cc_limit/travel%20editor%20favorite%20products.jpg">
		</div>
	</div>
   <form action="/recommend/scheduleDetail" method="post" id="mfrom">
		
      <p id="main_title">TraPick</p>
      <div id="container">
         <div id="contents">
         <input id="target" type="text" name="country_name">
            <select id="target2" name="city_name">
               <option value="">::선택::</option>
            </select> 
            
            <label for="start_time">출발일 : </label> <input type="text"
               name="start_time" id="start_time" autocomplete=off> ~ <label
               for="end_time">도착일 : </label> <input type="text" name="end_time"
               id="end_time" autocomplete=off> <input value="생성" id="submit" type="submit"
							class="booking_button trans_200">
            <input type="hidden" name="day" value="">   
            <div id="target3_weather">
               <a id="target3"></a><br>
               <p 	id="weather"></p>
               <img src="" id="weatherIcon" style="display: none;" />
              
            </div>
            
         </div>
      </div>
   </form>
</body>

</html>