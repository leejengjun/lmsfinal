<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
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


	function addQuestion(){
	// 문제를 만들어줄 폼을 보여줘야함
	
		location.href='<%=ctxPath%>/questionForm.lmsfinal?testclfc=${requestScope.testclfc}';
		
	}
	function goList(){
		
		location.href='<%=ctxPath%>/testroundList.lmsfinal?subjectid=${requestScope.subjectid}';
		
	}
  
</script>  


<div class="container w-75" style="margin: 250px; padding:0;">


<h2 style="margin-bottom: 30px;">시험 문제 목록</h2>

	<div>
		<table class="table table-bordered">
			<thead>
				<tr>
					<th style="width:10%; text-align: center;">번호</th>
					<th style="text-align: center;">시험문제</th>
				</tr>
			</thead>
			
			<tbody>
				<c:if test="${empty requestScope.questionList}">
					<tr> 
						<td colspan="2" style="background-color: #fff; color: red; text-align: center;">해당 시험에 대한 문제가  출제되지 않았습니다.</td>
					</tr>
				</c:if>
				<c:if test="${not empty requestScope.questionList}">
					<c:forEach var="question" items="${requestScope.questionList}" varStatus="status">
						<tr onClick="location.href='detailQuestion.lmsfinal?questionseq=${question.questionseq}'">
							<td>${status.count}</td>
							<td>${question.question}</td>
						</tr>
					</c:forEach>
				</c:if>
					
				
			</tbody>
		</table>
		<div>
			<button type="button" class="btn btn-dark " onclick="addQuestion()" style="width:49%">문제 추가</button>
			<button type="button" class="btn btn-light " onclick="goList()"style="width:49%">시험출제목록으로</button>
		</div>
	</div>
	
</div>	