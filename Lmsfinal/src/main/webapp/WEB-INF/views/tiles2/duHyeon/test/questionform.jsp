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
		
		
	
		
		 

	});// end of $(document).ready(funciton(){})----------------------------

	
	
	function addQuestion(){
		
		
		
		if($("input#question").val().trim() == ""){
			alert("문제를 입력해주세요");
			return;
		}
		if($("input#answer1").val().trim() == ""){
			alert("보기 1번을 채워주세요");
			return;
		}
		if($("input#answer2").val().trim() == ""){
			alert("보기 2번을 채워주세요");
			return;
		}
		if($("input#answer3").val().trim() == ""){
			alert("보기 3번을 채워주세요");
			return;
		}
		if($("input#answer4").val().trim() == ""){
			alert("보기 4번을 채워주세요");
			return;
		}
		
		
		
		
		const frm = document.insertQuestion;
		frm.method = "POST";
		frm.action = "<%=ctxPath%>/addQuestion.lmsfinal";
		frm.submit();
		
	}
	

</script>





<div class="container w-75" style="margin: 250px; padding:0;">

<h2 style="margin-bottom: 30px;">시험 문제 출제</h2>
	<div class="innercontainer w-100">
		<form name="insertQuestion">
	    	<div class="row">
	      	<div class="col-25">
	        	<label for="question">문제</label>
	      	</div>
	      	<div class="col-75">
	        	<input type="text" id="question" name="question" style="width:73%" value=""/>
	      	</div>
	    </div>
	    
	    
	    
	  	<div class="row">
	    	<div class="col-25">
	        	<label for="answer1">1번 보기</label>
	      	</div>
	      	<div class="col-75">
	      		<input type="text" id="answer1" name="answer1" style="width:73%;"/>
	      	</div>
	    </div>
	    
	    <div class="row">
	    	<div class="col-25">
	        	<label for="answer2">2번 보기</label>
	      	</div>
	      	<div class="col-75">
	      		<input type="text" id="answer2" name="answer2" style="width:73%;"/>
	      	</div>
	    </div>
	    
	    <div class="row">
	    	<div class="col-25">
	        	<label for="answer3">3번 보기</label>
	      	</div>
	      	<div class="col-75">
	      		<input type="text" id="answer3" name="answer3" style="width:73%;"/>
	      	</div>
	    </div>
	    
	    <div class="row">
	    	<div class="col-25">
	        	<label for="answer4">4번 보기</label>
	      	</div>
	      	<div class="col-75">
	      		<input type="text" id="answer4" name="answer4" style="width:73%;"/>
	      	</div>
	    </div>
	    
	    <div class="row">
	    	<div class="col-25">
	        	<label for="correct">정답 번호</label>
	      	</div>
	      	<div class="col-75">
	      		<select id="correct" name="correct" style="width:73%;">
	      			<option value="1">1번</option>
	      			<option value="2">2번</option>
	      			<option value="3">3번</option>
	      			<option value="4">4번</option>
	      		</select>
	      	</div>
	    </div>
		<div class="row">
			<div class="col-25">
			
			</div>
			<div class="col-75 mt-5">
				<button class="btn btn-dark" style="width:36%;" onclick="addQuestion()">출제하고 나가기</button> 
				<button class="btn btn-dark" style="width:36%;" onclick="javascript:history.back()">문제 목록으로</button>
			</div>
		</div>
	
	   	<input type="hidden" name="subjectid" value="${requestScope.smgMap.subjectid}"/>
	   	<input type="hidden" name="majorid" value="${requestScope.smgMap.majorid}"/>
	   	<input type="hidden" name="gyowonid" value="${requestScope.smgMap.gyowonid}"/>
	   	<input type="hidden" name="testclfc" value="${requestScope.smgMap.testclfc}"/>
	
	
	</form>
	
		
</div>
</div>