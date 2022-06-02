<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
    
<%
	String ctxPath = request.getContextPath();
    String gyowonid = String.valueOf(session.getAttribute("userid"));
    String subjectid = request.getParameter("subjectid");
    String seq_lectureplan = request.getParameter("seq_lectureplan");
    
%>    
<style type="text/css">
th {background-color: #DDD}
</style>

<script type="text/javascript">

  $(document).ready(function(){
	 
	// onclick="goEditlectureplan(seq_lectureplan)"	
	var subjectid = <%=subjectid%>;
	  
	  $.ajax({
   	   url: "<%= ctxPath%>/lctrplandetailSearch.lmsfinal",
   	   data: {"subjectid":<%=subjectid%>}, // data는 /MyMVC/member/isDuplicateCheck.up 로 전송해야할 데이터를 말한다.
   	   type: "POST", // type은 생략하면 "get"이다.
   	   dataType:"JSON",
   	   success: function(json){
   		   
   		  let html = "";
   		  
			  if(json.length > 0) {
				  $.each(json, function(index, item){
					  html += "<tr class='result'>";
					  html += "<td class='result'>"+item.lectureweek+"</td>";    	
					  html += "<td class='result'>"+item.lptopic+"</td>";    	
					  html += "<td class='result'>"+item.lpteaching+"</td>";
					  html += "<td class='result'>"+item.lpmaterial+"</td>";
					  html += "<td class='result'>"+item.lphomewk+"</td>";
					  html += "</tr>";
				  });
			  }
			  else {
				  html += "<tr>";
				  html += "<td colspan='5' class='result'>주차별 강의계획이 없습니다.</td>";
				  html += "</tr>";
			  }
			    
			  $("tbody#lecplandetailshow").html(html);
			  
			    
				 
   	   }, 
   	   error:function(request, status, error){
   		   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
   	   }

	});  
	
	
  });// end of $(document).ready(function(){})-------------------------------
  
  <%--
  function goEditlectureplan(seq_lectureplan) {
	   
	  location.href="<%=ctxPath%>/editlectureplan.lmsfinal?seq_lectureplan=" + seq_lectureplan;
	  
  }
  --%>
  <%--
  function goAddlecdetail(seq_lectureplan) {
	  // 나중엔 view로 바꾸고.. add단으로 옮길 것...
	  location.href="<%=ctxPath%>/addlectureplandetail.lmsfinal?subjectid=" + subjectid;
  }
  --%>
  
</script>

<div style="display: flex; height:1200px;">
	<div style="margin: auto; padding-left: 3%; margin-top: 3%;">

	<h3 style="margin-bottom:30px;">강의계획서</h3>

	
	
	<table style="width: 1024px" class="table table-bordered">
	<c:if test="${not empty requestScope.lctrplanvo}">
 	 	<tr>
			<th style="width: 15%; background-color: #DDDDDD;">강의명</th>
			<td>${requestScope.lctrplanvo.classname}</td>
		</tr>
		<tr>
			<th style="width: 15%; background-color: #DDDDDD;">학과</th>
			<td>${requestScope.lctrplanvo.deptname}</td>
		</tr>
		<tr>
			<th style="width: 15%; background-color: #DDDDDD;">교수</th>
			<td>${requestScope.lctrplanvo.gyoname}</td>
		</tr>
		<tr>
			<th style="width: 15%; background-color: #DDDDDD;">강의개요</th>
			<td>
				<p style="word-break: break-all;">${requestScope.lctrplanvo.lpsummary}</p>
			</td>
		</tr>
		<tr>
			<th style="width: 15%; background-color: #DDDDDD;">교과목표</th>
			<td>
				<p style="word-break: break-all;">${requestScope.lctrplanvo.lpobject}</p>
			</td>
		</tr>
		<tr>
			<th style="width: 15%; background-color: #DDDDDD;">교재 및 참고문헌</th>
			<td>
				<p style="word-break: break-all;">${requestScope.lctrplanvo.lpbook}</p>
			</td>
		</tr>
		<tr>
			<th style="width: 15%; background-color: #DDDDDD;">성적 비율</th>
			<td>
				<span>출석비율 : 0${requestScope.lctrplanvo.lpattendper}</span>
				<span>시험비율 : 0${requestScope.lctrplanvo.lpexamper}</span>
				<span>과제비율 : 0${requestScope.lctrplanvo.lphomewkper}</span>
			</td>
		</tr>
	</c:if>
	</table>
	
	<c:if test="${empty requestScope.lctrplanvo}">
    	<div style="padding: 50px 0; font-size: 16pt; color: red;" >강의계획서 데이터가 존재하지 않습니다</div>
    </c:if>
    
    <h5 style="margin-top: 50px; margin-bottom:30px;">▶ 주차별 강의계획서</h5>
	
	<table id="plandetail" style="width: 1024px; margin-top:30px;" class="table table-bordered">
      <thead>
         <tr><th colspan="5" style="text-align: center;">주차별 강의계획</th></tr>
         <tr><th style="text-align: center;">주</th>
            <th style="width: 23%;  text-align: center;">학습주제</th>
            <th style="width: 23%;  text-align: center;">수업방식</th>
            <th style="width: 23%;  text-align: center;">교수학습자료</th>
            <th style="width: 23%;  text-align: center;">과제</th></tr>
      </thead>
      <tbody id="lecplandetailshow">
      
      
      </tbody>
     </table>
	<div style="margin: 20px;">
	<c:if test="${sessionScope.loginuser.status eq 3}"> 
		<button type="button" class="btn btn-secondary btn-sm mr-3" onclick="location.href='<%=ctxPath%>/editlectureplan.lmsfinal?seq_lectureplan=<%=seq_lectureplan%>&subjectid=<%=subjectid%>'">수정하기</button>
	</c:if>
		<button type="button" class="btn btn-secondary btn-sm" onclick="javascript:history.back()">닫기</button>
	</div>
	
	
	
</div>
</div>
		
		
		