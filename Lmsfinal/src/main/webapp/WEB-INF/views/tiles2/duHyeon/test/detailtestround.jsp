<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
   String ctxPath = request.getContextPath();
  //       /lmsfinal
%>
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

label {
  padding: 12px 12px 12px 0;
  display: inline-block;
}

input[type=submit] {
  background-color: #04AA6D;
  color: white;
  padding: 12px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  float: right;
}

input[type=submit]:hover {
  background-color: #45a049;
}

.innercontainer {
  border-radius: 5px;
  background-color: #f2f2f2;
  padding: 20px;
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

</style>

<script type="text/javascript">

	$(document).ready(function(){

		
		// === *** 달력(type="date") 관련 시작 *** === //
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
		
		document.getElementById('startDate').valueAsDate = new Date();// 시작시간의 기본값을 금일로 지정
		document.getElementById('endDate').valueAsDate = new Date();  // 마감시간의 기본값을 금일로 지정
		
	      //직접입력 인풋박스 기존에는 숨어있다가
		
		$("#selexamtitle").change(function() {
	
		                //직접입력을 누를 때 나타남
		
				if($("#selexamtitle").val() == "direct") {
					$("input#examtitle").val("");// 시험종류가 바꼈을 경우 input을 숨기고 값을 지워줌
					$("input#examtitle").show();

				}
				else {
					let examtitle = $("#selexamtitle").val();
					
					$("input#examtitle").hide();
					$("input#examtitle").val(examtitle);
					// 넘어가서 testclfc 의 값이 있는지 없는지 먼저 확인하고 없으면 select값을 읽을 것이기 때문에 이렇게 해준것이다.
				}

			}) 
			
			html="";
			for(var i=5; i<=20; i++){
				
				html+="<option value='"+i+"''>"+i+"</option>";
				
			}// end of for--------------------
			html+="<option value='direct'>직접입력</option>"
			
			$("select#selquestioncnt").html(html);
		
			
			$("#selquestioncnt").change(function() {
		
			                //직접입력을 누를 때 나타남
			
					if($("#selquestioncnt").val() == "direct") {
						$("input#questioncnt").val("");// 시험종류가 바꼈을 경우 input을 숨기고 값을 지워줌
						// 넘어가서 testclfc 의 값이 있는지 없는지 먼저 확인하고 없으면 select값을 읽을 것이기 때문에 이렇게 해준것이다.
						$("input#questioncnt").show();

					}  else {
						$("input#questioncnt").hide();
						$("input#questioncnt").val($("#selquestioncnt").val());
					}

				}) 
			

				
				dataSetting();
			
			
	});// end of $(document).ready(funciton(){})----------------------------

	
	
	function modifyTestRound(){
		
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
		
		
		$("input[name=startdate]").val(startDate+$("select#startHour").val()+$("select#startMinute").val()+"00");
		$("input[name=enddate]").val(endDate+$("select#endHour").val()+$("select#endMinute").val()+"00");
        
		
	
		
		const frm = document.updateTestRound;
		frm.method = "POST";
		frm.action = "<%=ctxPath%>/modifytestround.lmsfinal";
		frm.submit();
		
	}

	
	function dataSetting(){
		
		/////////////////////////////////////////////////////////////////////
		
		// 시험종류  직접입력 넣어주기
		var el = document.getElementById('selexamtitle');  //select box
		var len = el.options.length; //select box의 option 갯수
		var str = $("input#examtitle").val(); //입력 받은 value 값
	
		var isoptions = false;
		 
		for (let i=0; i<len; i++){  
			if(el.options[i].value == str){

				$("#examtitle").hide();
				el.options[i].selected = true;
				isoptions = true;
			}
		}
		
		if(!isoptions){
			$("input#examtitle").val(str);
			el.options[2].selected = true;
			
			$("input#examtitle").show();
		}
		
		///////////////////////////////////////////////////////////////////////
		
		// 시험일시 넣어주기
		// 2022-06-09 00:00 공백에서 잘라주고 :에서 잘라주고 나머지
		
		let fc = $("input#storedStartDate").val().indexOf(" ");
		let sc = $("input#storedEndDate").val().indexOf(":");
		
		$("input#startDate").val($("input#storedStartDate").val().substring(0, fc));
		$("input#endDate").val($("input#storedEndDate").val().substring(0, fc));
		
		let sh = $("input#storedStartDate").val().substring(fc , sc);
		let sm = $("input#storedStartDate").val().substring(sc + 1);
		
		let eh = $("input#storedEndDate").val().substring(fc, sc);
		let em = $("input#storedEndDate").val().substring(sc + 1);
		
		let shour = document.getElementById('startHour');  //select box
		let sminute = document.getElementById('startMinute');  //select box
		
		let ehour = document.getElementById('endHour');  //select box
		let eminute = document.getElementById('endMinute');  //select box
		
		hourLen = shour.options.length; //select box의 option 갯수
		minuteLen = sminute.options.length; //select box의 option 갯수

		
		
		// 시 맞추기
		for (let i=0; i<hourLen; i++){  
			
			if(shour.options[i].value == Number(sh)){
				// alert("확인용 들어옴1 "+i);
				shour.options[i].selected = true;
			}
			if(ehour.options[i].value == Number(eh)){
				// alert("확인용 들어옴2 "+i);
				ehour.options[i].selected = true;
			}
		}
		// 분 맞추기
		for (let i=0; i<minuteLen; i++){  
			
			if(sminute.options[i].value == Number(sm)){
				// alert("확인용 들어옴1 "+i);
				sminute.options[i].selected = true;
			}
			if(eminute.options[i].value == Number(em)){
				// alert("확인용 들어옴2 "+i);
				eminute.options[i].selected = true;
			}
		}
		
		
		//////////////////////////////////////////////////////////////////////
		
		// 시험공개여부 세팅해주기
		
		
		el = document.getElementById('seldisclosure');  //select box
		len = el.options.length; //select box의 option 갯수
		str = $("input#disclosure").val(); //입력 받은 value 값
	
		var isoptions = false;
		 
		for (let i=0; i<len; i++){  
			if(el.options[i].value == str){
				el.options[i].selected = true;
			}
		}
		
		
		//////////////////////////////////////////////////////////////////////
		
		// 문항개수 설정 직접입력 넣어주기
		
		el = document.getElementById('selquestioncnt');  //select box
		len = el.options.length; //select box의 option 갯수
		str = $("input#questioncnt").val(); //입력 받은 value 값
	
		isoptions = false;
		
		for (let i=0; i<len; i++){  
			if(el.options[i].value == str){

				$("#questioncnt").hide();
				el.options[i].selected = true;
				isoptions = true;
			}
		}
		if(!isoptions){
			$("input#questioncnt").val(str);
			el.options[Number(len)-1].selected = true;
			
			$("input#questioncnt").show();
		}
		
		//////////////////////////////////////////////////////////////////////
	}
	
	
	function viewQuestionList(){
		
		location.href='<%=ctxPath%>/questionList.lmsfinal?testclfc=${requestScope.testRoundOne.testclfc}';
		
		
	}
	
</script>





<div class="container w-75" style="margin: 250px; padding:0;">


<h2 style="margin-bottom: 30px;">시험 상세정보</h2>
	<div class="innercontainer w-100">
	
	
	
		<form name="updateTestRound">
	    	<div class="row">
	      	<div class="col-25">
	        	<label for="classname">과목 이름</label>
	      	</div>
	      	<div class="col-75">
	        	<input type="text" id="classname" style="width:73%" value="${requestScope.testRoundOne.classname}" readonly/>
	      	</div>
	    </div>
	    
	  	<div class="row">
	    	<div class="col-25">
	        	<label for="testclfc">시험종류</label>
	      	</div>
	      	<div class="col-75">
	      		<input type="text" id="examtitle" name="examtitle" style="width:36%;" value="${requestScope.testRoundOne.examtitle}"/>
	        	<select id="selexamtitle" name="selexamtitle" style="width:36%;">
	          		<option value="중간고사">중간고사</option>
	          		<option value="기말고사">기말고사</option>
	          		<option value="direct">직접입력</option>
	        	</select>
	      	</div>
	    </div>
	    
	    
	    <div class="row">
	    	<div class="col-25"> 시험일시 </div>
			<div class="col-75">
				<input type="date" id="startDate"  style="height: 49px; width:25%;"/>&nbsp;
				<select id="startHour" class="schedule" style="width:20%;"></select> 시
				<select id="startMinute"  class="schedule" style="width:20%;"></select> 분
				~ 
				
				<input type="hidden" name="startdate"/>
			</div>
	    </div>
	    
	        <div class="row">
	    	<div class="col-25">  </div>
			<div class="col-75">
				<input type="date" id="endDate" style="height: 49px; width:25%;"/>&nbsp;
				<select id="endHour"  class="schedule" style="width:20%;"></select> 시
				<select id="endMinute"  class="schedule" style="width:20%;"></select> 분&nbsp;
				
				<input type="checkbox" id="allDay"/>&nbsp;<label for="allDay">종일</label>
				
				<input type="hidden" name="enddate"/>
			</div>
	    </div>
	    
	    
	    <div class="row">
	    	<div class="col-25">
	        	<label for="disclosure">시험공개여부</label>
	      	</div>
	      	<div class="col-75">
	        	<select id="seldisclosure" name="disclosure" style="width:73%">
	        		<option value="0">공개</option>
	          		<option value="1">비공개</option>
	        	</select>
	      	</div>
	    </div>
	    
	    
	    <div class="row">
	    	<div class="col-25">
	        	<label for="selquestioncnt">문항개수 설정</label>
	      	</div>
	      	<div class="col-75">
	      		<input type="text" id="questioncnt" name="questioncnt" style="width:36%" value="${requestScope.testRoundOne.questioncnt}"/>
	        	<select id="selquestioncnt" name="selquestioncnt" style="width:36%">
	        	</select>
	      	</div>
	    </div>
	    
	    
	     <div class="row">
	    	<div class="col-25">
	        	<label for="currentquestioncnt">현재 출제문항 개수</label>
	      	</div>
	      	<div class="col-75">
	      		<input type="text" id="currentquestioncnt" style="width:36%" value="${requestScope.testRoundOne.currentquestioncnt}" readonly/>
	      	</div>
	    </div>

	    <div class="row">
	    	<div class="col-25">
	      	</div>
	      	<div class="col-75">
	        	<button type="button" class="btn btn-dark mt-5" id="createTestpaper" style="margin:auto; width: 35%" onclick="modifyTestRound()">수정</button>
	      		<button type="button" class="btn btn-light mt-5" id="createTestpaper" style="margin:auto; width: 35%" onclick="viewQuestionList()">문제</button>
	      	</div>
	   	</div>
	   	<input type="hidden" id="majorid" name="majorid" value="${requestScope.testRoundOne.majorid}"/>
	   	<input type="hidden" id="gyowonid" name="gyowonid" value="${requestScope.testRoundOne.gyowonid}"/>
	   	<input type="hidden" id="subjectid" name="subjectid" value="${requestScope.testRoundOne.subjectid}"/>
	   	<input type="hidden" id="testclfc" name="testclfc" value="${requestScope.testRoundOne.testclfc}"/>
	   	<input type="hidden" id="disclosure" value="${requestScope.testRoundOne.disclosure}"/>
	   	<input type="hidden" id="startDate" name="startdate" />
	   	<input type="hidden" id="endDate" name="enddate" />
		<input type="hidden" id="storedStartDate" name="storedStartDate" value="${requestScope.testRoundOne.startdate}" />
	   	<input type="hidden" id="storedEndDate" name="storedEndDate" value="${requestScope.testRoundOne.enddate}" />
	   	
	</form>
</div>

 	
 	
</div>