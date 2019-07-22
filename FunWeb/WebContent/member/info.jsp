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
 th, td {padding: 3px 10px;
 	font-size: 13px;}
th {background-color: skyblue;}
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
<h1>회원정보</h1>
<br>
<%

// 세션아이디 저장
String id=(String)session.getAttribute("id");

// 아이디가 없으면(비어있으면 or 세션값이 없으면) => login.jsp 로 이동
if(id==null){
	response.sendRedirect("login.jsp");
}else{

	// 회원정보 출력 
	MemberDAO mdao = new MemberDAO();
	MemberBean mb = mdao.getMember(id);	%>
	
	<table>
	 <tr> <th width=80px>아이디</th> <td width=400px><%=mb.getId() %></td> </tr>
	 <tr> <th>이름</th> <td><%=mb.getName() %></td> </tr>
	 <tr> <th>나이</th><td><%=mb.getAge() %></td> </tr>
	 <tr> <th>이메일</th><td><%=mb.getEmail() %></td> </tr>
	 <tr> <th>주소</th><td><%=mb.getAddress() %></td> </tr>
	 <tr> <th>전화번호</th><td><%=mb.getPhone() %></td> </tr>
	 <tr> <th>휴대폰번호</th><td><%=mb.getMobile() %></td> </tr>
	 <tr> <th>가입날짜</th> <td><%=mb.getReg_date() %></td> </tr>
	</table>
	<br>
	
	<input type="button" name="" value="회원정보 수정" onclick="location.href='updateForm.jsp'">
	<input type="button" name="" value="회원 탈퇴" onclick="location.href='deleteForm.jsp'">

<%} %>
<div class="clear"></div>
<div id="page_control">
</div>
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