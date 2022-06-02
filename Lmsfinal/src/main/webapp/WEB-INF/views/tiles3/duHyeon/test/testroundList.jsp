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


	
	
</script>
    
<div class="container w-75" style="margin: 250px; padding:0;">
	
	
	
	<h2 style="margin-bottom: 30px;">시험 목록</h2>
	<div>
		<table class="table table-bordered">
			<thead>
				<tr>
					<th>시험종류</th>
					<th>응시일자</th>
					<c:if test="${not empty requestScope.gyowonid}">
						<th>정답공개여부</th>
						<th>출제문항개수</th>
					</c:if>
					<c:if test="${not empty requestScope.stdid and empty requestScope.gyowonid}">
						<th> </th>
					</c:if>
				</tr>
			</thead>
			
			<tbody>

				<!-- 교원이 했을 로그인 했을 때 -->
					<c:forEach var="testround" items="${requestScope.testRoundList}" varStatus="status">
						<tr onClick="location.href='detailtestround.lmsfinal?testclfc=${testround.testclfc}'">
							<td>${testround.examtitle}</td>
							<td>${testround.startdate} ~ ${testround.enddate}</td>
							<c:if test="${testround.disclosure == 0}">
								<td>공개</td>
							</c:if>
							<c:if test="${testround.disclosure == 1}">
								<td>비공개</td>
							</c:if>
							<td>${testround.currentquestioncnt}</td>
						</tr>
					</c:forEach>
			
			</tbody>
		</table>
		
		<c:if test="${not empty requestScope.gyowonid}">
			<div><button type="button" class="btn btn-dark" onclick="location.href='leeduhyeontest.lmsfinal?subjectid=${requestScope.subjectid}'">시험출제하기</button></div>
		</c:if>
	</div>
	
</div>	