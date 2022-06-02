<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<%
	String ctxPath = request.getContextPath();
%>   

<!-- Font Awesome 5 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">


<style type="text/css">
 
</style>

<script type="text/javascript">

  $(document).ready(function(){
	  
	  $("span.error").hide();
	  
	  // === 학과코드에 포커스가 가는 경우 학과찾기 모달창 활성화
	  $("input#majorid").click(function(){
		  $('#deptSearch').modal('show');
	  });
	  
	  $("input#deptname").click(function(){
		  $('#deptSearch').modal('show');
	  });
		  
		  
	  // === 학과 찾아 값 넣어주기 
      $("input#searchWord").keyup(function(event){
  		if(event.keyCode == 13){
  			// 엔터를 했을 경우
  			godeptSearch();
  		}
  	  });
       
	  
	  // === 검색 결과에 따라 학과 코드와 학과명 넣어주기
  	  $(document).on("click", "div.result", function(){
  		  
  		  const majorid = $(this).find("span#majorid").text();
  		  const deptname = $(this).find("span#deptname").text();
  		  
  		//  const majorid = $("span#majorid").text();
  		//  const deptname = $("span#deptname").text();
  		  
  	   	  $("input#majorid").val(majorid); //텍스트박스에 검색된 결과의 문자열을 입력해준다.
  	   	  $("input#deptname").val(deptname); 
  
   		  $('#deptSearch').modal('hide');
   		  
   		  // 학과코드에 따라 강의코드 주기
   		  $.ajax({
			  url:"<%= ctxPath%>/subjectidShow.lmsfinal",
			  type:"GET",
			  data:{"majorid":$("input#majorid").val()},
			  dataType:"JSON",
			  success:function(json){		

		          const subjectid = json.subjectid;
				  $("input#subjectid").val(subjectid+1);
				  
			  },
			  error: function(request, status, error){
	                  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	          }
		});
		   
   		
  	  });	  
  	  
	  
	  // 이수구분에 따라 학점 값 주기 
  	  $('select#courseclfc').change(function(){
    	  $("#courseclfc option:selected").each(function () {      		
      		if($(this).val()== ''){
      			$("#credit").val(''); //textBox값 초기화
      			$target.parent().find(".error").hide();
      		}	
      		else if($(this).val()== '전공필수' || $(this).val()== '전공핵심'){
                  $("#credit").val('3');                
      		}
  		    else{
  		    	 $("#credit").val('2'); 
  		    }
     	  });
      });	


      // 강의 신청하기 
	  $("button#btnWrite").click(function(){
		  
		// *** 학기가 선택되었는지 검사한다. ***// 
		const semesterCheckedLength = $("input:radio[name='semester']:checked").length;
			
		if(semesterCheckedLength == 0) {
			alert("학기를 선택하셔야 합니다.");
			return; //종료
		}
		  
		// *** 학년이 선택되었는지 검사한다. ***// 
		const gradeCheckedLength = $("input:radio[name='grade']:checked").length;
		
		if(gradeCheckedLength == 0) {
			alert("학년을 선택하셔야 합니다.");
			return; //종료
		}	
		
		// *** 이수구분이 선택되었는지 검사한다. ***//
		if($("#courseclfc").val() == "") {
			alert("이수구분을 선택해주세요");
			return;
		}
		
		// *** 선택된 값에 따라 개설학기 계산하고 값 넣어주기
		if(semesterCheckedLength != 0 && gradeCheckedLength != 0){
			var semester = $("input[name='semester']:checked").val(); 
			var grade = $("input[name='grade']:checked").val(); 
			var opensemester = 0;
			
			if(semester == 1){
				opensemester = ( (parseInt(semester) + 1) * grade) - 1;
				
			}
			else {
				opensemester = semester * grade;
			}
			
			$("input#opensemester").val(opensemester); 
			
		}
		
		
		
		// *** 필수입력 사항에 모두 입력이 되었는지 검사한다. ***// 
  		let b_FlagRequiredInfo = false;
		
		$("input.requiredInfo").each(function(index, item){
			const data = $(item).val().trim();
			if(data == "") {
				alert("모두 입력하셔야 합니다.");
				b_FlagRequiredInfo = true;
				return false; // for문에서 break;와 같은 기능이다. 
			}
		});
		
		if(b_FlagRequiredInfo) {
			return; // 종료 
		}
			 
		  
		// 폼(form)을 전송(submit)
		const frm = document.addlectureFrm;
		frm.method = "POST";
		frm.action = "<%= ctxPath%>/addlectureEnd.lmsfinal";
		frm.submit();
	  });
	  
  });// end of $(document).ready(function(){})-------------------------------

  function godeptSearch(){
	  $.ajax({
		  url:"<%= ctxPath%>/deptlist.lmsfinal",
		  data:{"searchType":$("select#searchType").val()
			  	, "searchWord":$("input#searchWord").val()},  	
		  dataType:"JSON",
		  success:function(json_1){ 
			  
			  let html = "";
			  if(json_1.length > 0) {
				  $.each(json_1, function(index_1, item_1){
					  html += "<div class='result' id='index_1' style='cursor:pointer; display:block;'>";
					  html += "<span id='majorid'>"+item_1.majorid+"</span>&nbsp;&nbsp;";
					  html += "<span id='deptname'>"+item_1.deptname+"</span>";
					  html += "</div>";
					//  console.log(item_1.deptname);
				  });
			  }
			  else {
				  html += "<span class='dept'>해당하는 학과가 없습니다</span>";
			  }
			  
			  $("div#deptDisplay").html(html);
		  },
		  error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		  }
	  });
  }// end of function goSearch(){}-----------------

	  
</script>

