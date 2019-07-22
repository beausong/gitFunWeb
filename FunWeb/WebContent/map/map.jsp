<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->
<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]-->
</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../include/top.jsp" />
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
<div id="sub_img"></div>
<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->
<jsp:include page="../include/leftMenu.jsp" />
<!-- 왼쪽메뉴 -->

<article>
<h1>부산 시민공원</h1>
<br>

		<div id="map" style="width:500px;height:400px;"></div>

		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9600bd080a754be9e17d773bd75df6de&libraries=services"></script>
		<script>
		// 마커를 클릭하면 장소명을 표출할 인포윈도우
		var infowindow = new daum.maps.InfoWindow({zIndex:1});

		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new daum.maps.LatLng(35.168679, 129.057850), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };  

		// 지도 생성
		var map = new daum.maps.Map(mapContainer, mapOption); 

		// 장소 검색 객체 생성
		var ps = new daum.maps.services.Places(); 

		// 키워드로 장소 검색
		ps.keywordSearch('부산시민공원', placesSearchCB); 

		// 키워드 검색 완료 시 호출되는 콜백함수
		function placesSearchCB (data, status, pagination) {
		    if (status === daum.maps.services.Status.OK) {

		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
		        // LatLngBounds 객체에 좌표를 추가
		        var bounds = new daum.maps.LatLngBounds();

		        for (var i=0; i<data.length; i++) {
		            displayMarker(data[i]);    
		            bounds.extend(new daum.maps.LatLng(data[i].y, data[i].x));
		        }       

		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정
		        map.setBounds(bounds);
		    } 
		}

		// 지도에 마커를 표시하는 함수
		function displayMarker(place) {
		    
		    // 마커를 생성하고 지도에 표시
		    var marker = new daum.maps.Marker({
		        map: map,
		        position: new daum.maps.LatLng(place.y, place.x) 
		    });

		    // 마커에 클릭이벤트를 등록
		    daum.maps.event.addListener(marker, 'click', function() {
		        // 마커를 클릭하면 장소명이 인포윈도우에 표출
		        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
		        infowindow.open(map, marker);
		    });
		}
		</script>
<br>
주소 : 대한민국 부산광역시 부산진구 범전동 시민공원로 73 <br>
오픈 시간 : 05:00 ~ 24:00 <br>

</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../include/bottom.jsp" />
<!-- /푸터들어가는 곳 -->
</body>
</html>