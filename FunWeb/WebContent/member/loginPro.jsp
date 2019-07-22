<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>05.loginPro.jsp</title>
</head>
<body>
<%
// request 파라미터 값들 한글처리 & 불러와서 변수에 저장
request.setCharacterEncoding("utf-8");

String id = request.getParameter("id");
String pass = request.getParameter("pass");

// MemberDAO mdao 객체 생성
MemberDAO mdao = new MemberDAO();

// int check = userCheck(id, pass) 호출
int check = mdao.userCheck(id, pass);

if(check==1){ // id, 비밀번호 일치
	session.setAttribute("id", id);  // 세션아이디 저장 
	response.sendRedirect("../main/main.jsp"); // 메인페이지로 이동
}else if(check==0) { %>
	<script>
	alert("비밀번호를 확인해주세요");
	history.back();
	</script>
<% 
}else if(check== -1) { %>
	<script>
	alert("아이디를 확인해주세요");
	history.back();
	</script>
<% } %>

</body>
</html>