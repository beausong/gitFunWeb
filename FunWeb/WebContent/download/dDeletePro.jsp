<%@page import="download.DownloadDAO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	// request 한글 처리, 파라미터 값 받기
	request.setCharacterEncoding("utf-8");

	int num = Integer.parseInt(request.getParameter("num"));
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
		
	// MemberDAO 클래스의 userCheck() 메서드
	MemberDAO mdao = new MemberDAO();
	int check = mdao.userCheck(id, pass);
	
	if (check == 1 || id.equals("admin")) {
		DownloadDAO ddao = new DownloadDAO();
		ddao.deleteDownload(num);
				%>
	<script type="text/javascript">
		alert("글 삭제가 완료되었습니다");
		location.href = "../download/dlList.jsp";
	</script>
<% } else if(check == 0) { %>
	<script type="text/javascript">
		alert("비밀번호가 일치하지 않습니다");
		history.back();
	</script>
<% } else {  %>
	<script type="text/javascript">
		alert("아이디가 일치하지 않습니다");
		history.back();
	</script>
<%
	}
%>

</body>
</html>