<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%
    String ctxPath = request.getContextPath(); 
%>

   <style type="text/css">

	table#tblstudentRegister {   
	   
	    margin: auto;      
	   
	}  
	   
	table#tblstudentRegister #th {
	    height: 150px;
	    text-align: center;
	    font-size: 14pt;      
	}
	   
	table#tblstudentRegister td {
	    line-height: 30px;
	    padding-top: 8px;
	    padding-bottom: 8px;      
	}
	   
	.btnSubmit {
	    background: #fff;
	    color: #000;
	    width: 230px;
	    height: 40px;
	    line-height: 40px;
	    font-size: 16px;
	    font-weight: 600;
	    border-radius: 0;
	    padding: 50;
	    cursor: pointer;
	    border: 2px solid #000;
	 } 
	 
	 .memberbox form{
	    margin:60px;
	    width: 100%; height: 930px;
	    background-color: #fff;
	    border: 3px solid #000033;
	    padding: 20px; 
	    width: 800px;
	    box-sizing: border-box;
	     border-radius: 40px;
	 
	}
	
	table#tblstudentRegister input {
	  border-radius: 5px;
	}
	

	
        
   </style>

   <script type="text/javascript">
   
   // 중복확인 여부 확인
    let b_flagStdIdDuplicatClick = false;
    let b_flagStdEmailDuplicatClick = false;

 
     $(document).ready(function(){
    	 
    	 $("span.error").hide();
    	  
    	 $("button#btnRegister").click(function(){
    		 func_StudentRegister()
    	  });
    	 
    	 
////### 학번 ###////  	  
    	  
    	  $("input#stdid").blur(function(){
    		  
       		const $target = $(event.target);
       		const stdid = $target.val().trim();
       		
       		
       		if(stdid == "" || stdid.length != 9) {    
       		    
       			  $("table#tblstudentRegister :input").prop("disabled", true);     
       			  $target.prop("disabled", false);
       			
       			  $target.parent().find(".error").show();
       			  
       			  $target.focus();
       		}
       		else {
       			  
       			  $("table#tblstudentRegister :input").prop("disabled", false); 
         	      $target.parent().find(".error").hide();
       		  }    		   
       	   }); 
       	    	
       	
////### 비밀번호 ###////  

       	   $("input#stdpwd").blur(function(){
       		  
   		     const $target = $(event.target);
   		     const stdpwd = $target.val().trim();
   	        
	   		 if(stdpwd == "") {     
	   			  $("table#tblstudentRegister :input").prop("disabled", true);     
	   			  $target.prop("disabled", false);
	   			
	   			  $target.parent().find(".error").show();
	   			  
	   			  $target.focus();
	   		 }
	   		 else {
	   			  
	   			  $("table#tblstudentRegister :input").prop("disabled", false); 
	     	      $target.parent().find(".error").hide();
	   		  }    		   
   	   }); 
   	    	

////### 이름 ###////
   
    	   $("input#stdname").blur(function(){
    		  
    		 const $target = $(event.target);
    		 const stdname = $target.val().trim();
    		 if(stdname == "") {
    			  $("table#tblstudentRegister :input").prop("disabled", true); 
    			  $target.prop("disabled", false);
    		
    			  $target.parent().find(".error").show();
    			  
    			  $target.focus();
    		 }
    		 else {
    			    
    			  $("table#tblstudentRegister :input").prop("disabled", false); 
    			
      			  $target.parent().find(".error").hide();
    		 }
    	}); 
 



///// #####주민번호 ###////

      	   $("input#stdjumin").blur(function(){
      		  
      		  const $target = $(event.target);
      	 
  	          const regExp = new RegExp(/[0-9]{2}(0[1-9]|1[0-2])(0[1-9]|[1,2][0-9]|3[0,1])/);  
  	       
      		  const bool = regExp.test($target.val());       
	      	 
      		  if(!bool) {
      			
      			  $("table#tblstudentRegister :input").prop("disabled", true);    
      			  $target.prop("disabled", false);
      			
      			  $target.parent().find(".error").show();
      			  
      			  $target.focus();
      		  }
      		  else {
      			
      			  $("table#tblstudentRegister :input").prop("disabled", false); 
      			
        			 $target.parent().find(".error").hide();
      		  }
      		    		   
      	   }); 
      		
      		
      		
//// #####생년월일 ###////

      	 	  $("input#datepicker").datepicker({
              dateFormat: 'yy-mm-dd'  
             ,showOtherMonths: true   
             ,showMonthAfterYear:true 
             ,changeYear: true       
             ,changeMonth: true                  
             ,showOn: "both"        
             ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" 
             ,buttonImageOnly: true 
             ,buttonText: "선택"               
             ,yearSuffix: "년"       
             ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] 
             ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] 
             ,dayNamesMin: ['일','월','화','수','목','금','토'] 
             ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] 
      	 	 ,minDate: '-100y' 
      	     ,yearRange: 'c-100:c+10'
                  
         });                    
         
		$('input#datepicker').datepicker('setDate', 'today');    
      	
      	
	    	  