<div style="display: flex; height:900px;">
<div style="margin: auto; padding-left: 3%; margin-top: 3%;">

	<h3 style="margin-bottom:30px;">강의 신청하기</h3>



<form name="addlectureFrm">

	<table style="width: 1024px" class="table table-bordered">
		<tr>
			<th style="width: 15%; background-color: #DDDDDD;">성명</th>
			<td>
				<input type="hidden" name="gyowonid" style="border:none;" value="${sessionScope.loginuser.gyowonid}" />
				<input type="text" name="name" style="border:none;" value="${sessionScope.loginuser.gyoname}" readonly />
			</td>
		</tr>
		
		<tr>
			<th style="width: 15%; background-color: #DDDDDD;">학과코드</th> 
			<!-- 검색하면 넣을 수 있게  -->
			<td> 
	            <input type="text" id="majorid" name="majorid" size="20" placeholder="학과코드" class="requiredInfo" value=""/><br/>
	            <input type="text" id="deptname" name="deptname" size="20" placeholder="학과명" class="requiredInfo" value="" style="margin-top:10px;"/>&nbsp;
	            <button type="button" id="deptSearch" class="btn btn-secondary btn-sm mr-3" data-toggle="modal" data-target="#deptSearch">
		                  학과찾기
		        </button>
	            <span class="error">&nbsp;찾기 버튼을 눌러서 학과를 입력하세요</span>
	            
            </td>
            
            <!-- Modal -->
				<div class="modal fade" id="deptSearch" data-backdrop="static">
			  	<div class="modal-dialog">
			    <div class="modal-content">
			      
			      <!-- Modal header -->
			      <div class="modal-header">
			        <h5 class="modal-title">학과 찾기</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button> 
			      </div>
			      
			      <!-- Modal body -->
			      <div class="modal-body">
			        <form name="searchFrm" style="margin-top: 20px;">
				      <select name="searchType" id="searchType" style="height: 26px;">
				         <option value="majorid">학과코드</option>
				         <option value="deptname">학과명</option>
				      </select>
				      <input type="text" name="searchWord" id="searchWord" size="30" autocomplete="off" /> 
				      <input type="text" style="display: none;"/> <%-- form 태그내에 input 태그가 오로지 1개 뿐일경우에는 엔터를 했을 경우 검색이 되어지므로 이것을 방지하고자 만든것이다. --%> 
				      <button type="button" class="btn btn-secondary btn-sm mr-3" onclick="godeptSearch()">검색</button>
				    </form>   
				   
				    <%-- === 검색결과 내용 보여주기 === --%>
				   	<p style="margin-top: 50px;">검색결과</p>
					<div id="deptDisplay"></div>
					
			      
			      <!-- Modal footer -->
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary btn-sm mr-3" data-dismiss="modal">취소</button>
			      </div>
			    </div>
			  </div>
			</div>
		</tr>
		
		<tr>
			<th style="width: 15%; background-color: #DDDDDD;">강의코드</th>
			<td>
				<input type="text" name="subjectid" id="subjectid" style="border:none;" class="requiredInfo" value=""/>
			</td>
		</tr>
	
		<tr>
			<th style="width: 15%; background-color: #DDDDDD;">강의명</th>
			<td>
				<input type="text" name="classname" id="classname" placeholder="강의명" size="50" class="requiredInfo"/>
				<span class="error">강의명을 적어주세요</span> 
			</td>
		</tr>
		
		<tr>
			<th style="width: 15%; background-color: #DDDDDD;">개설학기</th>
			<td>
				<input type="radio" id="first" name="semester" value="1" /><label for="first" style="margin-left: 2%;">1학기</label>
	            <input type="radio" id="second" name="semester" value="2" style="margin-left: 5%;" /><label for="second" style="margin-left: 2%;">2학기</label>
				<span class="error">개설학기를 선택해주세요</span> 
			</td>
			
			
		</tr>
		
		<tr>
			<th style="width: 15%; background-color: #DDDDDD;">개설학년</th>
			<td>
				<input type="radio" id="one" name="grade" value="1" /><label for="one" style="margin-left: 2%;">1학년</label>
	            <input type="radio" id="two" name="grade" value="2" style="margin-left: 5%;"/><label for="two" style="margin-left: 2%;">2학년</label>
	            <input type="radio" id="three" name="grade" value="3" style="margin-left: 5%;"/><label for="three" style="margin-left: 2%;">3학년</label>
	            <input type="radio" id="four" name="grade" value="4" style="margin-left: 5%;"/><label for="four" style="margin-left: 2%;">4학년</label>  
				<span class="error">개설학년를 선택해주세요</span> 
				<input type="hidden" id="opensemester" name="opensemester" size="20" placeholder="개설학기" class="requiredInfo" value=""/>&nbsp;
	            
			</td>
		</tr>
		
		
		
		<tr>
			<th style="width: 15%; background-color: #DDDDDD;">이수구분</th>
			<td>
				<select name="courseclfc" id="courseclfc" style="height: 30px;"> 
					<option value="">이수구분</option>
					<option value="전공필수">전공필수</option>
					<option value="전공핵심">전공심화</option>
					<option value="필수교양">필수교양</option>
					<option value="필수교양">선택교양</option>
				</select>
				<span class="error">이수구분을 선택해주세요</span> 
			</td>
		</tr>
		
		<tr>
			<th style="width: 15%; background-color: #DDDDDD;">학점</th>
			<td>
			<input type="text" id="credit" name="credit" value="" style="border:none;"/>
			</td>
		</tr>
     
	</table>
	
	
	
	<div style="margin: 20px;">
		<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnWrite">강의 신청하기</button>
		<button type="button" class="btn btn-secondary btn-sm" onclick="javascript:history.back()">취소</button>
	</div>
	
	

</form> 
  
</div>

</div>



		
