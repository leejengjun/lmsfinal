<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
    
<%
	String ctxPath = request.getContextPath();
	String gyowonid = String.valueOf(session.getAttribute("userid"));
	String subjectid = request.getParameter("subjectid");
	String seq_lectureplan = request.getParameter("seq_lectureplan");
%>    
<style type="text/css">
th {background-color: #DDD}
</style>

<script type="text/javascript">

  $(document).ready(function(){
	  
	  
      var subjectid = <%=subjectid%>;
	  
	  $.ajax({
   	   url: "<%= ctxPath%>/lctrplandetailSearch.lmsfinal",
   	   data: {"subjectid":<%=subjectid%>}, // data는 /MyMVC/member/isDuplicateCheck.up 로 전송해야할 데이터를 말한다.
   	   type: "POST", // type은 생략하면 "get"이다.
   	   dataType:"JSON",
   	   success: function(json){
   		   
   		  let html = "";
   		  
   		  
			  if(json.length > 0) {
				  $.each(json, function(index, item){
					  html += "<tr class='result'>";
					  html += "<td class='result'><input type='text' class='lectureweek' name='lectureweek' value='"+item.lectureweek+"'></td>";    	
					  html += "<td class='result'><input type='text' class='lptopic' name='lptopic' value='"+item.lptopic+"'></td>";    	
					  html += "<td class='result'><input type='text' class='lpteaching' name='lpteaching' value='"+item.lpteaching+"'/></td>";
					  html += "<td class='result'><input type='text' class='lpmaterial' name='lpmaterial' value='"+item.lpmaterial+"'/></td>";
					  html += "<td class='result'><input type='text' class='lphomewk' name='lphomewk' value='"+item.lphomewk+"'/></td>";
					  html += "</tr>";
				  });
			  }
			  else {
				  html += "<tr>";
				  html += "<td colspan='5' class='result'>주차별 강의계획이 없습니다.</td>";
				  html += "</tr>";
			  }
			    
			  $("tbody#lecplandetailshow").html(html);    
				 
   	   }, 
   	   error:function(request, status, error){
   		   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
   	   }

	});  
	
	  // 테이블 행 추가
	  
	  let html_2 = "";
	  
	  html_2 += "<tr>";
	  html_2 += "<td><input type='text' class='lectureweek' name='lectureweek' value=''/></td>";
	  html_2 += "<td><input type='text' class='lptopic' name='lptopic' value=''/></td>";
	  html_2 += "<td><input type='text' class='lpteaching' name='lpteaching' value=''/></td>";
	  html_2 += "<td><input type='text' class='lpmaterial' name='lpmaterial' value=''/></td>";
	  html_2 += "<td><input type='text' class='lphomewk' name='lphomewk' value=''/></td>";
	  html_2 += "</tr>";
	
	  $("button#btnAddrow").click(function(){
			$("table#plandetail > tbody:last").append(html_2);
		  });
	  
	  $("button#btnEditplan").click(function(){
		  const trGroup = Array.from(document.querySelectorAll('#lecplandetailshow tr'));
	      
	      const textGroup = trGroup.map(tr => {
	             
	            return Array.from(tr.querySelectorAll('input')).map(input => input.value);

	      });
	      
			 
	      var rowlength = $("tbody#lecplandetailshow tr").length;
	      
	      weekplanArr = [];
	            
	      for(i=0; i<rowlength; i++){      
	         weekplanArr.push({
	        	 lectureweek: textGroup[i][0]
	              ,lptopic: textGroup[i][1]
	              ,lpteaching: textGroup[i][2]
	              ,lpmaterial: textGroup[i][3]
	              ,lphomewk: textGroup[i][4]
	                });
	     }

		  console.log(weekplanArr);
		 var jsonData = JSON.stringify(weekplanArr); //json으로 parsing을 꼭해야한다.
			 
		  console.log(jsonData);
	 	
		// 제출하기
			const frm = document.editlectureplandetailFrm;
	 		frm.jsonData.value = jsonData;
	 		frm.method = "POST";
	 		frm.action = "editlectureplandetailEnd.lmsfinal";
	 		frm.submit();
	    
	  });
	 
	  
	  
	  
  });// end of $(document).ready(function(){})-------------------------------
 
  
</script>

<div style="display: flex; height:2000px;">
	<div style="margin: auto; padding-left: 3%; margin-top: 3%;">

<h5 style="margin-top: 50px; margin-bottom:30px;">▶ 주차별 강의계획서</h5>
	
	<form name="editlectureplandetailFrm">
	
	<table id="plandetail" style="width: 1024px; margin-top:30px;" class="table table-bordered">
      <thead>
         <tr><th colspan="5" style="text-align: center;">주차별 강의계획</th></tr>
         <tr><th style="text-align: center;">주</th>
            <th style="width: 23%;  text-align: center;">학습주제</th>
            <th style="width: 23%;  text-align: center;">수업방식</th>
            <th style="width: 23%;  text-align: center;">교수학습자료</th>
            <th style="width: 23%;  text-align: center;">과제</th></tr>
      </thead>
      <tbody id="lecplandetailshow">
      
      
      </tbody>
     </table>
	
	<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnAddrow">행추가</button>
       
	
	<div style="margin: 20px;">
		<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnEditplan">수정</button>	
		<button type="button" class="btn btn-secondary btn-sm" onclick="javascript:history.back()">뒤로</button>
	
		<input type="hidden" name="subjectid" value="<%=subjectid%>"/>
		<input type="hidden" name="gyowonid" value="<%=gyowonid%>"/>
		<input type="hidden" name="seq_lectureplan"  value="<%=seq_lectureplan%>"/>
		<input type="hidden" name="jsonData" value=""/>
	
	
	
	</div>
	
	</form>
	
</div>
</div>
		
		