<%@page import="kr.co.sist.mypage.MyPageService"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String id = request.getParameter("id");
MyPageService mps = new MyPageService();
pageContext.setAttribute("userData", mps.searchMyPage(id));
%>
<c:out value="${ userData }" escapeXml="false"/>
