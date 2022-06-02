<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  

<%
   String ctxPath = request.getContextPath();
  //       /lmsfinal
%>


<style type="text/css">
	
	td#goEvalue_lecture:hover{
		background-color: gray;
		cursor: pointer;
	}

</style>


<div style="display: flex;">
<div style="width: 70%; min-height: 2500px; margin:auto; ">

	<h3 style="margin: 50px 0;">성적조회</h3>
	
	<div id="appsemesterList">
		<p style="font-weight: bold; font-size: 15pt;">조회할 이수학기를 선택하세요!
		<select id="appsemesterList" style="width: 100px;">
		<c:forEach var="item" items="${appsemesterList}" varStatus="status">
			<c:if test="${status.index == 0}">
				<option  selected="selected" value="${item.appsemester}">${item.appsemester}학기</option>
			</c:if>
			<c:if test="${status.index > 0}">
				<option value="${item.appsemester}">${item.appsemester}학기</option>
			</c:if>
		</c:forEach>
		</select>
		</p>	
	</div>

	<div id="semester_grade"></div>

	<div style="border: solid 2px gray; margin-top: 100px;">
		<div style="margin: 20px 20px;">
			<h4>성적조회 안내사항</h4>
			<li style="font-weight: bold; color:red;">성적조회를 하시기 위해서는 반드시 "강의평가"를 먼저 하셔야 합니다.</li>
			<li>성적조회 기간에만 조회가 가능합니다.</li>
			<li>성적조회 기간이 지난 뒤에는 조회가 불가능합니다.</li>
			<li>성적에 미입력인 경우는 아직 해당과목 교수님이 성적을 입력중이신 경우로 입력이 완료되면 확인가능합니다.</li>
		</div>
	</div>

</div>
</div>


<script type="text/javascript">
	
	$(document).ready(function(){
	
		// 성적확인 페이지 로드시 최근 이수학기의 성적을 바로 보여준다.
		select_semester_grade();
		
		$("#appsemesterList").on("change", function(){ 
			select_semester_grade();
		});

		
		
	});
	
	function goEvalue_lecture(){
		alert("강의평가페이지로 이동합니다.");
		location.href="<%= ctxPath%>/lecture_evaluation.lmsfinal"
	}
	
	function select_semester_grade(){
		const latest_semester = $("select#appsemesterList").val();
	//	alert("확인용 latest_semester => "+latest_semester);
	
		$.ajax({
			url:"<%= ctxPath%>/getGrade.lmsfinal",
			type:"post",
			data:{"latest_semester":latest_semester},
			dataType:"JSON",
			success:function(json){
				
				let html = "<table class='table table-bordered'>";
				html += "<tr style='text-align:center;'>" +
							"<th>이수학기</th>" +
							"<th>과목명</th>" +
							"<th>이수구분</th>" +
							"<th>학점</th>" +
							"<th>등급</th>" +
						"</tr>";
			
				$.each(json, function(index, item){
					html += "<tr id='gradeList' style='text-align:center;'>";
					if(item.evaluwhether == '0'){	// 강의평가가 완료되지 않았다면
						html += "<td id='goEvalue_lecture' onclick='goEvalue_lecture()' colspan='6' style='text-align:center; color:red; font-weight: bold; '>'"+
						item.classname+"' 강의평가를 먼저 하셔야 성적확인이 가능합니다.</td>";
					}	
					else{
						html += "<td>" + item.appsemester +"</td>" +
								"<td>" + item.classname +"</td>" +
								"<td>" + item.courseclfc +"</td>" +
								"<td>" + item.credit +"</td>"+
								"<td><p id='grade'>"+item.grade+"</p><input type='hidden' name='courseno' id='courseno' class='courseno' value='"+item.courseno+"' /></td>" +
							"</tr>";
					}
				});
			
			html += "</table>";
			
			$("div#semester_grade").html(html);
				
			},
			error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		}); //  end of $.ajax({------------------
	}// end of function select_semester_grade(){-------------------

</script>















