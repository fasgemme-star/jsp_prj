<%@page import="java.util.Random"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%

//String sesName = null;
session.setAttribute("sesName", null);
if ( new Random().nextBoolean()) {
	session.setAttribute("sesName", "gsdaf");
	//sesName=(String)session.getAttribute("sesName");
}
%>