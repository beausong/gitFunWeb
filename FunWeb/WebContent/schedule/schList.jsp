<%@page import="schedule.ScheduleDAO"%>
<%@page import="schedule.ScheduleBean"%>
<%@page import="java.nio.channels.SeekableByteChannel"%>
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
 <style type="text/css">
 td {padding: 20px;}
 
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

<!-- 게시판 -->

<% /* 화면 하단 페이징 처리 */

// 1. 게시판 전체 글의 개수(int count)를 리턴하는 메서드 getScheduleCount() 호출
ScheduleDAO scdao = new ScheduleDAO();

int count = scdao.getScheduleCount(); 

// 2. 한 화면에 보여줄 글의 개수
int pageSize = 6;

// 3. 페이지 번호 가져오기
// pageNum==null 일 경우를 대비해 request 파라미터 값을 String 변수에 저장
String pageNum= request.getParameter("pageNum");

// 4. 페이지 번호가 없으면 "1" 실행
if(pageNum==null) {
	pageNum = "1";
}

// 5. 페이지 번호 인트형으로 형변환
int currentPage = Integer.parseInt(pageNum);

// 6. 시작하는 행번호 구하기
int startRow = (currentPage-1)*pageSize +1;

// 7. 끝나는 행번호 구하기
int endRow = currentPage*pageSize;

List scheduleList = null; 

if(count!=0){
	// 8. 게시판 전체 페이지 수 구하기
	scheduleList = scdao.getScheduleList(startRow, pageSize);
}
%>

<article>
<h1>Schedule</h1>
<br>
<h5>[전체글 개수 : <%=count %>]</h5>
<table>
<%
if(scheduleList != null) {
	for(int i=0;i<scheduleList.size();){	 %>
		<tr>
		<%	int j=0;
			while(j<3 && i<scheduleList.size()) {
				ScheduleBean sb = (ScheduleBean) scheduleList.get(i);	%>
				<td class="left"> <a href='schContent.jsp?num=<%=sb.getNum()%>'>
					<img src="../upload/<%=sb.getFile() %>" width="170px" height="170px"> <br>
					<%=sb.getSubject() %></a></td>
		<%		i++;
				j++;
			} %>
		</tr>	  
<%	}
}%>  
<!-- <tr><td>15</td><td class="left">Vivanus viveer portitor commodo.</td> -->
<!--     <td>Host Admin</td><td>2012.11.06</td><td>15</td></tr> -->
</table>

<div id="table_search">
<%
	//String id = 세션값 가져오기
	String id = (String) session.getAttribute("id");

	//세션값이 있으면  글쓰기 버튼이 보이기
	if(id != null) { %>
	<input type="button" value="글쓰기" class="btn" onclick="location.href='schWrite.jsp'">
<%  } %>
</div>


<div class="clear"></div>
<div id="page_control">

<%
//9. 페이징 처리하기
if(count != 0) {
	// getScheduleList(시작행번호, 몇개) : 게시판 글 가져오기
	// (1) 게시판 전체 페이지 수 구하기 - 삼항연산자 이용
	int pageCount = count/pageSize + ( count%pageSize==0 ? 0 : 1 );
	
	// (2) 한 화면에 보여줄 페이지 블럭의 개수 
	int pageBlock = 5;
	
	// (3) 페이지 블럭의 시작 페이지번호
	int startPage = ((currentPage-1)/pageBlock) * pageBlock +1;
	
	// (4) 페이지 블럭의 마지막 페이지번호
	int endPage=startPage-1 + pageBlock;
	
	if(endPage > pageCount){
		endPage=pageCount;
	}
	
	// [이전] 하이퍼링크 생성
	if(startPage > pageBlock){	%> 
		<a href="schList.jsp?pageNum=<%=startPage-pageBlock%>">[이전]</a> 
<%	}
			
	// [1][2]...[10] 출력    // 3번으로 pageNum 보내줌 
	for(int i=startPage; i<=endPage; i++) {  	%> 
		<a href="schList.jsp?pageNum=<%=i%>">[<%= i%>]</a> 
<%	}
	
	// [다음] 하이퍼링크 생성
	if(endPage < pageCount){	%> 
		<a href="schList.jsp?pageNum=<%=startPage+pageBlock%>">[다음]</a> 
<%	}
} %>

</div>
</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->

<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../include/bottom.jsp" />
<!-- /푸터들어가는 곳 -->
</div>

</body>
</html>