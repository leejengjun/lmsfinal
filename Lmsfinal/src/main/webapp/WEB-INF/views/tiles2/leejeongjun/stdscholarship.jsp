<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  

<%
   String ctxPath = request.getContextPath();
  //       /lmsfinal
%>


<style type="text/css">


</style>


<div style="display: flex;">
<div style="width: 70%; min-height: 2500px; margin:auto; ">

	<h3 style="margin: 50px 0;">학생정보</h3>
	<div id="student_info">
	<table class="table table-borderless table-dark">
	<tbody>
	    <tr>
	      <td>성명:  ${studentInfo.STDNAME}</td>
	      <td>학번:  ${studentInfo.STDID}</td>
	      <td>학과:  ${studentInfo.DEPTNAME}</td>
	      <td>학적상태:  ${studentInfo.STATENAME}</td>
	      <td>생년월일:  ${studentInfo.STDBIRTHDAY}</td>
	    </tr>
	    <tr>
	      <td>연락처:  ${studentInfo.STDMOBILE}</td>
	      <td colspan="2">주소: 우편주소: ${studentInfo.STDPOSTCODE} / 상세주소: ${studentInfo.STDADDRESS}</td>
	      <td>이메일: ${STDEMAIL}</td>
	      <td>이수학기: ${studentInfo.COMPLETESEMESTER}학기</td>
	    </tr>
	</tbody>
	</table>
	</div>
	<br/><br/>
	
	<h3 style="margin: 5px 0;">장학금 지급 내역</h3>
	<div style="text-align: right;">
		<button type="button" class="btn btn-secondary btn-sm" id="btnExcel">Excel파일로저장</button>
	</div>
	<br/>
	<div id="stdscholarship_List">
		<table id="stdscholarship_List" class="table">
		  <thead class="thead-light">
		    <tr style="text-align: center;">
		      <th>순번</th>
		      <th>지급학기</th>
		      <th>분류명</th>
		      <th>장학명</th>
		      <th>장학금액</th>
		    </tr>
		  </thead>
		  <tbody>
		    <c:forEach var="item" items="${stdscholarshipList}" varStatus="status">
			    <tr>
			      <th style="text-align: center;">${status.count}</th>
			      <td style="text-align: center;">${item.paysemester}</td>
			      <td style="text-align: center;">${item.sortname}</td>
			      <td style="text-align: center;">${item.scholarshipnm}</td>
			      <td style="text-align: right;"><fmt:formatNumber value="${item.scholarshipamt}" pattern="#,###" /></td>
			    </tr>
		    </c:forEach>
		  </tbody>
		</table>
	</div>

</div>
</div>

<script type="text/javascript">
	
	$(document).ready(function(){
		// ====== Excel 파일로 다운받기 시작 ====== //
		$("button#btnExcel").click(function(){
			
			location.href = "<%= request.getContextPath()%>/excel/downloadExcelFile.lmsfinal";	
		});
		// ====== Excel 파일로 다운받기 끝 ====== //
	}); // end of $(document).ready(function(){----------------------
	
</script>







