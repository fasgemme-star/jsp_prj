<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

a { text-decoration: none; color: #333; }
a:hover { text-decoration: underline; color: #1E4183 }

/* 달력 */
#calHeader { font-size: 25px; text-align: center; margin-bottom: 20px; }
.calTitle { font-weight: bold; font-size: 29px; }

#calTab, th, td { border: 1px solid #E5E5E5; margin: 0px auto; }
th { text-align: center; color:#909090; }
td { width: 120px; height: 80px; font-size: 15px; text-align: right; vertical-align: top; color:#909090; }


.sunTitle { width: 100px; height: 30px; background-color: #E72203; color: #FFFFFF; font-weight: bold; }
.weekTitle { width: 100px; height: 30px; }
.satTitle { width: 100px; height: 30px; background-color: #5379E1; color:#FFFFFF;font-weight: bold; }

.sunTextColor { color: #E72203; font-weight: bold; }
.weekTextColor { color: #000000; }
.satTextColor { color: #5379E1; font-weight: bold; }

.toDayCss { border: 1px solid #6C86C4; background-color: #EFF5FA; }
.dayCss { border: 1px solid #E5E5E5; }

</style>
<script type="text/javascript">
$(function(){
	
});//ready
function moveCal(month, year){
	//입력된 값을 hidden에 설정
	$("#year").val(year);
	$("#month").val(month);
	
	$("#calFrm").submit();
}
</script>

</head>
<body>
	<div id="wrap">
		<div id="header"></div>
		<div id="container">
			<div id="calWarp">
			<%
			Calendar cal = Calendar.getInstance();
			// 오늘의 요일 정보 저장.
			StringBuilder toDay = new StringBuilder();
			toDay.append(cal.get(Calendar.YEAR));
			toDay.append(cal.get(Calendar.MONDAY) + 1);
			
			
			int nowYear = 0;
			String year = request.getParameter("year");
			if (year != null){
				cal.set(Calendar.YEAR, Integer.parseInt(year));
			}
			nowYear = cal.get(Calendar.YEAR);
			
			int nowMonth = 0;
			String month = request.getParameter("month");
			if (month != null) { //month에 web parameter가 존재하면
				cal.set(Calendar.MONTH, Integer.parseInt(month)-1);
			}
			nowMonth = cal.get(Calendar.MONDAY) + 1;
			int nowDay = cal.get(Calendar.DAY_OF_MONTH);
			
			StringBuilder selectDay = new StringBuilder();
			selectDay.append(nowYear);
			selectDay.append(nowMonth);
			//log(toDay.toString());
			//log(selectDay.toString());
			//toDay와 selectDay가 같으면 true 다르면 false
			//log(String.valueOf((toDay.toString().equals(selectDay.toString()))));
			
			// 오늘을 표현하기 위한 flag 변수
			boolean toDayFlag = toDay.toString().equals(selectDay.toString());
			%>
			<form action="calendar2.jsp" method="post" id="calFrm">
			<input type="hidden" name="year" id="year">
			<input type="hidden" name="month" id="month">
			</form>
				<div id="calHeader">
					<a href="#void" onclick="moveCal(<%=nowMonth-1==0?12:nowMonth-1 %>, <%=nowMonth-1==0?nowYear-1:nowYear %>)" title="이전월">&lt;&lt;</a>
					<a href="calendar2.jsp?" title="오늘"><span class="calTitle"><%=nowYear%>.<%=nowMonth%></span></a>
					<a href="#void" onclick="moveCal(<%=nowMonth==12?1:nowMonth+1 %>, <%=nowMonth==12?nowYear+1:nowYear %>)" title="다음월">&gt;&gt;</a>
				</div>
				<div id="calContainer">
					<table id="calTab">
						<thead>
							<tr>
								<th class="sunTitle">일</th>
								<th class="weekTitle">월</th>
								<th class="weekTitle">화</th>
								<th class="weekTitle">수</th>
								<th class="weekTitle">목</th>
								<th class="weekTitle">금</th>
								<th class="satTitle">토</th>
							</tr>
						</thead>
						
						<tbody>
							<tr>
							<%! //declaration: 선언 - JSP에서 emthod를 만들거나, instance변수, static 변수를 만들 때 사용
							public static final int START_DAY=1;
							%>
							<%
							String textCss=""; //요일별 글자색
							String tdCss=""; //오늘을 강조하기 위한 CSS
							for (int tmpDay=1; ; tmpDay++){
								
								//증가하는 임시 일자를 달력객체에 설정
								cal.set(Calendar.DAY_OF_MONTH, tmpDay);
								
								//현재월에 없는 날짜가 입력되면 다음달로 넘어간다
								if (cal.get(Calendar.DAY_OF_MONTH) != tmpDay) {
									
									//반복문 종료 전 공백 설정
									int startDayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
									for (int blankTd=startDayOfWeek; blankTd < Calendar.SATURDAY+1; blankTd++){
										%>
										<td></td>
										<%
									}// end for
									
									
									break;
								}// end if
								
								//1일을 위한 공백
								switch(tmpDay){
								case START_DAY:
									int startDayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
									for (int blankTd=1; blankTd < startDayOfWeek; blankTd++){
										%>
										<td></td>
										<%
									}// end for
								}// end switch
								
								textCss = "weekTextColor";
								switch(cal.get(Calendar.DAY_OF_WEEK)){
								case Calendar.SUNDAY:
									textCss = "sunTextColor";
									break;
								case Calendar.SATURDAY:									
									textCss = "satTextColor";
									break;
								}// end switch
								tdCss = "dayCss";
								if (toDayFlag && tmpDay == nowDay){
									tdCss= "toDayCss";
								}// end if
								// 증가하는 일을 브라우저 출력
							%>
								<td class="<%=tdCss%>">
								<span class="<%=textCss%>"><%=tmpDay%></span>
								</td>
							<%
							//토요일 줄바꿈
							switch(cal.get(Calendar.DAY_OF_WEEK)){
							case Calendar.SATURDAY:
								%>
								</tr>
								<tr>
								<%
							}// end switch
							}
							%>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div id="footer"></div>
	</div>
</body>
</html>