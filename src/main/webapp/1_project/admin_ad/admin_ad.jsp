<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자_광고관리</title>
<link rel="stylesheet" type="text/css"
   href="../common/css/admin.css?after">
<link rel="stylesheet" type="text/css" href="css/admin_ad.css?after">
<script src="js/admin_ad.js" defer></script>
</head>
<body>
   <jsp:include page="../common/admin.jsp" />
   <div class="common_admin">
      <h1>광고관리</h1>
      <div class="ad-summary">
         <div class="ad-active">
            <span>활성광고 : </span> <span class="ad-count">null</span>
            <!-- 활성 광고 수 -->
         </div>
         <div class="total-impressions">
            <span>총 수익 : </span> <span class="total-amount">null</span>
            <!-- 총 수익 -->
         </div>
         <div class="total-clicks">
            <span>활성광고 클릭 수 : </span> <span class="total-clicks-count">null</span>
            <!-- 총 클릭 수 -->
         </div>
      </div>
      <div class="order-management">
         <div class="ad-filter">
            <input type="text" placeholder="광고 검색" class="search-bar">
            <button class="search-btn">검색</button>
            <div class="add-ad-btn">
               <button class="csv-download-btn">Excel로 다운로드</button>
               <button class="ad-btn" onclick="openAddAdModal()">광고 추가</button>
            </div>
         </div>

      <%-- 광고 관리 - 광고 검색  --%>

            <% 
   
   int totalCount=0; //총 레코드의 수
      
      //기본 한 페이지에 표시할 광고수:20
      //페이지 네비게이션 기능: 이전 페이지. 다음 페이지, 첫 페이지, 마지막 페이지로 이동하는 버튼 제공
      //사용자가 특정 페이지 번호를 선택항 이동할 수 있는 기능 제공
      //검색 결과에 대한 페이징 처리도 동일하게 적용
      
      
   AdDAO aMDAO=AdDAO.getInstance(sVO); //총 레코드 수를 조회하여 totalCount저장
      
      //2. 한 화면에 보여줄 레코드의 수 

   int pageScale=20; //한 화면에 표시할 광고수 20 
   
   //3.총 페이지 수
   int totalPage=(int)Math.ceil((double)totalCount/pageScale);
   
   //4.검색의 시작번호를 구하기 ( pagination의 번호) [1][2][3]
   String paramPage=request.getParameter("currentPage");

   int currentPage=1;   
   if(paramPage != null){
      try{
         currentPage=Integer.parseInt(paramPage);
      }catch(NumberFormatException nfe){
      }//end catch
   }//end if
         
   int startNum=currentPage*pageScale-pageScale+1;//시작번호
   //5. 끝번호 
   int endNum=startNum+pageScale-1; //끝 번호
   
   sVO.setStartNum(startNum);
   sVO.setEndNum(endNum);
   
   
   out.print(sVO); 
   
   List<AdMainVO> listAd = null;
   try{
      listAd=AdDAO.selectBoard(sVO); 
      //시작번호, 끝 번호를 사용한 게시글 조회
   
      
      String tempSubject="";
      for(AdMainVO tempVO : listAd){ //저장할 객체 tempVO
         tempSubject=tempVO.getSubject();
         if(tempSubject.length() > 30){
             //게시글 제목의 길이를 체크하여 30자를 초과하는 경우, 제목을 29자로 자르고 말줄임표(...)를 추가
            tempVO.setSubject(tempSubject.substring(0, 29)+"...");
         }
      }//end for
      
   }catch(SQLException se){
      se.printStackTrace();
   }//end catch
   
   pageContext.setAttribute("totalCount", totalCount);
   pageContext.setAttribute("pageScale", pageScale);
   pageContext.setAttribute("totalPage", totalPage);
   pageContext.setAttribute("currentPage", currentPage);
