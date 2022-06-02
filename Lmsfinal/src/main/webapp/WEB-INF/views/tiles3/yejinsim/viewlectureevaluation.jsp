<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
    
<%
	String ctxPath = request.getContextPath();
    String subjectid = request.getParameter("subjectid");
%>    
<style type="text/css">
th {background-color: #DDD}
.subjectStyle {background-color: #d5d5d5}
td.result {text-align: center;}
tr.result:hover {
		background-color: #d5d5d5;
	}
tr.avgresult {
	background-color: #ddd;
}
</style>

<script type="text/javascript">

  $(document).ready(function(){
	
	  
  });// end of $(document).ready(function(){})-------------------------------
  
  function goViewlctrevaluresult(){
	  
	  var subjectid = ${subjectid};
	  
	  $.ajax({
   	   url: "<%= ctxPath%>/lctrevaluresultSearch.lmsfinal",
   	   data: {"subjectid":subjectid}, // data는 /MyMVC/member/isDuplicateCheck.up 로 전송해야할 데이터를 말한다.
   	   type: "POST", // type은 생략하면 "get"이다.
   	   dataType:"JSON",
   	   success: function(json){
   		   
   		  let html = "";
			  if(json.length > 0) {
				  $.each(json, function(index, item){
					  html += "<tr class='result'>";
					  html += "<td class='result'>"+(index+1)+"</td>";    	
					  html += "<td class='result'>"+item.firstans+"</td>";    	
					  html += "<td class='result'>"+item.secondans+"</td>";
					  html += "<td class='result'>"+item.thirdans+"</td>";
					  html += "<td class='result'>"+item.fourans+"</td>";
					  html += "<td class='result'>"+item.fiveans+"</td>";
					  html += "<td class='result'>"+item.sixans+"</td>";
					  html += "<td class='result'>"+item.sevenans+"</td>";
					  html += "<td class='result'>"+item.eightans+"</td>";
					  html += "<td class='result'>"+item.etcans+"</td>";
					  html += "</tr>";
				  });
				  if (json.length > 1){
				  getavgresult(subjectid);
				  }
			  }
			  else {
				  html += "<tr>";
				  html += "<td colspan='10' class='result'>강의평가 데이터가 없습니다.</td>";
				  html += "</tr>";
			  }
			    
			  $("tbody#lctrevaluresultDisplay").html(html);
			  
			    
				 
   	   }, 
   	   error:function(request, status, error){
   		   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
   	   }

	});  
  }
  
  function getavgresult(subjectid){
  
	  $.ajax({
	   	   url: "<%= ctxPath%>/lctrevaluavgresultSearch.lmsfinal",
	   	   data: {"subjectid":subjectid}, // data는 /MyMVC/member/isDuplicateCheck.up 로 전송해야할 데이터를 말한다.
	   	   type: "POST", // type은 생략하면 "get"이다.
	   	   dataType:"JSON",
	   	   success: function(json){ 
	   		   
	   	    let html_2 = "";
	   	    
	   	 if(json.length > 0) {
			  $.each(json, function(index, item){
		   		html_2 += "<tr class='avgresult'>";
		   		html_2 += "<td class='result'>응답:"+(item.coursecount-1)+"건</td>";    	
		   		html_2 += "<td class='result'>"+item.firstansavg+"</td>";    	
		   		html_2 += "<td class='result'>"+item.secondansavg+"</td>";
		   		html_2 += "<td class='result'>"+item.thirdansavg+"</td>";
				html_2 += "<td class='result'>"+item.fouransavg+"</td>";
				html_2 += "<td class='result'>"+item.fiveansavg+"</td>";
				html_2 += "<td class='result'>"+item.sixansavg+"</td>";
				html_2 += "<td class='result'>"+item.sevenansavg+"</td>";
				html_2 += "<td class='result'>"+item.eightansavg+"</td>";
				html_2 += "<td class='result'></td>";
				html_2 += "</tr>";
			  });
		  
		    $("tbody#lctrevaluresultDisplay:last").append(html_2);
		  
	   	 }
	   	   }, 
	   	   error:function(request, status, error){
	   		   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	   	   }

		});  
  	
 
  }
</script>

<div style="display: flex; height:1200px;">
	<div style="margin: auto; padding-left: 3%; margin-top: 3%;">

	<h3 style="margin-bottom:30px;">강의평가 조회</h3>
	
	<h5 style="margin-bottom:30px; margin-top:10px;">▶강의평가문항</h5>
	<table style="width: 1050px; margin-bottom:50px;" class="table table-bordered">
		<thead>
		<tr><th colspan="2" style="text-align: center;">강의평가 문항</th></tr>
         <tr><th style="width: 15%;  text-align: center;">번호</th>
            <th style="text-align: center;">문항</th>
		</thead>
		<tbody>
		<tr>
		<td>1</td>
		<td>강의계획서는 수업게 관한 정보을 명확하게 제시하였다.</td>
		</tr>
		<tr>
		<td>2</td>
		<td>교수님은 매주 수업 시 학습목표를 명확하게 제시 하였다.</td>
		</tr>
		<tr>
		<td>3</td>
		<td>교수님은 규정된 수업시간(결강, 휴보강)을 준수하였다.</td>
		</tr>
		<tr>
		<td>4</td>
		<td>강의의 실제 수업내용은 일치하였다.</td>
		</tr>
		<tr>
		<td>5</td>
		<td>이 강의는 역량 달성에 도움이 되었다.</td>
		</tr>
		<tr>
		<td>6</td>
		<td>이 강의로 본인은 해당분야에 대한 지식이 향상되었다.</td>
		</tr>
		<tr>
		<td>7</td>
		<td>교수님은 학생의 질의응답에 신속하게 답변을 주었다.</td>
		</tr>
		<tr>
		<td>8</td>
		<td>이 강의에 대해 만족하며, 동기나 후배에게 추천하고 싶다.</td>
		</tr>
		<tr>
		<td>9</td>
		<td>기타 개선사항이나 의견이 있으시다면 자유롭게 작성하세요.</td>
		</tr>
		</tbody>
	
	</table>
	
	<h5 style="margin-bottom:30px; margin-top:10px;">▶ 강의평가결과</h5>
	
	<div style="margin-left: 960px; margin-bottom: 20px;">
		<button type="button" class="btn btn-secondary btn-sm" onclick="goViewlctrevaluresult(${subjectid})">조회</button>
	</div>
	
	<table id="lctrevaluresult">
		<thead>
			<th style="width: 70px; text-align: center; background-color: #DDDDDD;">평가번호</th>
			<th style="width: 70px; text-align: center; background-color: #DDDDDD;">1</th>
			<th style="width: 70px; text-align: center; background-color: #DDDDDD;">2</th>
			<th style="width: 70px; text-align: center; background-color: #DDDDDD;">3</th>
			<th style="width: 70px; text-align: center; background-color: #DDDDDD;">4</th>
			<th style="width: 70px; text-align: center; background-color: #DDDDDD;">5</th>
			<th style="width: 70px; text-align: center; background-color: #DDDDDD;">6</th>
			<th style="width: 70px; text-align: center; background-color: #DDDDDD;">7</th>
			<th style="width: 70px; text-align: center; background-color: #DDDDDD;">8</th>		
			<th style="width: 400px; text-align: center; background-color: #DDDDDD;">비고문항</th>			
			
		</thead>
		<tbody id="lctrevaluresultDisplay">
		
		</tbody>
	</table>
	<!-- 
	<c:if test="${empty requestScope.lctrEvaluitem}">
    	<div style="padding: 50px 0; font-size: 16pt; color: red;" >강의평가 결과가 존재하지 않습니다</div>
    </c:if>
     -->
    
    
	<div style="margin-top: 20px; margin-left: 450px;">
		<button type="button" class="btn btn-secondary btn-sm" onclick="javascript:history.back()">뒤로</button>
	</div>
	
	
	
</div>
</div>
		
		
		