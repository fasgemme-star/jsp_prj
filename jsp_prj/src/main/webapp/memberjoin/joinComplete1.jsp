<%@page import="kr.co.sist.user.member.MemberService"%>
<%@page import="kr.co.sist.user.member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
//POST방식일 때 한글처리
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>회원가입 완료 | BallPick</title>
<%-- <link rel="stylesheet" href="<%=request.getContextPath()%>/kr.user.member/member.css"> --%>
</head>
<body>

<main class="member-page">
    <section class="member-shell">
        <h1 class="member-title">회원가입</h1>
        <div class="member-steps" aria-label="회원가입 단계">
            <div class="member-step"><span class="member-step-number">1</span>약관동의</div>
            <div class="member-step"><span class="member-step-number">2</span>정보입력</div>
            <div class="member-step active"><span class="member-step-number">3</span>가입완료</div>
        </div>

        <div class="member-result">
            <div class="member-result-icon">✓</div>
            <jsp:useBean id="mDTO" class="kr.co.sist.user.member.MemberDTO" scope="page"/>
            <jsp:setProperty property="*" name="mDTO"/>
            <%-- <jsp:setProperty property="ip" name="mDTO" value="<%=request.getRemoteAddr() %>"/> --%>
        
			<h2>${ param.name }님의 회원가입을 축하드립니다.</h2>
			입력하신 정보는 아래와 같습니다. <br>
			<label>이메일 </label> : ${ param.email }<br>
			<label>전화번호 </label> : ${ param.phone1 }-${ param.phone2 }-${ param.phone3 }<br>
			<a href="#void">로그인</a>

			<!-- <h2>회원가입 실패</h2> -->
			smsReceiveYN / ${ param.smsReceiveYN }<br>
			emailReceiveYN / ${ param.emailReceiveYN }<br>
			codeChecked / ${ param.codeChecked }<br>
			id / ${ param.id }<br>
			password / ${ param.password }<br>
			passwordConfirm / ${ param.passwordConfirm }<br>
			name / ${ param.name }<br>
			email / ${ param.email }<br>
			hobby / 
			<c:forEach var="hobby" items="${paramValues.hobby}">
				${ hobby }
			</c:forEach>
			<br>
			phone1 / ${ param.phone1 }<br>
			phone2 / ${ param.phone2 }<br>
			phone3 / ${ param.phone3 }<br>
			zipcode / ${ param.zipcode }<br>
			address / ${ param.address }<br>
			address2 / ${ param.address2 }<br>

        </div>

        <div class="member-actions">
            <%-- <a class="member-button member-button-light" href="<%=request.getContextPath()%>/main.do">메인으로</a>
            <a class="member-button" href="<%=request.getContextPath()%>/member/login.do">로그인</a> --%>
        </div>
    </section>
</main>

</body>
</html>
