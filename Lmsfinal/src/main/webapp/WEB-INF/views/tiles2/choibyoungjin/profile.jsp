<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath  = request.getContextPath();
%>

<style type="text/css">
	table#first {
		width: 88%;
		float: right;
	}
	table {
		width:100%;
	}
	table#last {
		width: 80%;
		float: left;
	}
	table, th, td {
		border: 1px solid #bcbcbc;
	}
	td {
		text-align: center;
	}
	button#btnEdit {
		background-color: gray;
		color: white;
		border:none;
		float:right;
		margin-top: 4%;
	}
	th {
		text-align: center;
		background-color: #3c3c3c;
		color: white;
	}
	h4 {
		margin-top: 3%;
	}
	input {
		width:100%;
		text-align: center;
	}
</style>

<script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
	});

</script>

<div style="display: flex; margin-bottom: 50px;">   
<div style="width: 70%; min-height: 700px; margin:auto; ">
<h4>개인정보 조회/수정</h4></br>
	<img src="<%=ctxPath%>/resources/images/choibyoungjin/profile.jpg" style="width:110px;">
	<table id=first>
		<tr>
			<th>학번</th>
			<td>${requestScope.studentvo.stdid}</td>
			<th>성명</th>
			<td style="width: 7%;">${requestScope.studentvo.stdname}</td>
			<th style="width: 10%;">성명(영문)</th>
			<td>${requestScope.studentvo.stdnameeng}</td>
			<th>생년월일</th>
			<td>${requestScope.studentvo.stdbirthday}</td>
		</tr>
		<tr>
			<th>학과</th>
			<td>${requestScope.studentvo.majorname}</td>
			<th>학년</th>
			<td>${requestScope.studentvo.grade}</td>
			<th>이수학기</th>
			<td>${requestScope.studentvo.completesemester}</td>
			<th>학적상태</th>
			<td>${requestScope.studentvo.statename}</td>			
		</tr>
		<tr>
			<th>복수전공</th>
			<td>${requestScope.studentvo.dmajorname}</td>
			<th>부전공</th>
			<td style="width: 13%;">${requestScope.studentvo.minorname}</td>
			<th>입학일자</th>
			<td>${requestScope.studentvo.entday}</td>
			<th>입학구분</th>
			<td>${requestScope.studentvo.entstate}</td>
		</tr>
		
	</table>
	
	<h4>기본정보</h4>
	<table>
		<tr>
			<th>주민등록번호</th>
			<td>${requestScope.studentvo.stdjumin}</td>
			<th>국적</th>
			<td>${requestScope.studentvo.stdnation}</td>
			<th>지도교수</th>
			<td>${requestScope.studentvo.gyoname}</td>
		</tr>
		<tr>
			<th>입학전형</th>
			<td>${requestScope.studentvo.enttype}</td>
			<th>수험번호</th>
			<td>${requestScope.studentvo.examnum}</td>
		</tr>
	</table>
	
	<h4>연락처</h4>
	<table>
		<tr>
			<th>우편번호</th>
			<td>${requestScope.studentvo.stdpostcode}</td>
			<th>연락처</th>
			<td>${requestScope.studentvo.stdmobile_hyphen}</td>			
		</tr>
		<tr>
			<th>이메일</th>
			<td>${requestScope.studentvo.stdemail}</td>
			<th>주소</th>
			<td>${requestScope.studentvo.stdaddress}</td>			
		</tr>
	</table>
	
	<h4>학력사항</h4>
	<table style="width: 85%; float:left;">
		<tr>
			<th>순번</th>
			<th>학교구분</th>
			<th>학교명</th>
			<th>졸업년월</th>
		</tr>
		<tr>
			<td>2</td>			
			<td>고등학교</td>
			<td>${requestScope.studentvo.schoolfrom2}</td>
			<td>${requestScope.studentvo.graddate2}</td>
		</tr>
		<tr>
			<td>1</td>			
			<td>중학교</td>
			<td>${requestScope.studentvo.schoolfrom1}</td>
			<td>${requestScope.studentvo.graddate1}</td>
		</tr>
	</table>
	<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnEdit" onclick="javascript:location.href='<%= request.getContextPath() %>/profileEdit.lmsfinal?stdid=${requestScope.studentvo.stdid}'">수정하기</button>
</div>
</div>