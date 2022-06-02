<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
   String ctxPath = request.getContextPath();
%>

<style type="text/css">

	th {
		 background-color: #00001a; 
		 color: white;
		 border: 2px solid #00001a; 
		
	}

    .subjectStyle {
         font-weight: bold;
	     color: navy;
	     cursor: pointer;
	}

    a {
   		 text-decoration: none !important;
    }
    

	tr.memberInfo:hover {
		 background-color: #e6ffe6;
		 cursor: pointer;
		 border: 2px solid #00001a; 
	}

 table#gyowonLeture {   
	     padding: auto;    
	     border: 2px solid #00001a; 
	}  
</style>

<script type="text/javascript">


 $(document).ready(function(){
	 
		$("input#searchWord_1").bind("keyup", function(event){
			if(event.keyCode == 13) {
				goSearch();
			}			   
		});	
	
		if("${requestScope.searchType_1}" != "") { 
			$("select#searchType_1").val("${requestScope.searchType_1}");
			$("input#searchWord_1").val("${requestScope.searchWord_1}");
		 }

 // 검색시 검색조건 및 검색어 값 유지
		 if(${not empty requestScope.paraMap} ) {     
		    $("select#searchType_1").val("${requestScope.paraMap.searchType_1}");
		    $("input#searchWord_1").val("${requestScope.paraMap.searchWord_1}");
		 }
				 					   
		 const gyoOpenedListFrm = "${requestScope.gyoOpenedListFrm}";
			if(gyoOpenedListFrm != "") {
				$("select#gyoOpenedListFrm").val(gyoOpenedListFrm);
			}
	
// 검색시 검색조건 및 검색어 값 유지시키기 
		 if("${requestScope.applystate}" != "") {     
			   $("select#applystate").val("${requestScope.paraMap.applystate}"); 
		 }
	
 
		 if( ${not empty requestScope.paraMap} ) {     
			   $("select#applystate").val("${requestScope.paraMap.applystate}");
			 
		 }
		 
	     const applystate = "${requestScope.applystate}";
		    if(applystate != "") {
			  $("select#applystate").val(applystate);
		  }		
	

//개설강의 신청상태 변경_승인		
	$("input.btn_approve").click(function(){
		 const idx = $("input.btn_approve").index($(this));
		 alert(idx);
		 const subject = $("td#subjectid").eq(idx).text();
		 alert("확인용 subject=>" + subject);
		 const applystate = $("p#applystate").eq(idx).text();
		 alert("확인용 applystate=>" + applystate);
		 
	       $.ajax({
	    		url:"<%= ctxPath%>/gyoOpenedUpdate.lmsfinal",
	    		data:{"subjectid":subject
	    			  ,"applystate":$("select#applystate").val()},
	    		type:"post",  
	    		dataType:"JSON",
	    	 	success:function(json){
	    	 		if(json.n > 0) {
	                  alert("등록되었습니다");
	                  location.href="javascript:history.go(0);"; // 페이지 새로고침
	    	 	}
				 
		  	   }, 
		  	   error:function(request, status, error){
		  		   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		  	   }
		     }); 
		     	
		   });	// end of $("input.btn_approve").click(function()----------------------------
  
//개설강의 신청상태 변경_반려  
		   $("input.btn_reject").click(function(){
				
				 const idx = $("input.btn_reject").index($(this));
				 alert(idx);
				 const subject = $("td#subjectid").eq(idx).text();
				 alert("확인용 subject=>" + subject);
				 const applystate = $("p#applystate").eq(idx).text();
				 alert("확인용 applystate=>" + applystate);
				
			       $.ajax({
			    		url:"<%= ctxPath%>/gyoOpenedDelete.lmsfinal",
			    		data:{"subjectid":subject
			    			  ,"applystate":$("select#applystate").val()},
			    		type:"post",  
			    		dataType:"JSON",
			    	 	success:function(json){
			    	 		if(json.n > 0) {
			                  alert("반려되었습니다");
			                  location.href="javascript:history.go(0);"; // 페이지 새로고침
			    	 	}
						 
				  	   }, 
				  	   error:function(request, status, error){
				  		   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				  	   }
				     }); 	
				     	
				   });	// end of $("input.btn_reject").click(function()----------------

	  

		 function goSearch() {
		   	const frm = document.gyoOpenedListFrm;
		   	frm.action = "<%= ctxPath%>/gyoOpenedList.lmsfinal";
		   	frm.method = "GET";
		   	frm.submit();
         } 
	
  });// end of  $(document).ready(function(){		
 

 

