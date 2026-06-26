<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" info="부트스트랩 외부파일"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="container-fluid">
				<a class="navbar-brand" href="#">Carousel</a>
				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarCollapse"
					aria-controls="navbarCollapse" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarCollapse">
					<ul class="navbar-nav me-auto mb-2 mb-md-0">
						<li class="nav-item"><a class="nav-link active"
							aria-current="page" href="${ CommonUrl }/index.html">Home</a></li>
						<li class="nav-item"><a class="nav-link" href="javascript:history.back()" >이전으로</a></li>
						<li class="nav-item"><a class="nav-link disabled"
							aria-disabled="true">Disabled</a></li>
					</ul>
					<form class="d-flex" role="search">
					<c:choose>
					<c:when test="${ empty userInfo }">
						<a class="nav-link" style="color: #FFFFFF"
							aria-current="page" href="${ CommonUrl }/login/loginForm.jsp">로그인</a>
						&nbsp;&nbsp;
						<a class="nav-link" style="color: #FFFFFF"
							aria-current="page" href="${ CommonUrl }/memberjoin/joinForm.jsp">회원가입</a>
					</c:when>
					<c:otherwise>
						
						<a class="nav-link" style="color: #FFFFFF"
							aria-current="page" href="#void">
							<span title="${ userInfo.name }님의 마이페이지"><c:out value="${ userInfo.id }"/></span>
							</a>
						&nbsp;&nbsp;
						<a class="nav-link" style="color: #FFFFFF"
							aria-current="page" href="#void">로그아웃</a>
					
					</c:otherwise>
					</c:choose>
					</form>
				</div>
			</div>   