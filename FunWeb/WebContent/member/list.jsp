<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>STUDY IT</title>
</head>
<body>
<%
// 회원목록은 관리자만 볼 수 있도록 설정
String id = (String) session.getAttribute("id");

if(id == null) {
	response.sendRedirect("login.jsp");
} else if (!(id.equals("admin"))) {
	response.sendRedirect("../main/main.jsp");
} else if (id.equals("admin")) {

	MemberDAO mdao = new MemberDAO();
	
	// 각 멤버의 정보를 담은 mb들을  배열로 담아 리턴
	List memberList = mdao.getMemberList();
	
 %>
	<h1>회원 목록</h1>
	
	<table border="1">
	 <tr>   <td width=150px><b>아이디</b></td>  
	 		<td width=100px><b>비밀번호</b></td>
	        <td width=80px><b>이름</b></td>  
       		<td width=80px><b>나이</b></td>
	        <td width=230px><b>이메일 주소</b></td>
	        <td width=230px><b>가입날짜</b></td> 
	 </tr>
<% 
	for (int i=0; i<memberList.size(); i++) {
		MemberBean mb = (MemberBean) memberList.get(i);
%>
		  <tr> <td><%=mb.getId() %></td>  
		  	   <td><%=mb.getPass() %></td>
		 	   <td><%=mb.getName() %></td>  
		 	   <td><%=mb.getAge() %></td>
		 	   <td><%=mb.getEmail() %></td>
		 	   <td><%=mb.getReg_date() %></td>
		  </tr>	
<%	}
} %>

	</table>

</body>
</html>