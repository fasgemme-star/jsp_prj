<%@page import="java.util.ArrayList"%>
<%@page import="day0612.TestDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
//디자인 응답을 하지 않기 때문에 디자인에 관련된 코드를 정의할 필요가 없다.
//업무로직에 집중한다.
String name = "홍길동";
List<TestDTO> tList = new ArrayList<TestDTO>();
tList.add(new TestDTO("홍길동", 20));
tList.add(new TestDTO("길동", 23));
tList.add(new TestDTO("홍동", 26));
tList.add(new TestDTO("홍길", 21));
// 0.업무처리 한 결과를 view 페이지로 전달하기 위해서 request 내장객체에 속성으로 저장
request.setAttribute("name", name);
request.setAttribute("memberList", tList);


// 1.이동할 페이지 설정 URI를 변수로 받음
RequestDispatcher rd = request.getRequestDispatcher("forwardB.jsp");
//RequestDispatcher rd = request.getRequestDispatcher("http://localhost/jsp_prj/day0618/forwardB.jsp");
// 2.페이지 이동(이 페이지를 요청할 때 생성된 HttpServletRequest와 HttpServletResponse가 이동할 페이지로 전달된다.)
rd.forward(request,response);
%>