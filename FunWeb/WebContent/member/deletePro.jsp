<%@page import="member.MemberDAO"%>
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
		// request 한글 처리, 파라미터 값 받기
		request.setCharacterEncoding("utf-8");

		String id = request.getParameter("id");
		String pass = request.getParameter("pass");

		
		// MemberDAO 클래스의 userCheck() 메서드
		MemberDAO mdao = new MemberDAO();
		int check = mdao.userCheck(id, pass);

		if (check == 1) {
			// MemberDAO 클래스의 deleteMember() 메서드
			mdao.deleteMember(id);
			// 세션 삭제
				session.invalidate();	%>
		<script type="text/javascript">
			alert("탈퇴가 완료되어 모든 회원정보가 삭제되었습니다");
			location.href = "../main/main.jsp";
		</script>
	<% } else if(check == 0) { %>
		<script type="text/javascript">
			alert("비밀번호를 확인해주세요");
			history.back();
		</script>
	<% } else {  %>
		<script type="text/javascript">
			alert("아이디를 확인해주세요");
			history.back();
		</script>
	<%
		}
	%>



</body>
</html>