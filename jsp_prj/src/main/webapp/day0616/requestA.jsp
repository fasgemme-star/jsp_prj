<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" info="최초 요청되는 JSP: GET" isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="shortcut icon" href="http://192.168.10.70/jsp_prj/common/images/favicon.ico"/>
<!-- Bootstrap CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.min.js" integrity="sha384-G/EV+4j2dNv+tEPo3++6LCgdCROaejBqfUeNjuKAiuXbjrxilcCdDz6ZAVfHWe1Y" crossorigin="anonymous"></script>
<!-- jQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<style type="text/css">
#wrap { width: 1000px; height: 900px; margin: 0 auto; }
#header { height: 200px; }
#container { height: 600px; }
#footer { height: 100px; }

.bold { font-weight: bold; }

</style>
<script type="text/javascript">
$(function(){
	$("#btn").click(function(){
		location.href="requestB.jsp"
	})
	
	$("#btn3").click(function(){
		var txt = $("#txt").val();
		if (txt == ""){
			alert("입력은 필수입니다.");
			return;
		}
		$("#postFrm").submit();
	})
	
	$("#btn4").click(function(){
		var txt = $("#txt").val();
		if (txt == ""){
			alert("입력은 필수입니다.");
			return;
		}
		$("#postFrm").submit();
	})
});//ready

</script>

</head>
<body>
	<div id="wrap">
		<div id="header"></div>
		<div id="container">
		<div>
		요청방식 <span class="bold"><%=request.getMethod() %></span>
		</div>
		<div id="get">
		<h2>GET방식 요청</h2>
		<ul>
			<li>링크: <a href="requestB.jsp">요청</a></li>
			<li>location: <button class="btn btn-sm btn-outline-primary" id="btn">location요청</button></li>
			<li>form 태그: <form action="requestB.jsp" method="GET" id="getFrm">
				<!-- button태그가 form태그의 자식으로 정의되면 자동으로 submit이 된다 -->
				<button class="btn btn-sm btn-outline-primary" id="btn2">요청</button>
			</form>
		</ul>		
		</div>
		<div id="post">
		</div>
		<h2>POST방식 요청</h2>
		<ul>
			<li>form 태그: <form action="requestB.jsp" method="POST" id="postFrm" onsubmit="return false;">
			<label for="txt">1234</label><input type="text" name="txt" id="txt">
				<!-- button태그가 form태그의 자식으로 정의되면 자동으로 submit이 된다 -->
				<button class="btn btn-sm btn-outline-primary" id="btn3">요청</button>
				<input type="button" class="btn btn-sm btn-outline-primary" value="요청" id="btn4">
			</form>
		</ul>		
				
		</div>
		<div id="footer"></div>
	</div>
</body>
</html>