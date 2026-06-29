<%@page import="kr.co.sist.member.MemberDTO"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
MemberDTO mDTO = (MemberDTO)session.getAttribute("userInfo");
pageContext.setAttribute("mDTO", mDTO);
%>
<c:if test="${ empty mDTO }">
<c:redirect url="${ CommonUrl }/index.html"/>
</c:if>
