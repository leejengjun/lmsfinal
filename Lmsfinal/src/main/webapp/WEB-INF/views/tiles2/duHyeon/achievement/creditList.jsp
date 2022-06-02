<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<%
	String ctxPath = request.getContextPath();
%> 
<style type="text/css">
	th {background-color: #DDD}

    .subjectStyle {font-weight: bold;
    			   color: navy;
    			   cursor: pointer;}

    a {text-decoration: none !important;}
    
    
    tbody > tr:hover {background-color: #4c4c4ce6; cursor: pointer;}
    
  


.innercontainer {
  border-radius: 5px;
  background-color: #f2f2f2;
  padding: 20px;
}
.container{
	padding:20px;
}

.container > div.navbar > div.col-3{
	text-align: center;
	height:49px;
	border: solid 1px black;
	margin:0 auto;
	padding:0;
}
.container > div.navbar > div.col-3 > a{
	
	position: absolute;
	top:10px;
}
.col-25 {
  float: left;
  width: 25%;
  margin-top: 6px;
}

.col-75 {
  float: left;
  width: 75%;
  margin-top: 6px;
}

/* Clear floats after the columns */
.row:after {
  content: "";
  display: table;
  clear: both;
}
</style>    
    
    
<script type="text/javascript">
function goView(courseno){
	
	location.href="<%= ctxPath%>/detailcredit.lmsfinal?courseno="+courseno;   
	  
}
</script>    


<div style="display: flex;">
<div class="container w-75" style="margin: 250px; padding:0;">

	<h2 style="margin-bottom: 30px;">성적 목록</h2>
	


	<table class="table table-bordered">
		<thead>
	    <tr>
	    	<th style="width: 100px; text-align: center;">이름</th>
			<th style="width: 100px; text-align: center;">학번</th>
			<th style="width: 200px; text-align: center;">과목명</th>
			<th style="width: 100px; text-align: center;">중간점수</th>
			<th style="width: 100px; text-align: center;">기말점수</th>
			<th style="width: 100px; text-align: center;">출석점수</th>
			<th style="width: 100px; text-align: center;">과제점수</th>
			<th style="width: 100px; text-align: center;">최종학점</th>
	    </tr>
		</thead>
		
		<tbody>
			<c:if test="${ not empty requestScope.graderesultList}">
			
				<c:forEach var="graderesult" items="${requestScope.graderesultList}" varStatus="status">
					<tr onclick="goView('${graderesult.courseno}')">
				    	<td align="center">${graderesult.stdname}</td>
				    	
				      	<td align="left">
					    	${graderesult.stdid}	   
				      	</td>
						<td align="center">${graderesult.classname}</td>
						
						
						<c:if test="${empty graderesult.midscore}">
							<td align="center"><span>입력전</span></td>
						</c:if>
						<c:if test="${not empty graderesult.midscore}">
							<td align="center">${graderesult.midscore}</td>
						</c:if>
						
						<c:if test="${empty graderesult.finalscore}">
							<td align="center"><span>입력전</span></td>
						</c:if>
						<c:if test="${not empty graderesult.finalscore}">
							<td align="center">${graderesult.finalscore}</td>
						</c:if>
						
						<c:if test="${empty graderesult.attscore}">
							<td align="center"><span>입력전</span></td>
						</c:if>
						<c:if test="${not empty graderesult.attscore}">
							<td align="center">${graderesult.attscore}</td>
						</c:if>
						
						<c:if test="${empty graderesult.taskscore}">
							<td align="center"><span>입력전</span></td>
						</c:if>
						<c:if test="${not empty graderesult.taskscore}">
							<td align="center">${graderesult.taskscore}</td>
						</c:if>
						
						<c:if test="${empty graderesult.grade}">
							<td align="center"><span>입력전</span></td>
						</c:if>
						<c:if test="${not empty graderesult.grade}">
							<td align="center">${graderesult.grade}</td>
						</c:if>
						
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty requestScope.graderesultList}">
				<tr> 
					<td colspan="2" style="background-color: #fff; color: red; text-align: center;">수강 학생이 없습니다.</td>
				</tr>
			</c:if>
			
		</tbody>
	</table>
	
    <%-- === 페이지바 보여주기 === --%>  
    <div align="center" style="border: solid 0px gray; width: 70%; margin: 20px auto; ">
    	${requestScope.pageBar}
    </div>
 </div>
 

	
</div>

  