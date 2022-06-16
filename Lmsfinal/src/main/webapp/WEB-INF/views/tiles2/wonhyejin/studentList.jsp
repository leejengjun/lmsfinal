
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
   String ctxPath = request.getContextPath();
%>

<style type="text/css">

	th {
	     background-color:  #00001a;
		 color: white;
		 border: 2px solid #00001a; 
	 }

    .studentInfoStyle {
                   font-weight: bold;
    			   color: navy;
    			   cursor: pointer;}

    a {text-decoration: none !important;}
    
</style>

<script type="text/javascript">

$(document).ready(function(){
	
// 학적상태 변경_휴학신청 승인//
	$("input.btn_s_approve").click(function(){
		 const idx = $("input.btn_s_approve").index($(this));
		 //alert(idx);
		 const stdid = $("td#stdid").eq(idx).text();
		 //alert("확인용 stdid=>" + stdid);
		 const stdstateid = $("p#stdstateid").eq(idx).text();
		 //alert("확인용 stdstateid=>" + stdstateid);
		 
	       $.ajax({
	    		url:"<%= ctxPath%>/stuLeaveUpdate.lmsfinal",
	    		data:{"stdid":stdid
	    			  ,"stdstateid":$("select#stdstateid").val()},
	    		type:"post",  
	    		dataType:"JSON",
	    	 	success:function(json){
	    	 		if(json.n > 0) {
	                  alert("휴학승인되었습니다");
	                  location.href="javascript:history.go(0);"; // 페이지 새로고침
	    	 	}
				 
		  	   }, 
		  	   error:function(request, status, error){
		  		   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		  	   }
		     }); 
		     	
		   });// end of $("input.btn_approve").click(function()-----------------------------------
	
				   
// 학적상태 변경_휴학신청 반려//				   
	
	$("input.btn_s_reject").click(function(){
		 const idx = $("input.btn_s_reject").index($(this));
		 //alert(idx);
		 const stdid = $("td#stdid").eq(idx).text();
		 //alert("확인용 stdid=>" + stdid);
		 const stdstateid = $("p#stdstateid").eq(idx).text();
		 //alert("확인용 stdstateid=>" + stdstateid);
		 
	       $.ajax({
	    		url:"<%= ctxPath%>/stuLeaveDelete.lmsfinal",
	    		data:{"stdid":stdid
	    			  ,"stdstateid":$("select#stdstateid").val()},
	    		type:"post",  
	    		dataType:"JSON",
	    	 	success:function(json){
	    	 		if(json.n > 0) {
	                  alert("휴학신청이 반려되었습니다");
	                  location.href="javascript:history.go(0);"; // 페이지 새로고침
	    	 	}
				 
		  	   }, 
		  	   error:function(request, status, error){
		  		   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		  	   }
		     }); 
		     	
		   });// end of $("input.btn_approve").click(function()-----------------------------------
					   

							   
// 학적상태 변경_복학신청 승인//
	$("input.btn_sR_approve").click(function(){
		 const idx = $("input.btn_sR_approve").index($(this));
		 //alert(idx);
		 const stdid = $("td#stdid").eq(idx).text();
		// alert("확인용 stdid=>" + stdid);
		 const stdstateid = $("p#stdstateid").eq(idx).text();
		// alert("확인용 stdstateid=>" + stdstateid);
		 
	       $.ajax({
	    		url:"<%= ctxPath%>/stuReturnUpdate.lmsfinal",
	    		data:{"stdid":stdid
	    			  ,"stdstateid":stdstateid},
	    		type:"post",  
	    		dataType:"JSON",
	    	 	success:function(json){
	    	 		if(json.n > 0) {
	                  alert("복학 승인되었습니다");
	                  location.href="javascript:history.go(0);"; // 페이지 새로고침
	    	 	}
				 
		  	   }, 
		  	   error:function(request, status, error){
		  		   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		  	   }
		     }); 
		     	
		   });// end of $("input.btn_approve").click(function()-----------------------------------
	
				   
// 학적상태 변경_복학신청 반려//				   
	
		$("input.btn_sR_reject").click(function(){
			 const idx = $("input.btn_sR_reject").index($(this));
			 //alert(idx);
			 const stdid = $("td#stdid").eq(idx).text();
			 //alert("확인용 stdid=>" + stdid);
			 const stdstateid = $("p#stdstateid").eq(idx).text();
			 //alert("확인용 stdstateid=>" + stdstateid);
			 
		       $.ajax({
		    		url:"<%= ctxPath%>/stuReturnDelete.lmsfinal",
		    		data:{"stdid":stdid
		    			  ,"stdstateid":$("select#stdstateid").val()},
		    		type:"post",  
		    		dataType:"JSON",
		    	 	success:function(json){
		    	 		if(json.n > 0) {
		                  alert("복학 신청이 반려되었습니다");
		                  location.href="javascript:history.go(0);"; // 페이지 새로고침
		    	 	}
					 
			  	   }, 
			  	   error:function(request, status, error){
			  		   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  	   }
			     }); 
			     	
			   });// end of $("input.btn_approve").click(function()-----------------------------------
						   

				   
				   
	 $("td.stdname").bind("mouseover", function(event){
		   const $target = $(event.target);
		   $target.addClass("studentInfoStyle")
	 });
	   
	 $("td.stdname").bind("mouseout", function(event){
		   const $target = $(event.target);
		   $target.removeClass("studentInfoStyle")
	 });

	 $("input#searchWord_1").bind("keyup", function(event){
		if(event.keyCode == 13) {
			goSearch();
		}
	 });
	     

	 if("${requestScope.searchType_1}" != "") { 
		   $("select#searchType_1").val("${requestScope.searchType_1}");
		   $("input#searchWord_1").val("${requestScope.searchWord_1}");
	 }
	
		
	
	 if( ${not empty requestScope.paraMap} ) {     
		   $("select#searchType_1").val("${requestScope.paraMap.searchType_1}");
		   $("input#searchWord_1").val("${requestScope.paraMap.searchWord_1}");
	 }
	 
	 // 검색시 검색조건 및 검색어 값 유지시키기 
	  if("${requestScope.stdstateid}" != "") {     
		   $("select#stdstateid").val("${requestScope.paraMap.stdstateid}");
	 }
		
	 if( ${not empty requestScope.paraMap} ) {     
		   $("select#stdstateid").val("${requestScope.paraMap.stdstateid}");
		 
	 }
	 
	 const stdstateid = "${requestScope.stdstateid}";
	 if(stdstateid != "") {
		$("select#stdstateid").val(stdstateid);	
	 }
	
	// 특정 회원을 클릭시 그 회원의 상세정보 보여주기
	 $("td.stdname").click( ()=>{
	 	
	 	 const $target = $(event.target);
	     const stdname = $target.parent().children(".stdname").text();
	  
	     const gobackURL = "${requestScope.gobackURL}"; 

	     location.href="<%= ctxPath%>/studentOneDetail.lmsfinal?stdname="+stdname+"&gobackURL=${requestScope.goBackURL}"; 
	                                                                       
	 }); 

    

function goSearch() {

	const frm = document.studentListFrm;
		frm.action = "<%= ctxPath%>/studentList.lmsfinal";
		frm.method = "GET";
		frm.submit();

	} 
	
 });// end of $(document).ready(function(){})-----------------------------



