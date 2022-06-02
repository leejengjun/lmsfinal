<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%
   String ctxPath = request.getContextPath();
  //       /lmsfinal
%>

<style type="text/css">

	#table_semesterList > table {
		margin-top: 50px;
	}
	
	#table_semesterList > table > tbody > tr:nth-child(1){
		background-color: #DDD;
		text-align: center;
	}
	
	#table_semesterList > table > tbody > tr{
		text-align: center;
	}
	
	#lecture_evalue {
		border: solid 2px gray;
	}
	
	#lecturesEvalue {
		margin: 20px 20px;
	}
	li.qs {
		margin: 20px 20px;
	}
	
	input.firstans{
		margin-left: 20px;
		margin-right: 10px;
	}
	
	input.secondans{
		margin-left: 20px;
		margin-right: 10px;
	}

	input.thirdans{
		margin-left: 20px;
		margin-right: 10px;
	}
	
	input.fourans{
		margin-left: 20px;
		margin-right: 10px;
	}
	
	input.fiveans{
		margin-left: 20px;
		margin-right: 10px;
	}
	
	input.sixans{
		margin-left: 20px;
		margin-right: 10px;
	}
	
	input.sevenans{
		margin-left: 20px;
		margin-right: 10px;
	}
	
	input.eightans{
		margin-left: 20px;
		margin-right: 10px;
	}
	
	button#submit_lecture {
		width:100px;
        margin:auto;
        display:block;
	}
</style>

<div style="display: flex;">
<div style="width: 70%; min-height: 2500px; margin:auto; ">

	<h3 style="margin: 50px 0;">강의평가</h3>
	<div id="table_container" style="margin-bottom: 40px;">
	
	<div id="appsemesterList">
		<p style="font-weight: bold; font-size: 15pt;">강의평가 할 이수학기를 선택하세요!
		<select id="appsemesterList" style="width: 100px;">
		<c:forEach var="item" items="${appsemesterList}" varStatus="status">
			<c:if test="${status.index == 0}">
				<option  selected="selected" value="${item.appsemester}">${item.appsemester}학기</option>
			</c:if>
			<c:if test="${status.index > 0}">
				<option value="${item.appsemester}">${item.appsemester}학기</option>
			</c:if>
		</c:forEach>
		</select>
		</p>	
	</div>
		
		<div id="table_semesterList"></div>
			
	</div>
	
	<form name="form_lectureEvaluation" id="form_lectureEvaluation" ></form>
	
	<div style="border: solid 2px gray; margin-top: 100px;">
		<div style="margin: 20px 20px;">
			<h4>강의평가 안내사항</h4>
			<li>강의평가 참여자의 익명성은 철저히 보장됩니다.</li>
			<li>수강과목별로 강의평가 입력 후 저장하세요.</li>
			<li>강의평가 결과는 담당 교수님께서 수강 학생들의 의견을 수렴하고, 강의품질 제고와 강의 향상을 위한 중요한 참고자료가 됩니다.</li>
			<li>평가 내용에 대한 학생들의 신분은 절대 노출되지 않음을 알려드립니다.</li>
			<li style="font-weight: bold;" >강의평가를 완료하지 않으면 성적조회가 불가합니다.</li>
		</div>
	</div>
	
