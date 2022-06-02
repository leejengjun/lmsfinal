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
		
		var el = document.getElementById('correct');  //select box
		var len = el.options.length;
		var str = $("input#storedCorrect").val();
		
		for (let i=0; i<len; i++){  
			if(el.options[i].value == str){

				el.options[i].selected = true;
				
			}
		}
		
		$("button#viewQuestionList").click(function(){
			location.href='<%=ctxPath%>/questionList.lmsfinal?testclfc=${requestScope.testclfc}';
			
		});
		
		
		
	});// end of $(document).ready(funciton(){})----------------------------

	
	
	function modifyQuestion(){
		
		
		
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
		
		
		const frm = document.updateQuestion;
		frm.method = "POST";
		frm.action = "<%=ctxPath%>/modifyQuestion.lmsfinal";
		frm.submit();
		
	}

	

</script>





<div class="container w-75" style="margin: 250px; padding:0;">


<h2 style="margin-bottom: 30px;">시험 문제 수정</h2>
	<div class="innercontainer w-100">
		<form name="updateQuestion">
	    	<div class="row">
	      	<div class="col-25">
	        	<label for="question">문제</label>
	      	</div>
	      	<div class="col-75">
	      		<input type="text" style="display:none;"/>
	        	<input type="text" id="question" name="question" style="width:73%" value="${requestScope.question.question}"/>
	        	
	      	</div>
	    </div>
	    
		<c:forEach var="answer" items="${requestScope.answer}" varStatus="status">
			<div class="row">
		    	<div class="col-25">
		        	<label for="answer${status.count}">${status.count}번 보기</label>
		      	</div>
		      	<div class="col-75">
		      		<input type="text" id="answer${status.count}" name="answer${status.count}" style="width:73%;" value="${answer.answer}"/>
		      		<input type="hidden" id="answerseq${status.count}" name="answerseq${status.count}" value="${answer.answersseq}"/>
		      	</div>
		    </div>
		
		</c:forEach>
	    
	  	
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
	      		<input type="hidden" id="storedCorrect" value="${requestScope.question.correct}"/>
	      	</div>
	    </div>
		<div class="row">
			<div class="col-25">
			
			</div>
			<div class="col-75 mt-5">
				<button type="button" class="btn btn-dark" style="width:36%;" onclick="modifyQuestion()">수정하기</button> 
				<button type="button" class="btn btn-light" id="viewQuestionList"style="width:36%;" >전체시험문제보기</button>
			</div>
		</div>
	
	   	<input type="hidden" name="subjectid" value="${requestScope.question.subjectid}"/>
	   	<input type="hidden" name="majorid" value="${requestScope.question.majorid}"/>
	   	<input type="hidden" name="gyowonid" value="${requestScope.question.gyowonid}"/>
	   	<input type="hidden" name="testclfc" value="${requestScope.question.testclfc}"/>
	   	<input type="hidden" name="questionseq" value="${requestScope.question.questionseq}"/>
	
	
	</form>
	
		
</div>
</div>