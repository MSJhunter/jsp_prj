<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="데이터 처리에 집중"
    %>
<%
//데이터 처리
String name="정동진";

List<String> list=new ArrayList<String>();
list.add("이것이 자바다");
list.add("오라클로 배우는 데이터베이스");
list.add("HTML5 웹 프로그래밍");
list.add("JSP&Servlet 웹 프로그래밍");

//1.처리된 데이터를 뷰 페이지로 보내기 위해 scope객체에 저장
request.setAttribute("name", name);
request.setAttribute("data", list);

//2. 이동할페이지 설정
RequestDispatcher rd=request.getRequestDispatcher("forward_b.jsp");
//3.이동
 rd.forward(request, response);
%>
