<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
    
<%
	String ctxPath = request.getContextPath();
	String gyowonid = String.valueOf(session.getAttribute("userid"));
	String subjectid = request.getParameter("subjectid");
	String seq_lectureplan = String.valueOf(session.getAttribute("seq_lectureplan"));
%>    
<style type="text/css">
th {background-color: #DDD}
textarea {width: 100%; height: 100px;}
</style>

<script type="text/javascript">

  $(document).ready(function(){
	  
	  let html = "";
	  
	  html += "<tr>";
	  html += "<td><input type='text' class='lectureweek' name='lectureweek' value=''/></td>";
	  html += "<td><input type='text' class='lptopic' name='lptopic' value=''/></td>";
	  html += "<td><input type='text' class='lpteaching' name='lpteaching' value=''/></td>";
	  html += "<td><input type='text' class='lpmaterial' name='lpmaterial' value=''/></td>";
	  html += "<td><input type='text' class='lphomewk' name='lphomewk' value=''/></td>";
	  html += "</tr>";
	  
	  // 테이블 행 추가
	  $("button#btnAddrow").click(function(){
		$("table#plandetail > tbody:last").append(html);
	  });
	    
	  
	  // === 제출하기
	  $("button#btnWrite").click(function(){		  
		  const trGroup = Array.from(document.querySelectorAll('#lecplandetail tr'));
	      
	      const textGroup = trGroup.map(tr => {
	             
	            return Array.from(tr.querySelectorAll('input')).map(input => input.value);

	      });
	      
			 
	      var rowlength = $("tbody#lecplandetail tr").length;
	      
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

		 // console.log(weekplanArr);
		 var jsonData = JSON.stringify(weekplanArr); //json으로 parsing을 꼭해야한다.
			 
		 // console.log(jsonData);
     	
		
           
     	// 제출하기
		const frm = document.addlectureplandetailFrm;
 		frm.jsonData.value = jsonData;
 		frm.method = "POST";
 		frm.action = "addlectureplandetailEnd.lmsfinal";
 		frm.submit();
     		

	  }); // end of $("button#btnWrite"
	  
	  
  });// end of $(document).ready(function(){})-------------------------------
 
  
</script>

<div style="display: flex; height:1400px;">
	<div style="margin: auto; padding-left: 3%; margin-top: 3%;">

	<h3 style="margin-bottom:30px;">강의계획서</h3>
	
	<form name="addlectureplandetailFrm">
	  
	<table id="plandetail" style="width: 1024px; margin-top:30px;" class="table table-bordered">
      <thead>
         <tr><th colspan="5" style="text-align: center;">주차별 강의계획</th></tr>
         <tr><th style="text-align: center;">주</th>
            <th style="width: 23%;  text-align: center;">학습주제</th>
            <th style="width: 23%;  text-align: center;">수업방식</th>
            <th style="width: 23%;  text-align: center;">교수학습자료</th>
            <th style="width: 23%;  text-align: center;">과제</th></tr>
      </thead>
      <tbody id="lecplandetail">
       <tr>
            <td><input type="text" class='lectureweek' name="lectureweek" value=""></td>
            <td><input type='text' class='lptopic' name="lptopic" value=""/></td>
            <td><input type='text' class='lpteaching' name="lpteaching" value=""/></td>
            <td><input type='text' class='lpmaterial' name="lpmaterial" value=""/></td>
            <td><input type='text' class='lphomewk' name="lphomewk" value=""/></td>
          </tr>       
		
      </tbody>   

   </table>
   
   
	<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnAddrow">행추가</button>
          
	
	<div style="margin: 20px;">
		<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnWrite">작성완료</button>
		<button type="button" class="btn btn-secondary btn-sm" onclick="javascript:history.back()">취소</button>
		
		<input type="hidden" name="subjectid" value="<%=subjectid%>"/>
		<input type="hidden" name="gyowonid" value="<%=gyowonid%>"/>
		<input type="hidden" name="seq_lectureplan"  value="${seq_lectureplan}" />
		<input type="hidden" name="jsonData" value=""/>

	</div>
	
	</form>
	
</div>
</div>
		
		
		