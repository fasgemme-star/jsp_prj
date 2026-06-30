<%@page import="day0630.AjaxService"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="aDTO" class="day0630.AjaxDTO" scope="page"/>
<jsp:setProperty name="aDTO" property="*"/>
<%
AjaxService as = new AjaxService();
pageContext.setAttribute("jsonObj", as.paramProcess(aDTO));
%>
<c:out value="${ jsonObj }" escapeXml="false"/>
