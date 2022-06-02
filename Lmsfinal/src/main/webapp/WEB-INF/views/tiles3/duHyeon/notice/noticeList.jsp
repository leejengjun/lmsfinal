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
    
   
</style>

<script type="text/javascript">

  $(document).ready(function(){
	  
	
  });// end of $(document).ready(function(){})-------------------------------
  
  function goView(subnoticeno){
	  
	  
  	  location.href="<%= ctxPath%>/detailnotice.lmsfinal?subnoticeno="+subnoticeno;   
  	  
  }
  
  function addnotice(subjectid){
	  location.href="<%= ctxPath%>/addnotice.lmsfinal?subjectid="+subjectid;
  }

</script>

<div class="container w-75" style="margin: 250px; padding:0;">


	<h2 style="margin-bottom: 30px;">공지사항 목록</h2>
	
	<div class="innercontainer w-100">
	<table style="width: 1024px" class="table table-bordered">
		<thead>
	    <tr>
	    	<th style="width: 70px;  text-align: center;">글번호</th>
			<th style="width: 360px; text-align: center;">제목</th>
			<th style="width: 150px; text-align: center;">공지날짜</th>
	    </tr>
		</thead>
		
		<tbody>
			<c:if test="${not empty requestScope.noticeList}">
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
			</c:if>	
			<c:if test="${empty requestScope.noticeList}">
				<tr> 
					<td colspan="2" style="background-color: #fff; color: red; text-align: center;">해당 강의에 대한 문제가  공지사항이 없습니다.</td>
				</tr>
			</c:if>	
		</tbody>
	</table>
	
	<c:if test="${not empty sessionScope.loginuser and sessionScope.loginuser.gyowonid eq requestScope.gyowonid}">
		<div style="display: flex; margin-rignt: auto;">
		<button type="button" class = "btn btn-dark" onclick="addnotice(${requestScope.subjectid})"> 공지사항 등록하기 </button>
		</div>
	</c:if>
	
    <%-- === 페이지바 보여주기 === --%>  
    <div align="center" style="border: solid 0px gray; width: 70%; margin: 20px auto; ">
    	${requestScope.pageBar}
    </div>
 
 

	
</div>
</div>
  