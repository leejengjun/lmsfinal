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

	<h3 style="margin: 50px 0;">휴학신청내역</h3>
	
	<div id='table_leave_list'>
		<table class="table">
			<thead class="thead-dark">
				<tr>
					<th>신청학기</th>
					<th>신청일자</th>
					<th>휴학구분</th>
					<th>복학예정</th>
					<th>신청결과</th>
					<th>반려이유</th>
					<th>서류첨부</th>
					<th>취소</th>
					<th>수정</th>
				</tr>
			</thead>
			
			<tbody>
				<c:forEach var="item" items="${leave_list}" varStatus="status" >
					<tr>
						<td id='startsemester'>${item.startsemester}</td>
						<td id='regdate'>${item.regdate}</td>
						<td id='leavetype'>${item.leavetype}</td>
						<td id='returnsemester'>${item.returnsemester}</td>
						<td id='approve'>${item.approve}</td>
						<td id='noreason'>${item.noreason}</td>
						<td>
							 <c:if test="${item.orgfilename != null}">
								${item.orgfilename}<a href="<%= request.getContextPath()%>/download_add.lmsfinal?leaveno=${item.leaveno}"><img src="<%= ctxPath%>/resources/images/leejeongjun/save.gif" /></a> 
				             </c:if>
						</td>
						<td>
							<c:if test="${item.approve != '승인완료'}">
								<input type='button' class='btn btn-danger btn-sm mr-3 btn_cencel_leave' id='cencel_leave' value='취소' />
								<input type='hidden' class='cencel_leaveno' value='${item.leaveno}' />
								<input type='hidden' class='cencel_leave_filename' value='${item.filename}' />
							</c:if>
						</td>
						<td>
							<c:if test="${item.approve != '승인완료'}">
								<input type='button' class='btn btn-secondary btn-sm mr-3 btn_edit_leave' id='edit_leave' value='수정' />
								<input type='hidden' class='edit_leaveno' value='${item.leaveno}' />
								<input type='hidden' class='edit_endsemester' value='${item.endsemester}' />
								<input type='hidden' class='edit_armystartdate' value='${item.armystartdate}' />
								<input type='hidden' class='edit_armyenddate' value='${item.armyenddate}' />
								<input type='hidden' class='edit_armytype' value='${item.armytype}' />
								<input type='hidden' class='edit_leave_filename' value='${item.orgfilename}' />
								<input type='hidden' class='edit_leavereason' value='${item.leavereason}' />
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
	<div id="edit_leave">
		<form name="edit_leave_Frm" id="edit_leave_Frm" enctype="multipart/form-data">
			<h3 style="margin: 50px 0;">휴학신청상세정보</h3>
			
			<input type='hidden' name='leaveno' class='edit_leaveno_form' value='' />
			<input type='hidden' name='leavetype' class='edit_leavetype_form' value='' />
			
			<div id="general_leave">
				
				<p>
					▷ 시작학기&nbsp;&nbsp;&nbsp;<input type="text" id="startsemester" name="startsemester" value="" readonly />
					▷ 종료학기&nbsp;&nbsp;&nbsp;<input type="text" id="endsemester" name="endsemester" value="" readonly />
					▷ 복학예정학기&nbsp;&nbsp;&nbsp;<input type="text" id="returnsemester" name="returnsemester" value="" readonly />
				</p>
				<p>▷ 휴학신청사유</p> 
				<textarea style='width: 100%; height: 100px;' name='leavereason' id='leavereason' placeholder='휴학하는 이유를 구체적으로 적어주세요.'></textarea>
				<button type='button' class='btn btn-primary btn-sm mr-3' id='submit_edit_general_leave'>수정하기</button>
			</div>
			
			<div id="army_leave">
				<li>병종&nbsp;&nbsp;&nbsp;&nbsp;
					<input type='radio' id='army' class='armytype' name='armytype' value='육군'/>
					<label for='army'>육군</label>
					<input type='radio' id='navy' class='armytype' name='armytype' value='해군'/>
					<label for='navy'>해군</label>
					<input type='radio' id='air' class='armytype' name='armytype' value='공군'/>
					<label for='air'>공군</label>
					<input type='radio' id='marine' class='armytype' name='armytype' value='해병대' />
					<label for='marine'>해병대</label>
					<input type='radio' id='Service_of_Social_Work_Personnel' class='armytype' name='armytype' value='공익근무요원'/>
					<label for='Service_of_Social_Work_Personnel'>공익근무요원</label>
					<input type='radio' id='Industrial_Technial_Personnel' class='armytype' name='armytype' value='산업기능요원' />
					<label for='Industrial_Technial_Personnel'>산업기능요원</label>
					<input type='radio' id='etc' class='armytype' name='armytype' value='기타'  />
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
				
				<br/><button type='button' class='btn btn-primary btn-sm mr-3' id='submit_edit_army_leave'>수정하기</button>
			</div>
		</form>
	</div>
	
