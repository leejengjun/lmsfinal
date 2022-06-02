<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% 
   String ctxPath = request.getContextPath(); 
   //    /board
%>    
<style type="text/css">

	table#schedule{
		margin-top: 70px;
	}
	
	table#schedule th, td{
	 	padding: 10px 5px;
	 	vertical-align: middle;
	}
	
	a{
	    color: #395673;
	    text-decoration: none;
	    cursor: pointer;
	}
	
	a:hover {
	    color: #395673;
	    cursor: pointer;
	    text-decoration: none;
		font-weight: bold;
	}
	
	select.schedule{
		height: 30px;
	}
	
	input#joinUserName:focus{
		outline: none;
	}
	
	span.plusUser{
			float:left; 
			background-color:#737373; 
			color:white;
			border-radius: 10%;
			padding: 8px;
			margin: 3px;
			transition: .8s;
			margin-top: 6px;
	}
	
	span.plusUser > i {
		cursor: pointer;
	}
	
	.ui-autocomplete {
		max-height: 100px;
		overflow-y: auto;
	}
	  
	button.btn_normal{
		border: none;
		color: white;
		width: 70px;
		height: 30px;
		font-size: 12pt;
		padding: 3px 0px;
		border-radius: 10%;
	}
</style>

<script type="text/javascript">

	$(document).ready(function(){
				
		// ==== 종일체크박스에 체크를 할 것인지 안할 것인지를 결정하는 것 시작 ==== //
		// 시작 시 분
		var str_startdate = "${requestScope.map.STARTDATE}";
	 // console.log(str_startdate); 
		// 2021-12-01 09:00
		var target = str_startdate.indexOf(":");
		var start_min = str_startdate.substring(target+1);
	 // console.log(start_min);
		// 00
		var start_hour = str_startdate.substring(target-2,target);
	 // console.log(start_hour);
		// 09
				
		
		// 종료 시 분
		var str_enddate = "${requestScope.map.ENDDATE}";
	 //	console.log(str_enddate);
		// 2021-12-01 18:00
		target = str_enddate.indexOf(":");
		var end_min = str_enddate.substring(target+1);
	 // console.log(end_min);
	    // 00 
		var end_hour = str_enddate.substring(target-2,target);
	 //	console.log(end_hour);
		// 18
		
		
		if(start_hour=='00' && start_min=='00' && end_hour=='23' && end_min=='59' ){
			$("input#allDay").prop("checked",true);
		}
		else{
			$("input#allDay").prop("checked",false);
		}
		// ==== 종일체크박스에 체크를 할 것인지 안할 것인지를 결정하는 것 끝 ==== // 
		
		
		// 시작날짜 넣어주기
		target = str_startdate.indexOf(" ");
		var start_yyyymmdd = str_startdate.substring(0,target);
		$("input#startDate").val(start_yyyymmdd);
		
		// 종료날짜 넣어주기
		target = str_enddate.indexOf(" ");
		var end_yyyymmdd = str_enddate.substring(0,target);
		$("input#endDate").val(end_yyyymmdd);
		
		
		// 시작시간, 종료시간		
		var html="";
		for(var i=0; i<24; i++){
			if(i<10){
				html+="<option value='0"+i+"'>0"+i+"</option>";
			}
			else{
				html+="<option value="+i+">"+i+"</option>";
			}
		}// end of for----------------------
		
		$("select#startHour").html(html);
		$("select#endHour").html(html);
		
		// === *** 시작시간 시 분 넣어주기 *** === //
		$("select#startHour").val(start_hour);
		$("select#endHour").val(end_hour);
		
		// 시작분, 종료분 
		html="";
		for(var i=0; i<60; i=i+5){
			if(i<10){
				html+="<option value='0"+i+"'>0"+i+"</option>";
			}
			else {
				html+="<option value="+i+">"+i+"</option>";
			}
		}// end of for--------------------
		html+="<option value="+59+">"+59+"</option>"
		
		$("select#startMinute").html(html);
		$("select#endMinute").html(html);
		
		// === *** 종료시간 시 분 넣어주기 *** === //
		$("select#startMinute").val(start_min);
		$("select#endMinute").val(end_min);
		
		
		// '종일' 체크박스 클릭시
		$("input#allDay").click(function() {
			var bool = $('input#allDay').prop("checked");
			
			if(bool == true) {
				$("select#startHour").val("00");
				$("select#startMinute").val("00");
				$("select#endHour").val("23");
				$("select#endMinute").val("59");
				$("select#startHour").prop("disabled",true);
				$("select#startMinute").prop("disabled",true);
				$("select#endHour").prop("disabled",true);
				$("select#endMinute").prop("disabled",true);
			} 
			else {
				$("select#startHour").prop("disabled",false);
				$("select#startMinute").prop("disabled",false);
				$("select#endHour").prop("disabled",false);
				$("select#endMinute").prop("disabled",false);
			}
		});
		
		// ========== *** 캘린더선택에서 이미 저장된 캘린더 넣어주기 시작 *** ========== //
		$("select.calType").val("${requestScope.map.FK_LGCATGONO}");
		
		$.ajax({
				url: "<%= ctxPath%>/schedule/selectSmallCategory.lmsfinal",
				data: {"fk_lgcatgono":"${requestScope.map.FK_LGCATGONO}", 
					   "fk_userid":"${requestScope.map.FK_USERID}"},
				dataType: "json",
				async: false,  //동기방식
				success:function(json){
					var html ="";
					if(json.length>0){
						$.each(json, function(index, item){
							html+="<option value='"+item.smcatgono+"'>"+item.smcatgoname+"</option>";
						});
						$("select.small_category").html(html);
					}
				},
				error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
		});
	
		$("select.small_category").val("${requestScope.map.FK_SMCATGONO}");
		// ========== *** 캘린더선택에서 이미 저장된 캘린더 넣어주기 끝 *** ========== //
				
		// 내캘린더,사내캘린더 선택에 따른 서브캘린더 종류를 알아와서 select 태그에 넣어주기 
		$("select.calType").change(function(){
			var fk_lgcatgono = $("select.calType").val();      // 내캘린더이라면 1, 사내캘린더이라면 2 이다.
			var fk_userid = $("input[name=fk_userid]").val();  // 로그인 된 사용자아이디
			
			if(fk_lgcatgono != "") { // 선택하세요 가 아니라면
				$.ajax({
						url: "<%= ctxPath%>/schedule/selectSmallCategory.lmsfinal",
						data: {"fk_lgcatgono":fk_lgcatgono, 
							   "fk_userid":fk_userid},
						dataType: "json",
						success:function(json){
							var html ="";
							if(json.length>0){
								
								$.each(json, function(index, item){
									html+="<option value='"+item.smcatgono+"'>"+item.smcatgoname+"</option>"
								});
								$("select.small_category").html(html);
								$("select.small_category").show();
							}
						},
						error: function(request, status, error){
				            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
						}
				});
			}
			
			else {
				// 선택하세요 이라면
				$("select.small_category").hide();
			}
		});
		
		// **** 수정하기전 이미 저장되어있는 공유자 **** 
		var stored_joinuser = "${requestScope.map.JOINUSER}";
		if(stored_joinuser != "공유자가 없습니다."){
			var arr_stored_joinuser = stored_joinuser.split(",");
			var str_joinuser = "";
			for(var i=0; i<arr_stored_joinuser.length; i++){
				var user = arr_stored_joinuser[i];
			//	console.log(user);
				add_joinUser(user);
			}// end of for--------------------------
		}// end of if--------------------------------      

		
		// 공유자 추가하기
		$("input#joinUserName").bind("keyup",function(){
				var joinUserName = $(this).val();
			//	console.log("확인용 joinUserName : " + joinUserName);
				$.ajax({
					url:"<%= ctxPath%>/schedule/insertSchedule/searchJoinUserList.lmsfinal",
					data:{"joinUserName":joinUserName},
					dataType:"json",
					success : function(json){
						var joinUserArr = [];
				
					//	console.log("이:"+json.length);
						if(json.length > 0){
							
							$.each(json, function(index,item){
								var stdname = item.stdname;
								if(stdname.includes(joinUserName)){ // name 이라는 문자열에 joinUserName 라는 문자열이 포함된 경우라면 true , 
									                             // name 이라는 문자열에 joinUserName 라는 문자열이 포함되지 않은 경우라면 false 
								   joinUserArr.push(stdname+"("+item.stdid+")");
								}
							});
							
							$("input#joinUserName").autocomplete({  // 참조 https://jqueryui.com/autocomplete/#default
								source:joinUserArr,
								select: function(event, ui) {       // 자동완성 되어 나온 공유자이름을 마우스로 클릭할 경우 
									add_joinUser(ui.item.value);    // 아래에서 만들어 두었던 add_joinUser(value) 함수 호출하기 
									                                // ui.item.value 이  선택한이름 이다.
									return false;
						        },
						        focus: function(event, ui) {
						            return false;
						        }
							}); 
							
						}// end of if------------------------------------
					}// end of success-----------------------------------
				});
		});
		

		// x아이콘 클릭시 공유자 제거하기
		$(document).on('click','div.displayUserList > span.plusUser > i',function(){
				var text = $(this).parent().text(); // 이순신(leess/leesunsin@naver.com)
				
				var bool = confirm("공유자 목록에서 "+ text +" 회원을 삭제하시겠습니까?");
				// 공유자 목록에서 이순신(leess/leesunsin@naver.com) 회원을 삭제하시겠습니까?
				
				if(bool) {
					$(this).parent().remove();
				}
		});

		
		// 수정 버튼 클릭
		$("button#edit").click(function(){
		
			// 일자 유효성 검사 (시작일자가 종료일자 보다 크면 안된다!!)
			var startDate = $("input#startDate").val();	
	    	var sArr = startDate.split("-");
	    	startDate= "";	
	    	for(var i=0; i<sArr.length; i++){
	    		startDate += sArr[i];
	    	}
	    	
	    	var endDate = $("input#endDate").val();	
	    	var eArr = endDate.split("-");   
	     	var endDate= "";
	     	for(var i=0; i<eArr.length; i++){
	     		endDate += eArr[i];
	     	}
			
	     	var startHour= $("select#startHour").val();
	     	var endHour = $("select#endHour").val();
	     	var startMinute= $("select#startMinute").val();
	     	var endMinute= $("select#endMinute").val();
	        
	     	// 조회기간 시작일자가 종료일자 보다 크면 경고
	        if (Number(endDate) - Number(startDate) < 0) {
	         	alert("종료일이 시작일 보다 작습니다."); 
	         	return;
	        }
	        
	     	// 시작일과 종료일 같을 때 시간과 분에 대한 유효성 검사
	        else if(Number(endDate) == Number(startDate)) {
	        	
	        	if(Number(startHour) > Number(endHour)){
	        		alert("종료일이 시작일 보다 작습니다."); 
	        		return;
	        	}
	        	else if(Number(startHour) == Number(endHour)){
	        		if(Number(startMinute) > Number(endMinute)){
	        			alert("종료일이 시작일 보다 작습니다."); 
	        			return;
	        		}
	        		else if(Number(startMinute) == Number(endMinute)){
	        			alert("시작일과 종료일이 동일합니다."); 
	        			return;
	        		}
	        	}
	        }// end of else if---------------------------------
	    	
			// 제목 유효성 검사
			var subject = $("input#subject").val().trim();
	        if(subject==""){
				alert("제목을 입력하세요."); 
				return;
			}
	        
	        // 캘린더 선택 유무 검사
			var calType = $("select.calType").val().trim();
			if(calType==""){
				alert("캘린더 종류를 선택하세요."); 
				return;
			}
			
			// 달력 형태로 만들어야 한다.(시작일과 종료일)
			// 오라클에 들어갈 date 형식(년월일시분초)으로 만들기
			var sdate = startDate+$("select#startHour").val()+$("select#startMinute").val()+"00";
			var edate = endDate+$("select#endHour").val()+$("select#endMinute").val()+"00";
			
			$("input[name=startdate]").val(sdate);
			$("input[name=enddate]").val(edate);
		
		//	console.log("캘린더 소분류 번호 => " + $("select[name=fk_smcatgono]").val());
			/*
			      캘린더 소분류 번호 => 1 OR 캘린더 소분류 번호 => 2 OR 캘린더 소분류 번호 => 3 OR 캘린더 소분류 번호 => 4 
			*/
			
		//  console.log("색상 => " + $("input#color").val());
			
			      
			// 공유자 넣어주기
			var plusUser_elm = document.querySelectorAll("div.displayUserList > span.plusUser");
			var joinUserArr = new Array();
			
			plusUser_elm.forEach(function(item,index,array){
			//	console.log(item.innerText.trim());
				/*
					이순신(leess) 
					아이유1(iyou1) 
					설현(seolh) 
				*/
				joinUserArr.push(item.innerText.trim());
			});
			
			var joinuser = joinUserArr.join(",");
		//	console.log("공유자 => " + joinuser);
			// 이순신(leess),아이유1(iyou1),설현(seolh) 
			
			$("input[name=joinuser]").val(joinuser);
			
		    var frm = document.scheduleFrm;
		  	frm.action="<%= ctxPath%>/schedule/editSchedule_end.lmsfinal";
			frm.method="post";
			frm.submit(); 

		});// end of $("button#edit").click(function(){})--------------------
		
	}); // end of $(document).ready(function(){}-----------------------------------


	// ~~~~ Function Declaration ~~~~
	
	// div.displayUserList 에 공유자를 넣어주는 함수
	function add_joinUser(value){  // value 가 공유자로 선택한이름 이다.
		
		var plusUser_es = $("div.displayUserList > span.plusUser").text();
	
	 // console.log("확인용 plusUser_es => " + plusUser_es);
	    /*
	    	확인용 plusUser_es => 
 			확인용 plusUser_es => 이순신(leess/hanmailrg@naver.com)
 			확인용 plusUser_es => 이순신(leess/hanmailrg@naver.com)아이유1(iyou1/younghak0959@naver.com)
 			확인용 plusUser_es => 이순신(leess/hanmailrg@naver.com)아이유1(iyou1/younghak0959@naver.com)아이유2(iyou2/younghak0959@naver.com)
	    */
	
		if(plusUser_es.includes(value)) {  // plusUser_es 문자열 속에 value 문자열이 들어있다라면 
			alert("이미 추가한 회원입니다.");
		}
		
		else {
			$("div.displayUserList").append("<span class='plusUser'>"+value+"&nbsp;<i class='fas fa-times-circle'></i></span>");
		}
		
		$("input#joinUserName").val("");
		
	}// end of function add_joinUser(value){}----------------------------			

