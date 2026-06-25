<%@page import="kr.co.sist.member.MemberService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/siteProperty.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="shortcut icon" href="${ CommonUrl }/common/images/favicon.ico"/>

<c:import url="${ CommonUrl }/fragments/external_file.jsp"/>

<style type="text/css">
#wrap { width: 470px; height: 370px; margin: 0 auto; }
#idDivFrm {position: relative; width: 465px;height: 366px; background: #FFF url(images/id_background.png) no-repeat; }
#inputWarp { position: absolute; top: 250px; left: 60px; }
#viewResult { position: absolute; top: 320px; left: 60px; }

</style>
<script type="text/javascript">
$(function(){
	$("#btnChkNull").click(function(){
		chkNull();
	});
	$("#id").keyup(function( evt ){
		if(evt.which == 13){
			chkNull();
		}
	});
});

function chkNull(){
	var id = $("#id").val();
	if (id.replace(/ /g,"") == "") {
		alert("아이디는 필수입니다.");
		$("#id").val("");
		return;
	}// end if
	id = id.replace(/ /g,"");
	$("#id").val(id);
	$("#dupFrm").submit();
}// chkNull

function sendId(id){
	opener.window.document.joinForm.id.value=id;
	self.close();
}// sendId
</script>

</head>
<body>
	<div id="wrap">
		<div id="idDivFrm">
		<div id="inputWarp">
			<form name="dupfrm" id="dupFrm" action="${ CommonUrl }/memberjoin/idDup.jsp">
				<label>아이디</label>&nbsp;<input type="text" id="id" name="id" value="${ param.id }">
				<input type="button" value="중복확인" class="btn btn-outline-secondary btn-sm" id="btnChkNull">
				<input type="text" style="display: none;">
			</form>
		</div>
		<div id="viewResult">
		<%
		String id = request.getParameter("id");
		if (id != null && !"".equals(id)){
			//중복확인
			MemberService ms = new MemberService();
			boolean idFlag = ms.searchDupId(id);
			pageContext.setAttribute("idFlag", !idFlag);
			%>
			<strong style="font-size: 20px"><c:out value="${ param.id }"/></strong>는
			<c:choose>
			<c:when test="${ idFlag }">
			<span style="font-size: 25px; font-weight: bold; color: #2A5893;">사용 가능</span> 합니다.
			<input type="button" value="사용" class="btn btn-outline-secondary btn-sm" onclick="sendId('${ param.id }')">
			<%-- <a href="javascript:sendId('${ param.id }')">사용</a> --%>
			</c:when>
			<c:otherwise>
			이미 <span style="font-size: 25px; font-weight: bold; color: #D94754;">사용중인</span> 아이디 입니다.
		
			</c:otherwise>
			</c:choose>
			<%
		}
		%>
		</div>
		</div>
	</div>
</body>
</html>