<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%
   String ctxPath = request.getContextPath();
  //       /lmsfinal
%>

<style type="text/css">

   html, body {
       margin: 0;
       padding: 0;
       height: 100%;
       
   }
   
   #body-wrapper {
       min-height: 100%;
       position: relative;
   }
   
   #body-content {
       margin-top: 100px;
       padding-bottom: 800.590px; /* footer의 높이 */
   }
   
   footer {
       width: 100%;
       height: 800.590px; /* footer의 높이 */
       position: absolute;  
       bottom: 0;
       left: 0;
   }
   /* footer 하단 고정  */
   
   /* ===================================================================== */
   
   *{ padding: 0; margin: 0; } 
   li{ list-style: none; } 
   button{ cursor: pointer; } 
   
   
   body{ background-color: #ffffff; }
   
   .memberbox{
       width: 780px; height: 550px;
       margin: 0 auto; 
   }
   .memberbox h2{
       width: 100%; 
       height: 100px; 
       line-height: 400px;
       text-align: center; 
       font-size: 40px;
       font-weight: bolder;
   }
   .memberbox form{
       width: 100%; height: 750px;
       background-color: #fff;
       border: 5px solid #e5e5e5;
       padding: 160px; 
       box-sizing: border-box;
   }
   .memberbox fieldset{
       border: none; 
   }
   .memberbox legend{
       
       position: absolute; left: -999em;
   
   }
   
   .memberbox input{
       width: 100%; 
       height: 50px;
       margin-bottom: 25px; 
       border: none; 
       background-color: #ededed;
       padding: 0 20px; 
       box-sizing: border-box; 
   }
   
   .memberbox ul{
       width: 100%;
       text-align: right; 
       margin-bottom: 40px;
   }
   .memberbox li{
       display: inline-block;
       height: 10px; 
       line-height: 20px;
   }
   
   .memberbox a{
       
       color: #333; 
       font-size: 14px;
       position: relative; 
       top: -25px; 
   }
   
   .memberbox button{
       display: block;
       width: 220px; height: 50px;
       margin: -60px auto;
       border: none;
       background-color: #808080;
       color: #fff; font-size: 14px; font-weight: bold;
       position: relative; top: -40px;
   }
   
   .member_box_gift {
       margin-top: -40px;
       margin-bottom: 25px;
       width: 100%; height: 80px;
       padding: 0 20px;
       background-color: #f4f4f4;
       font-size: 14px;
       display: flex;
       flex-direction: column;
       text-align: center;
       box-sizing: border-box;
   
   }
   
   .loginfail {
       font-size: 14px;
       border: 1px solid #e5e5e5;
       text-align: center;
       margin-top: 30px;
       padding: 30px;
   }
   
   .login_return {
      float: left;
      position: relative; 
      top: 100px;
   
   }
   
   #userType {
       width: 40px;
       height: 20px;
       vertical-align: text-top;
   }

</style>


<script type="text/javascript">  


$(document).ready(function(){ 
   
   const method = "${requestScope.method}";  //POST 또는 GET 이므로 "${requestScope.method}"
   
   if( method == "GET") {  // GET이면 폼태그만 보여준다
	      $("div#div_findResult").hide(); 
	   } 

   else if(method == "POST") {
   
      $("div#div_findResult").show();
      
      $("input#userid").val("${requestScope.userid}"); 
      $("input#email").val("${requestScope.email}");
   }
   
/*   
// 인증하기
   $("button#btnConfirmCode").click(function(){  //인증키는 포스트 방식

      const frm = document.verifyCertificationFrm; 
      frm.userCertificationCode.value = $("input#input_confirmCode").val();   // 사용자가 입력한 값을 넣어준다.
      frm.userid.value = $("input#userid").val();      
      
      frm.action = "<%= ctxPath%>/verifyCertification.lmsfinal";  
      frm.method = "post";
      frm.submit();  
   });
 */  
  });// end of $(document).ready(function()--------------------
      
 
//인증코드 발생 후 제한시간안에 인증(연장 가능)
    counter_init();
   var tid;
   var cnt = parseInt(300);  //초기값(초단위)  5분
   
   function counter_init() {   //카운트 실행
      tid = setInterval("counter_run()", 1000);
   }
   
   function counter_reset() {
      clearInterval(tid);
      cnt = parseInt(300);
      counter_init();
   }
   
   function counter_run() { //카운트
       document.getElementById("counter").innerText = time_format(cnt);
      cnt--;
      if(cnt < 0) {
         alert("인증 요청을 다시 하세요")
         clearInterval(tid);
         location.replace(location.href);   //비밀번호 찾기 화면으로 이동.
   
      }
   }
   
   function time_format(s) {
      var nHour=0;
      var nMin=0;
      var nSec=0;
      if(s>0) {
         nMin = parseInt(s/60);
         nSec = s%60;
   
         if(nMin>60) {
            nHour = parseInt(nMin/60);
            nMin = nMin%60;
         }
      } 
      if(nSec<10) nSec = "0"+nSec;
      if(nMin<10) nMin = "0"+nMin;
   
      return ""+nHour+":"+nMin+":"+nSec;
   }

</script>


<body>

	<form name="pwdFindFrm"> 
		<div class="my-3" id="div_findResult">   
	        <p class="text-center">     
	           <c:if test="${empty requestScope.isUserExist}"> 
	              <span style="color:red;"> 사용자 정보가 없습니다.</span>
	           </c:if>
	           
	           <c:if test="${not empty requestScope.isUserExist && requestScope.sendMailSuccess == true}">
	          
	              <span style="font-size: 12pt;">이메일 ${requestScope.email}로 인증코드가 발송되었습니다.</span><br>
	              <span style="font-size: 12pt;">인증코드를 입력해주세요.</span>&nbsp;&nbsp;
	              <span id="counter" style="color: red;"></span>
	              <input type="button" value="연장" class="btn-outline-dark" style="width: 18%; height:25px; text-align: center; float: right; border-radius: 8px;" onclick="counter_reset()">
	              <input type="text" name="input_confirmCode" id="input_confirmCode" required />
	              <br><br>
	              <button type="button" class="btn btn-info" id="btnConfirmCode" style="border: solid 1px;">인증하기</button>
	            
	           </c:if>
	           
	            <c:if test="${not empty requestScope.isUserExist && requestScope.sendMailSuccess == false}"> 
	              <span style="color:red;">메일 발송이 실패했습니다. 잠시후 다시 시도해주세요.</span>
	           </c:if>
	      </p>
	   </div>
	     <div class="login_return"><a style="font-size: 1.3em; color:#000066;" href="<%= ctxPath%>/login.lmsfinal">로그인으로 돌아가기</a></div>
	</form>
			   
   <form name="verifyCertificationFrm">
         <input type="hidden" name="userCertificationCode">
         <input type="hidden" name="userid">
   </form> 

</body>