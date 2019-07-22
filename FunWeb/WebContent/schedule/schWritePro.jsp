<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="schedule.ScheduleDAO"%>
<%@page import="schedule.ScheduleBean"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
// 파일 업로드
// 프로그램 설치 WEB-INF/lib/cos.jar

// MultipartRequest 객체생성
String uploadPath=request.getRealPath("/upload");
System.out.println(uploadPath);

int maxSize=5*1024*1024;

MultipartRequest multi=new MultipartRequest(request,uploadPath,maxSize,"utf-8",new DefaultFileRenamePolicy());

// 파라미터 가져오기
String id = multi.getParameter("id");
String subject = multi.getParameter("subject");
String content = multi.getParameter("content");
String file = multi.getFilesystemName("file");

// ScheduleBean sb 객체 생성
ScheduleBean sb=new ScheduleBean();

// 멤버변수 <= 파라미터값 저장
sb.setId(id);
sb.setSubject(subject);
sb.setContent(content);
sb.setFile(file);

// ScheduleDAO scdao 객체생성
ScheduleDAO scdao=new ScheduleDAO();

// finsertBoard(sb) 메서드호출
scdao.insertSchedule(sb);

// schList.jsp 이동
%>
<script type="text/javascript">
alert("등록 완료");
location.href="schList.jsp";
</script>
</body>
</html>