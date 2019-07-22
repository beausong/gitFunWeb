<%@page import="schedule.ScheduleBean"%>
<%@page import="schedule.ScheduleDAO"%>
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

<!-- 게시판 -->
<%
// int num = num파라미터 가져오기
int num=Integer.parseInt(request.getParameter("num"));
// 객체생성 ScheduleDAO sdao
ScheduleDAO sdao=new ScheduleDAO();
sdao.updateReadconut(num);
// ScheduleBean sb  =   getSchedule(num)
ScheduleBean sb = sdao.getSchedule(num);
%>
<article>
<h1>Schedule</h1>
<br>
<table id="notice">
<tr><td class="tno">글번호</td><td><%=sb.getNum() %></td>
    <td class="tno">조회수</td><td><%=sb.getReadcount() %></td></tr>
<tr><td class="tno">작성자</td><td><%=sb.getId() %></td>
    <td class="tno">작성일</td><td><%=sb.getDate() %></td></tr>
<tr><td class="tno">글제목</td><td colspan="3"><%=sb.getSubject() %></td></tr>
<tr><td class="tno">첨부파일</td>
<td colspan="3">
	<% if(sb.getFile() == null) {%> 
			첨부된 파일이 없습니다.
	<% }else { 	%>
			<img src="../upload/<%=sb.getFile() %>" width="150" height="150"> <br>
			<a href="../upload/<%=sb.getFile() %>" target="_blank"><%=sb.getFile() %> 원본보기</a> <br>
			<a href="file_down.jsp?file_name=<%=sb.getFile() %>"><%=sb.getFile() %> 다운로드</a>
	<% }%>
</td></tr>
<tr><td class="tno">글내용</td><td colspan="3"><%=sb.getContent() %></td></tr>
</table>
<div id="table_search">
<%
//세션값 가져오기
String id=(String)session.getAttribute("id");
if(id!=null){
	if(id.equals(sb.getId())){
		%>
<input type="button" value="글수정" class="btn" 
onclick="location.href='schUpdate.jsp?num=<%=sb.getNum()%>'">
<input type="button" value="글삭제" class="btn" 
onclick="location.href='schDelete.jsp?num=<%=sb.getNum()%>'">		
		<%
	}
}
%>
<input type="button" value="글목록" class="btn" onclick="location.href='schList.jsp'">
</div>
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