</div>
</div>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		// 강의신청 페이지 로드시 바로 최근 이수학기의 강의평가 리스트를 보여줌.
		func_semesterList();
		
		$("#appsemesterList").on("change", function(){ 
			func_semesterList();
		});
		
		$(document).on('click','input.btn_evaluation',function(){
			$("form#form_lectureEvaluation").empty();
			const idx = $("input.btn_evaluation").index($(this));
			const choice_courseno = $("input.courseno").eq(idx).val();
			
		//	alert("강의평가 할 과목의 코스넘버는 "+choice_courseno);
		
			$.ajax({
				url:"<%= ctxPath%>/goLectureEvaluation.lmsfinal",
				type:"GET",
				data:{"choice_courseno":choice_courseno},
				dataType:"JSON",
				success:function(json){
					
					let html = "<div id='lecture_evalue'>";
						html += "<h4 style='margin:20px 20px;'>강의평가</h4>"
					$.each(json, function(index, item){
						
						html += "<div id='lecturesEvalue'>"+
								"<p>강의명 : "+item.classname+"</p>" + 
								"<p>교수명 : "+item.gyoname +"</P>" +
								"<input type='hidden' id='choice_courseno' name='courseno' value='"+item.courseno+"'/>" +
								"<input type='hidden' id='choice_evalueCode' name='evalucode' value='"+item.evalucode+"'/>" +
								"<ol>" +
								"<li class='qs'>강의계획서는 수업게 관한 정보을 명확하게 제시하였다.</li>" +
								
									"<input type='radio' id='point_five' class='firstans' name='firstans' value='5' />" +
									"<label for='point_five'>5</label>" +
									"<input type='radio' id='point_four' class='firstans' name='firstans' value='4' />" +
									"<label for='point_four'>4</label>" +
									"<input type='radio' id='point_third' class='firstans' name='firstans' value='3' />" +
									"<label for='point_third'>3</label>" +
									"<input type='radio' id='point_second' class='firstans' name='firstans' value='2' />" +
									"<label for='point_second'>2</label>" +
									"<input type='radio' id='point_first' class='firstans' name='firstans' value='1' />" +
									"<label for='point_first'>1</label>" +
								
								"<li class='qs'>교수님은 매주 수업 시 학습목표를 명확하게 제시 하였다.</li>" +
							
									"<input type='radio' id='point_five2' class='secondans' name='secondans' value='5' />" +
									"<label for='point_five2'>5</label>" +
									"<input type='radio' id='point_four2' class='secondans' name='secondans' value='4' />" +
									"<label for='point_four2'>4</label>" +
									"<input type='radio' id='point_third2' class='secondans' name='secondans' value='3' />" +
									"<label for='point_third2'>3</label>" +
									"<input type='radio' id='point_second2' class='secondans' name='secondans' value='2' />" +
									"<label for='point_second2'>2</label>" +
									"<input type='radio' id='point_first2' class='secondans' name='secondans' value='1' />" +
									"<label for='point_first2'>1</label>" +
								
								"<li class='qs'>교수님은 규정된 수업시간(결강, 휴보강)을 준수하였다.</li>" +
							
									"<input type='radio' id='point_five3' class='thirdans' name='thirdans' value='5' />" +
									"<label for='point_five3'>5</label>" +
									"<input type='radio' id='point_four3' class='thirdans' name='thirdans' value='4' />" +
									"<label for='point_four3'>4</label>" +
									"<input type='radio' id='point_third3' class='thirdans' name='thirdans' value='3' />" +
									"<label for='point_third3'>3</label>" +
									"<input type='radio' id='point_second3' class='thirdans' name='thirdans' value='2' />" +
									"<label for='point_second3'>2</label>" +
									"<input type='radio' id='point_first3' class='thirdans' name='thirdans' value='1' />" +
									"<label for='point_first3'>1</label>" +
							
								"<li class='qs'>강의의 실제 수업내용은 일치하였다.</li>" +
								
									"<input type='radio' id='point_five4' class='fourans' name='fourans' value='5' />" +
									"<label for='point_five4'>5</label>" +
									"<input type='radio' id='point_four4' class='fourans' name='fourans' value='4' />" +
									"<label for='point_four4'>4</label>" +
									"<input type='radio' id='point_third4' class='fourans' name='fourans' value='3' />" +
									"<label for='point_third4'>3</label>" +
									"<input type='radio' id='point_second4' class='fourans' name='fourans' value='2' />" +
									"<label for='point_second4'>2</label>" +
									"<input type='radio' id='point_first4' class='fourans' name='fourans' value='1' />" +
									"<label for='point_first4'>1</label>" +
						
								"<li class='qs'>이 강의는 역량 달성에 도움이 되었다.</li>" +
								
									"<input type='radio' id='point_five5' class='fiveans' name='fiveans' value='5' />" +
									"<label for='point_five5'>5</label>" +
									"<input type='radio' id='point_four5' class='fiveans' name='fiveans' value='4' />" +
									"<label for='point_four5'>4</label>" +
									"<input type='radio' id='point_third5' class='fiveans' name='fiveans' value='3' />" +
									"<label for='point_third5'>3</label>" +
									"<input type='radio' id='point_second5' class='fiveans' name='fiveans' value='2' />" +
									"<label for='point_second5'>2</label>" +
									"<input type='radio' id='point_first5' class='fiveans' name='fiveans' value='1' />" +
									"<label for='point_first5'>1</label>" +
							
								"<li class='qs'>이 강의로 본인은 해당분야에 대한 지식이 향상되었다.</li>" +
								
									"<input type='radio' id='point_five6' class='sixans' name='sixans' value='5' />" +
									"<label for='point_five6'>5</label>" +
									"<input type='radio' id='point_four6' class='sixans' name='sixans' value='4' />" +
									"<label for='point_four6'>4</label>" +
									"<input type='radio' id='point_third6' class='sixans' name='sixans' value='3' />" +
									"<label for='point_third6'>3</label>" +
									"<input type='radio' id='point_second6' class='sixans' name='sixans' value='2' />" +
									"<label for='point_second6'>2</label>" +
									"<input type='radio' id='point_first6' class='sixans' name='sixans' value='1' />" +
									"<label for='point_first6'>1</label>" +
								
								"<li class='qs'>교수님은 학생의 질의응답에 신속하게 답변을 주었다.</li>" +
								
									"<input type='radio' id='point_five7' class='sevenans' name='sevenans' value='5' />" +
									"<label for='point_five7'>5</label>" +
									"<input type='radio' id='point_four7' class='sevenans' name='sevenans' value='4' />" +
									"<label for='point_four7'>4</label>" +
									"<input type='radio' id='point_third7' class='sevenans' name='sevenans' value='3' />" +
									"<label for='point_third7'>3</label>" +
									"<input type='radio' id='point_second7' class='sevenans' name='sevenans' value='2' />" +
									"<label for='point_second7'>2</label>" +
									"<input type='radio' id='point_first7' class='sevenans' name='sevenans' value='1' />" +
									"<label for='point_first7'>1</label>" +
								
								"<li class='qs'>이 강의에 대해 만족하며, 동기나 후배에게 추천하고 싶다.</li>" +
								
									"<input type='radio' id='eightans8' class='eightans' name='eightans' value='5' />" +
									"<label for='point_five8'>5</label>" +
									"<input type='radio' id='point_four8' class='eightans' name='eightans' value='4' />" +
									"<label for='point_four8'>4</label>" +
									"<input type='radio' id='point_third8' class='eightans' name='eightans' value='3' />" +
									"<label for='point_third8'>3</label>" +
									"<input type='radio' id='point_second8' class='eightans' name='eightans' value='2' />" +
									"<label for='point_second8'>2</label>" +
									"<input type='radio' id='point_first8' class='eightans' name='eightans' value='1' />" +
									"<label for='point_first8'>1</label>" +
								
								"<li class='qs'>기타 개선사항이나 의견이 있으시다면 자유롭게 작성하세요.</li>" +
								"<textarea style='width: 100%; height: 100px;' name='etcans' id='etcans' placeholder='자유롭게 기술하세요.'></textarea>" +
								"</ol>" +
								"<div style='width: 100px; margin: auto;'>"+
								"<button type='button' class='btn btn-primary btn-sm mr-3' id='submit_lecture'>제출하기</button>" +
								"</div>";
						
					});// end of $.each(json, function(index, item)--------
					
					html += "</div>" +
							"</div>";
					
					$("form#form_lectureEvaluation").html(html);
						
				},
				error: function(request, status, error){
	                  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});// end of $.ajax({--------------
		});
		
		// 강의평가 제출하기 버튼 클릭
		$(document).on('click','button#submit_lecture',function(){
			
		//	alert("제출하기를 클릭하셨네요");	
			
		//	alert("8번 문항 선택한 점수는 "+$("input:radio[name='eightans']:checked").val());
			
			//////////////////////////////////////////////////////////////
			// 강의평가 각 항목들 유효성 검사 시작 //
			if ($("input:radio[name='firstans']").is(":checked")==false) {
				alert("1번 문항에 대한 답변 체크해주세요!");
				$("input:radio[name='firstans']").focus();
				return;
			}
			if ($("input:radio[name='secondans']").is(":checked")==false) {
				alert("2번 문항에 대한 답변 체크해주세요!");
				$("input:radio[name='secondans']").focus();
				return;
			}
			if ($("input:radio[name='thirdans']").is(":checked")==false) {
				alert("3번 문항에 대한 답변 체크해주세요!");
				$("input:radio[name='thirdans']").focus();
				return;
			}
			if ($("input:radio[name='fourans']").is(":checked")==false) {
				alert("4번 문항에 대한 답변 체크해주세요!");
				$("input:radio[name='fourans']").focus();
				return;
			}
			if ($("input:radio[name='fiveans']").is(":checked")==false) {
				alert("5번 문항에 대한 답변 체크해주세요!");
				$("input:radio[name='fiveans']").focus();
				return;
			}
			if ($("input:radio[name='sixans']").is(":checked")==false) {
				alert("6번 문항에 대한 답변 체크해주세요!");
				$("input:radio[name='sixans']").focus();
				return;
			}
			if ($("input:radio[name='sevenans']").is(":checked")==false) {
				alert("7번 문항에 대한 답변 체크해주세요!");
				$("input:radio[name='sevenans']").focus();
				return;
			}
			if ($("input:radio[name='eightans']").is(":checked")==false) {
				alert("8번 문항에 대한 답변 체크해주세요!");
				$("input:radio[name='eightans']").focus();
				return;
			}
			
			// etc 문항 유효성 검사
			const content = $("textarea#etcans").val().trim();
			if(content == ""){
				alert("글 내용을 입력하세요!!");
				return;
			}
		//	alert("etc 문항에 입력한 내용은 => "+$("textarea#etc").val());
			
			// 강의평가 각 항목들 유효성 검사 끝 //
			
		
			// 폼(form)을 전송(submit)
			const frm = document.form_lectureEvaluation;
			frm.method = "GET";
			frm.action = "<%= ctxPath%>/lectureEvaluationEnd.lmsfinal";
			frm.submit();
		});// end of $(document).on('click','button#submit_lecture',function(){------------
		
		
			
		
	});// end of $(document).ready(function()-----------

	// Function Declaration
	
	
	function func_semesterList(){
		const input_semester = $("select#appsemesterList").val();
	//	alert("선택한 학기는?   "+input_semester+"학기");
		

		$.ajax({
			url:"<%= ctxPath%>/inputSemestershow.lmsfinal",
			type:"GET",
			data:{"inputSemester":input_semester},
			dataType:"JSON",
			success:function(json){
				
				let html = "<table class='table table-bordered'>";
					html += "<tr>" +
								"<th>학기</th>" +
								"<th>강의명</th>" +
								"<th>강의코드</th>" +
								"<th>교수명</th>" +
								"<th>강의평가</th>" +
							"</tr>";
				
				$.each(json, function(index, item){
					html += "<tr>" +
								"<td>" + Number(item.appsemester) +"</td>" +
								"<td>" + item.classname +"</td>" +
								"<td>" + Number(item.subjectid) +"</td>" +
								"<td>" + item.gyoname +"</td>";
								if(Number(item.evaluwhether) == 0){
									html += "<td><input id='go_lecture_evaluation' type='button' class='btn btn-danger btn_evaluation' value='강의평가' /><input type='hidden' name='courseno' id='courseno' class='courseno' value='"+item.courseno+"' /></td>";
								}
								else{
									html += "<td><input id='go_lecture_evaluation' type='button' class='btn btn-success btn_evaluation' disabled value='평가완료' /><input type='hidden' name='courseno' id='courseno' class='courseno' value='"+item.courseno+"' /></td>";
								}
								
							"</tr>";
				});
				
				html += "</table>";
				
				$("div#table_semesterList").html(html);
				
			},
			error: function(request, status, error){
                  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		}); // end of $.ajax({------------------
	
	}// end of function func_semesterList()------------------
	
</script>