</script>

<div style="display: flex;">
<div style="margin: auto; padding-left: 3%;">

<h2 style="margin: 100px; text-align: center; font-weight:bolder;">회원전체 목록</h2>

<button type="button" class="btn btn-secondary btn-sm mr-3" onclick="javascript:location.href='<%= ctxPath%>/studentList.lmsfinal'">학생정보</button>
<button type="button" class="btn btn-secondary btn-sm mr-3" onclick="javascript:location.href='<%= ctxPath%>/gyowonList.lmsfinal'">교원정보</button> 


     <form name="studentListFrm"> 
     	<select name="searchType_1" id="searchType_1" style="height: 26px;">
			<option value="">검색대상</option>
			<option value="stdname">학생이름</option>
			<option value="stdid">학번</option>
			<option value="stdmajorid">학과코드</option>
			<option value="deptname">학과명</option>
		</select>
	
     	<input type="text" name="searchWord_1" id="searchWord_1" size="50" autocomplete="off" /> 
		<input type="text" style="display: none;"/> 
	
		<select name="stdstateid" id="stdstateid" style="height: 26px;">
			<option value="">학적상태</option>
			<option value="1">재학</option>
			<option value="2">휴학</option>
			<option value="6">휴학신청</option>
			<option value="7">복학신청</option>
			
		</select>
	
		<button type="submit" class="btn btn-secondary btn-sm" onclick="goSearch()">조회</button>
		
	</form> 
	
	  
      <table id="studentListTbl" class="table table-bordered" style="width: 1000px; margin-top: 20px; text-align: center;">
         <thead>
           <tr>
	         <th style="width: 70px;  text-align: center;">이름</th>
	         <th style="width: 150px; text-align: center;">학번</th>
	         <th style="width: 70px;  text-align: center;">학과코드</th>
	         <th style="width: 70px;  text-align: center;">학과명</th>
	         <th style="width: 120px; text-align: center;">학적상태</th>
           </tr>
         </thead>
         
         <tbody>
             <c:if test="${not empty requestScope.studentList}">
 	            <c:forEach var="studentvo" items="${requestScope.studentList}">
 	            	<tr class="studentInfo">
 	            	   
 	            		<td class="stdname">${studentvo.stdname}</td>
 	            	
 	            		<td id="stdid">${studentvo.stdid}</td>
 	            		<td>${studentvo.stdmajorid}</td>
 	            		<td>${studentvo.deptname}</td>
 	            		<td id="stdstateid" align="center"><p id="stdstateid" style="visibility:hidden; position:absolute;">${studentvo.stdstateid}</p> 
 	            		
 	            		    <c:choose>
 	            		    	<c:when test="${studentvo.stdstateid eq '1'}">재학
 	            		    	  <input type="hidden" id="s_approve" name="s_approve" class="btn btn-outline-dark btn-sm mr-3 btn_s_approve" value="승인"/>
	            	              <input type="hidden" id="s_reject" name="s_reject"  class="btn btn-outline-dark btn-sm mr-3 btn_s_reject" value="반려"/>
	            	              <input type="hidden" id="sR_approve" name="sR_approve" class="btn btn-outline-dark btn-sm mr-3 btn_sR_approve" value="승인"/>
	            	              <input type="hidden" id="sR_reject" name="sR_reject"  class="btn btn-outline-dark btn-sm mr-3 btn_sR_reject" value="반려"/>
 	            		    	</c:when>
 	            		    	
 	            		    	<c:when test="${studentvo.stdstateid eq '2'}">휴학
	            		    	  <input type="hidden" id="s_approve" name="s_approve" class="btn btn-outline-dark btn-sm mr-3 btn_s_approve" value="승인"/>
            	                  <input type="hidden" id="s_reject" name="s_reject"  class="btn btn-outline-dark btn-sm mr-3 btn_s_reject" value="반려"/>
            	                  <input type="hidden"  id="sR_approve" name="sR_approve" class="btn btn-outline-dark btn-sm mr-3 btn_sR_approve" value="승인"/>
            	                  <input type="hidden" id="sR_reject" name="sR_reject"  class="btn btn-outline-dark btn-sm mr-3 btn_sR_reject" value="반려"/>
 	            		    	</c:when>
 	            		  
 	            		    	<c:when test="${studentvo.stdstateid eq '6'}">휴학신청<br>
            		    	      <input type="button" id="s_approve" name="s_approve" class="btn btn-outline-dark btn-sm mr-3 btn_s_approve" value="승인"/>
	            	              <input type="button" id="s_reject" name="s_reject"  class="btn btn-outline-dark btn-sm mr-3 btn_s_reject" value="반려"/>
	            	              <input type="hidden" id="sR_approve" name="sR_approve" class="btn btn-outline-dark btn-sm mr-3 btn_sR_approve" value="승인"/>
	            	              <input type="hidden" id="sR_reject" name="sR_reject"  class="btn btn-outline-dark btn-sm mr-3 btn_sR_reject" value="반려"/>
 	            		    	</c:when>
 	            		  
 	            		    	<c:when test="${studentvo.stdstateid eq '7'}">복학신청<br>
 	            		    	  <input type="hidden" id="s_approve" name="s_approve" class="btn btn-outline-dark btn-sm mr-3 btn_s_approve" value="승인"/>
	            	              <input type="hidden" id="s_reject" name="s_reject"  class="btn btn-outline-dark btn-sm mr-3 btn_s_reject" value="반려"/>
	            	              <input type="button" id="sR_approve" name="sR_approve" class="btn btn-outline-dark btn-sm mr-3 btn_sR_approve" value="승인"/>
	            	              <input type="button" id="sR_reject" name="sR_reject"  class="btn btn-outline-dark btn-sm mr-3 btn_sR_reject" value="반려"/>
 	            		    	</c:when>
 	            		  	
 	            		    </c:choose> 
 	            		  
 	            		</td>
 	            	</tr>

 	            </c:forEach>
             </c:if>
             
           
             <c:if test="${empty requestScope.studentList}">
             	<tr>
             		<td colspan="4" style="text-align: center;">검색된 데이터가 존재하지 않습니다</td>
             	</tr>
             </c:if>
         </tbody>
      </table>    

      <div align="center" style="border: solid 0px gray; width: 70%; margin: 20px auto; ">
        ${requestScope.pageBar}
     </div>
 
</div>
</div>



