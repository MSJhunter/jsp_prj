<%@page import="day1016.TestVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="useBean 표준액션태그의 사용"
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="shortcut icon" href="http://192.168.10.225/jsp_prj/common/images/favicon.ico"/>
<link rel="stylesheet" type="text/css" href="http://192.168.10.221/jsp_prj/common/css/main_20240911.css">
<!-- bootstrap CDN 시작-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<!-- jQuery CDN 시작-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<style type="text/css">

</style>
<script type="text/javascript">
$(function(){
	
});//ready
</script>
</head>
<body>
<div id="wrap">
	<%
	//1.생성
	TestVO tVO=new TestVO();
	//2.scope 객체에 할당
	pageContext.setAttribute("tVO", tVO);
	//3.setter method호출 값 할당
	tVO.setName("김현우");
	tVO.setMyAge(20);
	%>
	이름 : <%= tVO.getName() %><br/>
	나이 : <%= tVO.getMyAge() %><br/>
	<%
	//scope객체에 저장된 값 얻기
	TestVO tVO2=(TestVO)pageContext.getAttribute("tVO");
	%>
	이름 : <%= tVO2.getName() %><br/>
	나이 : <%= tVO2.getMyAge() %><br/>
	<br/>
	<h2>useBean 표준액션 사용</h2>
	<!-- 객체화 + scope에 할당 -->
	<jsp:useBean id="tVO3" class="day1016.TestVO" scope="page"/>
	<!-- setter method호출 값 할당 -->
	<jsp:setProperty property="name" name="tVO3" value="이일환"/>
	<jsp:setProperty property="myAge" name="tVO3" value="25"/>
	
	<!-- getter method호출하여 웹 브라우저로 출력  -->
	이름: <jsp:getProperty property="name" name="tVO3"/><br/>
	나이: <jsp:getProperty property="myAge" name="tVO3"/><br/>
	<%
		//<jsp:useBean id=는 객체명이므로 자바코드로 직접 접근하여 사용할 수 있다.
		tVO3.setName("이인혁");
		tVO3.setMyAge(30);
	%>
	이름 : <%= tVO3.getName() %><br/>
	나이 : <%= tVO3.getMyAge() %><br/>
	
	
</body>
</html>











