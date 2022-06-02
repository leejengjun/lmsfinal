<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
 
<%
	String ctxPath = request.getContextPath(); 
	String classname = request.getParameter("classname");
%> 

<style>

.container {    
  /*  width: 700px*/
    float: left;
    width: 72.5%;
    position:relative;   
}
.homecontent{
	padding: 50px;
    border: 1px solid #ddd;
    margin-bottom: 20px;
}
.sidebar{
	padding: 50px;
	border: 1px solid #ddd;
/*	width: 150px;*/
	height: 620px;
	float: right;
	width: 27%;
	position:relative;
}
div#contents > aside {
	/*	border: solid 1px blue; */
		float: left;
		width: 20%;
		background-color: #999;
	}
div#contents > section {
/*	border: solid 1px red; */
	
	float: right;
	width: 72.5%;
	background-color: #333;
	color: #ffffe6;
/*	padding: 20px 0 0 40px; */
}
</style>

<script>

</script>


<div style="height:900px; width:1400px; display:inline-block;">
<div style="margin: auto; margin-left: 200px; padding-left: 3%; margin-top: 5%;">
	
<c:forEach var="mylecturevo" items="${requestScope.mylectureList}" varStatus="status">
			
   <div class="header">
	   <h5 style="color: navy; font-weight: bold; margin-top: 30px; padding-left: 20px;">${mylecturevo.classname} 홈페이지</h5>
   </div>
   <hr style="position: relative; top:10px; margin: 0; margin-bottom: 30px; ">

   <div class="container">
		

		<div class="homecontent" id="notice">		
	       
			<h5 style="color: navy; font-weight: bold;"><a href="<%=ctxPath%>/noticeList.lmsfinal?subjectid=${subjectid}">공지사항</a></h5>
		
			<div class="innercontainer w-100">
			
			<table style="width: 700px" class="table table-bordered">
				<thead>
			    <tr>
			    	<th style="width: 100px;  text-align: center;"></th>
					<th style="width: 400px; text-align: center;">제목</th>
					<th style="width: 200px; text-align: center;">공지날짜</th>
			    </tr>
				</thead>
				
				<tbody>
					<c:forEach var="noticevo" items="${requestScope.noticeList}" varStatus="status">
						<tr>
					    	<td align="center">
					        	${status.count}
					      	</td>
					      	<td align="left">
					      	 
					    <%-- === 댓글쓰기 및 답변형 및 파일첨부가 있는 게시판 시작 === --%>
					    	<%-- 첨부파일이 없는 경우 시작 --%>
					       	<c:if test="${empty noticevo.snfilename}">	 
						    	<span class="subject" onclick="goView('${noticevo.subnoticeno}')">${noticevo.snsubject}</span>    	   
					       	</c:if>
					       	<%-- 첨부파일이 없는 경우 끝 --%>
					       	<%-- 첨부파일이 있는 경우 시작 --%>
					        <c:if test="${not empty noticevo.snfilename}">	 
						    	<span class="subject" onclick="goView('${noticevo.subnoticeno}')">${noticevo.snsubject}</span>&nbsp;<img src="<%= ctxPath%>/resources/images/duHyeon/disk.gif" /> 
					      	</c:if>
					       	<%-- 첨부파일이 있는 경우 끝 --%>	 
					    <%-- === 댓글쓰기 및 답변형 및 파일첨부가 있는 게시판 끝 === --%>
					      	</td>
							<td align="center">${noticevo.snregdate}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		  </div>
	 </div> 
	 
	 <div class="homecontent" id="classinfo" style="height:200px">
	 	<h5 style="color: navy; font-weight: bold;">학습관리</h5>
	  </div>  
	</div>	
	  <div class="sidebar" id="classinfo">
	    	
		    <h5 style="color: navy; font-weight: bold;">강의정보</h5>
				  
			<table style="width: 200px" class="table table-bordered">
		<thead>
		<tr><th colspan="2" style="text-align: center;">${mylecturevo.classname}</th></tr>
		</thead>
		
		<tbody>
				<tr>
					<th style="width: 80px;  text-align: center;">학과</th>
					<td align="center">${mylecturevo.deptname}</td>
				</tr>
				<tr>
					<th style="width: 80px;  text-align: center;">코드</th>
					<td align="center">${mylecturevo.subjectid}</td>
				</tr>
				<tr>
					<th style="width: 80px;  text-align: center;">학년</th>
					<td align="center">${mylecturevo.opensemester}</td>
				</tr>
				<tr>
					<th style="width: 80px; text-align: center;">학점</th>
					<td align="center">${mylecturevo.credit}</td>
				</tr>
				<tr>
					<th style="width: 80px;  text-align: center;">위치</th>
					<td align="center">${mylecturevo.lctrid}</td>
				</tr>
				<tr>
					<th style="width: 80px;  text-align: center;">시간</th>
					<td align="center">${mylecturevo.dayid}</td>
				</tr>
			
		</tbody>
		
	</table>
	  
		
		

	   </div>

	</c:forEach>

</div>

</div>	