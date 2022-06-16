
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>

<%
   String ctxPath = request.getContextPath();
%>

<style type="text/css">

div#mvoInfo {
      width: 100%; 
      text-align: center;
      border: solid 0px red;
      margin-top: 100px; 
      font-size: 13pt;
      line-height: 200%;
   
   }
   
   span.myli {
      display: inline-block;
      width: 90px;
      border: solid 0px blue;
   
   }
   
	th {
	     background-color:  #00001a;
		 color: white;
		}
</style>

<script type="text/javascript">



$(document).ready(function(){
	

	function goStudentList() {
		let goBackURL = "${requestScope.goBackURL}";
	
        goBackURL = goBackURL.replace(/ /gi, "&");
     
	}
	
	
	});	


</script>

	
<div style="text-align: center; padding:50px;"><h3 style="font-weight:bolder;"> ${requestScope.studentvo.stdname} 님의 회원 상세정보 </h3></div>
	
	<c:if test="${not empty requestScope.studentvo}">
    	<table style="width: 800px; margin: auto;" class="table table-bordered table-white" id="mvoInfo">
    		<tr>
    		    <th style="width: 20%">학번</th>
    		    <td>${requestScope.studentvo.stdid}</td>
    		</tr>
    		<tr>
    		    <th>학과코드</th>
    		    <td>${requestScope.studentvo.stdmajorid}</td>
    		</tr>
    		<tr>
    		    <th>학과이름</th>
    		    <td>${requestScope.studentvo.deptname}</td>
    		</tr>
    		<tr>
    		    <th>복수전공코드</th>
    		    <td>${requestScope.studentvo.dmajorid}</td>
    		</tr>
    		<tr>
    		    <th>학적상태코드</th>
    		    <td>
	    		    <c:if test="${requestScope.studentvo.stdstateid eq '1'}">재학</c:if>
	    		    <c:if test="${requestScope.studentvo.stdstateid eq '2'}">휴학</c:if>
	    		    <c:if test="${requestScope.studentvo.stdstateid eq '6'}">휴학신청</c:if>
	    		    <c:if test="${requestScope.studentvo.stdstateid eq '7'}">복학신청</c:if>
    		    </td>
    		</tr>
    		
    		<tr>
    		    <th>이름</th>
    		    <td>${requestScope.studentvo.stdname}</td>
    		</tr>
    		<tr>
    		    <th>이메일</th>
    		    <td>${stdemail}</td>
    		</tr>
    	
    		<tr>
    		    <th>생년월일</th>
    		    <td>${requestScope.studentvo.stdbirthday}</td>
    		</tr>
    		<tr>
    		    <th>입학일자</th>
    		    <td>${requestScope.studentvo.entday}</td>
    		</tr>
    	
    		<tr>
    		    <th>입학전형</th>
    		    <td>${requestScope.studentvo.enttype}</td>
    		</tr>
    		<tr>
    		    <th>입학구분</th>
    		    <td>${requestScope.studentvo.entstate}</td>
    		</tr>
    		
    		<tr>
    		    <th>우편번호</th>
    		    <td>${requestScope.studentvo.stdpostcode}</td>
    		</tr>
    		<tr>
    		    <th>주소</th>
    		    <td>${requestScope.studentvo.stdaddress}</td>
    		</tr>
    		<tr>
    		    <th>연락처</th>
    		    <td>${requestScope.studentvo.stdmobile}</td>
    		</tr>
    		
    	
    	</table>	
 </c:if> 
<div>
   <button style="margin:10px 0 0 1390px; text-align:center;" type="button" class="btn-outline-dark btn-sm mr-3" onclick="javascript:history.back();">회원목록</button>  
 </div>  
  



    