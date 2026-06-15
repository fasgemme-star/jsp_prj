<%@page import="java.time.LocalDate"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="day0612.TestDTO"%>
<%@page import="java.util.List"%>
<%@page import="day0612.TestService"%>
<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="scriptlet의 사용"%>
<%
//method 내 정의하는 Java 코드 작성. 변수 선언, 연산자 사용, 제어문, 객체 생성    
String name = "홍길동";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%=name%>님</title>
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
.age { font-weight: bold; }
.age2 { font-weight: bold; color: #FF0000; }

</style>
<script type="text/javascript">
$(function(){
	
});//ready

</script>

</head>
<body>
	<div id="wrap">
		<div id="header"></div>
		<div id="container">
			<%
			// _jspService() 안쪽에 코드가 생성
			int age=25; // 지역변수 -> 초기화 할 것 
			
			String css="age";
			if (new Random().nextBoolean()) {
				css="age2";
			}
			%>
			<div>
				나이는 <span class="<%=css%>"><%=age%></span> 살 입니다.
			</div>
			<table class="table table-striped table-hover">
				<thead class="table-dark">
					<tr>
						<th>번호</th>
						<th>이름</th>
						<th>나이</th>
						<th>비고</th>
					</tr>
				</thead>
				<tbody>
				<%
				TestService ts = new TestService();
				List<TestDTO> list = ts.searchMember();
				
				TestDTO tDTO=null;
				
				
				for(int i = 0; i< list.size(); i++){
					tDTO=list.get(i);
				%>
				<tr>
				<td><%=i+1%></td>
				<td><input type="text" value="<%=tDTO.getName()%>"></td>
				<td>
				<select>
				<%for (int j=1; j<101; j++) { %>
					<option<%= j == tDTO.getAge()?" selected='selected'":""%>><%=j %></option>
				<%}//end for %>
				</select>
				</td>
				<td><button class="btn btn-danger btn-sm">삭제</button></td>
				</tr>
				<%}//end for %>
				</tbody>
			</table>
			<div>
			<%
			int sum=0;
			for(int j = 1; j < 101; j++){
				sum+=j;
			}
			%>
			1에서 100까지의 합: <%=sum%>
			</div>
			<div>
			<!-- 2026년을 기준으로 이전 2년 이후 2년을 옵션으로 보여주는 select을 Calendar를 사용하여 -->
			<select>
			<%
			LocalDate ld =LocalDate.now();
			int year = ld.getYear();			
			for (int i = 1950; i < year; i++) {%>
				<option<%=i == year?" selected = 'selected'":""%>><%=i%></option>
			<%}// end for%>
			</select>
			<select>
			<%
			int month = ld.getMonthValue();
			for (int i = 1; i < 13; i++){ %>
				<option<%=i == month?" selected = 'selected'":""%>><%=i%></option>
			<%} %>
			</select>
			<select>
			<%
			int day = ld.getDayOfMonth();
			int lastDay=ld.lengthOfMonth();
			for (int i = 1; i < lastDay+1; i++){ %>
				<option<%=i == day?" selected = 'selected'":""%>><%=i%></option>
			<%} %>
			</select>
			</div>
			<div>
				<%
				for (int i = 0; i < 11; i++){%>
					<input type="radio" name="score" class="form-check-input" <%=i==5?" checked":""%>><%=i%>점
				<%}%>
			</div>
			<div>
				<%
				int num = new Random().nextInt(4);
				String src = "../common/images/default_img2.png";
				if (num == 0){
					src = "../common/images/google.png";
				} else if( num == 1){
					src = "../common/images/naver.png";
				} else if ( num == 2){
					src = "../common/images/daum.png";
				}
				%>
				<img src=<%=src%>>
				<%
/* 					 public void test(){
					메소드 안에 메소드를 정의할 수 없기에 에러발생
				} */ 
				%>
			</div>
		</div>
		<div id="footer"></div>
	</div>
</body>
</html>