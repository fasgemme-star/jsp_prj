<%@page import="kr.co.sist.chipher.DataDecryption"%>
<%@page import="kr.co.sist.chipher.DataEncryption"%>
<%@page import="java.util.Base64"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.security.MessageDigest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/siteProperty.jsp" %>
<%
String password="1234";

// 1. 알코리즘을 설정하여 객체얻기
MessageDigest md = MessageDigest.getInstance("SHA-1");

// 2.평문에 알고리즘 적용
md.update(password.getBytes());

// 3.byte[] 얻기 4.인코딩(Base64)
byte[] algorithm = md.digest();
String sha = new String(Base64.getEncoder().encode(algorithm));

%>

plain text: <%=password%><br>
일방향 Hash: <%=sha%>

<%
String sha2 = DataEncryption.messageDigest("SHA-1", password);
%>
<br>
<%=sha2 %>
<br>
<%
String key = "a123456789123415";
DataEncryption de = new DataEncryption(key);
String name = "테스트";
String encryption = de.encrypt(name);

DataDecryption dd = new DataDecryption(key);
String decryption = dd.decrypt(encryption);
%>
원본문자: <%=name%><br>
암호화된 문자열: <%=encryption%><br>
복호화된 물자열: <%=decryption %>
