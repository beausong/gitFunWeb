<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>idCheck.jsp</title>

</head>
<body>
<%
//파라미터 값 저장
String id = request.getParameter("id"); %>

<%
// 아이디 중복여부 확인
MemberDAO mdao = new MemberDAO();
int check = mdao.idCheck(id);
	if(check == 1){
		%>
		<script>
			window.opener.alert("입력한 아이디 : <%=id %> 중복된 아이디입니다");
			opener.document.fr.id.value = "";
			window.close();
		</script>
		<%
	}else if(check == 0){
		%>
		<script>
			window.opener.alert("입력한 아이디 : <%=id %>\n 사용 가능한 아이디입니다"); 
			window.close();
		</script>
		<%
	}
%>
</body>
</html>