
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
   String ctxPath = request.getContextPath();
%>

<style type="text/css">

	th {background-color:  #00001a;
		 color: white;}

    .gyowonInfoStyle {font-weight: bold;
    			   color: navy;
    			   cursor: pointer;}

    a {text-decoration: none !important;}
 
</style>

<script type="text/javascript">

$(document).ready(function(){
	
	 
	 $("td.gyoname").bind("mouseover", function(event){
		   const $target = $(event.target);
		   $target.addClass("gyowonInfoStyle")
	   });
	   
	 $("td.gyoname").bind("mouseout", function(event){
		   const $target = $(event.target);
		   $target.removeClass("gyowonInfoStyle")
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

	
 // 검색시 검색조건 및 검색어 값 유지시
	 if(${not empty requestScope.paraMap} ) {     
			$("select#searchType_1").val("${requestScope.paraMap.searchType_1}");
			$("input#searchWord_1").val("${requestScope.paraMap.searchWord_1}");
	 }
 
// 특정 회원을 클릭시 그 회원의 상세정보 보여주기
	 $("td.gyoname").click( ()=>{
	 	
	 	 const $target = $(event.target);
	     const gyoname = $target.parent().children(".gyoname").text();
	 
	     const gobackURL = "${requestScope.gobackURL}"; 
	
	     location.href="<%= ctxPath%>/gyowonOneDetail.lmsfinal?gyoname="+gyoname+"&gobackURL=${requestScope.goBackURL}"; 
	                                                                        
	  }); 

    function goSearch() {
		const frm = document.gyowonListFrm;
		frm.action = "<%= ctxPath%>/gyowonList.lmsfinal";
		frm.method = "GET";
		frm.submit();
	} 
 
});// end of $(document).ready(function(){})-----------------------------



</script>

<div style="display: flex;">
<div style="margin: auto; padding-left: 3%;">

<h2 style="margin: 100px; text-align: center; font-weight:bolder;"> 회원전체 목록 </h2>

<button type="button" class="btn btn-secondary btn-sm mr-3" onclick="javascript:location.href='<%= ctxPath%>/studentList.lmsfinal'">학생정보</button>
<button type="button" class="btn btn-secondary btn-sm mr-3" onclick="javascript:location.href='<%= ctxPath%>/gyowonList.lmsfinal'">교원정보</button>


    <form name="gyowonListFrm"> 
     	<select name="searchType_1" id="searchType_1" style="height: 26px;">
			<option value="">검색대상</option>
			<option value="gyoname">교원이름</option>
			<option value="gyowonid">교원번호</option>
			<option value="gyomajorid">학과코드</option>
			<option value="deptname">학과명</option>
		</select>
	
     	<input type="text" name="searchWord_1" id="searchWord_1" size="50" autocomplete="off" /> 
		<input type="text" style="display: none;"/> 
		
		<button type="submit" class="btn btn-secondary btn-sm" onclick="goSearch()">조회</button>
		
	</form> 

      <table id="studentListTbl" class="table table-bordered" style="width: 1000px; margin-top: 20px; text-align: center;">
         <thead>
           <tr>
	         <th style="width: 70px;  text-align: center;">이름</th>
	         <th style="width: 150px; text-align: center;">교원번호</th>
	         <th style="width: 70px;  text-align: center;">학과코드</th>
	         <th style="width: 70px;  text-align: center;">학과명</th>
	         <th style="width: 90px; text-align: center;">근로상태</th>
	       </tr>
         </thead>
         
         <tbody>
             <c:if test="${not empty requestScope.gyowonList}">
 	            <c:forEach var="gyowonvo" items="${requestScope.gyowonList}">
 	            	<tr class="gyowonInfo">
 	            		<td class="gyoname">${gyowonvo.gyoname}</td>
 	            		<td id="gyowonid">${gyowonvo.gyowonid}</td>
 	            		<td>${gyowonvo.gyomajorid}</td>
 	            		<td>${gyowonvo.deptname}</td>
 	            		<td>
 	            		 <c:choose>
	           		    	<c:when test="${gyowonvo.workstatus eq '1'}">재직</c:when>
	           		    	<c:when test="${gyowonvo.workstatus eq '2'}">휴직</c:when>
	           		     </c:choose>
 	            		</td>
 	            	</tr>
 	            </c:forEach>
             </c:if>
             
           
             <c:if test="${empty requestScope.gyowonList}">
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



