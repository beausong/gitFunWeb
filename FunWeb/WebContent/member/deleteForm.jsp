<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>STUDY IT</title>
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
 

 
  <style type="text/css">
 table {border: 1px solid skyblue;}
 td {padding: 3px 10px;
 	font-size: 13px;}
 .td1 {background-color: skyblue;}
 </style>
 
</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../include/top.jsp" />
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
<div id="sub_img_member"></div>
<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->
<jsp:include page="../include/leftMenu.jsp" />
<!-- 왼쪽메뉴 -->

<article>
<h1>회원탈퇴</h1>
<br>
<form action="deletePro.jsp" method="post">

<table>
<tr><td class="td1">아이디 확인</td><td><input type="text" name="id">  </td></tr>  
<% // 삭제 구문을 쓸 때는 동일한 값의 내용을 삭제하지 않도록 반드시 기본키를 포함해야 한다. %>
<tr><td class="td1">비밀번호 확인</td><td><input type="password" name="pass">  </td></tr> 
</table>
<br>

<input type="submit" value="회원 탈퇴">
</form>

</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../include/bottom.jsp" />
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>