<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
    
<%
	String ctxPath = request.getContextPath();
	String gyowonid = String.valueOf(session.getAttribute("userid"));
	String subjectid = request.getParameter("subjectid");
	String seq_lectureplan = request.getParameter("seq_lectureplan");
%>    
<style type="text/css">
th {background-color: #DDD}
</style>

<script type="text/javascript">

  $(document).ready(function(){
	  

	  // === 제출하기
	  $("button#btnEditplan").click(function(){		  
		  // 글내용 유효성 검사 
		  const lpsummary = $("textarea#lpsummary").val().trim();
		  if(lpsummary == "") {
			  alert("강의개요를 입력하세요!!");
			  return;
		  }
		  const lpobject = $("textarea#lpobject").val().trim();
		  if(lpobject == "") {
			  alert("강의목표를 입력하세요!!");
			  return;
		  }
		  const lpbook = $("textarea#lpbook").val().trim();
		  if(lpbook == "") {
			  alert("교재 및 참고문헌을 입력하세요!!");
			  return;
		  }
		  
		// 비율은 1이 되는지  유효성검사
		var lpattendper = Number($("input#lpattendper").val()); 
		var lpexamper = Number($("input#lpexamper").val());
		var lphomewkper = Number($("input#lphomewkper").val());
		var sum = lpattendper + lpexamper + lphomewkper;
		if( sum != 1) {
			alert("성적 비율의 합은 1이 되어야 합니다.");
			return;
		}
		else {		
			lpattendper = lpattendper.toFixed(2);
			lpexamper = lpexamper.toFixed(2);
			lphomewkper = lphomewkper.toFixed(2);
		}
		
		
		// 폼(form)을 전송(submit)
		const frm = document.editlectureplanFrm;
		frm.method = "POST";
		frm.action = "<%= ctxPath%>/editlctrplanEnd.lmsfinal";
		frm.submit();

	  });
	  
	  
  });// end of $(document).ready(function(){})-------------------------------
 
  
</script>

<div style="display: flex; height:2000px;">
	<div style="margin: auto; padding-left: 3%; margin-top: 3%;">

	<h3 style="margin-bottom:30px;">강의계획서</h3>

	<form name="editlectureplanFrm">
	<table style="width: 1024px" class="table table-bordered">
					
		<tr>
			<th style="width: 15%; background-color: #DDDDDD;">강의명</th>
			<td>
				<input type="hidden" name="seq_lectureplan" id="seq_lectureplan" style="border:none;" value="${requestScope.lctrplanvo.seq_lectureplan}" readonly />
				<input type="hidden" name="subjectid" id="subjectid" style="border:none;" value="${requestScope.lctrplanvo.subjectid}" readonly />
				<input type="text" name="classname" id="classname" size="110" style="border:none;" value="${requestScope.lctrplanvo.classname}" readonly/>
			</td>
		</tr>
		<tr>
			<th style="width: 15%; background-color: #DDDDDD;">학과</th>
			<td>
				<input type="hidden" name="majorid" id="majorid" style="border:none;" value="${requestScope.lctrplanvo.majorid}" readonly/>
				<input type="text" name="deptname" id="deptname" style="border:none;" value="${requestScope.lctrplanvo.deptname}" readonly/>
			</td>
		</tr>
		<tr>
			<th style="width: 15%; background-color: #DDDDDD;">교수</th>
			<td>
				<input type="hidden" name="gyowonid" id="gyowonid" style="border:none;" value="${requestScope.lctrplanvo.gyowonid}" readonly/>
				<input type="text" name="gyoname" id="gyoname" style="border:none;" value="${requestScope.lctrplanvo.gyoname}" readonly/>
			</td>
		</tr>
		<tr>
			<th style="width: 15%; background-color: #DDDDDD;">강의개요</th>
			<td>
				<textarea style="width: 100%; height: 200px;" name="lpsummary" id="lpsummary">${requestScope.lctrplanvo.lpsummary}</textarea>
			</td>
		</tr>
		<tr>
			<th style="width: 15%; background-color: #DDDDDD;">교과목표</th>
			<td>
				<textarea style="width: 100%; height: 200px;" name="lpobject" id="lpobject">${requestScope.lctrplanvo.lpobject}</textarea>
			</td>
		</tr>
		<tr>
			<th style="width: 15%; background-color: #DDDDDD;">교재 및 참고문헌</th>
			<td>
				<textarea style="width: 100%; height: 300px;" name="lpbook" id="lpbook">${requestScope.lctrplanvo.lpbook}</textarea>
			</td>
		</tr>
		<tr>
			<th style="width: 15%; background-color: #DDDDDD;">성적 비율</th>
			<td>
				<span>출석비율</span><input type="number" id="lpattendper" name="lpattendper" min="0" max="1" step="0.05" value="0${requestScope.lctrplanvo.lpattendper}" style="width: 80px;" required />
				<span>시험비율</span><input type="number" id="lpexamper" name="lpexamper" min="0" max="1" step="0.05" value="0${requestScope.lctrplanvo.lpexamper}" style="width: 80px;" required />
				<span>과제비율</span><input type="number" id="lphomewkper" name="lphomewkper" min="0" max="1" step="0.05" value="0${requestScope.lctrplanvo.lphomewkper}" style="width: 80px;" required />
			</td>
		</tr>
	
	</table>
	
	
	<div style="margin: 20px;">
		<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnEditplan">수정</button>	
		<button type="button" class="btn btn-secondary btn-sm mr-3" onclick="location.href='<%=ctxPath%>/editlectureplandetail.lmsfinal?seq_lectureplan=<%=seq_lectureplan%>&subjectid=<%=subjectid%>'">다음으로</button>	
		<button type="button" class="btn btn-secondary btn-sm" onclick="javascript:history.back()">뒤로</button>
	</div>
	
	</form>
	
</div>
</div>
		
		
		