//   pageContext.setAttribute("startNum", startNum);
//   pageContext.setAttribute("endNum", endNum); 
   pageContext.setAttribute("listAd", listAd);
   
   %>
      <%-- 관리자 페이지 로그인 여부에 따라 변수에 값 할당--%>
   <c:set var="loginFlag" value="javascript:loginMove()"/> 
   <%--loginFlag라는 변수를 설정하고 초기값으로 javascript:loginMove()를 할당 --%>
   <c:if test="${ not empty userData }">
   <%-- userData에 변수가 비어(로그인)있으면 아래 코드 실행 --%>
   <c:set var="loginFlag" value="ad_modal.jsp"/>
   <%-- 로그인 한 상태에서면 편집 기능 사용 가능 --%>
   </c:if>

   <a href = "${ loginFlag }">편집</a>

   <table class="ad-table">
    <thead>
        <tr>
            <th>광고번호</th>
            <th style="width: 150px;">광고 기간</th>
            <th style="width: 180px;">광고주 이름</th>
            <th>광고주 연락처</th>
            <th>광고비용</th>
            <th>클릭 수</th>
            <th style="width: 150px;">입력일</th>
            <th style="width: 100px;">광고상태</th>
            <th style="width: 150px;">
               <div class="pagination">
                <button class="prev-page">◀</button>
                <span>null / null</span>
                <button class="next-page">▶</button>
            </div>
            </th>
        </tr>
    </thead>
    <tbody>
       <c:if test="${ empty listAd }"> 
       <%-- 시작 번호 끝 번호 조회 --%>
   <tr>
      <td style="text-align: center" colspan="4">
      <br>
      <a href="ad_modal.jsp">편집</a> 
      <%-- ad_modal: 광고 정보 추가
      	ad_edit_modal: 광고 정보 수정--%>
      </td>
   </tr>
   </c:if>
       <c:if test = "${not empty param.keyword }">
   <c:set var = "searchParam" value = "&field=${ param.field }&keyword=${param.keyword }"/>
   </c:if>
   <!-- 검색창: keyword에 검색한 기록이 그대로 남아있게 하기 -->
   
   
   <c:forEach var="adMainVO" items="${ listAd }" varStatus="i">
   <!-- listAd를 순회하며 게시글을 출력합니다. 
   광고번호, 광고기간, 광고주 이름, 광고주 연락처, 광고비용, 클릭수, 입력일, 광고상태를 테이블 행에 각각 표시
 -->   <tr>
      <td><c:out value="${i.count}"/></td>
      <td><a href="board_detail.jsp?num=${ adMainVO.num }&currentPage=${ currentPage }${ searchParam }"><c:out value="${ adMainVO.subject }"/></a></td>
      <td><c:out value="${ adMainVO.writer }/${ adMainVO.ip }"/></td>
      <td><fmt:formatDate value="${ adMainVO.input_date }" pattern="yyyy-MM-dd EEEE HH:mm"/></td>
   <!-- 입력일을 지정된 날짜 형식(yyyy-MM-dd EEEE HH
)으로 포맷  -->
   </tr> 
   </c:forEach>
   </tbody>
   </table>
   </div>
   
   <%--검색창 및 검색 기록 유지 기능 
   SearchVO:현재페이지, 시작번호, 끝 번호, 검색컬럼, 검색값, 검색URL --%>
   
   
   <div id="search" style="height: 60px;text-align: center">
   <form action="board_list.jsp" method="get" name="searchFrm" id="searchFrm">
      <input type="text" name="keyword" value = "${param.keyword }" id = "keyword" style="width: 200px"/>
      <!-- 이전 검색어를 그대로 유지하기 위해 keyword 값이 파라미터로 전달 -->
      <input type="button" value="검색" id="btn" class="btn btn-sm btn-primary"/>
      <input type="text" style="display: none"/>
   </form>
        <tr>
           <td>
              <button class="edit-btn" onclick="openEditAdModal('PROD001')">편집</button>
                <button class="action-btn delete-btn" onclick="deleteProduct()">종료</button>
           </td>
        </tr>
    </tbody>
</table>
   </div>
   
   <% 
      //1. 한 화면에 보여줄 인덱스의 수 [1][2][3]
      int pageNumber = 3;
      //2. 화면에 보여줄 시작페이지 번호(1,2,3이면 1시작 4,5,6이면 4시작 7,8,9이면 7시작)
      int startPage = ((currentPage-1)/pageNumber)*pageNumber+1;
      //3. 화면에 보여줄 마지막 페이지 번호
      int endPage=startPage+pageNumber-1;
      //4. 총 페이지 수가 연산된마지막 페이지 수보다 작다면 총 페이지수가 마지막 페이지수로 설정된다. 
      if(totalPage <= endPage) {
         
         endPage=totalPage; 
      }
      
      //5. 첫 페이지가 인덱스 화면이 아닌 경우 (3보다 큰 경우)
      
      int movePage=0; 
      String prevMark="[   &lt;&lt;   ]"; 
      
      
      if(currentPage > pageNumber) {//현재페이지가 pagination의 수보다 크면
         //이전으로 가서 링크를 만들어준다. 
         movePage=startPage-1; //4,5,6 -> 1  7,8,9->4
         prevMark="[<a href=\"board_list.jsp?currentPage="+movePage
         +"\">&lt;&lt;</a> ]"; 
         
         
         
      }//end if
      
      
   %>
   처음번호<%= startPage %>
   마지막번호<%= endPage %>
   

   <%= prevMark %>◀
   <% 
      //6. 시작페이지번호부터 끝 페이지 번호까지 화면에 출력
      movePage=startPage; 
   
      String pageLink=""; 
      
      while(movePage <= endPage){
         pageLink="[ <a href = 'board_list.jsp?currentPage="+movePage+"'>"+movePage+"</a> ]"; 
         
         if(movePage == currentPage) { //현재 페이지는 링크를 설정하지 않는다. 
            pageLink="[" + movePage+" ]";
         
            
         }//end if
         out.print(pageLink); 
         movePage++; 
         
         
      }//end while
   //7. 뒤에 페이지가 더 있는 경우
   String nextMark="[   &gt;&gt; ]"; 
      if(totalPage > endPage) {
         movePage=endPage+1; 
         nextMark="[ <a href = 'board_list.jsp?currentPage="+movePage
               +"'> &gt;&gt;</a> ]"; 
      }
   %>
   ▶<%= nextMark %>

         <div class="pagination">
			<%-- 추가할 내용은 여기에 --%>
         </div>
      </div>
   <script src="../common/js/admin.js"></script>
   <div id="editAdModal" style="display: none;">
      <jsp:include page="ad_edit_modal.jsp" />
   </div>
   <div id="adModal" style="display: none;">
      <jsp:include page="ad_modal.jsp" />
   </div>
</body>
</html>