////### 이메일 ###////
  
      	   $("input#stdemail").blur(function(){
      		  
      		 const $target = $(event.target);
      		    
      		 // 이메일 정규표현식 
  	         const regExp = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i); 
  	   
      	 	 const bool = regExp.test($target.val());      
      	 
      		 if(!bool) {  
      			 
   			   $("table#tblstudentRegister :input").prop("disabled", true);     
   			   $target.prop("disabled", false);
   		
   			   $target.parent().find(".error").show();
   			   $target.parent().find(".stdemailCheckimg").hide();
   		  	   $target.focus();
      		  }
      		else {
      			
      		   $("table#tblstudentRegister :input").prop("disabled", false); 
      			
   			   $target.parent().find(".error").hide();
   			   $target.parent().find(".stdemailCheckimg").show();
      		  }
      		    		   
      	   }); 
     
///###연락처 #####///

      	   $("input#stdmobile").blur(function(){
      		  
      		 const $target = $(event.target);
  	         const regExp = new RegExp(/^01[0-1, 7][0-9]{7,8}$/); 
  	   
      	 	 const bool = regExp.test($target.val());      
      	 
      		 if(!bool) {  
      			 
   			   $("table#tblstudentRegister :input").prop("disabled", true);     
   			   $target.prop("disabled", false);
   		
   			   $target.parent().find(".error").show();
   		  	   $target.focus();
      		  }
      		else {
      			
      		   $("table#tblstudentRegister :input").prop("disabled", false); 
      			
   			   $target.parent().find(".error").hide();
      		  }
      		    		   
      	   }); 
     


////### 학과코드  ###////


	  $("input#stdmajorid").click(function(){
		  $('#deptSearch').modal('show');  // 모달창 보여주기	
	  });
	  
	  // === 학과찾기
      $("input#searchWord").keyup(function(event){
  		if(event.keyCode == 13){
  			// 엔터를 했을 경우
  			goDpSearch();
  		}
  	  });
       
	  
      // === 검색 결과에 따라 학과 코드 넣어주기
  	 
  	 $(document).on("click", "div.sResult", function(){	  
  		 
  		  const stdmajorid = $(this).find("span#stdmajorid").text();
  		  
  	   	  $("input#stdmajorid").val(stdmajorid);
   		  $('#deptSearch').modal('hide');

  	});



   		  
////### 교원번호   ###////


 	  $("input#gyowonid").click(function(){
 		  $('#gyowonSearch').modal('show');   // 모달창 보여주기	    
 	  });
 		  
 		  
 	 // === 학과찾기
       $("input#searchWord_1").keyup(function(event){
   		if(event.keyCode == 13){
   			// 엔터를 했을 경우
   			goGySearch();
   		}
   	  });
        
 	  
    // === 검색 결과에 따라 교원번호 넣어주기
   	 
   	 $(document).on("click", "div.gResult", function(){	  
   		
   		  const gyowonid = $(this).find("span#gyowonid").text();
   	   	  $("input#gyowonid").val(gyowonid); 
    	  $('#gyowonSearch').modal('hide');

   	});

   

