<%@page import="mailtest.GoogleAuthentication"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="javax.activation.*"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.mail.*"%>
<%@ page import="javax.mail.internet.*"%><%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%

	request.setCharacterEncoding("UTF-8");
	String sender = request.getParameter("sender");
	String receiver = request.getParameter("receiver");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	String host = "smtp.naver.com"; 

	try {
		
		boolean debug = Boolean.valueOf("true").booleanValue();

		Properties properties = System.getProperties();
		properties.put("mail.smtp.starttls.enable", "true"); // gmail은 무조건 true 고정
		properties.put("mail.smtp.host", "smtp.gmail.com"); // smtp 서버 주소
		properties.put("mail.smtp.auth", "true"); // gmail은 무조건 true 고정
		properties.put("mail.smtp.port", "587"); // gmail 포트
		
		Authenticator auth = new GoogleAuthentication();
		if (debug) properties.put("mail.debug", "true");

		// SMTP 서버정보와 사용자 정보를 기반으로 Session 클래스의 인스턴스 생성
		Session s = Session.getDefaultInstance(properties, auth);
		//Session s = Session.getdefultInstance(properties, auth);
// 		session.setDebug(debug);
		
		// Message 클래스를 사용해 수신자, 내용, 제목, 메세지 작성
		Message message = new MimeMessage(s);
		
		// 받는 사람
		Address receiver_address = new InternetAddress(receiver);
		// 보내는 사람
		Address sender_address = new InternetAddress(sender);
		message.setFrom(sender_address);
		message.addRecipient(Message.RecipientType.TO, receiver_address);
		message.setHeader("content-type", "text/html;charset=UTF-8");
		// 제목
		message.setSubject(subject);
		// 내용
		message.setContent(content, "text/html;charset=UTF-8");
		// 보내는 날짜
		message.setSentDate(new java.util.Date());
		
		// Transport 클래스를 사용해 작성한 메세지 전달
		Transport.send(message); %>
		
		<script type="text/javascript">
			alert("메일이 정상적으로 전송되었습니다.");
			location.href="mailForm.jsp";
		</script>
<%		
	} catch (Exception e) { %>
		<script type="text/javascript">
			alert("로그인 후 이용하시거나, SMTP 서버의 설정을 확인해주세요.");
			history.back();
		</script>
<%		e.printStackTrace();
	}
%>
</body>
</html>