<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>

<%
	String ctxPath = request.getContextPath();
    String subjectid = request.getParameter("subjectid");
    String credit = request.getParameter("credit");
%>
<style type="text/css">

th {background-color: #DDD}

table#lectureroomtimetable {
  border-spacing: 2px;
  border-collapse: separate;
  
}
table#lectureroomtimetable td{
/*		background-color: green;*/
}
td.available {
/*		cursor:pointer; */
 	background-color:green;
}
.subjectStyle {background-color: #d5d5d5;
				cursor: pointer;}
tr.result:hover {
		background-color: #d5d5d5;
	}
.checkedStyle {background-color: navy;
				cursor: pointer;}
				
div#container {
	border: solid 1px navy;
	width: 95%;
	margin: 20px auto;
}


h5{
	font-weight: bold;
}

div.col-head {
	border:solid 1px gray;
	position: relative; 
    height: 30px;
    line-height: 50px;
    text-align: center;
    background-color: gray;
}


div.section {
	border: solid 1px navy;
    position: relative;
    float: left;
    margin-left: 2px;
    background-color: #f2f0e5;
    overflow: hidden;
    
}


.section-buildno {
    width: 200px;
    height: 500px
}

.section-lctrid {
    width: 265px;
    height: 500px;
}

.section-timetable{
    width: 600px;
    height: 500px;
}

.section-totalperson {
	width: 100px;
    height: 500px;
}







