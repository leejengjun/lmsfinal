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
	<br/><br/><br/>
	
	<h3>복학예정내역</h3>
	<div id='table_return_list'>
		<table class="table">
			<thead class="thead-dark">
				<tr>
					<th>신청년도 / 학기</th>
					<th>신청일자</th>
					<th>휴학구분</th>
					<th>복학예정</th>
					<th>복학구분</th>
					<th>복학신청</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td id='startsemester'>${choice_std_leave_return.STARTSEMESTER}</td>
					<td id='regdate'>${choice_std_leave_return.REGDATE}</td>
					<td id='leavetype'>${choice_std_leave_return.LEAVETYPE}</td>
					<td id='returnsemester'>${choice_std_leave_return.RETURNSEMESTER}</td>
					<td id='return_type'>
						<c:if test="${choice_std_leave_return.LEAVETYPE == '일반휴학'}">
							<p id='return_type'>일반복학</p>
						</c:if>
						<c:if test="${choice_std_leave_return.LEAVETYPE  == '군휴학'}">
							<p id='return_type'>군복학</p>
							
							
						</c:if>
					</td>
					<td>
						<c:if test="${choice_std_leave_return.LEAVETYPE != null}">
							<%-- <c:if test="${studentInfo.STATENAME == '휴학'}"> --%>
								<input type="button" id="reutrn_application" class="btn btn-primary btn-sm mr-3" value="복학신청" />
							<%-- </c:if> --%>
						</c:if>
						<c:if test="${choice_std_leave_return.LEAVETYPE == null}">
							<input type="hidden" id="reutrn_application" class="btn btn-primary btn-sm mr-3" value="복학신청" />
						</c:if>
												
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	</br>
	
	<form name='return_army' id='return_army' enctype='multipart/form-data'>
		<div style="border: solid 2px gray;">
			<div style="margin: 20px 20px;">
				<h3>군복학신청</h3>
					<input type='hidden' id='stdid' name='stdid' class='stdid' value='${studentInfo.STDID}' readonly />
					<input type='hidden' id='returntype' name='returntype' class='returntype' value='군복학' readonly />
					<input type='hidden' id='returnsemester' name='returnsemester' class='returnsemester' value='${choice_std_leave_return.RETURNSEMESTER}' readonly />
				<li>병종
					<input type='text' id='armytype' name='armytype' class='armytype' value='${choice_std_leave_return.ARMYTYPE}' readonly />
				</li>
				<br/>
				<li>복무기간
						<input type='text' id='armystartdate' name='armystartdate' class='armystartdate' value='${choice_std_leave_return.ARMYSTARTDATE}' readonly />
						~
						<input type='text' id='armyenddate' name='armyenddate' class='armyenddate' value='${choice_std_leave_return.ARMYENDDATE}' readonly />
				</li>
				<br/>
				<li>입영통지서
					<input type="file" name="attach" id="attach" />
					<p style="color: red; font-weight: bold; font-size: 11pt;">군복학 신청은 반드시 스캔하거나 선명하게 찍은 전역증을 첨부하셔야 합니다. 파일명은 '전역증(이정준).jpg'로 하시기 바랍니다.</p>
				</li>
					
				<br/>
				<button type='button' class='btn btn-primary btn-sm mr-3' id='submit_army_return'>복학신청</button>
			</div>
		</div>
	</form>
	</br></br>
	
	<h3>복학신청내역</h3>
	<div id="app_return_show"></div>
	
	<div style="border: solid 2px gray; margin-top: 100px;">
		<div style="margin: 20px 20px;">
			<h4>복학신청 안내사항</h4>
			<li style="font-weight: bold;">복학신청은 현재 년도월일 기준 가장 가까운 학기에 해당하는 휴학정보가 있을 때 신청가능합니다.</li>
			<li>일반복학일 경우 별다른 양식 없이 '복학신청' 버튼을 클릭하면 신청이 됩니다.</li>
			<li style="font-weight: bold;">군복학은 반드시 전역증을 스캔하시거나 선명하게 사진촬영하여 첨부하셔야 합니다. 확인이 불가할 경우 복학신청이 반려될 수 있습니다!</li>
			<li>군복학은 온라인 복학신청 접수기간이 지난 뒤 추가신청 접수기간에는 직접 학사과에 제출서류를 지참하셔야 합니다. </li>
		</div>
	</div>
	
</div>
</div>



