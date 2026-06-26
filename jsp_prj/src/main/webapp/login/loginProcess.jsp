<%@page import="kr.co.sist.member.MemberDTO"%>
<%@page import="kr.co.sist.user.login.LoginService"%>
<%@page import="kr.co.sist.chipher.DataEncryption"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/siteProperty.jsp" %>

<jsp:useBean id="lDTO" class="kr.co.sist.user.login.LoginDTO" scope="page"/>
<jsp:setProperty name="lDTO" property="*"/>
<%
//비번은 일방향 hash
lDTO.setPassword(DataEncryption.messageDigest("SHA-1", lDTO.getPassword()));

//로그인 수행
LoginService ls = new LoginService();
MemberDTO mDTO = ls.searchLogin(lDTO);
if (mDTO != null){
	//세션에 정보 추가
	session.setAttribute("userInfo", mDTO);
	//로그인 히스토리 남기기
	//메인페이지로 이동
	String url = application.getAttribute("CommonUrl")+"/index.jsp";
	%>
	<script type="text/javascript">
	location.replace("<%=url%>");
	</script>
	
	<%
	//response.sendRedirect(application.getAttribute("CommonUrl")+"/index.html");
}else{
	response.sendRedirect("loginForm.jsp?flag=N");
}
%>
