<%@page import="schedule.ScheduleBean"%>
<%@page import="schedule.ScheduleDAO"%>
<%@page import="java.util.List"%>
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

<!-- 게시판 -->
<%
//String id = 세션값 가져오기
String id=(String)session.getAttribute("id");
//세션값이 없으면  member/login.jsp 이동
if(id==null){
	response.sendRedirect("../member/login.jsp");
}
//int num = num파라미터 가져오기
int num=Integer.parseInt(request.getParameter("num"));
// ScheduleDAO sdao 객체생성
ScheduleDAO sdao=new ScheduleDAO();
// ScheduleBean sb  =   getSchedule(num)
ScheduleBean sb=sdao.getSchedule(num);
%>
<article>
<h1>Schedule 수정</h1>
<br>
<form action="schUpdatePro.jsp" method="post" enctype="multipart/form-data">
<input type="hidden" name="num" value="<%=num%>">
<table id="notice">
<tr><td class="tno">글쓴이</td>
<td><input type="text" name="id" value="<%=id%>" readonly></td></tr>
<tr><td class="tno">제목</td><td><input type="text" name="subject"></td></tr>
<tr><td class="tno">파일</td><td><input type="file" name="file"></td></tr>
<tr><td class="tno">내용</td>
<td><textarea name="content" rows="10" cols="20"></textarea></td></tr>
</table>
<div id="table_search">
<input type="submit" value="글수정" class="btn">
<input type="button" value="글목록" class="btn" onclick="location.href='schList.jsp'">
</div>
</form>
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