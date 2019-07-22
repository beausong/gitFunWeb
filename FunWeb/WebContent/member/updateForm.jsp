<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
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
<h1>회원정보 수정</h1>
<br>
<%
String id = (String) session.getAttribute("id");

MemberDAO mdao = new MemberDAO();
MemberBean mb = mdao.getMember(id);

%>
	
<form action="updatePro.jsp" method="post">
<table>
  <tr> <td class="td1">아이디</td> <td><input type="text" name="id" value="<%=id%>" readonly> </td></tr>
  <tr> <td class="td1">비밀번호 확인</td> <td><input type="password" name="pass" required> </td></tr>
  <tr> <td class="td1">이름</td> <td><input type="text" name="name" value="<%=mb.getName()%>"> </td></tr>
  <tr> <td class="td1">나이</td> <td><input type="text" name="age" value="<%=mb.getAge()%>"> </td></tr>
  <tr> <td class="td1">이메일</td> <td><input type="text" name="email" value="<%=mb.getEmail()%>"> </td></tr>
  <tr> <td class="td1">주소</td> <td><input type="text" name="address" value="<%=mb.getAddress() %>"></td> </tr>
  <tr> <td class="td1">전화번호</td> <td><input type="text" name="phone" value="<%=mb.getPhone()%>"></td> </tr>
  <tr> <td class="td1">휴대폰번호</td> <td><input type="text" name="mobile" value="<%=mb.getMobile()%>"></td> </tr>
  <tr> <td class="td1">가입날짜</td> <td><input type="text" name="phone" value="<%=mb.getReg_date() %>" readonly></td> </tr>  
  
  
</table>
<br> 
<input type="submit" value="회원정보 수정">
<input type="reset" value="다시 작성">

</form>

</body>
</html>