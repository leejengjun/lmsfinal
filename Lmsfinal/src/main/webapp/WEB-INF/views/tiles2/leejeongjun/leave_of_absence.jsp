<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

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
	
	<!-- 아래 폼은 군휴학 신청 시 파일첨부를 해야할 수도 있으므로 멀티폼으로 넘겨준다! -->
	<form name="leave_Frm" id="leave_Frm" enctype="multipart/form-data">
		<h3 style="margin: 50px 0;">휴학신청</h3>
		<input type='hidden' id='stdid' name='stdid' calss='stdid' value="${studentInfo.STDID}"/>
		<div id="leave_type">
			<label class="title">휴학구분</label>
			<select name="leavetype" id="leavetype" class="leavetype">
				<option value='휴학구분' selected>휴학구분</option>
				<option value='일반휴학'>일반휴학</option>
				<option value='군휴학'>군휴학</option>
			</select>
		</div>
		
		<div id="general_leave">
			<p>
				▷ 시작학기&nbsp;&nbsp;&nbsp;<input type="text" id="startsemester" name="startsemester" value="" readonly />
				▷ 종료학기&nbsp;&nbsp;&nbsp;<input type="text" id="endsemester" name="endsemester" value="" readonly />
				▷ 복학예정학기&nbsp;&nbsp;&nbsp;<input type="text" id="returnsemester" name="returnsemester" value="" readonly />
			</p>
			<p>▷ 휴학신청사유</p> 
			<textarea style='width: 100%; height: 100px;' name='leavereason' id='leavereason' placeholder='휴학하는 이유를 구체적으로 적어주세요.'></textarea>
			<button type='button' class='btn btn-primary btn-sm mr-3' id='submit_general_leave'>휴학신청</button>
		</div>
		
		<div id="army_leave">
			<li>병종&nbsp;&nbsp;&nbsp;&nbsp;
				<input type='radio' id='army' class='armytype' name='armytype' value='육군' />
				<label for='army'>육군</label>
				<input type='radio' id='navy' class='armytype' name='armytype' value='해군' />
				<label for='navy'>해군</label>
				<input type='radio' id='air' class='armytype' name='armytype' value='공군' />
				<label for='air'>공군</label>
				<input type='radio' id='marine' class='armytype' name='armytype' value='해병대' />
				<label for='marine'>해병대</label>
				<input type='radio' id='Service_of_Social_Work_Personnel' class='armytype' name='armytype' value='공익근무요원' />
				<label for='Service_of_Social_Work_Personnel'>공익근무요원</label>
				<input type='radio' id='Industrial_Technial_Personnel' class='armytype' name='armytype' value='산업기능요원' />
				<label for='Industrial_Technial_Personnel'>산업기능요원</label>
				<input type='radio' id='etc' class='armytype' name='armytype' value='기타' />
				<label for='etc'>기타</label>
			</li>
			
			<li>복무예정기간
				<input type='text' id='armystartdate' name='armystartdate' class='armystartdate' value='' placeholder='예시(20220513)' />
				~
				<input type='text' id='armyenddate' name='armyenddate' class='armyenddate' value='' />
				<input type="hidden" id="startsemester_army" name="startsemester_army" value=""/>
				<input type="hidden" id="returnsemester_army" name="returnsemester_army" value=""/>
			</li>
			<br/>
			<li>입영통지서
				<input type="file" name="attach" id="attach" />
			</li>
			
			<br/><button type='button' class='btn btn-primary btn-sm mr-3' id='submit_army_leave'>휴학신청</button>
		</div>
	</form>

	<div style="border: solid 2px gray; margin-top: 100px;">
		<div style="margin: 20px 20px;">
			<h4>휴학신청 안내사항</h4>
			<li style="font-weight: bold;">일반휴학신청은 기본 1년 단위 입니다.</li>
			<li>휴학은 최대 3년(6학기) 신청 가능합니다.</li>
			<li style="font-weight: bold;">군입대휴학은 반드시 입영통지서를 스캔하시거나 선명하게 사진촬영하여 첨부하셔야 합니다. 확인이 불가할 경우 신청이 반려될 수 있습니다!</li>
			<li>군입대휴학일 경우 휴학신청기간이 지난 뒤에는 온라인 신청이 불가하며 직접 학사과에 제출서류를 지참하여 방문하셔야 합니다.</li>
		</div>
	</div>

