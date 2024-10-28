<%@page import="java.sql.SQLException"%>
<%@page import="kr.co.sist.user.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   <%@ include file = "../common/jsp/session_chk.jsp" %>
   <%@ include file = "../common/jsp/post_chk.jsp" %>
<jsp:useBean id = "bVO" class = "kr.co.sist.user.board.BoardVO" scope = "page"/>
<%-- 글 제목 내용 번호가 bVO객체에 입력 --%>
<jsp:setProperty name = "bVO" property="*" />
<%

	// 1. 글삭제 -> 글 번호만 가지고 삭제하면 남의 글도 삭제 가능
	// num, id가 일치하는 것으로 ->값 두개이나 parameter 
	
	//작성자는 로그인한 세션에서 받아온다. 
	bVO.setWriter(sessionId); 
	
	//2. 삭제
	
	BoardDAO bDAO=BoardDAO.getInstance(); 
	int rowCnt = 0; 
	
	
	try{
		
		rowCnt=bDAO.deleteBoard(bVO); 
		//0-num을 외부에서 편집, 1은 성공
		
		
	}catch(SQLException se) {
		rowCnt=-1; //DB에서 문제 발생
		se.printStackTrace(); 
		
	}//end catch
	
	pageContext.setAttribute("rowCnt", rowCnt); //${rowCnt} 
	
	
	


%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="http://192.168.10.221/jsp_prj/common/images/favicon.png">
<link rel = "stylesheet" type = "text/css" href = "http://192.168.10.221/jsp_prj/common/css/main_20240911.css"/>
<!-- bootstrap CDN 시작 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<!--JQuery 시작-->

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<style type="text/css"> 

</style>
<script type="text/javascript">


var msg = "문제가 발생했습니다. 잠시 후 다시 시도해주세요.";
var cnt = "${rowCnt}";


var flag = false; 
if(cnt == -1 || cnt == 0) {
	msg = "번호는 외부에서 임의로 편집할 수 없습니다."; 
	
}//end if

if(cnt == 1) {
	flag = true;
	msg = "${param.num}번 글을 삭제하였습니다."; 
	
}//end if

alert(msg);

if(flag) {
	location.href = "board_list.jsp?currentPage=${param.currentPage}"; 
	
	
}else{
	history.back(); 
	
	
}

$(function() {
	
}); //ready

</script>
</head>
<body>
<div id = "wrap"> 
	
	
	
	
	
</div>
</body>
</html>