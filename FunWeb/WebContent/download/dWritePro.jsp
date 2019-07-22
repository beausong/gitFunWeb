<%@page import="download.DownloadDAO"%>
<%@page import="download.DownloadBean"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
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

// DownloadBean db 객체 생성
DownloadBean db=new DownloadBean();

// 멤버변수 <= 파라미터값 저장
db.setId(id);
db.setSubject(subject);
db.setContent(content);
db.setFile(file);

// DownloadDAO ddao 객체생성
DownloadDAO ddao=new DownloadDAO();

// finsertBoard(db) 메서드호출
ddao.insertDownload(db);

// dlList.jsp 이동
%>
<script type="text/javascript">
alert("등록 완료");
location.href="dlList.jsp";
</script>
</body>
</html>