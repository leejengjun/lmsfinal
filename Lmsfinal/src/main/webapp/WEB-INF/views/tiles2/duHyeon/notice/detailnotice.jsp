<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 


<style type="text/css">

    span.move {cursor: pointer; color: navy;}
    .moveColor {color: #660029; font-weight: bold; background-color: #ffffe6;}
    
    td.comment {text-align: center;}
    
    a {text-decoration: none !important;}

</style>   
    
<script type="text/javascript">
  $(document).ready(function(){
	  
	  $("span.move").hover(function(){
		  					 $(this).addClass("moveColor");
	                       }, 
	                       function(){
	                    	 $(this).removeClass("moveColor");  
	                       });
	      
  });// end of $(document).ready(function(){})------------------------
  
  
</script>

<div style="display: flex; margin: 250px;">
<div style="margin: auto; padding-left: 3%;">

	<h2 style="margin-bottom: 30px;">글내용보기</h2>

    <c:if test="${not empty requestScope.noticevo}">
    	<table style="width: 1024px" class="table table-bordered table-dark">
    		<tr>
    		    <th>제목</th>
    		    <td>${requestScope.noticevo.snsubject}</td>
    		</tr>
    		
    		<tr>
    		    <th>강의명</th>
    		    <td>${requestScope.noticevo.classname}</td>
    		</tr>
    		<tr>

    		</tr>
    		
    		<%-- === #162. 첨부파일 이름 및 파일크기를 보여주고 첨부파일을 다운로드 되도록 만들기 === --%>
			<tr>
				<th>첨부파일</th>
				<td>
					<c:if test="${sessionScope.loginuser != null and requestScope.noticevo.snorgfilename != '없음'}">
						<a href="<%= request.getContextPath()%>/download_attch.lmsfinal?subnoticeno=${requestScope.noticevo.subnoticeno}">${requestScope.noticevo.snorgfilename}</a>  
					</c:if>
					
					<c:if test="${sessionScope.loginuser == null}">
						${requestScope.noticevo.snorgfilename}
					</c:if>
				</td>
			</tr>
    		<tr>
    		    <th>내용</th>
    		    <td>
    		      <p style="word-break: break-all; min-height: 200px;">${requestScope.noticevo.sncontent}</p>
    		    </td>
    		</tr>
    	</table>
    	<br/>
    	
    	<%-- 
    	<c:set var="v_gobackURL" value='${ fn:replace(requestScope.gobackURL, "&", " ") }' />
    	
    	<div style="margin-bottom: 1%;">이전글제목&nbsp;&nbsp;<span class="move" onclick="javascript:location.href='view_2.action?seq=${requestScope.noticevo.previousseq}&searchType=${requestScope.paraMap.searchType}&searchWord=${requestScope.paraMap.searchWord}&gobackURL=${v_gobackURL}'">${requestScope.noticevo.previoussubject}</span></div>
    	<div style="margin-bottom: 1%;">다음글제목&nbsp;&nbsp;<span class="move" onclick="javascript:location.href='view_2.action?seq=${requestScope.noticevo.nextseq}&searchType=${requestScope.paraMap.searchType}&searchWord=${requestScope.paraMap.searchWord}&gobackURL=${v_gobackURL}'">${requestScope.noticevo.nextsubject}</span></div>
    	<br/>  
    	--%>
    	    	
    	<button type="button" class="btn btn-secondary btn-sm mr-3" onclick="javascript:location.href='<%= request.getContextPath()%>/noticeList.lmsfinal?subjectid=${requestScope.noticevo.subjectid}'">전체목록보기</button>
    	<c:if test="${not empty sessionScope.loginuser and sessionScope.loginuser.gyowonid eq requestScope.gyowonid}">
	    	<button type="button" class="btn btn-secondary btn-sm mr-3" onclick="javascript:location.href='<%= request.getContextPath()%>/modifynotice.lmsfinal?subnoticeno=${requestScope.noticevo.subnoticeno}'">글수정하기</button>
	    	<button type="button" class="btn btn-secondary btn-sm mr-3" onclick="javascript:location.href='<%= request.getContextPath()%>/del.action?seq=${requestScope.noticevo.subnoticeno}'">글삭제하기</button>
    	</c:if>
    </c:if>

	<c:if test="${empty requestScope.noticevo}">
    	<div style="padding: 50px 0; font-size: 16pt; color: red;" >등록된 공지사항이 없습니다.</div>
    </c:if>
    
</div>
</div>    
    