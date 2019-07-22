
<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@page import="java.util.Properties"%>
<%@page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Study IT</title>
<style>
	table{
		width : 500px;
		margin : auto;
	}

</style>

<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link href="../css/front.css" rel="stylesheet" type="text/css">

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
/*  table {border: 1px solid skyblue;} */
td {border: 1px solid white;
 	padding: 3px 10px;
 	font-size: 13px;}
.td1 {background-color: skyblue;
	font-weight: bold;}
 </style>

</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../include/top.jsp" />
<!-- /헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
<div id="sub_img"></div>
<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->
<jsp:include page="../include/leftMenu.jsp" />
<!-- 왼쪽메뉴 -->

<article>
<form action="mailPro.jsp" name="frm" method="post">
<h1>E-MAIL</h1>
<br>

<table>
	<tr><td class="td1">FunWeb의 메일 주소</td><td><input type="text" name="sender" value="fhdgofhdgo@gamil.com" readonly="readonly" style="width: 300px;"></td></tr>
	<tr><td class="td1">회원님의 메일 주소</td>
	
	<% System.out.println((String) session.getAttribute("id"));
	if((String) session.getAttribute("id") == null) {  %>
		<td><input type="text" name="receiver" placeholder="로그인 후 이용해주세요" style="width: 300px;"></td>
	<% } else {
		System.out.println("else 1");
		String id = (String) session.getAttribute("id");
		MemberDAO mdao = new MemberDAO();
		MemberBean mb = mdao.getMember(id);  %>
		<td><input type="text" name="receiver" value=<%=mb.getEmail() %> readonly="readonly" style="width: 300px;"></td>
	<%} %>
	</tr>
	<tr><td class="td1">제목</td><td><input type="text" name="subject" placeholder="FunWeb에서 작성한 메일입니다." required="required" style="width: 300px;"></td></tr>
	<tr>
		<td class="td1">내용</td>
		<td><textarea name="content" cols=40 rows=20></textarea></td>
	</tr>
	<tr><td align=center colspan=2><input type="submit" value="보내기"></td></tr>
	
</table>
</form>
</article>
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../include/bottom.jsp" />
<!-- /푸터들어가는 곳 -->
</div>
</body>
</html>