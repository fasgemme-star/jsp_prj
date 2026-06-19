<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String name = (String)session.getAttribute("name");

if (name == null){
	response.sendRedirect("useSessionA.jsp");
	return;
}

//세션의 값을 삭제(세션은 존재하고 값만 삭제)
session.removeAttribute("name");
log("삭제된 후 " + session.getAttribute("name"));

//브라우저에 할당된 세션 무효화(세션 자체를 삭제)
session.invalidate();

//메인화면으로이동
response.sendRedirect("useSessionA.jsp");
%>
<!-- <script type="text/javascript">
location.href="http://localhost/jsp_prj/day0619/useSessionA.jsp";
</script>> -->
<!-- <!DOCTYPE html>
<html>
<head>
<meta http-equiv="refresh" content="0; http://localhost/jsp_prj/day0619/useSessionA.jsp">
</head>
<body>
</body>
</html> -->