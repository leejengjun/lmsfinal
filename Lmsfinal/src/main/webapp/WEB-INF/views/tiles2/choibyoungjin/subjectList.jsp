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

	table#subjecttbl {
		width: 100%;
	}
	
	table#courseList {
		width: 100% !important;
	}
	
	table#courseList td {
		height: auto !important;
	}
	
	table#subjecttbl th, table#subjecttbl td {
		border: solid 1px gray;
		border-collapse: collapse;
		
	}

	table#subjecttbl th {
		text-align: center;
		background-color: black;
		color: white;
	}
	
	table#subjecttbl td {
		background-color: #eee;
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
		width: 100% !important; 
		
	}
	li {
		cursor: pointer;
	}
	
	button#submit, #cancel {
		background-color: #0071bd;
		border: none;
		color: white;
		width: 70px;
		height: 30px;
		font-size: 12pt;
		padding: 3px 0px;
		border-radius: 10%;
	}
	
	td.button {
		text-align: center !important; 
		display: block !important; 
		background-color: none !important; 
		border: none !important; 
		width: 40px !important;
	}
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		
		// 검색하기 버튼 클릭시 
		$("button#btnSearch").click(function(){
						
			const frm = document.searchFrm;			
			frm.method = "GET";
			frm.action = "course_application.lmsfinal";	// 상대주소
			frm.submit();
			
		});			
		
		const deptname = "${requestScope.deptname}";
		if(deptname != "") {
			$("select#deptname").val(deptname);
		}
		
		const dayname = "${requestScope.dayname}";
		if(dayname != "") {
			$("select#dayname").val(dayname);
		}
		
		const grade = "${requestScope.grade}";
		if(grade != "") {
			$("select#grade").val(grade);
		}
		
		const classname = "${requestScope.classname}";
		if(classname != "") {
			$("input#classname").val(classname);
		}
		
		const gyoname = "${requestScope.gyoname}";
		if(gyoname != "") {
			$("input#gyoname").val(gyoname);
		}
		
		$("button#submit").click(function(){
			
			let str = "";
			let tdArr = new Array();	// 배열 선언
			let submit = $(this);
						
			// 현재 클릭된 row
			let tr = submit.parent().parent();
			let td = tr.children();
			
			// td.eq(index)를 통해 값을 가져올 수 있다.
			let subjectid = td.eq(0).text();
			let majorid = td.eq(12).text();
			let gyowonid = td.eq(13).text();
			let remaingseat = parseInt((td.eq(5).text()).slice(0, -1));	
			let dayid = td.eq(14).text();
			let periodid1 = td.eq(15).text();
			let periodid2 = td.eq(16).text();
			let periodid3 = td.eq(17).text();
						
		//	let로 선언한 td값 확인 
		//	console.log(remaingseat);
		//	console.log($("input#submitcredit").val());	
		//	console.log($("input#dayid").val());
		//	console.log($("input#periodid1").val());
		//	console.log($("input#periodid2").val());
		//	console.log($("input#periodid3").val());
		//	console.log(dayid);
		//	console.log(periodid1);
		//	console.log(periodid2);
		//	console.log(periodid3);
			
			if(remaingseat == 0){
				alert("남은 자리가 없습니다!!");
				return 0;
			}
			
			if($("input#submitcredit").val() >= 21){
				alert("신청 가능 학점을 초과했습니다.");
				return 0;
			}
			
			document.submitFrm.subjectid.value = subjectid;
			document.submitFrm.majorid.value = majorid;
			document.submitFrm.gyowonid.value = gyowonid;
			document.submitFrm.remaingseat.value = remaingseat;
			
			var rows = document.getElementById("courseList_body").getElementsByTagName("tr");
		//	console.log(rows.length);	// tbody tr 개수 = 2
		    
		    
		    // 신청한 과목의 요일, 교시코드 모두 가져오기
		    for( var r=0; r<rows.length-1; r++ ){
				var cells = rows[r].getElementsByTagName("td");
				var cell_1 = cells[13].firstChild.data;
			    var cell_2 = cells[14].firstChild.data;
			    var cell_3 = cells[15].firstChild.data;
			    var cell_4 = cells[16].firstChild.data;
			    var cell_5 = cells[0].firstChild.data;
			    
			    if(cell_5 == subjectid){
			    	alert("이미 신청된 과목입니다!")
			    	return 0;
			    }
			    
			    
			    if(cell_1 == dayid && (cell_2 == periodid1 || cell_2 == periodid2 || cell_2 == periodid3
			    					|| cell_3 == periodid1 || cell_3 == periodid2 || cell_3 == periodid3 
			    					|| cell_4 == periodid1 || cell_4 == periodid2 || cell_4 == periodid3)){
			    	alert("신청완료한 과목과 시간이 겹칩니다!!");
			    	return 0;
			    }
			    
			    
			    // 신청한 과목의 요일, 교시코드 확인
			//    console.log(cell_1);
			//    console.log(cell_2);
			//    console.log(cell_3);
			//    console.log(cell_4);
			//    console.log("");
				
			}
			
			const frm = document.submitFrm;
			frm.method = "POST";
			frm.action = "<%=ctxPath%>/course_submit.lmsfinal";
			frm.submit();
		});
		
	});

