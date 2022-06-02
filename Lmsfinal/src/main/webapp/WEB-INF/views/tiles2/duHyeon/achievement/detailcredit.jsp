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
		
		const subjectid = $("input#subjectid").val();
		const stdid = $("input#stdid").val();
		
		
		
		$.ajax({
			url:"<%= request.getContextPath()%>/testresult_json.lmsfinal", 
			type:"POST",
			data : {"subjectid" : subjectid, "stdid" : stdid},
	    	dataType:"JSON",
            success:function(json){
            	
            	// console.log(json);
            	
            	let html = "";
            	
            	
            	if(json.length == 0){
            		html += "<option value=''>아직 시험을 출제하지 않았습니다</option>";
            	}
            	else{
            		html += "<option value=''>시험 선택</option>";
            		json.forEach(function (item, index){
                		if(item.score == null){
                			html += "<option value='0'>"+item.examtitle+"</option>"
                		}
                		else{
                			html += "<option value='"+item.score+"'>"+item.examtitle+"</option>"
                    	}
                	});
            	}
            	
            	
            	$("select#finalscoreList").html(html);
            	$("select#midscoreList").html(html);
            	
            },
            error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
		
		
		
		$("#midscoreList").bind( "change", function() {
			
			let score = $("#midscoreList").val();
			
			if( score == null){

				$("input#midscore").val("0");
				
			}
			else{

				$("input#midscore").val(score);
					
			}

		});

		$("#finalscoreList").bind( "change", function() {
			
			$("input#finalscore").val($("#finalscoreList").val());

		});
		
		
			
	});// end of $(document).ready(funciton(){})----------------------------

	
	
	function modifytestresult(){
		
		
		
		
		
		
		
		
		
		const frm = document.testresultFrm;
		frm.method = "POST";
		frm.action = "<%=ctxPath%>/updatecredit.lmsfinal";
		frm.submit();
		
	}
	
	function checkattend(){
		const courseno = $("input#courseno").val();
		
		$.ajax({
			url:"<%= request.getContextPath()%>/detailcredit_json.lmsfinal", 
			data : {"courseno" : courseno},
	    	dataType:"JSON",
            success:function(json){
            	
            	const attcnt = Number(json.attendance) + Number(json.tardy)+Number(json.absent);
        
           	
           		// 점수란에 바로 점수화 시켜줄것
           		// 3회에 결석 1회 4회면 F
           		
           		if(Math.floor(Number(json.tardy)/3) + Number(json.absent) >= 4 ){
           			// 학점란에 F넣어주기
           			$("input#attscore").val(0);
           			$("input#grade").val("F");
           			
           		}
           		else{
           			
           			var score = 100 - (Number(json.tardy) * 7 + Number(json.absent) * 25);
           		
           			$("input#attscore").val(score);
           		}
           		
            	let html = "<span>출석 : "+ json.attendance + "회	지각 : "+json.tardy+ "회	결석 : "+json.absent+"회</span>";

            	$("div#currentAttStatus").html(html);
            	
            },
            error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
			
		});
	}
	
	
	function compute(){
		
		let flagF = 0;
		const courseno = $("input#courseno").val();
		
		$.ajax({
			url:"<%= request.getContextPath()%>/detailcredit_json.lmsfinal", 
			data : {"courseno" : courseno},
	    	dataType:"JSON",
            success:function(json){
            	
            	const attcnt = Number(json.attendance) + Number(json.tardy)+Number(json.absent);
        
           	
           		// 점수란에 바로 점수화 시켜줄것
           		// 3회에 결석 1회 4회면 F
           		
           		if(Math.floor(Number(json.tardy)/3) + Number(json.absent) >= 4 ){
           			// 학점란에 F넣어주기
           			$("input#attscore").val(0);
           			$("input#grade").val("F");
           			
           		}
           		else{
           			
           			var score = 100 - (Number(json.tardy) * 7 + Number(json.absent) * 25);
           		
           			$("input#attscore").val(score);
           		}
           		
            	let html = "<span>출석 : "+ json.attendance + "회	지각 : "+json.tardy+ "회	결석 : "+json.absent+"회</span>";

            	$("div#currentAttStatus").html(html);
            	
            },
            error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
			
		});
		
		const subjectid = $("input#subjectid").val();
		
		$.ajax({
			url:"<%= request.getContextPath()%>/compute_json.lmsfinal", 
			data : {"subjectid" : subjectid},
	    	dataType:"JSON",
            success:function(json){
            	
            	var lpattendper = Number(json.lpattendper);
            	var lphomewkper = Number(json.lphomewkper);
            	var lpexamper = Number(json.lpexamper)/2;
            		
            	$("input#attscore").val(Number($("input#attscore").val()) * lpattendper);
            	$("input#midscore").val(Number($("input#midscore").val()) * lpexamper);
            	$("input#finalscore").val(Number($("input#finalscore").val()) * lpexamper);
            	$("input#taskscore").val(Number($("input#taskscore").val()) * lphomewkper);
            	
            	var attscore =Number($("input#attscore").val());
            	var midscore = Number($("input#midscore").val());
            	var finalscore = Number($("input#finalscore").val());
            	var taskscore = Number($("input#taskscore").val());
            
            	var totalscore = attscore + midscore + finalscore + taskscore;
            	
            	let grade = "";
            	
            	
            	if(flagF != 1){
            		if(totalscore > 95){
                		grade="A+";
                	}
                	else if(totalscore > 90){
                		grade="A";
                	}
                	else if(totalscore > 85){
                		grade="B+";
                	}
    				else if(totalscore > 80){
    					grade="B";
                	}
    				else if(totalscore > 75){
    					grade="C+";
    				}
    				else if(totalscore > 70){
    					grade="C";
                	}
    				else if(totalscore > 65){
    					grade="D+";
                	}
    				else if(totalscore > 60){
    					grade="D";
    				}
    				else{
    					grade="F";
                	}
            	}
            	else{
            		grade="F";
            	}
            	
           		
            	$("input#grade").val(grade);
            	
            },
            error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
			
		});
	}

	