////### 입학전형  ###////

     	 $('#selectEnttype').change(function() {
             if ($('#selectEnttype').val() == 'directly') {
                 $('#enttype').attr("disabled", false);
                 $('#enttype').val("");
                 $('#enttype').focus();
             } else {
                 $('#enttype').val($('#selectEnttype').val());
             }
         });


////### 입학구분  ###////

     	 $('#selectEntstate').change(function() {
             if ($('#selectEntstate').val() == 'directly') {
                 $('#entstate').attr("disabled", false);
                 $('#entstate').val("");
                 $('#entstate').focus();
             } else {
                 $('#entstate').val($('#selectEntstate').val());
             }
         });
      
         
//// #####입학일자 ###////

     	  $("input#datepicker1").datepicker({
              dateFormat: 'yy-mm-dd' 
             ,showOtherMonths: true  
             ,showMonthAfterYear:true 
             ,changeYear: true      
             ,changeMonth: true         
             ,showOn: "both"        
             ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" 
             ,buttonImageOnly: true  
             ,buttonText: "선택"               
             ,yearSuffix: "년"        
             ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] 
             ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
             ,dayNamesMin: ['일','월','화','수','목','금','토']
             ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] 
     	     ,minDate: '-100y' 
      	     ,yearRange: 'c-70:c+70'
                 
         });                    
      
		 $('input#datepicker1').datepicker('setDate', 'today');    
    

// ## 학번중복검사 하기 ## ///

       $("button#stdidcheck").click(function(){
          	 
        	 b_flagStdIdDuplicatClick = true; 
        
             $.ajax({
          		url:"<%= ctxPath%>/stdidDuplicateCheck.lmsfinal",
          		data:{"stdid":$("input#stdid").val()}, 
          		type:"post",  
          	 	success:function(data){
          	 		if(data == 1) {
                        alert("중복된 학번입니다.");
                    } else if (data == 0) {
                   
                        alert("사용 가능한 학번입니다.")
                    }
          	 	}
             });
           	
       }); 		
          		
           
           $("input#stdid").bind("change", function(){
        	   b_flagStdIdDuplicatClick = false;
           });
       
           $("input#stdemail").bind("change", function(){
          	 b_flagStdEmailDuplicatClick = false;
           });
    
       }); //end of $(document).ready(function() ----------------------------	                  
  
       
       
 //## 이메일 중복여부 검사하기 ##//
    function isExistStdEmailCheck() {
  	  
    	b_flagStdEmailDuplicatClick = true;
  	 
    	 $.ajax({
    		url:"<%= ctxPath%>/stdemailDuplicateCheck.lmsfinal",
    		data:{"stdemail":$("input#stdemail").val()},   
    		type:"post",   
    		dataType:"json",       
    		success : function (data) {
                    if(data == 1) {
                        alert("중복된 이메일입니다.");
                    } else if (data == 0) {
                        alert("사용 가능한 이메일입니다.")
                    }
                }	
    	    });	
    	 };	
    	 
    	 
 /////// 학과 찾기 ////////    	 
    	  function goDpSearch(){
    		  	 $.ajax({
    				  url:"<%= ctxPath%>/stdDeptlist.lmsfinal",
    				  data:{"searchType":$("select#searchType").val()
    					  	, "searchWord":$("input#searchWord").val()},  	
    				  dataType:"JSON",
    				  success:function(json){ 
    					  
    					  let html = "";
    					  if(json.length > 0) {
    						  $.each(json, function(index, item){
    							  html += "<div class='sResult' id='index' style='cursor:pointer;'>";
    							  html += "<span id='stdmajorid' style='color:#3333ff'>"+item.majorid+"</span>&nbsp;";
    							  html += "<span id='deptname'>"+item.deptname+"</span>";
    							  html += "</div>";
    						  });
    					  }
    					  else {
    						 alert("해당하는 학과가 없습니다. 다시 입력하세요.");
    					  }
    					  
    					  $("div#div_searchResult").html(html);
    				  },
    				  error: function(request, status, error){
    						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
    				  }
    			  });
    		  }// end of function goDpSearch(){}-----------------
    		  
    		  
    		  
    
 /////// 교원찾기 ////////
 
   function goGySearch(){
    		  	 $.ajax({
    				  url:"<%= ctxPath%>/stdGyowonlist.lmsfinal",
    				  data:{"searchType_1":$("select#searchType_1").val()
    					  	, "searchWord_1":$("input#searchWord_1").val()},  	
    				  dataType:"JSON",
    				  success:function(json){ 
    					  
    					  let html = ""; 
    					  if(json.length > 0) {
    						  $.each(json, function(index, item){
    							  html += "<div class='gResult' id='index' style='cursor:pointer;'>"
    								  html += "<span id='majorid' style='color:#3333ff'>"+item.majorid+"</span>&nbsp;"
    								  html += "<span id='deptname'>"+item.deptname+"</span>&nbsp;"
    								  html += "<span id='gyowonid' style='color:#3333ff'>"+item.gyowonid+"</span>&nbsp;"
    								  html += "<span id='gyoname'>"+item.gyoname+"</span>";
    								  html += "</div>";
    						  });
    					  }
    					  else {
    						  alert("해당하는 교원이 없습니다. 다시 입력하세요.");
    					  }// end of else ---------------------
    					  
    					  $("div#div_GySearchResult").html(html);
    				  },
    				  error: function(request, status, error){
    						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
    				  }
    			  });
    		  }// end of  function goGySearch(){}-----------------
   	  	  
    		  
    		  