</script>

<div style="display: flex; margin-bottom: 50px; margin-top: 4%">   
<div style="width: 80%; min-height: 1100px; margin:auto; ">
<div style="margin-left: 80px; width: 88%;">
<h3 style="display: inline-block;">일정 수정하기</h3>&nbsp;&nbsp;<a href="<%= ctxPath%>/schedule/scheduleManagement.lmsfinal"><span>◀캘린더로 돌아가기</span></a>
	<form name="scheduleFrm">
		<table id="schedule" class="table table-bordered">
			<tr>
				<th>일자</th>
				<td>
					<input type="date" id="startDate" value="${requestScope.chooseDate}" style="height: 30px;"/>&nbsp; 
					<select id="startHour" class="schedule"></select> 시
					<select id="startMinute" class="schedule"></select> 분
					- <input type="date" id="endDate" value="${requestScope.chooseDate}" style="height: 30px;"/>&nbsp;
					<select id="endHour" class="schedule"></select> 시
					<select id="endMinute" class="schedule"></select> 분&nbsp;
					<input type="checkbox" id="allDay"/>&nbsp;<label for="allDay">종일</label>
					
					<input type="hidden" name="startdate"/>
					<input type="hidden" name="enddate"/>
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" id="subject" name="subject" class="form-control" value="${requestScope.map.SUBJECT}"/></td> 
			</tr>
			
			<tr>
				<th>캘린더선택</th>
				<td>
					<select class="calType schedule" name="fk_lgcatgono">
					<c:choose>
					<%-- 공유 캘린더 추가를 할 수 있는 직원은 직위코드가 3 이면서 부서코드가 4 에 근무하는 사원이 로그인 한 경우에만 가능하도록 조건을 걸어둔다.
						<c:when test="${loginuser.fk_pcode =='3' && loginuser.fk_dcode == '4' }">
							<option value="">선택하세요</option>
							<option value="1">내 캘린더</option>
							<option value="2">공유 캘린더</option>
						</c:when>
					--%> 
					<%-- 일정등록시 사내캘린더 등록은 oginuser.status == 3 인 사용자만 등록이 가능하도록 한다. --%> 
						<c:when test="${loginuser.status == 3}"> 
							<option value="">선택하세요</option>
							<option value="1">내 캘린더</option>
							<option value="2">공유 캘린더</option>
						</c:when>
					<%-- 일정등록시 내캘린더 등록은 로그인 된 사용자이라면 누구나 등록이 가능하다. --%> 	
						<c:otherwise>
							<option value="">선택하세요</option>
							<option value="1">내 캘린더</option>
						</c:otherwise >
					</c:choose>
					</select> &nbsp;
					<select class="small_category schedule" name="fk_smcatgono"></select>
				</td>
			</tr>
			<tr>
				<th>색상</th>
				<td><input type="color" id="color" name="color" value="${requestScope.map.COLOR}"/></td>
			</tr>
			<tr>
				<th>장소</th>
				<td><input type="text" name="place" class="form-control" value="${requestScope.map.PLACE}"/></td>
			</tr>
			<c:if test="${sessionScope.loginuser.status == 3 }"> 
			<tr>
				<th>공유자</th>
				<td>
				<input type="text" id="joinUserName" class="form-control" placeholder="일정을 공유할 회원명을 입력하세요"/>
				<div class="displayUserList"></div>
				<input type="hidden" name="joinuser"/>
				</td>
			</tr>
			</c:if>
			<c:if test="${sessionScope.loginuser.status == 2}"> 
			<tr style="display: none;">
				<th>공유자</th>
				<td>
				<input type="text" id="joinUserName" class="form-control" placeholder="일정을 공유할 회원명을 입력하세요"/>
				<div class="displayUserList"></div>
				<input type="hidden" name="joinuser"/>
				</td>
			</tr>
			</c:if>
			<tr>
				<th>내용</th>
				<td><textarea rows="10" cols="100" style="height: 200px;" name="content" id="content" class="form-control">${requestScope.map.CONTENT}</textarea></td>
			</tr>
		</table>
		
		<input type="hidden" value="${requestScope.map.SCHEDULENO}" name="scheduleno"/>
	</form>
	
	<div style="float: right;">
	<button type="button" id="edit" class="btn_normal" style="margin-right: 10px; background-color: #0071bd;">완료</button>
	<button type="button" class="btn_normal" style="background-color: #990000;" onclick="javascript:location.href='<%= ctxPath%>/${gobackURL_detailSchedule}'">취소</button> 
	</div>
</div>
</div>
</div>