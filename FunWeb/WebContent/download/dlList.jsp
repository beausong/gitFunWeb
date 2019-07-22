<%@page import="download.DownloadBean"%>
<%@page import="download.DownloadDAO"%>
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
/*  table {border: 1px solid skyblue;} */
 th {background-color: skyblue; }
 th, td {border: 1px solid skyblue;
 	padding: 3px 10px;
 	font-size: 13px;}

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

// 1. 게시판 전체 글의 개수(int count)를 리턴하는 메서드 getDownloadCount() 호출
DownloadDAO dbao = new DownloadDAO();

int count = dbao.getDownloadCount(); 

// 2. 한 화면에 보여줄 글의 개수
int pageSize = 10;

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

List DownloadList = null; 

if(count!=0){
	// 8. 게시판 전체 페이지 수 구하기
	DownloadList = dbao.getDownloadList(startRow, pageSize);
}
%>

<article>
<h1>자료실</h1>
<br>
<h5>[전체글 개수 : <%=count %>]</h5>
<table>
	<tr> <th width="50px">글번호</th> 
		 <th width="250px">제목</th>
		 <th width="80px">작성자</th> 
		 <th width="100px">날짜</th> 
		 <th width="50px">조회수</th> </tr>
	
	
<%	// (2-1) DownloadList 배열에 들어있는 db를 순서대로(i) 꺼내
if(DownloadList != null) {
	for(int i=0; i<DownloadList.size(); i++){
		
		// (2-2) 배열 하나의 db 꺼냄	
		// ★ DownloadList.get(i) 는 Object 형으로 임시 저장되므로 DownloadBean 형으로 형변환 필요
		DownloadBean db = (DownloadBean) DownloadList.get(i);   %>
	
		<!-- (2-3) 꺼낸 db의 값을 출력 -->
		<tr> <td><%=db.getNum() %></td> 
			 <td><a href="dContent.jsp?num=<%=db.getNum()%>"  target="_blank"><%=db.getSubject() %></a></td> 
			 <td><%=db.getId() %></td> 
			 <td><%=db.getDate() %></td> 
			 <td><%=db.getReadcount() %></td> 
		</tr>
<% }
	}%>

</table>

<div id="table_search">
<%
	//String id = 세션값 가져오기
	String id = (String) session.getAttribute("id");

	//세션값이 있으면  글쓰기 버튼이 보이기
	if(id != null) { %>
	<input type="button" value="글쓰기" class="btn" onclick="location.href='dWrite.jsp'">
<%  } %>
</div>


<div class="clear"></div>
<div id="page_control">

<%
//9. 페이징 처리하기
if(count != 0) {
	// getDownloadList(시작행번호, 몇개) : 게시판 글 가져오기
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
		<a href="dlList.jsp?pageNum=<%=startPage-pageBlock%>">[이전]</a> 
<%	}
			
	// [1][2]...[10] 출력    // 3번으로 pageNum 보내줌 
	for(int i=startPage; i<=endPage; i++) {  	%> 
		<a href="dlList.jsp?pageNum=<%=i%>">[<%= i%>]</a> 
<%	}
	
	// [다음] 하이퍼링크 생성
	if(endPage < pageCount){	%> 
		<a href="dlList.jsp?pageNum=<%=startPage+pageBlock%>">[다음]</a> 
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