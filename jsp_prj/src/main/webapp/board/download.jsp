<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="application/octet-stream"	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
String fileName = request.getParameter("file");
// 2.응답 헤더 변경
response.setHeader("Content-Disposition", "attachment;fileName="+URLEncoder.encode( fileName, "UTF-8"));
// 3.다운로드할 파일에 InputStream을 연결
FileInputStream fis = null;
	OutputStream os = null;
try{
	fis = new FileInputStream("C:/Users/user/git/jsp_prj/jsp_prj/src/main/webapp/upload/" + fileName);

	// 4.응답 스트림 다기
	os = response.getOutputStream();
	byte[] readData = new byte[12];
	int readSize = 0;
	
	// 5.읽기스트림에서 파이르이 내용을 읽어들여서, 출력스트림으로 내보낸다.
	while ((readSize=fis.read(readData))!= -1) {
		os.write(readData,0,readSize);
	}
	// 6.출력스트림 초기화
	out.clear();//현제 출력 스트림 비우기
	out=pageContext.pushBody();//헤더 초기화
}finally{
	if(fis != null){ fis.close(); }
}
%>