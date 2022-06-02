<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.net.InetAddress"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- ======= #27 tile1 중 header 페이지 만들기 (#26.번은 없다 샘이 장난침.) ======= --%>
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
	  background-color: #111;
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

<div><a class="navbar-brand" href="<%=ctxPath%>/home.lmsfinal" style="margin-top: -85px; margin-left: -7px;"><img src="<%= ctxPath %>/resources/images/jeongKyeongEun/sidelogo.png" style="width: 170px;"/></a></div>

<!-- === #49. 로그인이 성공되어지면 로그인되어진 사용자의 아이디를 출력하기 === -->
	<div style="margin-bottom: 50px; padding-left: 20px;">
	<c:if test="${not empty sessionScope.loginuser}">
       <div style="color: white;">
       		<c:if test="${sessionScope.loginuser.status eq 1}"> 
				<span style="color: white; font-weight: bold;">관리자</span> 님&nbsp;&nbsp;
            </c:if>
         	
         	<c:if test="${sessionScope.loginuser.status eq 2}"> 
				<span style="color: white; font-weight: bold;">${sessionScope.loginuser.stdid}</span> 님&nbsp;&nbsp;
            </c:if>
         
         	<c:if test="${sessionScope.loginuser.status eq 3}"> 
				<span style="color: white; font-weight: bold;">${sessionScope.loginuser.gyowonid}</span> 님&nbsp;&nbsp;
            </c:if>
         <span style="display: inline-block; border: solid 2px gray; background-color: gray; width: 60px; height: 30px;"><a href="<%=ctxPath%>/logout.lmsfinal" style="color: white; font-size: 8pt; text-align: center; padding: 3px 1px;">로그아웃</a></span>
       </div>
    </c:if>
      
    <c:if test="${empty sessionScope.loginuser}">
       <div style="">
         <span style="display: inline-block; border: solid 2px gray; background-color: gray; float: right; margin-right: 20px;"><a href="<%=ctxPath%>/login.lmsfinal" style="color: white; font-size: 9pt; padding: 5px;">로그인</a></span>
       </div>
    </c:if>
	</div>

<!-- 로그인한 사용자의 status 가 1(관리자) 이라면 보이는 메뉴들 -->
	<c:if test="${not empty sessionScope.loginuser and sessionScope.loginuser.status eq 1}">
		<button class="dropdown-btn">회원관리 
		  <i class="fa fa-caret-down"></i>
	    </button>
	    <div class="dropdown-container">
	    	<a href="<%=ctxPath%>/stdRegister.lmsfinal">학생등록</a>
			<a href="<%=ctxPath%>/gyowonRegister.lmsfinal">교수등록</a>
		    <a href="<%=ctxPath%>/gyowonList.lmsfinal">회원조회</a>
		</div>
		
		<button class="dropdown-btn">강의관리 
			<i class="fa fa-caret-down"></i>
		</button>
		<div class="dropdown-container">
		    <a href="<%=ctxPath%>/gyoOpenedList.lmsfinal">교수강의개설</a>
		</div>
		
		<button class="dropdown-btn">게시물관리 
		    <i class="fa fa-caret-down"></i>
		</button>
		<div class="dropdown-container">
		    <a href="<%=ctxPath%>/noticeList.lmsfinal">공지사항</a>
		    <a href="<%=ctxPath%>/faq.lmsfinal">FAQ</a>
		</div>
	</c:if>
	
	
	<!-- 로그인한 사용자의 status 가 2(학생) 이라면 보이는 메뉴들 -->
	<c:if test="${not empty sessionScope.loginuser and sessionScope.loginuser.status eq 2}">
		<button class="dropdown-btn">My Page 
		    <i class="fa fa-caret-down"></i>
		</button>
		<div class="dropdown-container">
		    <a href="<%= ctxPath%>/profile.lmsfinal">개인정보 조회/수정</a>
		    <a href="<%= ctxPath%>/stdscholarship.lmsfinal"">장학금 지급내역</a>
		    <a href="<%= ctxPath%>/result_grade.lmsfinal"">성적확인</a>
		    <a href="<%= ctxPath%>/Application_for_leave_of_absence.lmsfinal">휴학신청</a>
		    <a href="<%= ctxPath%>/leave_result.lmsfinal">휴학신청결과조회</a>
		    <a href="<%= ctxPath%>/Application_for_returnSchool.lmsfinal">복학신청및결과조회</a>
		    <a href="<%= ctxPath%>/schedule/scheduleManagement.lmsfinal"">일정</a>
		</div>
		
		<button class="dropdown-btn">나의 강좌 
		    <i class="fa fa-caret-down"></i>
		</button>
		<div class="dropdown-container">
		    <a href="<%=ctxPath%>/mylecture.lmsfinal">내 강의실</a>
		    <a href="<%= ctxPath%>/course_application.lmsfinal">수강신청</a>
		    <a href="<%= ctxPath%>/mycourseList.lmsfinal?stdid=${sessionScope.loginuser.userid}">수강신청내역</a>
		    <a href="<%= ctxPath%>/lecture_evaluation.lmsfinal">강의평가</a>
		</div>
		
	</c:if>
	
	
	<!-- 로그인한 사용자의 status 가 3(교수) 이라면 보이는 메뉴들 -->
	<c:if test="${not empty sessionScope.loginuser and sessionScope.loginuser.status eq 3}">
		<button class="dropdown-btn">My Page 
		    <i class="fa fa-caret-down"></i>
		</button>
		<div class="dropdown-container">
		    <a href="<%=ctxPath%>/gyowoninfo.lmsfinal">개인정보 조회/수정</a>
		    <a href="<%=ctxPath%>/schedule/scheduleManagement.lmsfinal">일정</a>
		</div>
		
		<button class="dropdown-btn">나의 강좌 
		    <i class="fa fa-caret-down"></i>
		</button>
		<div class="dropdown-container">
		    <a href="<%=ctxPath%>/mylecture.lmsfinal">내 강의실</a>
		    <a href="<%=ctxPath%>/applylecture.lmsfinal">강의신청</a>
		</div>
	</c:if>
	
	
	<%-- 추후에 없애는 부분(학생페이지에 비회원 사이드바 적용 예정) --%>
	<button class="dropdown-btn">이용안내
		    <i class="fa fa-caret-down"></i>
		</button>
		<div class="dropdown-container">
		    <a href="<%=ctxPath%>/noticeList.lmsfinal">공지사항</a>
		    <a href="<%=ctxPath%>/faq.lmsfinal">FAQ</a>
		</div>

</div>	
<script type="text/javascript">

/* Loop through all dropdown buttons to toggle between hiding and showing its dropdown content - This allows the user to have multiple dropdowns without any conflict */
var dropdown = document.getElementsByClassName("dropdown-btn");
var i;

for (i = 0; i < dropdown.length; i++) {
  dropdown[i].addEventListener("click", function() {
    this.classList.toggle("active");
    var dropdownContent = this.nextElementSibling;
    if (dropdownContent.style.display === "block") {
      dropdownContent.style.display = "none";
    } else {
      dropdownContent.style.display = "block";
    }
  });
}

</script>