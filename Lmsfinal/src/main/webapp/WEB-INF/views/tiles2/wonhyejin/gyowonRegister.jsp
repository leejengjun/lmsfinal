<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%
    String ctxPath = request.getContextPath();
%>

   <style type="text/css">

	
	table#tblgyowonRegister {   
	   margin: auto;         
	   
	}  
	   
	table#tblgyowonRegister #th {
	     height: 150px;
	    text-align: center;
	    background-color: silver;
	    font-size: 14pt;      
	}
	   
	table#tblgyowonRegister td {
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
	    width: 100%; height: 800px;
	    background-color: #fff;
	    border: 3px solid #000033;
	    padding: 20px; 
	    width: 800px;
	    box-sizing: border-box;
	     border-radius: 40px;
	}
	
	table#tblgyowonRegister input {
	  border-radius: 5px;
	}
   </style>
   

   <script type="text/javascript">
  
   // 중복확인검사확인
    let b_flagGyowonIdDuplicatClick = false;
    let b_flagGyoEmailDuplicatClick = false;
   
 
     $(document).ready(function(){
    	  
    	 $("button#btnRegister").click(function(){
    		 func_GyowonRegister()
    	  });
    	  
    	 $("span.error").hide();
    
    	   
////### 교원번호 ###////  	  
    	  
    	  $("input#gyowonid").blur(function(){
    		  
       		const $target = $(event.target);
       		const gyowonid = $target.val().trim();
       		
       		if(gyowonid == "" || gyowonid.length != 5) {    
       		     
       			  $("table#tblgyowonRegister :input").prop("disabled", true);     
       			  $target.prop("disabled", false);
       			
       			  $target.parent().find(".error").show();
       			  
       			  $target.focus();
       		 }
       		 else {
       			  
       			  $("table#tblgyowonRegister :input").prop("disabled", false); 
         	      $target.parent().find(".error").hide();
       		  }    		   
       	   }); 
       	    	
       	
////### 비밀번호 ###////  

       	   $("input#gyopwd").blur(function(){
       		  
   		     const $target = $(event.target);
   		     const gyopwd = $target.val().trim();
   	        
   		     if(gyopwd == "") {    
   			    $("table#tblgyowonRegister :input").prop("disabled", true);     
   			    $target.prop("disabled", false);
   			
   			    $target.parent().find(".error").show();
   			  
   			    $target.focus();
   		     }
   		     else {
   			  
   			    $("table#tblgyowonRegister :input").prop("disabled", false); 
     	        $target.parent().find(".error").hide();
   		     }    		   
   	      }); 
   	    	
        	

////### 이름 ###////
   
    	   $("input#gyoname").blur(function(){
    		  
    		 const $target = $(event.target);
    		 const gyoname = $target.val().trim();
    		 
    		 if(gyoname == "") {
    			  $("table#tblgyowonRegister :input").prop("disabled", true); 
    			  $target.prop("disabled", false);
    		
    			  $target.parent().find(".error").show();
    			  
    			  $target.focus();
    		 }
    		 else {
    			    
    			  $("table#tblgyowonRegister :input").prop("disabled", false); 
    			
      			  $target.parent().find(".error").hide();
    		 }
    	}); 
    	
    	
///// #####주민번호 ###////

      	   $("input#gyojumin").blur(function(){
      		  
      		  const $target = $(event.target);
      	 
  	          const regExp = new RegExp(/^(?:[0-9]{2}(?:0[1-9]|1[0-2])(?:0[1-9]|[1,2][0-9]|3[0,1]))-[1-4][0-9]{6}$/);  //정규표현식
  	       
      		  const bool = regExp.test($target.val());       
	      	 
      		  if(!bool) {
      			
      			  $("table#tblgyowonRegister :input").prop("disabled", true);    
      			  $target.prop("disabled", false);
      			
      			  $target.parent().find(".error").show();
      			  
      			  $target.focus();
      		  }
      		  else {
      			
      			  $("table#tblgyowonRegister :input").prop("disabled", false); 
      			
        			 $target.parent().find(".error").hide();
      		  }
      		    		   
      	   }); 
      		
      		 
//// #####생년월일 ###////

   	 	  $("input#datepicker3").datepicker({
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
      
		  $('input#datepicker3').datepicker('setDate', 'today');    
   	
	    	  
////### 이메일 ###////
  
      	  $("input#gyoemail").blur(function(){
      		  
      		 const $target = $(event.target);
      		    
      		 // 이메일 정규표현식 
  	         const regExp = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i); 
  	   
      	 	 const bool = regExp.test($target.val());      
      	 
      		 if(!bool) {  
      			 
   			   $("table#tblgyowonRegister :input").prop("disabled", true);     
   			   $target.prop("disabled", false);
   		
   			   $target.parent().find(".error").show();
   			   $target.parent().find(".gyoemailCheckimg").hide();
   		  	   $target.focus();
      		  }
      		 else {
      			
      		   $("table#tblgyowonRegister :input").prop("disabled", false); 
      			
   			   $target.parent().find(".error").hide();
   			   $target.parent().find(".gyoemailCheckimg").show();
      		  }
      		    		   
      	   }); 
      	   
      	   
///###연락처 #####///

      	  $("input#gyomobile").blur(function(){
      		  
      		 const $target = $(event.target);
  	         const regExp = new RegExp( /^\d{3}-\d{3,4}-\d{4}$/); 
  	   
      	 	 const bool = regExp.test($target.val());      
      	 
      		 if(!bool) {  
      			 
   			   $("table#tblgyowonRegister :input").prop("disabled", true);     
   			   $target.prop("disabled", false);
   		
   			   $target.parent().find(".error").show();
   		  	   $target.focus();
      		  }
      		 else {
      			
      		   $("table#tblgyowonRegister :input").prop("disabled", false); 
      			
   			   $target.parent().find(".error").hide();
      		  }
      		    		   
      	   }); 
     
  	   
////### 학과코드  ###////

      		  $("input#gyomajorid").click(function(){
      			  $('#deptSearch1').modal('show'); // 모달창 보여주기	
      		  });
      	
      		  // === 학과찾기
      	      $("input#searchWord1").keyup(function(event){
      	  		if(event.keyCode == 13){
      	  			// 엔터를 했을 경우
      	  			goDpSearch1();
      	  		}
      	  	  });
      	       
      		  
      	// === 검색 결과에 따라 교원번호 넣어주기
      	  	 
      	  	 $(document).on("click", "div.sResult1", function(){	  
      	  		
      	  		  const gyomajorid = $(this).find("span#gyomajorid").text();
      	  		
      	  	   	  $("input#gyomajorid").val(gyomajorid); 
      	  	   	 
      	   		  $('#deptSearch1').modal('hide');

      	  	  });

   	   		
//// #####임용일자 ###////

    	  $("input#datepicker4").datepicker({
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
     
		  $('input#datepicker4').datepicker('setDate', 'today');    
   
		
// ## 교원번호중복검사 하기 ## ///

       $("button#gyowonidcheck").click(function(){
          	 
        	 b_flagGyowonIdDuplicatClick = true; 
        
             $.ajax({
          		url:"<%= ctxPath%>/gyowonIdDuplicateCheck.lmsfinal",
          		data:{"gyowonid":$("input#gyowonid").val()}, 
          		type:"post",  
          	 	success:function(data){
          	 		if(data == 1) {
                        alert("중복된 교원번호입니다.");
                    } else if (data == 0) {
                   
                        alert("사용 가능한 교원번호입니다.")
                    }
          	 	}
             });
           	
       }); 		
          		
         
           $("input#gyowonid").bind("change", function(){
        	   b_flagGyowonIdDuplicatClick = false;
           });
           
          
           $("input#gyoemail").bind("change", function(){
          	 b_flagGyoEmailDuplicatClick = false;
           });
    
       }); //end of $(document).ready(function() ----------------------------	                  
  
       
       
 //## 이메일 중복여부 검사하기 ##//
    function isExistGyoEmailCheck() {
  	  
    	b_flagGyoEmailDuplicatClick = true;
  	 
    	 $.ajax({
    		url:"<%= ctxPath%>/gyoemailDuplicateCheck.lmsfinal",
    		data:{"gyoemail":$("input#gyoemail").val()},   
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
   	  function goDpSearch1(){
   		  	 $.ajax({
   				  url:"<%= ctxPath%>/gyoDeptlist.lmsfinal",
   				  data:{"searchType1":$("select#searchType1").val()
   					  	, "searchWord1":$("input#searchWord1").val()},  	
   				  dataType:"JSON",
   				  success:function(json){ 
   					  
   					  let html = "";
   					  if(json.length > 0) {  
   						  $.each(json, function(index, item){
   							  html += "<div class='sResult1' id='index' style='cursor:pointer;'>";
   							  html += "<span id='gyomajorid' style='color:#3333ff'>"+item.majorid+"</span>&nbsp;";
   							  html += "<span id='deptname'>"+item.deptname+"</span>";
   							  html += "</div>";
   						  });
   					  }
   					  else {
   						 alert("해당하는 학과가 없습니다. 다시 입력하세요.");
   					  }
   					  
   					  $("div#div_searchResult1").html(html);
   					
   				  },
   				  error: function(request, status, error){
   						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
   				  }
   			  });
   		  }// end of function goDpSearch1(){}-----------------  
   		  
//////////## 등록하기 ##//////////

  function func_GyowonRegister() {
	
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
	    
    	   
////### 근로상태코드 ###////
	   
	  const workstatusCheckedLength = $("input:radio[name='workstatus']:checked").length;
	   
	   if(workstatusCheckedLength == 0) {
		   alert("학적상태를 체크하세요");
		   return; 
	   }
	   
  
// 교원번호 중복확인 여부
    	   
	    	if(!b_flagGyowonIdDuplicatClick) {
	    		alert("교원번호중복확인 클릭하여 중복 여부를 확인하세요");
	    		return; 
	       }
    	    
// 이메일 중복확인 여부
		    if(!b_flagGyoEmailDuplicatClick) {
			   	 alert("이메일중복확인 클릭하여 중복 여부를 확인하세요");
			   	 return; 
		   } 
	   	  
   	  const frm = document.gyowonRegisterFrm;
	   	  frm.action = "<%= ctxPath%>/gyowonRegisterEnd.lmsfinal";
	   	  frm.method = "post";
	   	  frm.submit(); 
    	   
   } //end of function func_StudentRegister()
         	
   
  </script>
  
      <div style="display: flex; align-items: center; justify-content: center; ">
       <div class="memberbox">
		    <div class="col-md-7" id="divgyowonRegisterFrm"> 
              <form name="gyowonRegisterFrm">
		   
		        <h2 style="text-align:center; padding:15px; font-weight:bolder;">교원 등록</h2>
			    <table id="tblgyowonRegister" style="margin:0 0 0 200px;">
			       
			      <tbody>
			      <tr>
			         <td style="width: 20%; font-weight: bold;">교원번호</td>
			         <td style="width: 80%; text-align: left;">
			             <input type="text" name="gyowonid" id="gyowonid" class="requiredInfo" />&nbsp;&nbsp;
			             <button type="button" id="gyowonidcheck" style="vertical-align: middle; width: 80px; height: 30px; line-height: 15px; border-radius: 5px;  background-color: #00001a; color: white; font-size: 10pt;">교원번호 조회</button>
			             <span id="gyowonidcheckResult"></span>
			             <span class="error"><br>교원번호는 5자리 숫자로 입력하세요.</span> 
			         </td> 
			      </tr>
			      
			       <tr>
			         <td style="width: 20%; font-weight: bold;">비밀번호</td>
			         <td style="width: 80%; text-align: left;"><input type="text" name="gyopwd" id="gyopwd" class="requiredInfo" />
			            <span class="error"><br>비밀번호는 필수입력 사항입니다.</span>
			         </td>
			      </tr>
			      
			      <tr>
			         <td style="width: 20%; font-weight: bold;">이름</td>
			         <td style="width: 80%; text-align: left;">
			             <input type="text" name="gyoname" id="gyoname" class="requiredInfo" /> 
			             <span class="error"><br>이름은 필수입력 사항입니다.</span>
			         </td>
			      </tr>
			      
			       <tr>
			         <td style="width: 20%; font-weight: bold;">주민등록번호</td>
			         <td style="width: 80%; text-align: left;">
			             <input type="text" id="gyojumin" name="gyojumin" class="requiredInfo" size="25" maxlength="14" placeholder=" '-'를 포함하여  기입하시오."/>
			             <span class="error">주민등록번호 형식이 아닙니다.</span>
			         </td>
			      </tr>
			      
			      <tr>
			         <td style="width: 20%; font-weight: bold;">생년월일</td>
			         <td style="width: 80%; text-align: left;">
			            <input type="text" id="datepicker3" name="gyobirthday" class="requiredInfo">
	         		</td>
	      		  </tr>
	      		  
			      <tr>
			         <td style="width: 20%; font-weight: bold;">이메일</td>
			         <td style="width: 80%; text-align: left;"><input type="text" name="gyoemail" id="gyoemail" class="requiredInfo" placeholder="abc@def.com" /> 
			             <span class="error"><br>이메일 형식에 맞지 않습니다.</span>
			             
			             <span class="gyoemailCheckimg" style="display: inline-block; width: 80px; height: 30px;  background-color: #00001a; color: white; border: solid 1px gray; border-radius: 5px; font-size: 8pt; text-align: center; margin-left: 10px; cursor: pointer;" onclick="isExistGyoEmailCheck();">이메일중복확인</span> 
			             <span id="gyoemailCheckResult"></span>
			         </td>
			      </tr>
			      
			     <tr>
			         <td style="width: 20%; font-weight: bold;">연락처</td>
			         <td style="width: 80%; text-align: left;"><input type="text" name="gyomobile" id="gyomobile" class="requiredInfo" placeholder="예)010-1111-1111" /> 
			             <span class="error"><br>연락처 형식에 맞지 않습니다.</span>
			            
			         </td>
			      </tr>
			      
 
				  <tr>
					<th style="width: 20%; font-weight: bold;">학과코드</th> 
					<td> 
			            <input type="text" id="gyomajorid" name="gyomajorid" size="20" placeholder="학과코드" class="requiredInfo" value=""/>
			            <button type="button" id="deptSearch1" class="btn btn-secondary btn-sm mr-3" data-toggle="modal" data-target="#deptSearch1" style="background-color: #00001a; color: white;">
				                  학과찾기
				        </button>
			          
			            
		            </td>
		            
		            <!-- *** 학과,학과코드 찾기 Modal ***** -->
						<div class="modal fade" id="deptSearch1" data-backdrop="static">
					  	 <div class="modal-dialog ">
		                  <div class="modal-content">
					      
					      <!-- Modal header -->
					     <div class="modal-header">
		                  <h4 class="modal-title">학과 찾기</h4>
		                  <button type="button" class="close myclose" data-dismiss="modal">&times;</button>
		                 </div>
					     
				
					      <!-- Modal body -->
					      <div class="modal-body">
					        <div id="deptnameSearch1">
					          <form name="searchFrm1" style="margin-top: 20px;">
						      <select name="searchType1" id="searchType1" style="height: 26px;">
						         <option value="majorid">학과코드</option>
						         <option value="deptname">학과명</option>
						      </select>
						      <input type="text" name="searchWord1" id="searchWord1" size="35" autocomplete="off" /> 
						      <input type="text" style="border: none; display: none;"/> 
						      <button type="button" class="btn btn-secondary btn-sm"  style="background-color: #00001a; color: white;" onclick="goDpSearch1()">조회</button>
						    </form>   
						   </div>
						
						   <div class="my-3" id="div_searchResult1"></div> 
						
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
			         <td style="width: 20%; font-weight: bold;">임용일자</td>
			         <td style="width: 80%; text-align: left;">
			            <input type="text" id="datepicker4" name="appointmentdt" class="requiredInfo">
	         		</td>
	      		  </tr>
			  
			      <tr>
			         <td style="width: 20%; font-weight: bold;">근로상태코드</td>
			         <td style="width: 80%; text-align: left;">
			             <input type="radio" name="workstatus" id="Attending" value="1" class="requiredInfo" /><label for="Attending">재직</label> 
			         </td>
			      </tr>
			      
			     <tr>
		             <td colspan="2" style="line-height: 50px;" class="text-center">
		             <button type="button" id="btnRegister" class="btnSubmit btn-outline-dark btn-sm mr-3"  style="position: relative; top: 30px; border-radius: 10px;">가입하기</button> 
				    </td>
		         </tr>
			  </tbody>
			 </table>
		  </form>  
		</div>	      
	</div>
	</div>