<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../fragments/external_file.jsp"/>
<script type="text/javascript">
$(function(){
	$("#btn").click(function(){
		$.ajax({
			url: "member.xml",
			type: "get",
			dataType: "XML",
			error: function(xhr){
				alert(xhr.status);
			},
			success: function(xmlDoc){
				var name = $(xmlDoc).find("name").text();
				var addr = $(xmlDoc).find("addr").text();
				var age = $(xmlDoc).find("age").text();
				$("#name").html(name);
				$("#addr").html(addr);
				$("#age").html(age);
			}
			
			
		});//ajax
	});
	$("#btn2").click(function(){
		$.ajax({
			url: "../xml0709/depts2.xml",
			type: "get",
			dataType: "xml",
			error: function(xhr){
				alert(xhr.status);
			},
			success: function(xmlDoc){
				//
				$(xmlDoc).find("dept").each(function(ind,deptNode){
					$("#tab tbody:last").append("<tr><td>" + (ind+1) 
							+ "</td><td>" + $(deptNode).find("deptno").text()
							+ "</td><td>" + $(deptNode).find("dname").text()
							+ "</td><td>" + $(deptNode).find("loc").text()
							+ "<td></tr>");
					
					if(!$(xmlDoc).find("result")){
						$("#tab tbody:last").append("<tr><td colspan='4'>부서가 존재하지 않습니다.</td></tr");
					}
					
				});//end each
			}
			
			
		});//ajax
	});
});//ready
</script>

</head>
<body>

<input type="button" value="값 얻기" class="btn btn-sm btn-primary" id="btn"/>
<br>
<div>
회원명: <span id="name"></span><br>
주소: <span id="addr"></span><br>
나이: <span id="age"></span><br>
</div>
<div>
<input type="button" value="부서 정보 얻기" class="btn btn-sm btn-primary" id="btn2"/>
<table class="table table-hober" id="tab">
	<thead>
	<tr>
		<th>번호</th>
		<th>부서번호</th>
		<th>부서명</th>
		<th>위치</th>
	</tr>
	</thead>
	<tbody>
	<%
	
	%>
	</tbody>
</table>
</div>
</body>
</html>