</script>





<div class="container w-75" style="margin: 250px; padding:0;">

	<div class="innercontainer w-100">
		<form name="testresultFrm">
	    	<div class="row">
	      	<div class="col-25">
	        	과목 이름
	      	</div>
	      	<div class="col-75">
	        	<input type="text" id="classname" style="width:73%" value="${requestScope.graderesultOne.classname}" readonly/>
	      	</div>
	    </div>
	    
	  	<div class="row">
	    	<div class="col-25">
	        	이름
	      	</div>
	      	<div class="col-75">
	      		<input type="text" id="stdname" style="width:73%" value="${requestScope.graderesultOne.stdname}" readonly/>
	      	</div>
	    </div>
	    
	    
	    <div class="row">
	    	<div class="col-25"> 학번 </div>
			<div class="col-75">
				<input type="text" id="stdid" style="width:73%" value ="${requestScope.graderesultOne.stdid}" readonly/>
			</div>
	    </div>
	    
	    <div class="row">
	    	<div class="col-25">중간고사 점수</div>
			<div class="col-75">
				<input type="text" id="midscore" name="midscore" style="width:36%" value="${requestScope.graderesultOne.midscore}" />
				<select id="midscoreList" style="width:36%;"></select>
			</div>
	    </div>
	    
	    
	    <div class="row">
	    	<div class="col-25">
	        	기말고사점수
	      	</div>
	      	<div class="col-75">
	        	<input type="text" id="finalscore" name="finalscore" style="width:36%" value="${requestScope.graderesultOne.finalscore}">
	        	<select id="finalscoreList" style="width:36%;"></select>
	      	</div>
	    </div>
	    
	    
	    <div class="row">
	    	<div class="col-25">
	        	과제점수
	      	</div>
	      	<div class="col-75">
	      		<input type="text" id="taskscore" name="taskscore" style="width:73%" value="${requestScope.graderesultOne.taskscore}" placeholder="100점 만점으로 입력해주세요"/>
	      	</div>
	    </div>
	    
	    
	     <div class="row">
	    	<div class="col-25">
	        	출결점수
	      	</div>
	      	<div class="col-75">
	      		<input type="text" id="attscore" name="attscore" style="width:36%" value="${requestScope.graderesultOne.attscore}"/>
	      		<button type="button" class="btn btn-dark" onclick="checkattend()" style="width:36%">출결확인하기</button>
	      	</div>
	    </div>
	    
	    <div class="row">
	    	<div class="col-25">
	      	</div>
	      	<div class="col-75" id = "currentAttStatus">
	      		
	      	</div>
	    </div>
	    
	    <div class="row">
	    	<div class="col-25">
	        	최종 학점
	      	</div>
	      	<div class="col-75">
	      		<input type="text" id="grade" name="grade" style="width:73%" value="${requestScope.graderesultOne.grade}"/>
	      	</div>
	    </div>

	    <div class="row">
	    	<div class="col-25">
	      	</div>
	      	<div class="col-75">
	      		<button type="button" class="btn btn-light mt-5" style="margin:auto; width: 73%" onclick="compute()">계산하기</button>
	        	<button type="button" class="btn btn-dark mt-1" style="margin:auto; width: 73%" onclick="modifytestresult()">저장하기</button>
	      	</div>
	   	</div>
	   	<input type="hidden" id="courseno" name ="courseno" value="${requestScope.graderesultOne.courseno}"/>
   		<input type="hidden" id="subjectid" name="subjectid" value="${requestScope.graderesultOne.subjectid}"/>
	</form>
</div>

 	
 	
</div>