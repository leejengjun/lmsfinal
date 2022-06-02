<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath  = request.getContextPath();
%>

<style type="text/css">

	h4 {
		margin-top: 3%;
	}

	table#courseList {
		width: 100%;
	}
	
	table#courseList th, table#courseList td {
		border: solid 1px gray;
		border-collapse: collapse;
	}

	table#courseList th {
		text-align: center;
		background-color: black;
		color: white;
	}
	
	table#courseList td {
		background-color: #eee;
		height: 60px;
	}
	
	form#searchFrm {
		border: solid 1px gray;
		padding: 20px;
		padding-left: 40px;
	}
	input {
		float: center;
	}
	div#courseList {
		width: 70%; 
		min-height: 1100px; 
		margin:auto;"	
	}
	div#out{
		display: flex; 
		margin-bottom: 50px;
	}
	td.button {
		display:none;
		background-color: white;
	}
	
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("button#cancel").click(function(){
			
			let str = "";
			let tdArr = new Array();	// 배열 선언
			let submit = $(this);
						
			// 현재 클릭된 row
			let tr = submit.parent().parent();
			let td = tr.children();
			
			// td.eq(index)를 통해 값을 가져올 수 있다.
			let subjectid = td.eq(0).text();
			let courseno = td.eq(12).text();
			
			document.cancelFrm.subjectid.value = subjectid;
			document.cancelFrm.courseno.value = courseno;

			const frm = document.cancelFrm;
			frm.method = "POST";
			frm.action = "<%=ctxPath%>/course_delete.lmsfinal";
			frm.submit();
			
		});
	
		// 신청학점 확인
		let totalRow = 0;
		$('#courseList tr').each(function() {
			
			$(this).find('td:eq(7)').each(function(){
				
				totalRow += parseFloat($(this).text());
				
			});
			
			document.credit.submitcredit.value = totalRow;
			document.credit.totalcredit.value = 21;
			
		}); 
		
		
	});
	
	

</script>

<div id=out>   
<div id=courseList>

	<form name=cancelFrm>
		<input type="hidden" name="courseno" value="">
		<input type="hidden" name="subjectid" value="">
	</form>
	
	<h4>신청목록</h4>
	<div style="margin-left: 70%;">
		<form name=credit>
			<span>총 신청 가능학점 : <input style="font-weight:bolder; border:0 solid black" type="text" name="totalcredit" value=""/></br></span>
			<span>신청학점 : <input style="font-weight:bolder; border:0 solid black" type="text" name="submitcredit" id="submitcredit" value=""/> </span>
		</form>
	</div>
	<table id="courseList">
		<thead>
			<tr>				
				<th>학수번호</th>
				<th>학과</th>
				<th>강좌명</th>
				<th>대상학년</th>
				<th>정원</th>
				<th>잔여인원</th>
				<th>교수명</th>
				<th>학점</th>
				<th>요일</th>
				<th>교시</th>
				<th>강의실</th>	
				<th style="display: none;">courseno</th>
			</tr>
		</thead>
		<tbody id=courseList_body>
			<c:forEach var="map" items="${requestScope.courseList}">
				<tr>
					<td style="text-align: center;">${map.subjectid}</td>
					<td>${map.deptname}</td>
					<td>${map.classname}</td>
					<td style="text-align: center;">${map.grade}학년</td>
					<td style="text-align: center;">${map.totalperson}명</td>
					<td style="text-align: center;">${map.remaingseat}명</td>
					<td style="text-align: center;">${map.gyoname}</td>
					<td style="text-align: center;">${map.credit}학점</td>
					<td style="text-align: center;">${map.dayname}</td>
					<td style="text-align: center;">${map.periodid1} ~ ${map.periodid3} 교시</td>
					<td style="text-align: center;">${map.lctrid}</td>
					<td class=button style="text-align: center; border: none; width: 40px;"><button id="cancel">취소</button></td>
					<td style="text-align: center; display: none;">${map.courseno}</td>
					<td style="text-align: center; display: none;">${map.dayid}</td>
					<td style="text-align: center; display: none;">${map.periodid1}</td>
					<td style="text-align: center; display: none;">${map.periodid2}</td>
					<td style="text-align: center; display: none;">${map.periodid3}</td>
				</tr>
			</c:forEach>
			<tr id="totalRow"></tr>
		</tbody>		
	</table>	
	
</div>
</div>

