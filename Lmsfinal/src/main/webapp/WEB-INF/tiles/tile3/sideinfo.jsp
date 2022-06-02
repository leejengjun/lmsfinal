<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.net.InetAddress"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- ======= #27. tile1 중 header 페이지 만들기 (#26.번은 없다 샘이 장난침.) ======= --%>
<%
   String ctxPath = request.getContextPath();

   // === #172. (웹채팅관련3) === 
   // === 서버 IP 주소 알아오기(사용중인 IP주소가 유동IP 이라면 IP주소를 알아와야 한다.) ===
   InetAddress inet = InetAddress.getLocalHost(); 
   String serverIP = inet.getHostAddress();
   
 // System.out.println("serverIP : " + serverIP);
 // serverIP : 211.238.142.72
   
   // String serverIP = "211.238.142.72"; 만약에 사용중인 IP주소가 고정IP 이라면 IP주소를 직접입력해주면 된다.
   
   // === 서버 포트번호 알아오기   ===
   int portnumber = request.getServerPort();
 // System.out.println("portnumber : " + portnumber);
 // portnumber : 9090
   
   String serverName = "http://"+serverIP+":"+portnumber; 
 // System.out.println("serverName : " + serverName);
 // serverName : http://211.238.142.72:9090 
%>

<%-- ======= tile2 중 sideinfo 페이지 만들기  ======= --%>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<style>
body {
  font-family: "Lato", sans-serif;
}

/* Fixed sidenav, full height */
.sidenav {
  height: 100%;
  width: 200px;
  position: fixed;
  z-index: 1;
  top: 0;
  left: 0;
  background-color: gray;
  overflow-x: hidden;
  padding-top: 100px;
}

/* Style the sidenav links and the dropdown button */
.dropdown-btn, #mysideinfo > div > a {
  padding: 6px 8px 6px 16px;
  text-decoration: none;
  font-size: 18px;
  color: #b5b5b5;
  display: block;
  border: none;
  background: none;
  width: 100%;
  text-align: left;
  cursor: pointer;
  outline: none;
}

.sidenav a {
  padding: 6px 8px 6px 20px;
  text-decoration: none;
  font-size: 16px;
  color: #b5b5b5;
  display: block;
  border: none;
  background: none;
  width: 100%;
  text-align: left;
  cursor: pointer;
  outline: none;
}

/* On mouse-over */
.sidenav a:hover, .dropdown-btn:hover {
  color: #f1f1f1;
}

/* Main content */
.main {
  margin-left: 200px; /* Same as the width of the sidenav */
  font-size: 20px; /* Increased text to enable scrolling */
  padding: 0px 10px;
}

/* Add an active class to the active dropdown button 클릭시 배경색깔*/
.active {
  background-color: #b1b7fa;
  color: black;
}

/* Dropdown container (hidden by default). Optional: add a lighter background color and some left padding to change the design of the dropdown content */
.dropdown-container {
  display: none;
  background-color: #262626;
  padding-left: 8px;
}

/* Optional: Style the caret down icon */
.fa-caret-down {
  float: right;
  padding-right: 8px;
}

/* Some media queries for responsiveness */
@media screen and (max-height: 450px) {
  .sidenav {padding-top: 15px;}
  .sidenav a {font-size: 18px;}
}

#mysideinfo > div.sidenav > div:nth-child(7) > div {
	padding-top: 100px;
}
</style>

<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>

<div class="sidenav">

<div style="color: white; font-size: 20px; font-weight: bold; margin-top: -70px; padding-left: 20px;">SIST</div>