//////////## 등록하기 ##//////////

  function func_StudentRegister() {
    	   
	   
// ### 항목 전부 입력이 되었는지 검사한다. ###//
	   let b_FlagRequirededInfo = false;
	   
	    $("input.requiredInfo").each(function(index, item){
	    	const data = $(item).val().trim();  
	    	if(data == "") {
	    		alert("항목 전부 입력하셔야합니다.");
	    		b_FlagRequirededInfo = true;
	    		return false;     
	    	}
	    });
	   
	    if(b_FlagRequirededInfo) {
	    	return;   
	    }
	    
////### 학적상태코드  ###////
	   
	  const stdstateidCheckedLength = $("input:radio[name='stdstateid']:checked").length;
	   
	  if(stdstateidCheckedLength == 0) {
		   alert("학적상태를 체크하세요");
		   return; 
	   }
	   
  
// 학번 중복확인 여부
    	   
	    	if(!b_flagStdIdDuplicatClick) {
	    		alert("학번중복확인 클릭하여 중복 여부를 확인하세요");
	    		return; 
	       }
    	    
// 이메일 중복확인 여부
		    if(!b_flagStdEmailDuplicatClick) {
			   	 alert("이메일중복확인 클릭하여 중복 여부를 확인하세요");
			   	 return; 
		   } 
	   	  
   	  const frm = document.studentregisterFrm;
	   	  frm.action = "<%= ctxPath%>/stdRegisterEnd.lmsfinal";
	   	  frm.method = "post";
	   	  frm.submit(); 
    	   
   } //end of function func_StudentRegister()
         	
 
  </script>



   <div style="display: flex; align-items: center; justify-content: center; ">
      <div class="memberbox">
		    <div class="col-md-7 " id="divstudentRegisterFrm"> 
              <form name="studentregisterFrm" >
              
		       <h2 style="text-align:center;  padding:15px; font-weight:bolder;">학생 등록</h2>
			     <table id="tblstudentRegister" >
			 
			      <tbody>
			      <tr>
			         <td style="width: 20%; font-weight: bold;">학번</td>
			         <td style="width: 80%; text-align: left;">
			             <input type="text" name="stdid" id="stdid" class="requiredInfo" />&nbsp;&nbsp;
			             <button type="button" id="stdidcheck" style="vertical-align: middle; width: 80px; height: 30px; line-height: 15px; border-radius: 5px;  background-color: #00001a; color: white; font-size: 10pt;">학번 조회</button>
			             <span id="stdidcheckResult"></span>
			             <span class="error"><br>학번은 9자리 숫자로 입력하세요.</span> 
			            
			         </td> 
			      </tr>
			       <tr>
			         <td style="width: 20%; font-weight: bold;">비밀번호</td>
			         <td style="width: 80%; text-align: left;"><input type="text" name="stdpwd" id="stdpwd" class="requiredInfo" />
			            <span class="error"><br>비밀번호는 필수입력 사항입니다.</span>
			         </td>
			      </tr>
			      
			      <tr>
			         <td style="width: 20%; font-weight: bold;">이름</td>
			         <td style="width: 80%; text-align: left;">
			             <input type="text" name="stdname" id="stdname" class="requiredInfo" /> 
			             <span class="error"><br>이름은 필수입력 사항입니다.</span>
			         </td>
			      </tr>
			       <tr>
			         <td style="width: 20%; font-weight: bold;">주민등록번호</td>
			         <td style="width: 80%; text-align: left;">
			             <input type="text" id="stdjumin" name="stdjumin" class="requiredInfo" size="25" maxlength="13" placeholder=" '-'을 제외하고 기입하시오."/>
			             <span class="error">주민등록번호 형식이 아닙니다.</span>
			         </td>
			      </tr>
			       <tr>
			         <td style="width: 20%; font-weight: bold;">생년월일</td>
			         <td style="width: 80%; text-align: left;">
			            <input type="text" id="datepicker" name="stdbirthday" class="requiredInfo">
	         		</td>
	      		  </tr>
			      <tr>
			         <td style="width: 20%; font-weight: bold;">이메일</td>
			         <td style="width: 80%; text-align: left;"><input type="text" name="stdemail" id="stdemail" class="requiredInfo" placeholder="abc@def.com" /> 
			             <span class="error"><br>이메일 형식에 맞지 않습니다.</span>
			             <span class="stdemailCheckimg" style="display: inline-block; width: 80px; height: 30px;  background-color: #00001a; color: white; border: solid 1px gray; border-radius: 5px; font-size: 8pt; text-align: center; margin-left: 10px; cursor: pointer;" onclick="isExistStdEmailCheck();">이메일중복확인</span> 
			             <span id="stdemailCheckResult"></span>
			         </td>
			      </tr>
			    <tr>
			         <td style="width: 20%; font-weight: bold;">연락처</td>
			         <td style="width: 80%; text-align: left;"><input type="text" name="stdmobile" id="stdmobile" class="requiredInfo" maxlength="11" placeholder="예)01012345678" /> 
			             <span class="error"><br>연락처 형식에 맞지 않습니다.</span>
			         </td>
			      </tr>

				<tr>
				<th style="width: 20%; font-weight: bold;">학과코드</th> 
				<td> 
		            <input type="text" id="stdmajorid" name="stdmajorid" size="20" placeholder="학과코드" class="requiredInfo" value=""/>
		            <button type="button" id="deptSearch" class="btn btn-secondary btn-sm mr-3" data-toggle="modal" data-target="#deptSearch" style="background-color: #00001a; color: white;">
			                  학과찾기
			        </button>
		          
		            
	            </td>
	            
	            <!-- *** 학과,학과코드 찾기 Modal ***** -->
					<div class="modal fade" id="deptSearch" data-backdrop="static">
				  	 <div class="modal-dialog">
	                  <div class="modal-content">
				      
				      <!-- Modal header -->
				     <div class="modal-header">
	                  <h4 class="modal-title">학과 찾기</h4>
	                  <button type="button" class="close myclose" data-dismiss="modal">&times;</button>
	                 </div>
				     
			
				      <!-- Modal body -->
				      <div class="modal-body">
				        <div id="deptnameSearch">
				          <form name="searchFrm" style="margin-top: 20px;">
					      <select name="searchType" id="searchType" style="height: 26px;">
					         <option value="majorid">학과코드</option>
					         <option value="deptname">학과명</option>
					      </select>
					      <input type="text" name="searchWord" id="searchWord" size="35" autocomplete="off" /> 
					      <input type="text" style="border: none; display: none;"/> 
					      <button type="button" class="btn btn-secondary btn-sm"  style="background-color: #00001a; color: white;" onclick="goDpSearch()">조회</button>
					    </form>   
					   </div>
					
					   	<div class="my-3" id="div_searchResult"></div> 
					
					
				      <!-- Modal footer -->
				      <div class="modal-footer">
				        <button type="button" class="btn btn-danger myclose" data-dismiss="modal">Close</button>
				      </div>
				     </div>
				    </div>
				  </div>
				</div>
			</tr>

            <tr>
			<th style="width: 20%; font-weight: bold;">교원번호</th> 
			<td> 
	            <input type="text" id="gyowonid" name="gyowonid" size="20" placeholder="교원번호" class="requiredInfo" value=""/>
	            <button type="button" id="gyowonSearch" class="btn btn-secondary btn-sm mr-3" data-toggle="modal" data-target="#gyowonSearch" style="background-color: #00001a; color: white;">
		                 교원찾기
		        </button>
            </td>
            <!-- *** 학과,학과코드 찾기 Modal ***** -->
				<div class="modal fade" id="gyowonSearch">
			  	 <div class="modal-dialog ">
                  <div class="modal-content">
			      
			      <!-- Modal header -->
			     <div class="modal-header">
                  <h4 class="modal-title">교원 찾기</h4>
                  <button type="button" class="close myclose" data-dismiss="modal">&times;</button>
                 </div>
			     
		
			      <!-- Modal body -->
			      <div class="modal-body">
			        <div id="gyowonidSearch">
				      <select name="searchType_1" id="searchType_1" style="height: 26px;">
				         <option value="gyowonid">교원번호</option>
				         <option value="majorid">학과코드</option>
				         <option value="deptname">학과명</option>
				      </select>
				      <input type="text" name="searchWord_1" id="searchWord_1" size="35" autocomplete="off" /> 
				      <input type="text" style="display: none;"/> 
				      <button type="button" class="btn btn-secondary btn-sm"  style="background-color: #00001a; color: white;" onclick="goGySearch()">조회</button>
				   </div>
				
				   	<div class="my-3" id="div_GySearchResult"></div> 
					
			      <!-- Modal footer -->
			      <div class="modal-footer">
			        <button type="button" class="btn btn-danger myclose" data-dismiss="modal">Close</button>
			      </div>
			     </div>
			    </div>
			  </div>
			</div>
		</tr>

			       <tr>
			         <td style="width: 20%; font-weight: bold;">입학전형</td>
			         <td style="width: 80%; text-align: left;">
			             <input type="text" name="enttype" id="enttype" class="requiredInfo" /> 
			             <select id="selectEnttype">
			              <option value="" disabled selected>입학전형 선택</option>
			              <option value="정시" id="정시">정시</option>
			              <option value="수시" id="수시">수시</option>
			               <option value="재외국민" id="재외국민">재외국민</option>
        			    </select>
			             <span class="error"><br>입학전형은 필수입력 사항입니다.</span>
			         </td>
			      </tr>
			       <tr>
			         <td style="width: 20%; font-weight: bold;">입학구분</td>
			         <td style="width: 80%; text-align: left;">
			             <input type="text" name="entstate" id="entstate" class="requiredInfo" /> 
			             <select id="selectEntstate">
			              <option value="" disabled selected>입학구분 선택</option>
			              <option value="신입학" id="신입학">신입학</option>
			              <option value="편입학" id="편입학">편입학</option>
        			    </select>
			             <span class="error"><br>입학구분은 필수입력 사항입니다.</span>
			         </td>
			      </tr>
		         
			      <tr>
			         <td style="width: 20%; font-weight: bold;">입학일자</td>
			         <td style="width: 80%; text-align: left;">
			            <input type="text" id="datepicker1" name="entday" class="requiredInfo">
	         		</td>
	      		  </tr>
			      <tr>
			         <td style="width: 20%; font-weight: bold;">학적상태</td>
			         <td style="width: 80%; text-align: left;">
			             <input type="radio" name="stdstateid" id="Attending" value="1" class="requiredInfo"  /><label for="Attending">재학</label> 
			        </td>
			      </tr>
		        <tr>
		            <td colspan="2" style="line-height: 50px;" class="text-center">
		             <button type="button" id="btnRegister" class="btnSubmit btn-outline-dark btn-sm mr-3"  style="position: relative; top: 15px; border-radius: 10px;">가입하기</button> 
				    </td>
				</tr>
			  </tbody>
			 </table>
		   </form>  
		</div>	      
   </div>
</div>