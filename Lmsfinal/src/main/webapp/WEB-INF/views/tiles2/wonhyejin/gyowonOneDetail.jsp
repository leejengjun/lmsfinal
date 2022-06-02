
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
   
	th {background-color:  #00001a;
		 color: white;}
</style>

<script type="text/javascript">



$(document).ready(function(){
 
	function goGyowonList() {
		let goBackURL = "${requestScope.goBackURL}";
	  
        goBackURL = goBackURL.replace(/ /gi, "&");
  
	}
	
</script>

	<div style="text-align: center; padding:50px;"><h3 style="font-weight:bolder;"> ${requestScope.gyowonvo.gyoname} 님의 회원 상세정보 </h3></div>
	

	<c:if test="${not empty requestScope.gyowonvo}">
    	<table style="width: 800px; margin: auto;" class="table table-bordered table-white" id="mvoInfo">
    		<tr>
    		    <th style="width: 20%">교원번호</th>
    		    <td>${requestScope.gyowonvo.gyowonid}</td>
    		</tr>
    		<tr>
    		    <th>학과코드</th>
    		    <td>${requestScope.gyowonvo.gyomajorid}</td>
    		</tr>
    		<tr>
    		    <th>학과이름</th>
    		    <td>${requestScope.gyowonvo.deptname}</td>
    		</tr>
    		<tr>
    		    <th>근로상태코드</th>
    		    <td>
	    		    <c:if test="${requestScope.gyowonvo.workstatus eq '1'}">재직</c:if>
	    		    <c:if test="${requestScope.gyowonvo.workstatus eq '2'}">휴직</c:if>
    		    </td>
    		</tr>
    		
    		<tr>
    		    <th>이름</th>
    		    <td>${requestScope.gyowonvo.gyoname}</td>
    		</tr>
    		<tr>
    		    <th>이메일</th>
    		    <td>${gyoemail}</td>
    		</tr>
    	
    		<tr>
    		    <th>생년월일</th>
    		    <td>${requestScope.gyowonvo.gyobirthday}</td>
    		</tr>
    		
    		<tr>
    		    <th>임용일자</th>
    		    <td>${requestScope.gyowonvo.appointmentdt}</td>
    		</tr>
    		
    		<tr>
    		    <th>우편번호</th>
    		    <td>${requestScope.gyowonvo.gyopostcode}</td>
    		</tr>
    		<tr>
    		    <th>주소</th>
    		    <td>${requestScope.gyowonvo.gyoaddress}</td>
    		</tr>
    		<tr>
    		    <th>연락처</th>
    		    <td>${requestScope.gyowonvo.gyomobile}</td>
    		</tr>
    		 
    	</table>	
 </c:if> 
<div>
   <button style="margin:10px 0 0 1390px; text-align:center;" type="button" class="btn-outline-dark btn-sm mr-3" onclick="javascript:history.back();">회원목록</button>  
 </div>  


    