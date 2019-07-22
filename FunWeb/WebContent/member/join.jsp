<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>join.jsp</title>
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



<script type="text/javascript">
	function idCheck() {
		
		var id = document.fr.id.value;
		
		if(id == "") {
			alert("아이디를 입력해주세요");
			document.fr.id.focus();
			return;
		}else {			
			window.open("joinIdCheck.jsp?id="+id, "", "width=0, height=0");
		}
	}
</script>
	
</head>
<body>

<div id="wrap">

<!-- 헤더들어가는 곳 -->
<jsp:include page="../include/top.jsp" />
<!-- /헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 본문메인이미지 -->
<div id="sub_img_member"></div>
<!-- /본문메인이미지 -->
<!-- 왼쪽메뉴 -->
<jsp:include page="../include/leftMenu.jsp" />
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<article>
<h1>회원가입</h1>
<br>

<form action="joinPro.jsp" id="join" name="fr" method="post">

<fieldset>

<legend>필수입력</legend>
<label>아이디</label>
<input type="text" name="id" class="id" value="" required>
<input type="button" value="ID 중복체크" class="dup" onclick="idCheck()" required><br>


<label>비밀번호</label>
<input type="password" name="pass" required><br>
<label>비밀번호 확인</label>
<input type="password" name="pass2" required><br>
<label>이름</label>
<input type="text" name="name" required><br>
<label>나이</label>
<input type="text" name="age" required><br>
<label>이메일 주소</label>
<input type="email" name="email" required><br>
</fieldset>
<br>

<fieldset>
<legend>선택사항</legend>
<!-- 주소와 우편번호를 입력할 <input>들을 생성하고 적당한 name과 class를 부여한다 -->
<label>우편번호</label>
	<input type="text" name="postNum" class="postcodify_postcode5" value="" >
	<input type="button" id="postcodify_search_button" value="검색"><br>
<label>주소</label>
	<input type="text" name="address1" class="postcodify_address" value="" ><br>
<label>상세주소</label>	
	<input type="text" name="address2" class="postcodify_details" value="" ><br>
<label></label>
	<input type="text" name="address3" class="postcodify_extra_info" value=""><br>

<!-- jQuery와 Postcodify를 로딩한다 -->
<script src="//ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>

<!-- "검색" 단추를 누르면 팝업 레이어가 열리도록 설정한다 -->
<script> $(function() { $("#postcodify_search_button").postcodifyPopUp(); }); </script>
<!-- <label>우편번호</label> <input type="text" name="postNum" > -->
<!--  <input type="button" class="dup"  name="postNumSearch" value="우편번호 검색" onclick=> <br> -->
<!-- <label>주소</label><input type="text" name="address"><br> -->
<!-- <label>상세주소</label><input type="text" name="address2"><br> -->
<label>전화번호</label>
<input type="text" name="phone"><br>
<label>휴대폰번호</label>
<input type="text" name="mobile"><br>
</fieldset>
<div class="clear"></div>
<div id="buttons">
<input type="submit" value="회원가입" class="submit">
<input type="reset" value="다시 입력" class="cancel">
</div>
</form>
</article>
<!-- /본문내용 -->
<!-- /본문들어가는 곳 -->

<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../include/bottom.jsp" />
<!-- /푸터들어가는 곳 -->

</div>
</body>
</html>