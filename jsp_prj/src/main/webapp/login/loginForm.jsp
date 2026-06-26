<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/siteProperty.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html lang="en" data-bs-theme="auto">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Astro v5.13.2">
<title>Signin Template · Bootstrap v5.3</title>
<!-- <link rel="canonical"
	href="https://getbootstrap.com/docs/5.3/examples/sign-in/">
<script src="/docs/5.3/assets/js/color-modes.js"></script>
 --><link href="${ CommonUrl }/common/JS/bootstrap.min.css" rel="stylesheet"
	integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB">
<meta name="theme-color" content="#712cf9">
<link href="${ CommonUrl }/common/JS/sign-in.css" rel="stylesheet">
<style>

</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	//id="id", id="password", id="btnSubmit" 에서 이벤트가 발생하면, null체크
	$("#id").keyup(function(evt){
		if (evt.which == 13){
			chkNull();			
		}
	}); 
	$("#password").keyup(function(evt){
		if (evt.which == 13){
			chkNull();	
		}
	}); 
	$("#btnSubmit").click(function(){
		chkNull();	
	}); 
});// ready
function chkNull(){
	var id = $("#id").val();
	if (id.replace(/ /g,"") == ""){
		$("#id").focus();
		return;
	}
	$("#password").focus();
	var pass = $("#password").val();
	if (pass.replace(/ /g,"") == ""){
		$("#password").focus();
		return;
	}
	$("#loginForm")[0].submit();
}
</script>
</head>
<body class="d-flex align-items-center py-4 bg-body-tertiary">
	<main class="form-signin w-100 m-auto">
		<form action="${ CommonUrl }/login/loginProcess.jsp" method="post" name="loginForm" id="loginForm" onsubmit="return false;">
			
			<h1 class="h3 mb-3 fw-normal">로그인</h1>
			<div class="form-floating">
				<input type="text" class="form-control" id="id" name="id"
					placeholder="아이디"> <label for="id">아이디</label>
			</div>
			<div class="form-floating">
				<input type="password" class="form-control" id="password" name="password"
					placeholder="비밀번호"> <label for="password">비밀번호</label>
			</div>
			<c:if test="${ param.flag =='N' }">
				<div class="form-floating">
					<span style="color: #FF0000;" id="warning">아이디 또는 비밀번호가 잘못 되었습니다. 아이디와 비밀번호를 정확히 입력해 주세요.</span>
					<script type="text/javascript">
						for (var i = 0; i < 5; i++) {
							$("#warning").fadeOut(500).fadeIn(500);
						}
							$("#warning").fadeOut(1500);
					</script>
				</div>
			</c:if>
			<button class="btn btn-primary w-100 py-2" id="btnSubmit">로그인</button>
			<p class="mt-5 mb-3 text-body-secondary">&copy; class 2</p>
		</form>
	</main>
	<script src="${ CommonUrl }/common/JS/bootstrap.bundle.min.js"
		integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI"
		class="astro-vvvwv3sm"></script>
</body>
</html>