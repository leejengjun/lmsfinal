<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
   String ctxPath = request.getContextPath();
  //       /lmsfinal
%>    
    
<style type="text/css">

.container{
	padding:20px;
}




th {background-color: #DDD}


tbody > tr:hover {
	 background-color: #4c4c4ce6;
	 cursor: pointer;
}

</style>    

<script type="text/javascript">


	function checkscore(testclfc){

		const stdid = $("input#stdid").val();
		
		$.ajax({
			url : "<%=ctxPath%>/checkmodal.lmsfinal", 
			data:{"testclfc" : testclfc
				, "stdid" : stdid},
			datatype : "JSON",
			success:function(json){
				
				const score = JSON.parse(json).score;
				alert("해당 시험의 점수는 "+ score+" 점");
				
			},
			error: function(){
			}
			
		
	});
		
	}
	
</script>
    
<div class="container w-75" style="margin: 250px; padding:0;">
	
	
	
	<h2 style="margin-bottom: 30px;">시험 목록</h2>
	<div>
		<table class="table table-bordered">
			<thead>
				<tr>
					<th style="text-align: center;">시험종류</th>
					<th style="text-align: center;">응시일자</th>
					<c:if test="${not empty requestScope.stdid and empty requestScope.gyowonid}">
						<th> </th>
					</c:if>
				</tr>
			</thead>
			
			<tbody>
	
					<c:forEach var="testround" items="${requestScope.testRoundList}" varStatus="status">
					<!-- 누르면 시험보기로 갈 수 있도록 만들 것임 -->
						<tr >
							<td style="text-align: center;">${testround.examtitle}</td>
							<td style="text-align: center;">${testround.startdate} ~ ${testround.enddate}</td>
							<c:set var="now" value="<%=new java.util.Date()%>" />
							<fmt:parseDate var="endTime" value="${testround.enddate}" pattern="yyyy-MM-dd HH:mm:ss"/>
							<c:if test="${endTime < now and testround.disclosure != 1}">
								<td style="text-align: center;"><button type="button" class="btn btn-dark" onclick="checkscore(${testround.testclfc})">시험결과 보기</button></td>
							</c:if>
							<c:if test="${endTime > now}">
								<td style="text-align: center;"><button type="button" class="btn btn-sm btn-dark"  onClick="location.href='takeTheExam.lmsfinal?testclfc=${testround.testclfc}'">시험응시</button></td>
							</c:if>
							<c:if test="${endTime < now and testround.disclosure == 1}">
								<td style="text-align: center;">비공개</td>
							</c:if>
						</tr>
					</c:forEach>
			</tbody>
		</table>
		
	</div>
	<input type="hidden" id="stdid" value="${requestScope.stdid}"/>
</div>	






