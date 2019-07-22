<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>joinPro.jsp</title>
</head>
<body>
<%
// 아이디 중복확인 => idCheck.jsp 파일에서.

// request 한글처리, 파라미터 저장
request.setCharacterEncoding("utf-8");

String pass = request.getParameter("pass");
String pass2 = request.getParameter("pass2");

String id = request.getParameter("id");
String name = request.getParameter("name");
int age = Integer.parseInt(request.getParameter("age"));
String email = request.getParameter("email");
String phone = request.getParameter("phone");
String mobile = request.getParameter("mobile");
String postNum = request.getParameter("postNum");
String address1 = request.getParameter("address1");
String address2 = request.getParameter("address2");
String address3 = request.getParameter("address3");

String address = "("+ postNum + ") " + address1 +" "+ address2 +" "+ address3 ;


	// 비밀번호 일치 여부
	if(pass.equals(pass2)) {
		
		// MemberDAO.insertMember(MemberBean)
		MemberBean mb = new MemberBean();
		
		mb.setId(id);
		mb.setPass(pass);
		mb.setName(name);
		mb.setAge(age);
		mb.setEmail(email);
		mb.setPhone(phone);
		mb.setMobile(mobile);
		mb.setAddress(address);
		mb.setReg_date(new Timestamp(System.currentTimeMillis()));
		
		MemberDAO mdao = new MemberDAO();
		
		mdao.insertMember(mb);	%>
		
		<script type="text/javascript">
		alert("회원가입이 완료되었습니다.");
		location.href="login.jsp";
		</script>
		
<%	}else { %>
	
		<script type="text/javascript">
		alert("비밀번호가 일치하지 않습니다.");
		history.back();
		</script>
<%	}

%>

</body>
</html>