</div>
</div>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		var now = new Date();	// 시간 정보 담기
		
		var year = now.getFullYear();	// 연도
		var month = now.getMonth()+1;	// 월
		var date = now.getDate();	// 일
		
		$("div#edit_leave").hide();
		
		$(document).on('click', 'input.btn_edit_leave', function(){
		//	alert("휴학신청 수정 버튼 클릭하셨네요.");
			const idx = $('td#startsemester').index($(this));
		//	alert(idx);
		//	alert($("td#startsemester").eq(idx).text());
			$("input.edit_leaveno_form").val($("input.edit_leaveno").eq(idx).val());
			$("input.edit_leavetype_form").val($("td#leavetype").eq(idx).text());
			
			// 수정하려는 휴학타입(일반휴학 or 군휴학)에 따라 보여주는 폼 분기 시작
			if($("td#leavetype").eq(idx).text() == '일반휴학'){
			//	alert("일반휴학 수정폼 입니다.");
				$("div#edit_leave").show();
				$("div#army_leave").hide();
				
		    	$('div#general_leave').show();
				
				$("input#startsemester").val($("td#startsemester").eq(idx).text())
				$("input#endsemester").val($("input.edit_endsemester").eq(idx).val())
				$("input#returnsemester").val($("td#returnsemester").eq(idx).text())
				$("textarea#leavereason").val($("input.edit_leavereason").eq(idx).val())
				
				$(document).on('click', 'button#submit_edit_general_leave', function(){ 
				//	alert("일반휴학의 수정하기버튼 클릭했군요.");
					
					var leavereason = $("textarea#leavereason").val().trim();
					// 일반 휴학신청 유효성 검사
					if( leavereason == "" ){
						alert("휴학신청사유를 작성하세요!");
						return;
					}
					
					const frm = document.edit_leave_Frm;
					frm.method = "POST";
					frm.action = "<%= ctxPath%>/edit_leave.lmsfinal";
					frm.submit();
				});
			}
			else if($("td#leavetype").eq(idx).text() == '군휴학'){
			//	alert("군휴학 수정폼 입니다.");
				$("div#edit_leave").show();
				$("div#general_leave").hide();
				
		    	$('div#army_leave').show();
				
				$("input.edit_leaveno_form").val($("input.edit_leaveno").eq(idx).val());
				
				$("input:radio[name=armytype]:input[value=" + $('input.edit_armytype').eq(idx).val() + "]").attr("checked", true);
				$("input#armystartdate").val($("input.edit_armystartdate").eq(idx).val());
				$("input#armyenddate").val($("input.edit_armyenddate").eq(idx).val());
				
				$(document).on('click', 'button#submit_edit_army_leave', function(){
				//	alert("군휴학 수정하기버튼 클릭했군요.");
					
					var attach = $("input#attach").val();
					var armystartdate = $("input#armystartdate").val();
					var armyenddate = $("input#armyenddate").val();
					var today = ""+year+'0'+month+date+"";
				//	alert(today);
					
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
					
				//	alert("군입대 복학 예정학기"+$("input#returnsemester_army").val());
				
					const frm = document.edit_leave_Frm;
					frm.method = "POST";
					frm.action = "<%= ctxPath%>/edit_leave.lmsfinal";
					frm.submit();
				});// end of $(document).on('click', 'button#submit_edit_army_leave', function(){-------------
			}
			// 수정하려는 휴학타입(일반휴학 or 군휴학)에 따라 보여주는 폼 분기 끝
			
		});// end of $(document).on('click', 'input.btn_edit_leave', function(){------------
		
		
		
		
		$(document).on('click', 'input.btn_cencel_leave', function(){
			alert("휴학신청 취소 버튼 클릭하셨네요.");
			const idx = $('input.btn_cencel_leave').index($(this));
		//	alert(idx);
			const choice_leaveno = $("input.cencel_leaveno").eq(idx).val();
		//	alert(choice_leaveno);
			const choice_leave_filename = $("input.cencel_leave_filename").eq(idx).val();
			alert(choice_leave_filename);
			
			// 유저가 장난치는 것을 막기위해 post방식으로 취소할 휴학번호를 넘겨줌 //
			let f = document.createElement('form');
			
			let obj;
			obj = document.createElement('input');
			obj.setAttribute('type', 'hidden');
			obj.setAttribute('name', 'leaveno');
			obj.setAttribute('value', choice_leaveno);
			
			let obj2;
			obj2 = document.createElement('input');
			obj2.setAttribute('type', 'hidden');
			obj2.setAttribute('name', 'filename');
			obj2.setAttribute('value', choice_leave_filename);

			f.appendChild(obj);
			f.appendChild(obj2);
			f.setAttribute('method', 'post');
			f.setAttribute('action', '<%= ctxPath%>/cancel_leave.lmsfinal');
			document.body.appendChild(f);
			f.submit();
		});// end of $(document).on('click', 'input.btn_cencel_leave', function(){------------
		
	});// end of $(document).ready(function()-----------
</script>




















