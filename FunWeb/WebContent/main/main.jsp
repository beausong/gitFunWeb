<%@page import="download.DownloadBean"%>
<%@page import="download.DownloadDAO"%>
<%@page import="schedule.ScheduleBean"%>
<%@page import="schedule.ScheduleDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Study IT</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
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


</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../include/top.jsp" />
<!-- /헤더들어가는 곳 -->
<!-- 메인이미지 들어가는곳 -->
<div class="clear"></div>
<div id="main_img"><img src="../images/main_img.jpg"
 width="971" height="282"></div>
<!-- 메인이미지 들어가는곳 -->
<!-- 메인 콘텐츠 들어가는 곳 -->
<article id="front">
<div id="news_notice">
<h3 class="brown"><a href="../schedule/schList.jsp">Schedule</a></h3>
<table>

<%
ScheduleDAO sdao = new ScheduleDAO();
List ScheduleList = sdao.getScheduleList(1, 3);

if(ScheduleList != null) { %>
	<tr>
<%	for(int i=0; i<ScheduleList.size(); i++) {
		ScheduleBean sb = (ScheduleBean) ScheduleList.get(i);  %>
		
		<td  class="contxt" width="100px">
			<a href="../schedule/schContent.jsp?num=<%=sb.getNum()%>">
				<img src="../upload/<%=sb.getFile() %>" width="100px" height="100px"> <br>
				<%=sb.getSubject() %> <br></a></td>
<%	} %>
	</tr>
<%}    

ScheduleList = sdao.getScheduleList(4, 3);

if(ScheduleList != null) { %>
	<tr>
<%	for(int i=0; i<ScheduleList.size(); i++) {
		ScheduleBean sb = (ScheduleBean) ScheduleList.get(i);  %>
		
		<td  class="contxt" width="100px">
			<a href="../schedule/schContent.jsp?num=<%=sb.getNum()%>">
				<img src="../upload/<%=sb.getFile() %>" width="100px" height="100px"> <br>
				<%=sb.getSubject() %> <br></a></td>
<%	} %>
	</tr>
<%} %> 
</table>
</div>

<div id="news_notice">
<h3 class="brown"><a href="../programDownload/dlList.jsp">Download</a></h3>
<table>
<!-- 	<tr><th class="tno">글번호</th> -->
<!-- 	    <th class="ttitle">제목</th> -->
<!-- 	    <th class="twrite">작성자</th> -->
<!-- 	    <th class="tdate">날짜</th> -->
<!-- 	    <th class="tread">조회수</th></tr> -->
<%
DownloadDAO ddao = new DownloadDAO();
List DownloadList = ddao.getDownloadList(1, 10);

if(DownloadList != null) {
	
	for(int i=0; i<DownloadList.size(); i++) {
		DownloadBean db = (DownloadBean) DownloadList.get(i);  %>
		
		<tr> <td class="contxt"><a href="../download/dContent.jsp?num=<%=db.getNum()%>"><%=db.getSubject() %></a></td>
    		 <td><%=db.getDate() %></td> </tr>		
<%	} 
}
%>	    
</table>
</div>

</article>
<!-- 메인 콘텐츠 들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../include/bottom.jsp" />
<!-- /푸터들어가는 곳 -->
</div>
</body>
</html>