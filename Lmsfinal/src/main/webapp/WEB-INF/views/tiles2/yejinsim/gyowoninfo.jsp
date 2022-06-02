<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
      
<%
	String ctxPath = request.getContextPath();
    //     /MyMVC
%>    
 
<style type="text/css">

th {background-color: #DDD}
  
</style>
<script type="text/javascript">
	var gyowonid = ${requestScope.gyowonvo.gyowonid}

	function editGyowoninfo(gyowonid) {
		   
		  location.href="<%=ctxPath%>/editgyowoninfo.lmsfinal?gyowonid=" + ${requestScope.gyowonvo.gyowonid};
		  
	}
</script>

  
</head>
<body>


<div style="display: flex; height:1200px;">
	<div style="margin: auto; padding-left: 3%; margin-top: 3%;">

	<h3 style="margin-bottom:30px;">개인정보 조회</h3>
	
	<h5 style="margin-bottom:30px; margin-top:10px;">▶개인 정보</h5>
	<table style="width: 1200px" class="table table-bordered">
		<thead>
			<th colspan="4" style="text-align: center;">개인정보</th>        
		</thead>	
		<tbody>
		<tr>
			<th style="width: 15%; text-align: center; background-color: #DDDDDD;">이름</th>
			<td>${requestScope.gyowonvo.gyoname}</td>
			<th style="width: 15%; text-align: center; background-color: #DDDDDD;">이름(영문)</th>
			<td>${requestScope.gyowonvo.gyonameeng}</td>
		</tr>
		<tr>
			<th style="width: 15%; text-align: center; background-color: #DDDDDD;">아이디</th>
			<td colspan="3">${requestScope.gyowonvo.gyowonid}</td>
		</tr>
		<!-- 
		<tr>
			<th style="width: 15%; text-align: center; background-color: #DDDDDD;">비번</th>
			<td colspan="3">${requestScope.gyowonvo.gyopwd}</td>
		</tr>
		 -->
		<tr>
			<th style="width: 15%; text-align: center; background-color: #DDDDDD;">핸드폰</th>
			<td colspan="3">${requestScope.gyowonvo.gyomobile}</td>
		</tr>
		<tr>
			<th style="width: 15%; text-align: center; background-color: #DDDDDD;">이메일</th>
			<td colspan="3">${requestScope.gyowonvo.gyoemail}</td>
		</tr>
		<tr>
			<th style="width: 15%; text-align: center; background-color: #DDDDDD;">주소</th>
			<td>${requestScope.gyowonvo.gyoaddress}</td>
			<th style="width: 15%; text-align: center; background-color: #DDDDDD;">우편번호</th>
			<td>${requestScope.gyowonvo.gyopostcode}</td>
		</tr>
		<tr>
			<th style="width: 15%; text-align: center; background-color: #DDDDDD;">생년월일</th>
			<td colspan="3">${requestScope.gyowonvo.gyobirthday}</td>
		</tr>
		<tr>
			<th style="width: 15%; text-align: center; background-color: #DDDDDD;">국적</th>
			<td colspan="3">${requestScope.gyowonvo.gyonation}</td>
		</tr>
		
		
		</tbody>
	</table>
	
	<h5 style="margin-bottom:30px; margin-top:10px;">▶ 근로 정보</h5>
	<table style="width: 1200px" class="table table-bordered">
		<thead>
			<th colspan="4" style="text-align: center;">근로정보</th>        
		</thead>
		<tbody>
		<tr>
			<th style="width: 15%; text-align: center; background-color: #DDDDDD;">소속</th>
			<td>${requestScope.gyowonvo.deptname}</td>
			<th style="width: 15%; text-align: center; background-color: #DDDDDD;">직위</th>
			<td>${requestScope.gyowonvo.position}</td>
		</tr>
		<tr>
			<th style="width: 15%; text-align: center; background-color: #DDDDDD;">근로상태</th>
			<td>
			<c:if test="${requestScope.gyowonvo.workstatus eq 0}">휴직</c:if>
			<c:if test="${requestScope.gyowonvo.workstatus ne 0}">재직</c:if>
			</td>
			<th style="width: 15%; text-align: center; background-color: #DDDDDD;">임용일자</th>
			<td>${requestScope.gyowonvo.appointmentdt}</td>
		</tr>
		<tr>
			<th style="width: 15%; text-align: center; background-color: #DDDDDD;">최종학력</th>
			<td colspan="3">${requestScope.gyowonvo.degree}</td>
		</tr>
		<tr>
			<th colspan="4" style="text-align: center; background-color: #DDDDDD;">교원경력</th>
		</tr>
		<tr>
			<th style="width: 15%; text-align: center; background-color: #DDDDDD;">1</th>
			<td>${requestScope.gyowonvo.careerTime1}</td>
			<td colspan="2">${requestScope.gyowonvo.career1}</td>
		</tr>
		<tr>
			<th style="width: 15%; text-align: center; background-color: #DDDDDD;">2</th>
			<td>${requestScope.gyowonvo.careerTime2}</td>
			<td colspan="2">${requestScope.gyowonvo.career2}</td>
		</tr>
		</tbody>
	
	</table>
	
	<div style="margin: 20px;">
		<button type="button" class="btn btn-secondary btn-sm" onclick="location.href='<%=ctxPath%>/editgyowoninfo.lmsfinal?gyowonid=${requestScope.gyowonvo.gyowonid}'">수정하기</button>	
		<button type="button" class="btn btn-secondary btn-sm" onclick="javascript:history.back()">뒤로</button>
	</div>
	

	
</div>
</div>
		
		
		