</script>

<div style="display: flex; margin-bottom: 50px;">   
<div style="width: 70%; min-height: 1100px; margin:auto; ">
	<form name=submitFrm>
		<input type="hidden" name="stdid" value="${sessionScope.loginuser.userid}"/>
		<input type="hidden" name="completesemester" value="${sessionScope.loginuser.completesemester + 1}"/>		
		<input type="hidden" name="subjectid" value="">
		<input type="hidden" name="majorid" value="">
		<input type="hidden" name="gyowonid" value="">
		<input type="hidden" name="remaingseat" value="">
	</form>
	
	<h4>개설강좌목록</h4>
	<form name="searchFrm" id="searchFrm">
		<span>학과</span>			
		<select name="deptname" id="deptname" style="height: 30px; width: 120px; margin: 10px 30px 0 0;">
			<option value="">학과선택</option>
			<c:forEach var="deptname" items="${requestScope.deptList}" varStatus="status">
				<option>${deptname}</option>
			</c:forEach>
		</select>

		<span>요일</span>	
		<select name="dayname" id="dayname" style="height: 30px; width: 120px; margin: 10px 30px 0 0;">
			<option value="">요일선택</option>
			<c:forEach var="dayname" items="${requestScope.dayList}" varStatus="status">
				<option>${dayname}</option>
			</c:forEach>
		</select>

		<span>학년</span>
		<select name="grade" id="grade" style="height: 30px; width: 120px; margin: 10px 30px 0 0;">
			<option value="">학년선택</option>
			<c:forEach var="grade" items="${requestScope.gradeList}" varStatus="status">
				<option>${grade}</option>
			</c:forEach>
		</select>
	
		<span>강좌명</span>
		<input type="text" name="classname" id="classname" style="height: 30px; width: 120px; margin: 10px 30px 0 0;"/>

		<span>교수명</span>
		<input type="text" name="gyoname" id="gyoname" style="height: 30px; width: 120px; margin: 10px 30px 0 0;"/>

		<button type="button" class="btn btn-secondary btn-sm" id="btnSearch" style="margin-left: 150px; width: 100px;">검색하기</button>
	</form>
	</br>
	
	
	
	<table id="subjecttbl">
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
				<th style="display: none;">과목번호</th>
				<th style="display: none;">교수번호</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${not empty requestScope.subjectList}">
			<c:forEach var="map" items="${requestScope.subjectList}">
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
					<td style="text-align: center; display: block; background-color: white; border: none; width: 40px;"><button id="submit">신청</button></td>
					<td style="text-align: center; display: none;">${map.majorid}</td>
					<td style="text-align: center; display: none;">${map.gyowonid}</td>
					<td style="text-align: center; display: none;">${map.dayid}</td>
					<td style="text-align: center; display: none;">${map.periodid1}</td>
					<td style="text-align: center; display: none;">${map.periodid2}</td>
					<td style="text-align: center; display: none;">${map.periodid3}</td>				
				</tr>
			</c:forEach>
		</c:if>
		</tbody>
	</table>
	<div align="center" style="border: solid 0px gray; width: 70%; margin: 20px auto;">
		${requestScope.pageBar}
	</div>
	</br>
	
		<c:import url="/mycourseList.lmsfinal?stdid=${sessionScope.loginuser.userid}"/>
	
</div>
</div>
