<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<%
	String ctxPath = request.getContextPath();
	String subjectid = request.getParameter("subjectid");
%>   

<style type="text/css">

	
</style>

<script type="text/javascript">

  $(document).ready(function(){
	  
	
		
	
	
	
  });// end of $(document).ready(function(){})-------------------------------
 
  
  //Function Declaration
  
  
</script>
<div style="display: flex;">
<div style="margin: auto; padding-left: 3%;">
	<h2 style="margin-bottom: 30px;">질답게시판</h2>
	
	<button type="button" class="btn btn-secondary btn-sm mr-3" onclick="location.href='<%=ctxPath%>/addlctrQna.lmsfinal?subjectid=<%=subjectid%>'">글쓰기</button>
				      	
</div>
</div>