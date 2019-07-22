<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<header>
<%
// 세션 ID 가져오기
String id = (String) session.getAttribute("id");

if(id != null) { %>
<div id="login"><%=id %>님 | <a href="../member/info.jsp">내 정보</a> | <a href="../member/logout.jsp">로그아웃</a></div>
<%	
}else { %>
<div id="login"><a href="../member/login.jsp">로그인</a> | <a href="../member/join.jsp">회원가입</a></div>
<%
}
%>

<div class="clear"></div>
<!-- 로고들어가는 곳 -->
<div id="logo"><img src="../images/logo.gif" width="265" height="62" alt="Fun Web"></div>
<!-- /로고들어가는 곳 -->
<nav id="top_menu">
<ul>
	<li><a href="../main/main.jsp">HOME</a></li>
	<li><a href="../schedule/schList.jsp">일정 갤러리</a></li>
	<li><a href="../download/dlList.jsp">자료실</a></li>
	<li><a href="../mail/mailForm.jsp">E-MAIL</a></li>
	<li><a href="../map/map.jsp">위치</a></li>
</ul>
</nav>
</header>
