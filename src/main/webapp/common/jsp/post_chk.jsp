<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
request.setCharacterEncoding("UTF-8"); //요청 데이터의 문자 인코딩
String method=request.getMethod().toUpperCase();
//현재 요청의 HTTP 메서드를 받아와 대문자로 변환하여 method 변수에 저장
pageContext.setAttribute("method", method);
//pageContext 객체를 통해 method 변수를 JSP 페이지 내에서 method라는 이름으로 참조
%>
<c:if test="${ method eq 'GET'}">
<c:redirect url="http://192.168.10.221/jsp_prj/index.jsp"/>
</c:if>
