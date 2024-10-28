<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 태그 사용 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="shortcut icon" href="http://192.168.10.221/jsp_prj/common/images/favicon.ico"/>
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
	<a href="http://localhost/jsp_prj/member/join_frm.jsp">회원가입</a>
	
	<c:choose>
	<%-- c:choose는 if-else와 같은 구문으로 서로 다른 콘텐츠 표시
	c:when은 sessionScope.userData가 비어 있을 때 실행  
	이 경우 로그인하지 않은 상태로 간주하여'로그인' 링크를 표시
	c:otherwise는 로그인한 상태에서 표시됩니다. '로그아웃' 링크와 '마이페이지' 링크가 표시되며, 
	현재 로그인한 사용자의 userData.id와 userData.name을 표시 --%>
	<c:when test="${ empty sessionScope.userData }">
	<a href="http://localhost/jsp_prj/login/login_frm.jsp">로그인</a>
	</c:when>
	<c:otherwise>
	<a href="http://localhost/jsp_prj/login/login_out.jsp">로그아웃</a>
	<a href="http://localhost/jsp_prj/mypage/mypage.jsp" title="마이페이지"><c:out value="${ userData.id }(${userData.name })님 로그인 중"/></a>
	
	</c:otherwise>
	</c:choose>
	
	<a href="http://localhost/jsp_prj/board/board_list.jsp">게시판</a>
	
</div>
</body>
</html>