</style>
<script type="text/javascript">
	$(document).ready(function(){
		
		// 건물 선택하기
		// 선택할 때 마우스 올리면 바뀌게 하기
	    $("span.buildno").bind("mouseover", function(event){
		    const $target = $(event.target);
		    $target.addClass("subjectStyle");
	    });
	  
  	    $("span.buildno").bind("mouseout", function(event){
		  const $target = $(event.target);
		  $target.removeClass("subjectStyle");  
	    });
		
  	    // 건물 테이블의 Row 클릭시 값 가져오기
		$("#building tr").click(function(){ 	
			
			// 현재 클릭된 Row(<tr>)
			var tr = $(this);
			var td = tr.children();
			
			// td.eq(index)를 통해 값을 가져올 수도 있다.
			var buildno = td.eq(0).text();
			var buildname = td.eq(1).text();
			
			$("input#buildno").val(buildno);
		});
  	   
		// 강의정원 입력
		$("input[type=number]").bind('keyup input', function(){
			var person = $("input#person").val();
			$("input#totalperson").val(person);
			goviewroom();
		});
		
		
		
		
	});// end of $(document).ready()-----------------------
	
	// 강의실 조회
	// - 정원에 맞는 강의실번호만 클릭 가능하게
	// - 정원에 맞지 않는 강의실 번호는 회색 처리, 클릭 불가능하게 		
	function goviewroom() {
		$.ajax({
	        	   url: "<%= ctxPath%>/lectureroomSearch.lmsfinal",
	        	   data: {"buildno":$("input#buildno").val(),
	        		   "totalperson":$("input#totalperson").val()}, // data는 /MyMVC/member/isDuplicateCheck.up 로 전송해야할 데이터를 말한다.
	        	   type: "post", // type은 생략하면 "get"이다.
	        	   dataType:"JSON",
	        	   success: function(json){
	        		  let html = "";
	     			  if(json.length > 0) {
	     				  $.each(json, function(index, item){
	     					  html += "<tr>";
	     					 // html += "<td class='room'>"+(index+1)+"</td>";    	
	     					  html += "<td class='room'>"+item.seq_lctrid+"</td>";    	
	     					  html += "<td class='room'><span class='lctrid'>"+item.lctrid+"</span></td>";
	     					  html += "<td class='room'>"+item.maxperson+"</td>";
	     					  html += "</tr>";
	     				  });
	     			  }
	     			  else {
	     				  html += "<tr>";
	     				  html += "<td colspan='3' class='room'>강의실이 없습니다</td>";
	     				  html += "</tr>";
	     			  }
	     			  
	     			  $("tbody#lectureroomDisplay").html(html);
	     			  
	     			    // 선택할 때 마우스 올리면 바뀌게 하기
	     			    $("span.lctrid").bind("mouseover", function(event){
	     				    const $target = $(event.target);
	     				    $target.addClass("subjectStyle");
	     			    });
	     			  
	     		  	    $("span.lctrid").bind("mouseout", function(event){
	     				  const $target = $(event.target);
	     				  $target.removeClass("subjectStyle");  
	     			    });
	     		  	    
	     		     	// 강의실 테이블의 Row 클릭시 값 가져오기
	     				$("#lectureroom tr").click(function(){ 	
	     					
	     					// 현재 클릭된 Row(<tr>)
	     					var tr = $(this);
	     					var td = tr.children();
	     					
	     					// td.eq(index)를 통해 값을 가져올 수도 있다.
	     					var seq_lctrid = td.eq(0).text();
	     					var lctrid = td.eq(1).text();
	     					//var seq_lctrid = $("td.seq_lctrid").val();
	     					
	     					console.log("lctrid에 담긴 값 : "+lctrid);
	     					console.log("seq_lctrid에 담긴 값 : "+seq_lctrid);
	     					
	     					$("input#lctrid").val(lctrid);
	     					$("input#seq_lctrid").val(seq_lctrid);
	     					
	     	    		   
	     					goviewtimetable(seq_lctrid);
	     				});
	     				 
	        	   }, 
	        	   error:function(request, status, error){
	        		   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        	   }
	
	   });  
		
		
	} // end of function goviewroom() {
    
	function goviewtimetable(seq_lctrid) {
		$.ajax({
     	   url: "<%= ctxPath%>/lctrtimetableSearch.lmsfinal",
     	   data: {"seq_lctrid":$("input#seq_lctrid").val(), 
     		   	"subjectid":<%=subjectid%>,
     	   		"credit":<%=credit%>},
     	   type: "post", // type은 생략하면 "get"이다.
     	   dataType:"JSON",
     	//   async	: false, 
     	   success: function(json){
     		  
     	       let lctrtimetableArr = []; 
     	       let selectedtimetableArr = [];
     	       
     	       var html = "";	            	       
     	       
		       $.each(json, function(index, item){

		    	   if(item.dayid == 1){
		    		   html += "<tr>";
	        		   html += "<td style='text-align: center;'>"+item.periodid+"</td>";
		    	   }
		    	    
		    	   if(item.emptystate == 1){
        		       html += "<td style='background-color:gray;'>";
        			   html += "<input type='hidden' value="+item.seq_lctrassign+"'>";
        			   html += "</td>";
		    	   }		    	   
		    	   else if (item.emptystate != 1){
		    		   html += "<td class='available'>";
        			   html += "<input type='checkbox' class='seq_lctrassign' name='seq_lctrassign' id='"+item.seq_lctrassign+"' value='"+item.seq_lctrassign+"'>";
        			   html += "<input type='hidden' class='dayid' name='dayid' value='"+item.dayid+"'>";
        			   html += "<input type='hidden' class='periodid' name='periodid' value='"+item.periodid+"'>";
        			   html += "</td>";
		    	   }
		    	   
		    	   if (item.dayid == 5){
		    		   html += "</tr>";
		    	   }
		       	});// end of $.each(json, function(index, item){	
		       	
		       	$("tbody#roomtimetableDisplay").html(html);	
		       	
  	
		       // 학점에 따라 선택할 수 잇는 갯수 제한하기: 배열 갯수 < 학점 유효성 검사 
		       	$("input:checkbox").on('click', function() {
		       		var count = $("input:checkbox:checked").length;    
		       		
		       		if(count > <%=credit%>){
		                  $(this).prop("checked", false);
		                  alert("<%=credit%>개까지만 선택할 수 있습니다.");
		               return;
		            } 	
		       	});

		       	// 배정하기!
		       	$("button#assignlectureroom").on('click', function() { 
		       		
		       		const arrSeq_lctraasign = new Array();
				      
		       		var count = $("input:checkbox:checked").length;
		       		
		       		if(count < <%=credit%>) {
		       			alert("학점에 비해 배정한 교시가 부족합니다. 추가 배정해주세요.")
		       			
		       		} 
		       		else if(count == <%=credit%> ) {
		       			
		    			$("input[name=seq_lctrassign]:checked").each(function(index,item) {
		    				arrSeq_lctraasign.push($(item).val());
		    			});
		    			
			       	} // end of else if(count == 

		       		const str_Seq_lctraasign = arrSeq_lctraasign.join();
	    			
		    	//	console.log("확인용 str_Seq_lctraasign =>" +str_Seq_lctraasign);
		    			
		    		const frm = document.assignroomFrm;
		    		frm.str_Seq_lctraasign.value = str_Seq_lctraasign;
		    		frm.method = "POST";
		    		frm.action = "assignlectureroom.lmsfinal";
		    		frm.submit();
		       	}); // 제출 버튼
		       	
		       	
		       	},
                error: function(request, status, error){
                         alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
                } 
	            
	       });  
	
			
	} // end of function goviewtimetable() {
	
	
</script>

