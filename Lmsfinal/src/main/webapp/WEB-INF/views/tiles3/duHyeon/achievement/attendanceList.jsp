<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   String ctxPath = request.getContextPath();
  //       /lmsfinal
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
* {
  box-sizing: border-box;
}

input[type=text], select, textarea {
  width: 100%;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 4px;
  resize: vertical;
}


input[type=submit]:hover {
  background-color: #45a049;
}


.container{
	padding:20px;
}

.container > div.navbar > div.col-3{
	text-align: center;
	height:49px;
	border: solid 1px black;
	margin:0 auto;
	padding:0;
}
.container > div.navbar > div.col-3 > a{
	
	position: absolute;
	top:10px;
}
.col-25 {
  float: left;
  width: 25%;
  margin-top: 6px;
}

.col-75 {
  float: left;
  width: 75%;
  margin-top: 6px;
}

/* Clear floats after the columns */
.row:after {
  content: "";
  display: table;
  clear: both;
}

/* Responsive layout - when the screen is less than 600px wide, make the two columns stack on top of each other instead of next to each other */
@media screen and (max-width: 600px) {
  .col-25, .col-75, input[type=submit] {
    width: 100%;
    margin-top: 0;
  }
}

.chekckboxcontainer {
  display: block;
  position: relative;
  padding-left: 35px;
  margin-bottom: 12px;
  cursor: pointer;
  font-size: 22px;
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
  display: inline-block;
}

/* Hide the browser's default radio button */
.chekckboxcontainer input {
  position: absolute;
  opacity: 0;
  cursor: pointer;
}

/* Create a custom radio button */
.checkmark {
  position: absolute;
  top: 0;
  left: 0;
  height: 25px;
  width: 25px;
  background-color: #eee;
  border-radius: 50%;
}

/* On mouse-over, add a grey background color */
.chekckboxcontainer:hover input ~ .checkmark {
  background-color: #ccc;
}

/* When the radio button is checked, add a blue background */
.chekckboxcontainer input.attend:checked ~ .checkmark {
  background-color: #0033cc;
}

/* When the radio button is checked, add a blue background */
.chekckboxcontainer input.tardy:checked ~ .checkmark {
  background-color: #e6e600;
}

/* When the radio button is checked, add a blue background */
.chekckboxcontainer input.absent:checked ~ .checkmark {
  background-color: #ff0000;
}

/* Create the indicator (the dot/circle - hidden when not checked) */
.checkmark:after {
  content: "";
  position: absolute;
  display: none;
}

/* Show the indicator (dot/circle) when checked */
.chekckboxcontainer input:checked ~ .checkmark:after {
  display: block;
}

/* Style the indicator (dot/circle) */
.chekckboxcontainer .checkmark:after {
 	top: 9px;
	left: 9px;
	width: 8px;
	height: 8px;
	border-radius: 50%;
	background: white;
}
</style>

<script type="text/javascript">

	$(document).ready(function(){
		

		
		let fix = $("input#attendweek").val();
		
		var html = "";
		for(var i = 1; i < 16; i++){
			
			if(fix != "" && i == fix){
				html+="<option value='"+i+"' selected>"+i+"주차</option>"
			}
			else{
				html+="<option value='"+i+"'>"+i+"주차</option>"
			}
			
			
		}
		$("select#week").html(html);
		fixweek();
		
		$("td.tdweek").text($("select#week").val());
		
		
		

	});// end of $(document).ready(funciton(){})----------------------------
	
	
	function gocheckattend(){
		
		const frm = document.attendanceFrm;
		frm.method = "POST";
		frm.action = "<%=ctxPath%>/checkattend.lmsfinal";
		frm.submit();
		
	}
	
	
	function gosearch(){
		
		$("input#attendweek").val($("select#week").val());
		
		const frm = document.attendanceFrm;
		frm.method = "get";
		frm.action = "<%=ctxPath%>/attendanceList.lmsfinal";
		frm.submit();
	}// end o gosearch() --------------------------
	
	function fixweek(){
		
		el = document.getElementById('week');  //select box
		len = el.options.length; //select box의 option 갯수
		str = $("input#attendweek").val(); //입력 받은 value 값
	
		 
		for (let i=0; i<len; i++){  
			if(el.options[i].value == str){
				el.options[i].selected = true;
			}
		}
	}// end of fixweek------------------------------- 
	
	
	function modifyatt(count){
		
		
		var courseno = $("input[name=courseno"+count+"]").val();
		var stdid = $("input[name=stdid"+count+"]").val();
		var attendance = $("input[name=attendance"+count+"]:checked").val();
		
		$.ajax({
			url : "<%=ctxPath%>/updateAtt.lmsfinal", 
			type : "POST", 
			data:{"courseno" : courseno
				, "stdid" : stdid
				, "attendance" : attendance
				, "attendweek" : $("input#attendweek").val()
				, "subjectid" : $("input#subjectid").val()},
			datatype : "json",
			success:function(json){
				alert("정상적으로 수정 완료되었습니다.");
			},
			error: function(){
				alert("수정 실패");
			}
			
		
	});
	
}
</script>

