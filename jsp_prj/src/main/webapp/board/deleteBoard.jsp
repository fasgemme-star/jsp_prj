<%@page import="kr.co.sist.board.BoardService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/siteProperty.jsp" %>
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bDTO" class="kr.co.sist.board.BoardDTO" scope="page"/>
<jsp:setProperty name="bDTO" property="*"/>
<jsp:setProperty name="bDTO" property="id" value="${ userInfo.id }"/>
<% 
BoardService bs = new BoardService();
pageContext.setAttribute("result", bs.removeBoard(bDTO));
%>

<script type="text/javascript">
<c:choose>
<c:when test="${ result }">
	alert("글을 삭제했습니다.");
	location.href="boardList.jsp?currentPage=${param.currentPage}";
</c:when>
<c:otherwise>
	alert("글 삭제 중 문제가 발생했습니다.\n 잠시 후 다시 시도해주세요.");
	history.back();
</c:otherwise>
</c:choose>
</script>