<!-- === #49. 로그인이 성공되어지면 로그인되어진 사용자의 아이디를 출력하기 === -->
	<div style="margin-bottom: 50px; padding-left: 20px;">
	
	<c:if test="${not empty sessionScope.loginuser}">
       <div style="color: white;">
       		<c:if test="${sessionScope.loginuser.status eq 1}"> 
				<span style="color: navy; font-weight: bold;">${userid}</span> 님&nbsp;&nbsp;
            </c:if>
         	
         	<c:if test="${sessionScope.loginuser.status eq 2}"> 
				<span style="color: navy; font-weight: bold;">${userid}</span> 님&nbsp;&nbsp;
            </c:if>
         
         	<c:if test="${sessionScope.loginuser.status eq 3}"> 
				<span style="color: navy; font-weight: bold;">${userid}</span> 님&nbsp;&nbsp;
            </c:if>
         <span style="display: inline-block; border: solid 2px gray; background-color: gray; width: 60px; height: 30px;"><a href="<%=ctxPath%>/logout.lmsfinal" style="color: white; font-size: 8pt; text-align: center; padding: 3px 1px;">로그아웃</a></span>
       </div>
    </c:if>
      
    <c:if test="${empty sessionScope.loginuser}">
       <div style="">
         <span style="display: inline-block; border: solid 2px gray; background-color: gray;"><a href="<%=ctxPath%>/login.lmsfinal" style="color: white; font-size: 6pt;">로그인</a></span>
       </div>
    </c:if>
	</div>

   <!-- 집으로 돌아가기  -->
   <div style="">
        <span style="display: inline-block;"><a href="<%=ctxPath%>/home.lmsfinal" style="color: #ddd;"><i class="fas fa-home fa-2x"></i></a></span>
   </div>
    <c:forEach var="mylecturevo" items="${requestScope.mylectureList}" varStatus="status">
       
<!-- 로그인한 사용자의 status 가 1(관리자) 이라면 보이는 메뉴들 -->
	<c:if test="${not empty sessionScope.loginuser and sessionScope.loginuser.status eq 1}">
		<h5 style="color: navy; font-weight: bold; margin-top: 30px; padding-left: 20px;">${mylecturevo.classname}</h5>
	  	<div id="lecturehomesidevar" style="margin-top: 20px; padding-left:10px;">			
		 <p><a href="<%=ctxPath%>/goLecturehome.lmsfinal?subjectid=${subjectid}&subjectid=${seq_lectureplan}">강의계획서</a></p>
         <p><a href="<%=ctxPath%>/noticeList.lmsfinal?subjectid=${subjectid}">공지사항</a></p>
       </div>
    </c:if>  
    
    
    <!-- 로그인한 사용자의 status 가 2(학생) 이라면 보이는 메뉴들 -->
	<c:if test="${not empty sessionScope.loginuser and sessionScope.loginuser.status eq 2}">
		<h5 style="color: navy; font-weight: bold; margin-top: 30px; padding-left: 20px;">${mylecturevo.classname}</h5>
	  	<div id="lecturehomesidevar" style="margin-top: 20px; padding-left:10px;">			
		 <p><a href="<%=ctxPath%>/viewlectureplan.lmsfinal?subjectid=${subjectid}&seq_lectureplan=${mylecturevo.seq_lectureplan}">강의계획서</a></p>
         <p><a href="<%=ctxPath%>/noticeList.lmsfinal?subjectid=${subjectid}">공지사항</a></p>
         <p><a href="#">강의평가</a></p>
         <p><a href="<%=ctxPath%>/testroundList.lmsfinal?subjectid=${subjectid}">시험응시</a></p>
        </div>
     </c:if> 
         
     <!-- 로그인한 사용자의 status 가 3(교수) 이라면 보이는 메뉴들 -->
	<c:if test="${not empty sessionScope.loginuser and sessionScope.loginuser.status eq 3}">
	     <h5 style="color: navy; font-weight: bold; margin-top: 30px; padding-left: 20px;">${mylecturevo.classname}</h5>
	  	 <div id="lecturehomesidevar" style="margin-top: 20px; padding-left:10px;">			
		 <p><a href="<%=ctxPath%>/viewlectureplaninlectureroom.lmsfinal?subjectid=${subjectid}&seq_lectureplan=${mylecturevo.seq_lectureplan}">강의계획서</a></p>
        <p><a href="<%=ctxPath%>/noticeList.lmsfinal?subjectid=${subjectid}">공지사항</a></p>
         <p><a href="<%=ctxPath%>/attendanceList.lmsfinal?subjectid=${subjectid}">출결관리</a></p>
         <p><a href="<%=ctxPath%>/gradeResultList.lmsfinal?subjectid=${subjectid}">성적관리</a></p>
         <p><a href="<%=ctxPath%>/testroundList.lmsfinal?subjectid=${subjectid}">시험관리</a></p>
         <p><a href="<%=ctxPath%>/viewlectureevaluation.lmsfinal?subjectid=${subjectid}">강의평가조회</a></p>
        </div>
     </c:if>          
</c:forEach>
</div>


<script type="text/javascript">

</script>