<div style="height:600px;">
<div style="margin: auto; margin-left: 250px; padding-left: 3%; margin-top: 3%;">

	<h3>강의 <span id="subjectid"><%=subjectid%><span>번의 강의실 배정하기</h3>
	
	<div style="padding-left: 1060px; padding-bottom: 20px;">
	<button type="button" class="btn btn-secondary btn-sm" id="assignlectureroom">입력</button>
	<button type="button" class="btn btn-secondary btn-sm" onclick="javascript:history.back()">뒤로</button>	
	</div>
	
	<div id="contents" class="customDisplay">
	 
		<div class="section section-buildno">
			<!-- col-head -->
			<div class="col-head" id="">
				<h5>건물</h5>
			</div>
			<!-- col-body -->
			<div class="col-body" style="height: 560px;">
				<!-- 건물선택 -->
				<div class="building-select">
				 <table class="table table-bordered" id="building">
				 	<thead>
				 	<tr>
				 		<th style="width: 30px;  text-align: center;">번호</th>
				 		<th style="width: 100px;  text-align: center;">건물명</th>
				 	</tr>
				 	</thead>
				 	
				 	<tbody>				 	
				 	
				 	<c:if test="${not empty requestScope.buildingList}">
				    <c:forEach var="mylectureroomvo" items="${requestScope.buildingList}" varStatus="status">
					<tr>
						<td align="center">${mylectureroomvo.buildno}</td>
						<td align="center">
							<span class="buildno">${mylectureroomvo.buildname}</span>
						</td>
				 	</tr>
				 	</c:forEach>
				 	</c:if>
				 	<c:if test="${empty requestScope.buildingList}">
						<tr>
	            		<td colspan="2" style="text-align: center;">배정가능한 건물이 존재하지 않습니다</td>
	            		</tr>
					</c:if>
				 	
				 	</tbody>
				 </table>
				 
				
				</div>
			</div>
	    </div>
	    
	    <div class="section section-totalperson">
			<!-- col-head -->
			<div class="col-head" id="">
				<h5>정원</h5>
			</div>
			<!-- col-body -->
			<div class="col-body" style="height: 560px;">
				<!-- 건물선택 -->
				<div class="building-select">
				 <input type="number" id="person" name="person" min="10" max="60" step="1" value="0" style="width: 90px; margin-left:5px;" required />
				</div>
			</div>
	    </div>
		
		<div class="section section-lctrid">
			<!-- col-head -->
			<div class="col-head" id="">
				<h5>강의실</h5>
			</div>
			<!-- col-body -->
			<div class="col-body" style="height: 560px;">
				<!-- 강의실선택 -->
				<div class="lectureroom-select">
				<table class="table table-bordered" id="lectureroom">
				 	<thead>
				 	<tr>
				 		<th style="width: 60px;  text-align: center;">번호</th>
				 		<th style="width: 85px;  text-align: center;">강의실</th>
				 		<th style="width: 85px;  text-align: center;">최대정원</th>
				 	</tr>
				 	</thead>
				 	<tbody id="lectureroomDisplay"></tbody>	
				 </table>
			    </div>
		    </div>
		</div>
		
		<div class="section section-timetable">
			<!-- col-head -->
			<div class="col-head" id="">
				<h5>시간표</h5>
			</div>
			<!-- col-body -->
			<div class="col-body" style="height: 560px;">
				<!-- 시간표선택 -->
				<div class="timetable-select">
				&nbsp;&nbsp;&nbsp;&nbsp;<span id="credit"><%=credit%></span>학점이므로 <%=credit%>시간을 선택하셔야 합니다.
	
				<table id="lectureroomtimetable" style="margin: auto 20px;">
					<thead>
					<tr>
				 		<th style="width: 90px;  text-align: center;">번호＼요일</th>
				 		<th style="width: 90px;  text-align: center;">월</th>
				 		<th style="width: 90px;  text-align: center;">화</th>
				 		<th style="width: 90px;  text-align: center;">수</th>
				 		<th style="width: 90px;  text-align: center;">목</th>
				 		<th style="width: 90px;  text-align: center;">금</th>
				 	</tr>
					</thead>
					
					<tbody id="roomtimetableDisplay"></tbody>
				</table>
		
				</div>
				</div>
				</div>
	</div> 
</div>
		
		<div style="display:inline-block; margin-left: 330px; margin-top:10px; float:left;">
		<div id="tab" class="customDisplay">
		 <form name="assignroomFrm" action=""> 
			선택한 건물:<input type="text" name="buildno" id="buildno" style="border:none;" size="5" value="" />
		    ,정원:<input type="number" id="totalperson" name="totalperson" style="width: 80px; border:none;" value="" />
		    ,강의실:<input type="text" id="lctrid" name="lctrid" size="5" style="border:none;" value="" />
			<input type="hidden" id="seq_lctrid" name="seq_lctrid" size="10" value="" />
			<input type="hidden" id="dayid" name="dayid" size="10" value="" />
			<input type="hidden" id="periodid" name="periodid" size="10" value="" />
			<input type="hidden" name="subjectid" value="<%=subjectid%>"/>
			<input type="hidden" name="str_Seq_lctraasign" value=""/>
			
			</form>
		</div> 
	
		
	</div>
</div>
	