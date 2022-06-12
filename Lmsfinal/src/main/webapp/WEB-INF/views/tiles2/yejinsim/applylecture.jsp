<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>

<%
	String ctxPath = request.getContextPath();
%>   

<style type="text/css">
	th {background-color: #DDD}
	
	.subjectStyle {font-weight: bold;
					color: navy;
					cursor: pointer;}
	
	a {text-decoration: none; !important;}
	
</style>

<script type="text/javascript">

  $(document).ready(function(){
	  
	  $("span.subject").bind("mouseover", function(event){
		  const $target = $(event.target);
		  $target.addClass("subjectStyle");
	  });
	  
	$("span.subject").bind("mouseout", function(event){
		const $target = $(event.target);
		$target.removeClass("subjectStyle");  
	  });
	  
	
	
	// *** 선택된 값에 따라 개설학기 계산하고 값 넣어주기
	// 이수구분에 따라 학점 값 주기 
	

	$("input#searchWord").keyup(function(event){
		if(event.keyCode == 13){
			// 엔터를 했을 경우
			goSearch();
		}
	});
	
	// 검색시 검색조건 및 검색어 값 유지시키기 
	if( ${not empty requestScope.paraMap}){
		$("input#searchWord").val("${requestScope.paraMap.searchWord}");		
		$("select#searchType").val("${requestScope.paraMap.searchType}");
	}
	
	if( ${not empty requestScope.semester}){
		$("select#semester").val("${requestScope.semester}");
	}
	
	if( ${not empty requestScope.grade}){
		$("select#grade").val("${requestScope.grade}");
	}
	
	if( ${not empty requestScope.deptname}){
		$("input#deptname").val("${requestScope.deptname}");
	}
		
	<%-- === #107. 검색어 입력시 자동글 완성하기 2 --%>
	$("div#displayList").hide();
	
	$("input#searchWord").keyup(function(){
			
			const wordLength = $(this).val().trim().length;
			// 검색어의 길이를 알아온다.
			
			if(wordLength == 0){
				$("div#displayList").hide();
				// 검색어가 공백이거나 검색어 입력후 백스페이스키를 눌러서 검색어를 모두 지우면 검색된 내용이 안 나오도록 해야 한다.
			}
			else {
				$.ajax({
					url:"<%= ctxPath%>/lectureSearchShow.lmsfinal",
					type:"GET",
					data:{"searchType":$("select#searchType").val()
						, "searchWord":$("input#searchWord").val()},
					dataType:"JSON",
					success:function(json){
						//json ==> [{"word":"Korea VS Japan 라이벌 축구대결"},{"word":"JSP 가 뭔가요?"},{"word":"프로그램은 JAVA 가 쉬운가요?"},{"word":"java가 재미 있나요?"}]
						
						<%-- === #112. 검색어 입력시 자동글 완성하기 7 --%>
						if(json.length > 0){
							// 검색된 데이터가 있는 경우임
							
							let html = "";
							
							$.each(json,function(index,item){
								const word = item.word;
								// word ==> 프로그램은 JAVA 가 쉬운가요?
										
								const idx = word.toLowerCase().indexOf($("input#searchWord").val().toLowerCase());
								// 			word ==> 프로그램은 java 가 쉬운가요?
								// 검색어(JaVa)가  나오는 idx는 6이 된다. 
								
								const len = $("input#searchWord").val().length;
								// 검색어(Java)의 길이 len은 4가 된다.
								/*
								console.log("~~~~~~~~~~시작~~~~~~~~~~~");
								console.log(word.substring(0, idx))// 검색어(JaVa) 앞까지의 글자 => "프로그램은 "
								console.log(word.substring(idx, idx+len))// 검색어(JaVa) 글자 => "JAVA"
								console.log(word.substring(idx+len))// 검색어(JaVa) 뒤부터 끝까지 글자 => " 가 쉬운가요?"
								console.log("~~~~~~~~~~끝~~~~~~~~~~~");
								*/
								
								const result = word.substring(0, idx) +"<span>"+word.substring(idx, idx+len)+"</span>" + word.substring(idx+len);
								
								html += "<span style='cursor:pointer;' class='result'>"+result+"</span><br>";
							});
							
							
							const input_width = $("input#searchWord").css("width");// 검색어에 input태그 알아오기
							
							$("div#displayList").css({"width":input_width});// 검색결과 div의 width 크기를 검색어 입력 input 태그 width와 일치시키기 
							
							$("div#displayList").html(html);
							$("div#displayList").show();
						}
						
						
					},
					error: function(request, status, error){
		                  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		                }
				});
			}
			
		}); // end of $("input#searchWord").keyup(function(){

	
	<%-- === #113. 검색어 입력시 자동글 완성하기 8--%>
	$(document).on("click", "span.result", function(){
		const word = $(this).text();
		$("input#searchWord").val(word); //텍스트박스에 검색된 결과의 문자열을 입력해준다.
		$("div#displayList").hide();
		goSearch();
	});
		
	$("div#displayDeptlist").hide();
	
	$("input#deptname").keyup(function(){
		
		const wordLength = $(this).val().trim().length;
		// 검색어의 길이를 알아온다.
		
		if(wordLength == 0){
			$("div#displayDeptlist").hide();
			// 검색어가 공백이거나 검색어 입력후 백스페이스키를 눌러서 검색어를 모두 지우면 검색된 내용이 안 나오도록 해야 한다.
		}
		else {
			$.ajax({
				url:"<%= ctxPath%>/deptSearchShow.lmsfinal",
				type:"GET",
				data:{"deptname":$("input#deptname").val()},
				dataType:"JSON",
				success:function(json){
					//json ==> [{"word":"Korea VS Japan 라이벌 축구대결"},{"word":"JSP 가 뭔가요?"},{"word":"프로그램은 JAVA 가 쉬운가요?"},{"word":"java가 재미 있나요?"}]
					
					<%-- === #112. 검색어 입력시 자동글 완성하기 7 --%>
					if(json.length > 0){
						// 검색된 데이터가 있는 경우임
						
						let html = "";
						
						$.each(json,function(index,item){
							const word = item.word;
							// word ==> 프로그램은 JAVA 가 쉬운가요?
									
							const idx = word.toLowerCase().indexOf($("input#deptname").val().toLowerCase());
							// 			word ==> 프로그램은 java 가 쉬운가요?
							// 검색어(JaVa)가  나오는 idx는 6이 된다. 
							
							const len = $("input#deptname").val().length;
							// 검색어(Java)의 길이 len은 4가 된다.
							/*
							console.log("~~~~~~~~~~시작~~~~~~~~~~~");
							console.log(word.substring(0, idx))// 검색어(JaVa) 앞까지의 글자 => "프로그램은 "
							console.log(word.substring(idx, idx+len))// 검색어(JaVa) 글자 => "JAVA"
							console.log(word.substring(idx+len))// 검색어(JaVa) 뒤부터 끝까지 글자 => " 가 쉬운가요?"
							console.log("~~~~~~~~~~끝~~~~~~~~~~~");
							*/
							
							const result = word.substring(0, idx) +"<span>"+word.substring(idx, idx+len)+"</span>" + word.substring(idx+len);
							
							html += "<span style='cursor:pointer;' class='result2'>"+result+"</span><br>";
						});
						
						
						const input_width = $("input#deptname").css("width");// 검색어에 input태그 알아오기
						
						$("div#displayDeptlist").css({"width":input_width});// 검색결과 div의 width 크기를 검색어 입력 input 태그 width와 일치시키기 
						
						$("div#displayDeptlist").html(html);
						$("div#displayDeptlist").show();
					}
					
					
				},
				error: function(request, status, error){
	                  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	                }
			});
		}
		
	}); // end of $("input#searchWord").keyup(function(){

	<%-- === #113. 검색어 입력시 자동글 완성하기 8--%>
	$(document).on("click", "span.result2", function(){
		const word = $(this).text();
		$("input#deptname").val(word); //텍스트박스에 검색된 결과의 문자열을 입력해준다.
		$("div#displayDeptlist").hide();
		goSearch();
	});
		

	
  });// end of $(document).ready(function(){})-------------------------------
  
  function goApplylecture() {
	  
	  location.href="<%=ctxPath%>/addlecture.lmsfinal";
	  	  
  }// end of function goView(seq) 
  
  
    function goAssignroom(subjectid, credit) {
	  
      location.href="<%=ctxPath%>/assignlectureroom.lmsfinal?subjectid=" + subjectid+"&credit="+credit;
    }
 	 
    function goViewlecplan(subjectid, seq_lectureplan) {
	  
      location.href="<%=ctxPath%>/viewlectureplan.lmsfinal?subjectid=" + subjectid +"&seq_lectureplan="+seq_lectureplan;
    }
  
    function goWritelecplan(subjectid) {
	  
    location.href="<%=ctxPath%>/addlectureplan.lmsfinal?subjectid=" + subjectid;
    }
  
    function goSearch(){
    
	   	 const frm = document.searchFrm;
	   	 frm.method = "GET";
	   	 frm.action = "<%= ctxPath%>/applylecture.lmsfinal";
	   	 frm.submit();
     }// end of function goSearch(){}-----------------
     
</script>
<div style="display: flex; height:1500px;">
<div style="margin: auto; margin-left: 250px; padding-left: 3%; margin-top: 3%;">
	<h3 style="margin-bottom: 30px;">내 강의 신청 목록</h3>
	<h5>강의실 배정과 강의계획서 작성을 마쳐야 강의 개설이 가능합니다.</h5>
	
	<%-- === #101. 글검색 폼 추가하기 : 강의명, 강의번호로 검색을 하도록 한다. --%>
	<div class="search" style="border: 1px solid gray; margin: 10px 0; padding: 10px; position:relative;">
	<form id="searchFrm" name="searchFrm">
	
	 학과&nbsp; <input type="text" name="deptname" id="deptname" size="20" style="margin: 10px 30px 0 0;" autocomplete="off" /> 
	<input type="text" style="display: none;"/> <%-- form 태그내에 input 태그가 오로지 1개 뿐일경우에는 엔터를 했을 경우 검색이 되어지므로 이것을 방지하고자 만든것이다. --%> 
	
	<div id="displayDeptlist" style="position:absolute; background-color:white; border:solid 1px gray; border-top:0px; height:100px; margin-left:45px; margin-top:-1px; overflow:auto;">
   	바이~
   </div>
	
	  학년&nbsp;<select name="grade" id="grade" style="height: 30px; width: 120px; margin: 10px 30px 0 0;">
         <option value="">학년선택</option>
         <option value="1">1</option>
         <option value="2">2</option>
         <option value="3">3</option>
         <option value="4">4</option>
        </select>
        
         학기&nbsp;<select name="semester" id="semester" style="height: 30px; width: 120px; margin: 10px 30px 0 0;">
         <option value="">학기선택</option>
         <option value="1">1</option>
         <option value="2">2</option>
        </select>
	
	<input type="hidden" id="opensemester" value=""/> 
	
	
         강의&nbsp;<select name="searchType" id="searchType" style="height: 26px;">
         <option value="classname">강의명</option>
         <option value="subjectid">강의코드</option>
      </select>
      <input type="text" name="searchWord" id="searchWord" size="20" autocomplete="off" /> 
      <input type="text" style="display: none;"/> <%-- form 태그내에 input 태그가 오로지 1개 뿐일경우에는 엔터를 했을 경우 검색이 되어지므로 이것을 방지하고자 만든것이다. --%> 
      <button type="button" class="btn btn-secondary btn-sm" onclick="goSearch()">검색</button>
   </form>
   
   <%-- === #106. 검색어 입력시 자동글 완성하기 1 --%>
   <div id="displayList" style="position:absolute; background-color:white; border:solid 1px gray; border-top:0px; height:100px; margin-left:790px; margin-top:-1px; overflow:auto;">
   	안녕~
   </div>
  </div>
   
	
	<button type="button" class="btn btn-secondary btn-sm mr-3" style="margin-left:1080px; margin-bottom:10px;" onclick="goApplylecture()">강의 신청하기</button>
   
	<table style="width: 1200px" class="table table-bordered">
		<thead>
		<tr>
			<th style="width: 70px;  text-align: center;">번호</th>
			<th style="width: 70px;  text-align: center;">학과</th>
			<th style="width: 70px;  text-align: center;">강의코드</th>
	        <th style="width: 160px; text-align: center;">강의명</th>
	        <th style="width: 70px;  text-align: center;">대상학년</th>
	        <th style="width: 70px; text-align: center;">이수학점</th>
	        <th style="width: 70px;  text-align: center;">정원</th>
	        <th style="width: 70px;  text-align: center;">강의실</th>
	        <th style="width: 70px;  text-align: center;">강의시간</th>
	        <th style="width: 100px;  text-align: center;">강의계획서</th>
	        <th style="width: 70px;  text-align: center;">신청상태</th>
		</tr>
		</thead>
		
		<tbody>
		<tr>
			<c:if test="${not empty requestScope.applylectureList}">
				<c:forEach var="mylecturevo" items="${requestScope.applylectureList}" varStatus="status">
				<tr>
					<td align="center">${mylecturevo.rno}</td>
					<td align="center">${mylecturevo.deptname}</td>
					<td align="center">${mylecturevo.subjectid}</td>
					<td align="left">
						<span class="subject" onclick="goView('${mylecturevo.subjectid}')">${mylecturevo.classname}</span>
					</td>

					<td align="center">
					<c:if test="${mylecturevo.opensemester eq '1' or mylecturevo.opensemester eq '2'}">1학년</c:if>
					<c:if test="${mylecturevo.opensemester eq '3' or mylecturevo.opensemester eq '4'}">2학년</c:if>
					<c:if test="${mylecturevo.opensemester eq '5' or mylecturevo.opensemester eq '6'}">3학년</c:if>
					<c:if test="${mylecturevo.opensemester eq '7' or mylecturevo.opensemester eq '8'}">4학년</c:if>				
					</td>
					<td align="center">${mylecturevo.credit}</td>
					
					<c:if test="${not empty mylecturevo.totalperson}">
					<td align="center">${mylecturevo.totalperson}</td>
					<td align="center">${mylecturevo.lctrid}</td>
					<td align="center">${mylecturevo.dayid}교시</td>
					</c:if>
					
					<c:if test="${empty mylecturevo.totalperson}">
						<td colspan='3'>
	                    <button type='button' class='btn btn-secondary btn-sm mr-3' onclick='goAssignroom("${mylecturevo.subjectid}","${mylecturevo.credit}")'>강의시간 및 강의실 배정하기</button>
	                    </td>
					</c:if>
					
					<c:if test="${not empty mylecturevo.seq_lectureplan}">
					<td align="center"><button type='button' class='btn btn-secondary btn-sm mr-3' onclick='goViewlecplan("${mylecturevo.subjectid}", "${mylecturevo.seq_lectureplan}")'>계획서 보기</button>
	                    </td>
					</c:if>
					<c:if test="${empty mylecturevo.seq_lectureplan}">
					<td align="center"><button type='button' class='btn btn-secondary btn-sm mr-3' onclick='goWritelecplan("${mylecturevo.subjectid}")'>계획서 쓰기</button>
	                    </td>
					</c:if>
					<td align="center">${mylecturevo.applystate}</td>
				</tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty requestScope.applylectureList}">
				<tr>
            		<td colspan="11" style="text-align: center;">신청 강의가 존재하지 않습니다</td>
            	</tr>
			</c:if>
		</tr>
		</tbody>
	</table>
	
	<%-- === #122. 페이지바 보여주기 === --%>
	<div align="center" style="border: solid 0px gray; width: 70%; margin: 20px auto;">
		${requestScope.pageBar}
	</div>
	
</div>	
   
</div>