</script>   

<div style="display: flex;">
<div style="margin: auto; padding-left: 3%;">

<div>
<h2 style="margin: 100px; text-align: center; font-weight:bolder;">교수강의 개설 조회</h2>

 
 <form name="gyoOpenedListFrm"> 
     	<select name="searchType_1" id="searchType_1" style="height: 26px; margin: 0 0 20px 100px; ">
			<option value="">검색대상</option>
			<option value="deptname">학과</option>
			<option value="subjectid">강의코드</option>
			<option value="classname">강의명</option>
		</select>
	
     	<input type="text" name="searchWord_1" id="searchWord_1" size="50" autocomplete="off" /> 
		<input type="text" style="display: none;"/> 
		
		<select name="applystate" id="applystate" style="height: 26px;">
			<option value="">신청상태</option>
			<option>등록완료</option>
			<option>승인대기중</option>
			<option>신청반려</option>
		</select>
		
		<button type="submit" class="btn btn-secondary btn-sm" onclick="goSearch()">조회</button>
		
 </form> 
 
 <table id="gyowonLeture" style="width: 1200px; margin-left:100px; " class="table table-bordered" >
 
		<thead>
		<tr>
			<th style="width: 70px;  text-align: center;">번호</th>
			<th style="width: 100px;  text-align: center;">학과</th>
			<th style="width: 70px;  text-align: center;">강의코드</th>
	        <th style="width: 160px; text-align: center;">강의명</th>
	        <th style="width: 70px;  text-align: center;">대상학년</th>
	        <th style="width: 70px;  text-align: center;">이수학점</th>
	        <th style="width: 70px;  text-align: center;">정원</th>
	        <th style="width: 80px;  text-align: center;">강의실</th>
	        <th style="width: 70px;  text-align: center;">강의시간</th>
	        <th style="width: 100px;  text-align: center;">신청상태</th>
		</tr>
		</thead>
		
	<tbody>
		<tr>
			<c:if test="${not empty requestScope.applylectureList}">
				<c:forEach var="gyoOpenedList" items="${requestScope.applylectureList}" varStatus="status">
				<tr>
				    <td align="center">${gyoOpenedList.rno}</td>
					<td align="center">${gyoOpenedList.deptname}</td>
					<td id="subjectid" align="center">${gyoOpenedList.subjectid}</td>
					<td align="center">${gyoOpenedList.classname}</td>

					<td align="center">${gyoOpenedList.opensemester}</td>
					<td align="center">${gyoOpenedList.credit}</td>
					
					
					<td align="center">${gyoOpenedList.totalperson}</td>
					<td align="center">${gyoOpenedList.lctrid}</td>
					<td align="center">${gyoOpenedList.dayid}</td>
				
				
					<td id="applystate" align="center"><p id="applystate">${gyoOpenedList.applystate}</p>
					  <c:choose>
					   <c:when  test="${gyoOpenedList.applystate != '등록완료' && gyoOpenedList.applystate != '신청반려'}">
						   <input type="button" id="approve" name="approve" class="btn btn-outline-dark btn-sm mr-3 btn_approve" value="승인"/>
						   <input type="button" id="reject" name="reject" class="btn btn-outline-dark btn-sm mr-3 btn_reject" value="반려"/>
				       </c:when >
				   
				       <c:otherwise>
						   <input type="hidden" id="approve" name="approve" class="btn btn-outline-dark btn-sm mr-3 btn_approve" value="승인"/>
						   <input type="hidden" id="reject" name="reject" class="btn btn-outline-dark btn-sm mr-3 btn_reject" value="반려"/>
				       </c:otherwise >
				      </c:choose>    
					</td>
					
				</tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty requestScope.applylectureList}">
				<tr>
            		<td colspan="11" style="text-align: center;">강의가 존재하지 않습니다</td>
            	</tr>
			</c:if>
		</tr>
	</tbody>
  </table>
	
     <div align="center" style="border: solid 0px gray; width: 70%; margin: 20px auto; ">
        ${requestScope.pageBar}
     </div>
    
</div> 	
</div>
</div>

  <form name="updateFrm">
  	<input type="hidden" name="applystate" value="${requestScope.gyoOpenedList.applystate}"/>
  </form>
	