<div class="container w-75" style="margin: 250px; padding:0;">
	
		<h2 style="margin-bottom: 30px;">출결 목록</h2>
	
	
	<select id="week"  style="width: 20%;">
	</select>
	<button type="button" class="btn btn-dark" style="width: 20%;" onclick="gosearch()">조회</button>
	<div class="innercontainer w-100">
		<form name="attendanceFrm">
			<table class="table table-bordered">
				<thead>
					<tr>
						<td>이름</td>
						<td>학번</td>
						<td>주차</td>
						<td>출석</td>
						<td>수정하기</td>
					</tr>
				</thead>
				
				<tbody>
					<c:if test="${ empty requestScope.attList}">
						없습니다.
					</c:if>
					<c:forEach var="att" items="${requestScope.attList}" varStatus="status">
						<tr>
							<td>${att.stdname}</td>
							<td>${att.stdid}</td>
							<td class="tdweek"></td>
							<td>
								<input type="hidden" name="courseno${status.count}" value="${att.courseno}"/>
								<input type="hidden" name="stdid${status.count}" value="${att.stdid}"/>
							
								<c:choose>
									<c:when test="${att.attendance == 1}">
										<label class="chekckboxcontainer">출석
											<input type="radio" id="attend${status.count}" name="attendance${status.count}" value="attend" class="attend" checked>
										  	<span class="checkmark"></span>
										</label>
										<label class="chekckboxcontainer">지각
											<input type="radio" id="tardy${status.count}" name="attendance${status.count}" value="tardy" class="tardy">
										  	<span class="checkmark"></span>
										</label>
										<label class="chekckboxcontainer">결석
										  	<input type="radio" id="absent${status.count}" name="attendance${status.count}" value="absent" class="absent">
										  	<span class="checkmark"></span>
										</label>
									</c:when>
									<c:when test="${att.tardy== 1}">
										<label class="chekckboxcontainer">출석
											<input type="radio" id="attend${status.count}" name="attendance${status.count}" value="attend" class="attend">
										  	<span class="checkmark"></span>
										</label>
										<label class="chekckboxcontainer">지각
											<input type="radio" id="tardy${status.count}" name="attendance${status.count}" value="tardy" class="tardy" checked>
										  	<span class="checkmark"></span>
										</label>
										<label class="chekckboxcontainer">결석
										  	<input type="radio" id="absent${status.count}" name="attendance${status.count}" value="absent" class="absent">
										  	<span class="checkmark"></span>
										</label> 
									</c:when>
									<c:when test="${att.absent == 1}">
										<label class="chekckboxcontainer">출석
											<input type="radio" id="attend${status.count}" name="attendance${status.count}" value="attend" class="attend">
										  	<span class="checkmark"></span>
										</label>
										<label class="chekckboxcontainer">지각
											<input type="radio" id="tardy${status.count}" name="attendance${status.count}" value="tardy" class="tardy">
										  	<span class="checkmark"></span>
										</label>
										<label class="chekckboxcontainer">결석
										  	<input type="radio" id="absent${status.count}" name="attendance${status.count}" value="absent" class="absent" checked>
										  	<span class="checkmark"></span>
										</label> 
									</c:when>
									
									<c:otherwise>
									<label class="chekckboxcontainer">출석
											<input type="radio" id="attend${status.count}" name="attendance${status.count}" value="attend" class="attend">
										  	<span class="checkmark"></span>
										</label>
										<label class="chekckboxcontainer">지각
											<input type="radio" id="tardy${status.count}" name="attendance${status.count}" value="tardy" class="tardy">
										  	<span class="checkmark"></span>
										</label>
										<label class="chekckboxcontainer">결석
										  	<input type="radio" id="absent${status.count}" name="attendance${status.count}" value="absent" class="absent">
										  	<span class="checkmark"></span>
										</label> 
									</c:otherwise> 
								</c:choose>
							</td>
							<td style="text-align: center"><button type="button" class="btn btn-dark" onclick="modifyatt(${status.count})">수정하기</button></td>
						</tr>
						
						
					</c:forEach>
				</tbody>
			</table>
			<input type="hidden" id="subjectid" name="subjectid" value="${requestScope.subjectid}"/>
			<input type="hidden" id="attendweek" name="attendweek" value="${requestScope.attendweek}"/>
		</form>
		<c:set var="isfirst" value="true"></c:set>
		
		<c:forEach var="attlist" items="${requestScope.attList}">
			<c:if test="${attlist.attendweek eq null and attlist.tardy eq null and attlist.attendance eq null and attlist.absent eq null}">
				<c:set var="isfirst" value="false"></c:set>
			</c:if>
		</c:forEach>
		
			
		<c:if test="${isfirst ne true}">
			<div style="text-align: center;"><button type="button" class="btn btn-dark" id="${staus.count}" onclick="gocheckattend()">출석체크 하기</button></div>
		</c:if>	
	</div>
</div>