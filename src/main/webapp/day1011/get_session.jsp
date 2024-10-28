<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="세션에 설정된 값을 얻는 페이지"
    session="true"
    %>
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
<%
//session은 내장객체이므로 scriptlet나 expression에서 사용할 수 있다.
//1.세션 값 읽기
String name=(String)session.getAttribute("name");

Object objAge=session.getAttribute("age");

int age=0;
if(objAge != null){
	age=(int)objAge;
}//end if

%>
<%if( name == null ){%>
세션에 값이 존재하지 않습니다.<br/>
<form action="set_session.jsp">
<label for="name">이름</label>
<input type="text" name="name" id="name" /><br/>
<label for="age">나이</label>
<select name="age" id="id">
<%for(int i=20 ; i < 40 ;i++){ %>
<option value="<%= i %>"><%= i %></option>
<%}//end for %>
</select>
<button class="btn btn-sm btn-primary">입력</button>
</form>
<%}else{%>
세션에 값 있습니다.<br/>
<button type="button" class="btn btn-primary">
  <%= name  %> ${ name }님 안녕하세요?<span class="badge text-bg-secondary">나이는 <%= age %></span>
</button>
<br/>
<a href="remove_session.jsp">세션삭제</a>
<%}//end %>
</div>
</body>
</html>









