<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>07_2.updatePro.jsp</title>
</head>
<body>
<%
// request 한글처리
request.setCharacterEncoding("utf-8");

String id = (String) session.getAttribute("id");
String pass = request.getParameter("pass");

// id, pass 일치 확인
	MemberDAO mdao = new MemberDAO();
	int check = mdao.userCheck(id, pass);
	
	MemberBean mb = new MemberBean();

	if(check == 1) { 
		// 변경한 값을 DB에 갱신
		mb.setId(id);
		mb.setName(request.getParameter("name"));
		mb.setAge(Integer.parseInt(request.getParameter("age")));
		mb.setEmail(request.getParameter("email"));
		mb.setPhone(request.getParameter("phone"));
		mb.setMobile(request.getParameter("mobile"));
		mdao.updateMember(mb);
		%>		
		<script type="text/javascript">
			alert("회원정보 수정 완료");
 			location.href="../main/main.jsp";
		</script>
<%	}else { %>
		<script type="text/javascript">
			alert("비밀번호를 확인하세요");
			location.href="updateForm.jsp";
		</script>
<%}


%>

</body>
</html>