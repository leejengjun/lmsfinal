<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>

<%
	String ctxPath = request.getContextPath();
%>   

<style type="text/css">
	th {background-color: #DDD}
	
	.subjectStyle {font-weight: bold;
					color: navy;
					cursor: pointer;}
	
	a {text-decoration: none; !important;}
	
</style>

<script type="text/javascript">

  $(document).ready(function(){
	  
	  $("span.subject").bind("mouseover", function(event){
		  const $target = $(event.target);
		  $target.addClass("subjectStyle");
	  });
	  
	$("span.subject").bind("mouseout", function(event){
		const $target = $(event.target);
		$target.removeClass("subjectStyle");  
	  });
	  
	
  });// end of $(document).ready(function(){})-------------------------------
  
  function goLecturehome(subjectid) {

	  location.href="<%=ctxPath%>/goLecturehome.lmsfinal?subjectid="+subjectid;
	  
	  
	  
  }// end of function goView(seq) 
  
 function goViewlecplan(subjectid, seq_lectureplan) {
	  
	 location.href="<%=ctxPath%>/viewlectureplan.lmsfinal?subjectid="+ subjectid +"&seq_lectureplan="+seq_lectureplan;
	   
    }
</script>
<div style="display: flex;">
<div style="margin: auto; margin-left: 250px; padding-left: 3%; margin-top: 5%;">
	<h3 style="margin-bottom: 30px;">내 강의 목록 보기</h3>
	<table style="width: 1200px" class="table table-bordered">
		<thead>
		<tr>
			<th style="width: 70px;  text-align: center;">번호</th>
			<th style="width: 70px;  text-align: center;">학과</th>
			<th style="width: 70px;  text-align: center;">강의코드</th>
	        <th style="width: 160px; text-align: center;">강의명</th>
	        <th style="width: 70px;  text-align: center;">대상학년</th>
	        <th style="width: 70px; text-align: center;">이수학점</th>
	        <th style="width: 70px;  text-align: center;">신청인원</th>
	        <th style="width: 70px;  text-align: center;">정원</th>
	        <th style="width: 70px;  text-align: center;">강의실</th>
	        <th style="width: 70px;  text-align: center;">강의시간</th>
	        <th style="width: 100px;  text-align: center;">강의계획서</th>
		</tr>
		</thead>
		
		<tbody>
		<tr>
			<c:if test="${not empty requestScope.mylectureList}">
				<c:forEach var="mylecturevo" items="${requestScope.mylectureList}" varStatus="status">
				<tr>
					<td align="center"><c:out value="${status.count}"/></td>
					<td align="center">${mylecturevo.deptname}</td>
					<td align="center">${mylecturevo.subjectid}</td>
					<td align="left">
						<span class="subject" onclick="goLecturehome('${mylecturevo.subjectid}')">${mylecturevo.classname}</span>
					</td>

					<td align="center">${mylecturevo.opensemester}</td>
					<td align="center">${mylecturevo.credit}</td>
					<td align="center">${mylecturevo.applyperson}</td>
					<td align="center">${mylecturevo.totalperson}</td>
					<td align="center">${mylecturevo.lctrid}</td>
					<td align="center">${mylecturevo.dayid}</td>
					<td align="center"><button type='button' class='btn btn-secondary btn-sm mr-3' onclick='goViewlecplan("${mylecturevo.subjectid}","${mylecturevo.seq_lectureplan}")'>계획서 보기</button>
	                    </td>
				</tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty requestScope.mylectureList}">
				<tr>
            		<td colspan="11" style="text-align: center;">내 강의가 존재하지 않습니다</td>
            	</tr>
			</c:if>
		</tr>
		</tbody>
	</table>
	

   
</div>
</div>