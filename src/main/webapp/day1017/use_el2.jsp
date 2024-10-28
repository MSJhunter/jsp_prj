<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="EL사용"
    isELIgnored="false"
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
<div>
<h2>web parameter 출력</h2>
<form action="use_el2.jsp">
<input type="text" name="name" placeholder="이름"/><br>
<input type="text" name="addr" placeholder="주소"/><br>

<label>취미</label>
<input type="checkbox" name="hobby" value="등산"/>등산<br>
<input type="checkbox" name="hobby" value="낚시"/>낚시<br>
<input type="checkbox" name="hobby" value="독서"/>독서<br>
<input type="checkbox" name="hobby" value="운동"/>운동<br>

<input type="submit" value="전송" class="btn btn-outline-primary"/>
</form>

<div>
입력값 <br/>
이름 : ${ param.name eq '' or param.name eq null ?"이름을 입력": param.name }<br>
주소 : ${ empty param.addr ? "주소 입력" : param.addr }<br>
<!-- 배열은 선택된 갯수만큼 반복해야한다. => JSTL의 <c:forEach >와 함께 사용. -->
취미 : ${ paramValues.hobby[0] }
${ paramValues.hobby[1] }
${ paramValues.hobby[2] }
${ paramValues.hobby[3] }<br>
</div>

<div>
<!-- nick이 없다면 아래 링크를 클릭해주세요 를 웹 브라우저로 출력하고
 nick 이 존재한다면 nick과 age에 설정된 값을 웹 브라우어제 출력.  -->
 ${ empty param.nick ? "아래 링크를 클릭해주세요": param.nick }
 ${ param.age }

</div>
<div>
<!-- 요청 링크를 클릭했을 때 nick의 값으로 test를,age를 20으로 
설정하여 현재 페이지로 요청하는 URL과 Query String을 작성 -->
<a href="http://localhost/jsp_prj/day1017/use_el2.jsp?nick=test&age=20">요청</a>
<a href="use_el2.jsp?nick=test2&age=202">요청</a>
</div>
</div>
<%
String msg="오늘은 목요일";
int temp=0;
%>
<!-- EL에서는 변수를 직접 접근할 수 없다. -->
${ msg }	
${ temp }	
</div>
</body>
</html>