<script type="text/javascript">
	
	$(document).ready(function(){
		
		viewReturnlist();
		
		$("form#return_army").hide();
		
		const return_type = $("p#return_type").text();
		
		$("input#reutrn_application").on('click', function(){
		//	alert("복학신청 버튼 클릭하셨네요.");
			
			if(return_type == '일반복학'){
			//	alert("일반복학 신청입니다.");
				const returnsemester = $("td#returnsemester").text();
				
				$.ajax({
					url:"<%= ctxPath%>/addReturnSchool.lmsfinal",
					type:"GET",
					data:{"returntype":return_type
						  ,"returnsemester":returnsemester},
					dataType:"json",
					success:function(json){
						
						if(json.result_addReturn == '1'){
							alert("일반복학신청이 완료되었습니다.");
							location.reload();
						}
						else if(!json.check_return_school) {
							alert("이미복학신청하였습니다. 승인을 기다려주세요.");
							location.reload();
						}
						
					},
					error: function(request, status, error){
		                  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
				});// end of $.ajax({-------------------- 
				
				
			}
			else if(return_type == '군복학'){
			//	alert("군복학 신청입니다.");
				$("form#return_army").show();
				
				$(document).on('click','button#submit_army_return',function(){
					if(!$("input#attach").val()){
						alert("입영통지서를 파일첨부하세요!!");
						return;
					}
					
					const frm = document.return_army;
					frm.method = "POST";
					frm.action = "<%= ctxPath%>/addreturn_attach.lmsfinal";
					frm.submit();
				});
			}
		}); // end of $("input#reutrn_application").on('click', function(){----------------
		
		$(document).on('click','input.btn_cencel_return',function(){
		//	alert("복학신청 취소 버튼 눌렀네요.");
			const idx = $('input.btn_cencel_return').index($(this));
		//	alert(idx);
			const choice_returnno = $("input#returnseq").eq(idx).val();
		//	alert(choice_returnno);
			const filename = $("input#filename").eq(idx).val();
		//	alert(filename);
			const returntype = $("td#returntype").eq(idx).text();
		//	alert(returntype);
			
			// 유저가 장난치는 것을 막기위해 post방식으로 취소할 휴학번호를 넘겨줌 //
			let f = document.createElement('form');
			
			let obj;
			obj = document.createElement('input');
			obj.setAttribute('type', 'hidden');
			obj.setAttribute('name', 'returnseq');
			obj.setAttribute('value', choice_returnno);
			f.appendChild(obj);
			
			// 군복학 신청을 취소할 경우 첨부파일이 있으므로 삭제할 파일명도 같이 넣어준다.
			if( returntype == '군복학' ){
				let obj2;
				obj2 = document.createElement('input');
				obj2.setAttribute('type', 'hidden');
				obj2.setAttribute('name', 'filename');
				obj2.setAttribute('value', filename);
				f.appendChild(obj2);
			}
			
			
			f.setAttribute('method', 'post');
			f.setAttribute('action', '<%= ctxPath%>/cancel_return.lmsfinal');
			document.body.appendChild(f);
			f.submit();
		});
		
	}); // end of $(document).ready(function(){----------------------
	
	
	function viewReturnlist(){
		
		const return_type = $("p#return_type").text();
		
		$.ajax({
			url:"<%= ctxPath%>/showReturnSchool.lmsfinal",
			type:"GET",
			data:{"returntype":return_type},
			dataType:"JSON",
			success:function(json){
				
				const returntype = '군복학';
				
				let html = "<table class='table'>";
					html += "<thead class='thead-dark'>" +
							"<tr>" +
								"<th>복학년도 / 학기</th>" +
								"<th>신청일자</th>" +
								"<th>복학구분</th>" +
								"<th>신청결과</th>" +
								"<th>서류첨부</th>" +
								"<th>취소</th>" +
							"</tr>" +
							"</thead>";
							
				$.each(json, function(index, item){
					html += "<tr>" +
								"<td>" + item.returnsemester + "</td>" +
								"<td>" + item.regdate + "</td>" +
								"<td id='returntype'>" + item.returntype + "</td>" +
								"<td>" + item.approve + "</td>" +
								"<td>";
								if(item.returntype == '군복학'){
									html +=	"<input type='hidden' name='filename' id='filename' value='"+item.filename+"'/>" +
										item.orgfilename + "<a href='<%= request.getContextPath()%>/download_return.lmsfinal?returnseq=${'"+item.returnseq+"'}'><img src='<%= ctxPath%>/resources/images/leejeongjun/save.gif' /></a>";
								}
								html += "</td>";
								if(item.approve == '승인전') {
									html += "<td><input type='button' class='btn btn-danger btn-sm mr-3 btn_cencel_return' id='cencel_return' value='취소' /><input type='hidden' class='btn_returnseq' id='returnseq' value='"+item.returnseq+"' /></td>";
								}
								else{
									html += "<td><input type='hidden' class='btn btn-danger btn-sm mr-3 btn_cencel_return' id='cencel_return' value='취소' /><input type='hidden' class='btn_returnseq' id='returnseq' value='"+item.returnseq+"' /></td>";
								}
							"</tr>";
				});// end of $.each(json, function(){--------
				
				html += "</table>";
				
				$("div#app_return_show").html(html);
			},
			error: function(request, status, error){
                  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});// end of $.ajax({-------------------- 
		
				
	};// end of function viewReturnlist(){-------------	
		
		
</script>














