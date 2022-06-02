<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<style type="text/css">

    span.move {cursor: pointer; color: navy;}
    .moveColor {color: #660029; font-weight: bold; background-color: #ffffe6;}

</style>   
    
<script type="text/javascript">
  $(document).ready(function(){ // 화살표 함수 쓰려면 $(this)대신 $("span.move")을 써야한다. 화살표함수에서는 $(this)가 먹지 않음
								// $(this) 는 자기자신!!
	  $("span.move").hover(function(){
		  					 $(this).addClass("moveColor");
	                       }, 
	                       function(){
	                    	 $(this).removeClass("moveColor");  
	                       });
	  
  });// end of $(document).ready(function(){})------------------------
  
  
  
</script>




<div style="display: flex; margin: 50px 0 140px 0;">
<div style="margin: auto; padding-left: 12%;">

	<h2 style="text-align: center; margin-top: 50px; font-weight: bold; margin: -10px 0 40px 0; "><font size="15" color="#84c1f5">공지사항</font></h2>

    <c:if test="${not empty requestScope.noticevo}">
    	<table style="width: 1024px" class="table table-bordered table-active">
    		<tr>
    		    <th class="table-primary" style="width: 15%">글번호</th>
    		    <td>${requestScope.noticevo.noticeno}</td>
    		</tr>
    		<tr>
    		    <th class="table-primary">성명</th>
    		    <td class="table-light">관리자</td>
    		</tr>
    		<tr>
    		    <th class="table-primary">제목</th>
    		    <td class="table-light">${requestScope.noticevo.nsubject}</td>
    		</tr>
    		<tr>
    		    <th class="table-primary">내용</th>
    		    <td class="table-light">
    		      <p style="word-break: break-all;">${requestScope.noticevo.ncontent}</p>
    		      <%-- 
				      style="word-break: break-all; 은 공백없는 긴영문일 경우 width 크기를 뚫고 나오는 것을 막는 것임. 
				           그런데 style="word-break: break-all; 나 style="word-wrap: break-word; 은
				           테이블태그의 <td>태그에는 안되고 <p> 나 <div> 태그안에서 적용되어지므로 <td>태그에서 적용하려면
				      <table>태그속에 style="word-wrap: break-word; table-layout: fixed;" 을 주면 된다.
				 --%>
    		    </td>
    		</tr>
    		<tr>
    		    <th class="table-primary">조회수</th>
    		    <td class="table-light">${requestScope.noticevo.ncnt}</td>
    		</tr>
    		<tr>
    		    <th class="table-primary">날짜</th>
    		    <td class="table-light">${requestScope.noticevo.nregdate}</td>
    		</tr>
    	</table>
    	<br/>
    	
    	<div style="margin-bottom: 1%;">이전글제목&nbsp;&nbsp;<span class="move" onclick="javascript:location.href='noticeView2.lmsfinal?noticeno=${requestScope.noticevo.previousnno}'">${requestScope.noticevo.previousnsubject}</span></div>
    	<div style="margin-bottom: 1%;">다음글제목&nbsp;&nbsp;<span class="move" onclick="javascript:location.href='noticeView2.lmsfinal?noticeno=${requestScope.noticevo.nextnno}'">${requestScope.noticevo.nextnsubject}</span></div>
    	<br/>
    	    	
    	<button type="button" class="btn btn-primary btn-sm mr-3" onclick="javascript:location.href='<%= request.getContextPath()%>/noticeList.lmsfinal'">전체목록보기</button>
    	<c:if test="${sessionScope.loginuser != null && sessionScope.loginuser.status eq 1}">
	    	<button type="button" class="btn btn-primary btn-sm mr-3" onclick="javascript:location.href='<%= request.getContextPath()%>/noticeEdit.lmsfinal?noticeno=${requestScope.noticevo.noticeno}'">글수정하기</button>
	    	<button type="button" class="btn btn-primary btn-sm mr-3" onclick="javascript:location.href='<%= request.getContextPath()%>/noticeDel.lmsfinal?noticeno=${requestScope.noticevo.noticeno}'">글삭제하기</button>
    	</c:if>
    	
    	
    </c:if>

	<c:if test="${empty requestScope.noticevo}">
    	<div style="padding: 50px 0; font-size: 16pt; color: red;" >존재하지 않습니다</div>
    </c:if>
    
</div>
</div>    
    