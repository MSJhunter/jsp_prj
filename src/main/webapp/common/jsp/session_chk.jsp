<%@page import="kr.co.sist.user.member.WebMemberVO"%>
<%-- 사용자의 정보를 가져옴  --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${ empty userData }">
<%--조건이 true일 때만 안의 내용을 실행
userData가 비어 있는 경우(empty userData), 즉 사용자가 로그인하지 않은 상태로 간주--%>
<c:redirect	url="http://192.168.10.221/jsp_prj/index.jsp"/>
</c:if>
<%
String remoteIp = request.getRemoteAddr();// 접속자 ip
String sessionId = ((WebMemberVO)session.getAttribute("userData")).getId(); 
//로그인한 계정의 id
//request.getRemoteAddr() 메서드는 사용자가 접속한 IP 주소를 반환하여
//session.getAttribute("userData")를 통해 세션에 저장된 userData를 가져옴.
//WebMemberVO 타입으로 캐스팅되며,getId() 메서드를 통해 
//로그인한 사용자의 ID를 sessionId 변수에 저장
%>