</div>
</div>


<script type="text/javascript">
	
	$(document).ready(function(){
		
		// 페이지 로드시 휴학신청 폼은 숨겨놓는다!
		$("div#general_leave").hide();
		$("div#army_leave").hide();
		
		var now = new Date();	// 시간 정보 담기
		
		var year = now.getFullYear();	// 연도
		var month = now.getMonth()+1;	// 월
		var date = now.getDate();	// 일
		
	//	alert("확인용 : 오늘은 "+year+'0'+month+date+"입니다.");	// 이건 학생이 휴학신청 할때 신청 학기를 자동으로 계산하기 위해서 신청한 날짜를 받아오는 것!
		
		///////////////////////////// 휴학 시작학기, 휴학 종료학기, 복학예정학기 계산하기////////////////////////////////////////////
		// 휴학 신청기간은 1학기는 01월 15일 부터 02 월 15일 까지이다.
		//			 2학기는 07월 15일 부터 08 월 15일 까지이다.
		if( !(month == "01" || month == "02" || month == "05" || month == "08") ){	// 수강 신청 기간이 아닐경우
			alert("휴학신청기간이 아닙니다.");
			$("form#leave_Frm").hide();
		}
		else {	// 휴학신청 기간이라면
			// 휴학 시작 학기 계산하기!
			let start_semester = "";
			if( month == "01" || month == "02" ){
				// 휴학 신청한 '월'이 01월 02월 이라면  시작학기값은 해당년도+"1학기"이다.
				start_semester = year+" / 1학기";
			//	alert("휴학신청학기는"+start_semester);
				$("input#startsemester").val(start_semester);
			
				// 휴학 종료 학기 계산하기!
				let end_semester = year+ " / 2학기";
				$("input#endsemester").val(end_semester);
				
				// 복학예정 학기 계산하기!
				let returnsemester = (year+1)+" / 1학기";
				$("input#returnsemester").val(returnsemester);
			}
			else if( month == "05" || month == "08" ){
				// 휴학 신청한 월이 07월 08월 이라면!
				start_semester = year+" / 2학기";
			//	alert("휴학신청학기는"+start_semester);
				$("input#startsemester").val(start_semester);
				
				// 휴학 종료 학기 계산하기!
				let end_semester = (year+1)+ " / 1학기";
				$("input#endsemester").val(end_semester);
				
				// 복학예정 학기 계산하기!
				let returnsemester = (year+1)+" / 2학기";
				$("input#returnsemester").val(returnsemester);
			}
		
		}
		///////////////////////////// 휴학 시작학기 휴학 종료학기, 복학예정학기 계산하기 끝 ////////////////////////////////////////////

		
		
		// 휴학 종류 선택 (일반휴학 or 군입대휴학)
		$('select#leavetype').change(function() {
			var result = $('select#leavetype option:selected').val();
		    if (result == '휴학구분') {
		    	$("div#general_leave").hide();
				$("div#army_leave").hide();
		    }
		    else if (result == '일반휴학') {
		    	$("div#general_leave").hide();
				$("div#army_leave").hide();
				
		    	$('div#general_leave').show();
		    }
		    else if (result == '군휴학') {
		    	$("div#general_leave").hide();
				$("div#army_leave").hide();
				
		    	$('div#army_leave').show();
		    	
				
			}
		}); // end of $('select#leavetype').change(function() {----------------------
			
		$(document).on('click','button#submit_general_leave',function(){
			alert("일반휴학신청하셨군요!");	
			
			var leavereason = $("textarea#leavereason").val().trim();
			// 일반 휴학신청 유효성 검사
			if( leavereason == "" ){
				alert("휴학신청사유를 작성하세요!");
				return;
			}
			
			const frm = document.leave_Frm;
			frm.method = "POST";
			frm.action = "<%= ctxPath%>/insert_leaveAdd.lmsfinal";
			frm.submit();
			
		});// end of $(document).on('click','button#submit_general_leave',function(){----------------
		
		
		$(document).on('click','button#submit_army_leave',function(){
			alert("군휴학신청하셨군요!");	
			
			var attach = $("input#attach").val();
			var armystartdate = $("input#armystartdate").val();
			var armyenddate = $("input#armyenddate").val();
			var today = ""+year+'0'+month+date+"";
	//		alert(today);
			
			// 군휴학신청 유효성 검사
			if ($("input:radio[name='armytype']").is(":checked")==false) {
				alert("군입대하는 병종을 선택하세요!");
				$("input:radio[name='armytype']").focus();
				return;
			}
			else if( (armystartdate.trim() == "") || (armyenddate.trim() == "") ){
				alert("복무기간은 필수로 입력하세요!");
				armystartdate.focus();
			}
			else if( (armystartdate.trim() != "") || (armyenddate.trim() != "") ){
				// regex 는 8자리로 이루어진 숫자 정규식
				var regex = /[(0-9)]{8}/;
                
				if(!regex.test(Number(armystartdate)) || !regex.test(Number(armyenddate)) ){
					alert("복무기간의 형식을 제대로 입력하세요!");
					$("input#armystartdate").val("");
					$("input#armyenddate").val("");
					$("input#armystartdate").focus();
					return;
				}
			}
			
			if( Number(armystartdate) > Number(armyenddate) ){
				alert("복무종료일이 복무시작일보다 작을 수 없습니다! 다시입력하세요!");
				$("input#armystartdate").val("");
				$("input#armyenddate").val("");
				$("input#armystartdate").focus();
				return;
			}
			
			if( Number(today) > Number(armystartdate)){
				alert("복무시작일이 신청하는 날짜보다 과거일 수 없습니다! 다시입력하세요!");
				$("input#armystartdate").val("");
				$("input#armyenddate").val("");
				$("input#armystartdate").focus();
				return;
			}
			
			if(!attach){
				alert("입영통지서를 파일첨부하세요!!");
				return;
			}
			// 군휴학신청 유효성 검사 끝
			
			// 군휴학시작학기 계산하기
			var start_army_date = $("input#armystartdate").val();
			var start_army_year = start_army_date.substr(0, 4);
			var start_army_month = start_army_date.substr(4, 2);
			
			if( start_army_month == "01" || start_army_month == "02" ){
				let startsemester = start_army_year+" / 1학기";
				$("input#startsemester").val("");
				$("input#startsemester_army").val(startsemester);
			}
			else if(start_army_month == "09" || start_army_month == "10" 
					|| start_army_month == "11" || start_army_month == "12"){
				let startsemester = (Number(start_army_year)+1)+" / 1학기";
				$("input#startsemester").val("");
				$("input#startsemester_army").val(startsemester);
			}
			else {
				let startsemester = start_army_year+" / 2학기";
				$("input#startsemester").val("");
				$("input#startsemester_army").val(startsemester);
			}
	//		alert("병종 타입은"+$("input:radio[name='armytype']").val());
	//		alert("군입대 휴학 예정학기"+$("input#startsemester_army").val());
			
			
			// 복학학기 계산하기
			var end_army_date = $("input#armyenddate").val();
			var end_army_year = end_army_date.substr(0, 4);
			var end_army_month = end_army_date.substr(4, 2);
			
			if( end_army_month == "01" || end_army_month == "02" ){
				let returnsemester = end_army_year+" / 1학기";
				$("input#returnsemester").val("");
				$("input#returnsemester_army").val(returnsemester);
			}
			else if(end_army_month == "09" || end_army_month == "10" 
					|| end_army_month == "11" || end_army_month == "12"){
				let returnsemester = (Number(end_army_year)+1)+" / 1학기";
				$("input#returnsemester").val("");
				$("input#returnsemester_army").val(returnsemester);
			}
			else {
				let returnsemester = end_army_year+" / 2학기";
				$("input#returnsemester").val("");
				$("input#returnsemester_army").val(returnsemester);
			}
			
	//		alert("군입대 복학 예정학기"+$("input#returnsemester_army").val());
			
			const frm = document.leave_Frm;
			frm.method = "POST";
			frm.action = "<%= ctxPath%>/insert_leaveAdd.lmsfinal";
			frm.submit();
			
		});
		
		
	}); // end of $(document).ready(function(){----------------------
	
</script>


















































