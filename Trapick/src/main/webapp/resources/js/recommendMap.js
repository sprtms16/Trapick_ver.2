   var map;
   var testMarker = new Array();
   
   function initialize() {
	    
	    var mapOptions = {
	                        zoom: 6	, // 지도를 띄웠을 때의 줌 크기
	                        mapTypeId: google.maps.MapTypeId.ROADMAP
	                    };
	     
	     
	    map = new google.maps.Map(document.getElementById("map-canvas"), // div의 id과 값이 같아야 함. "map-canvas"
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
	    var address	 = "한국"; //주소
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
	
	function Markerinfo($selector){
		var lon = $selector.find('input[name=longitude]').val();
    	var lat = $selector.find('input[name=latitude]').val();
    	var name = $selector.find('input[name=item_name]').val();
    	addMarker(name, lat,lon);
	}
	
	function addMarker(name, lat,lon){
		var lat = parseFloat(lat);
		var lon = parseFloat(lon);
		var marker = new google.maps.Marker({
			title: name,
			//position: {lat: parseFloat(lon) ,lon: parseFloat(lat)},
			//position : {lat: 37.769, lng: -122.446},
			//position : {lat: 34.0194543, lng: -118.4911912},
			position : {lat: lat, lng: lon},
			map: map
		});
		testMarker.push(marker)
		map.setCenter({lat: lat, lng: lon });
	}
	
	function delMarker(){
		
	}
	
	
