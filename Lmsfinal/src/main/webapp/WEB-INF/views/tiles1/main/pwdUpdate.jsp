<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%
   String ctxPath = request.getContextPath();
  //       /lmsfinal
%>

<style type="text/css">

	/* footer 하단 고정  */
	
	/* 새로 짜는 CSS ----------------------------------------------- */

#body-wrapper {
  width: 100%;
  margin: 0 auto;
}

#body-content {
  width: 100%;  
  min-height: 100vh;
  flex-wrap: wrap;
  justify-content: center;
  align-items: center;
  padding: 100px;
  background: #ebeeef;
  
}

.memberbox {
  background: #fff;
  border-radius: 10px;
  overflow: hidden;
  position: relative;
}
/*==================================================================
[ Title form ]*/
.login100-form-title {
  width: 100%;
  position: relative;
  z-index: 1;
  display: -webkit-box;
  display: -webkit-flex;
  display: -moz-box;
  display: -ms-flexbox;
  display: flex;
  flex-wrap: wrap;
  flex-direction: column;
  align-items: center;
	background-image: url("https://cdn.eroun.net/news/photo/201811/3566_15794_1740.jpg");
  background-repeat: no-repeat;
  background-size: cover;
  background-position: center;

  padding: 70px 15px 74px 15px;
}

.login100-form-title-1 {
  font-family: Poppins-Bold;
  font-size: 30px;
  color: #fff;
  text-transform: uppercase;
  line-height: 1.2;
  text-align: center;
}

.login100-form-title::before {
  content: "";
  display: block;
  position: absolute;
  z-index: -1;
  width: 100%;
  height: 100%;
  top: 0;
  left: 0;
  background-color: rgba(54,84,99,0.7);
}	
	/* ===================================================================== */
	
	*{ padding: 0; margin: 0; } 
	li{ list-style: none; } 
	button{ cursor: pointer; } 
	
	
	body{ background-color: #ffffff; }
	
	.memberbox{
	    width: 780px; height: 650px;
	    margin: 0 auto; 
	    padding-bottom: 100px;
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
	    padding: 90px 160px; 
	    margin-top: -40px;
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
   
   #btnUpdate {
   	margin-top: 50px;
   }

</style>

<script type="text/javascript"> 
	
	$(document).ready(function(){ 
	
		$("button#btnUpdate").click(function(){
			const pwd = $("input#pwd").val();
			const pwd2 = $("input#pwd2").val();
			
			// const regExp = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g;     //정규표현식//
    	    // 또는
			const regExp = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
    	         // 숫자/문자/특수문자/ 포함 형태의 8~15자리 이내의 비밀번호 정규표현식 객체 생성
    	         
    		const bool = regExp.test(pwd);       ///리턴타입 불린값
    	 
    		   if(!bool) {
    			  // 비밀번호가 정규표현식에 위배된 경우
    			 alert("비밀번호는 8글자 이상 15글자 이하에 영문자,숫자,특수기호만 가능합니다.");
    			  
    			 $("input#pwd").val("");
    			 $("input#pwd2").val("");
    			 return; //종료
    			  
    		    }
    		    else if(bool && pwd != pwd2) {
	    		  	  // 비밀번호가 정규표현식에 위배된 경우
	       			 alert("비밀번호가 일치하지 않습니다.");
	       			  
	       			 $("input#pwd").val("");
	       			 $("input#pwd2").val("");
	       			 return; //종료 
    		   }
    		    else {
    		    	const frm = document.pwdUpdateFrm;
    		    	frm.action = "<%= ctxPath%>/pwdUpdate.lmsfinal";
    		    	frm.method = "post";
    		    	frm.submit();
    		    	
    		    }	   
    	 
		});
		
	});// end of $(document).ready(function()--------------------
			
</script>

	 <div id="body-wrapper"> 
	 <div id="body-content">
	
	  <div class="memberbox">
         <div class="login100-form-title">
			<span class="login100-form-title-1">
				비밀번호 변경
			</span>
		</div>
            
	   <form name="pwdUpdateFrm">
	
		<div id="div_pwd" align="left">
	      <span style="color: black; font-size: 12pt;">새 비밀번호</span><br/> 
	      <input type="password" name="pwd" id="pwd" placeholder="새 비밀번호를 입력하세요." required />
	   </div>
	   
	   <div id="div_pwd2" align="left">
	      <span style="color: black; font-size: 12pt;">새 비밀번호 확인</span><br/>
	      <input type="password" id="pwd2" placeholder="새 비밀번호를 한번 더 입력하세요." required />
	   </div>
	   
	   <input type="hidden" name="userid" value="${requestScope.userid}">   
	   
	   <c:if test="${requestScope.method == 'GET'}">
	      <div id="div_btnUpdate" align="center" style="position: relative; top: 50px;">
	        <button type="button" class="btn btn-primary btn-sm" id="btnUpdate" >비밀번호 변경</button>
	      </div>
	   </c:if> 
      
       <c:if test="${requestScope.method == 'POST' && requestScope.n == 1}"> 
        <div id="div_updateResult" align="center" style="color:red;">
            ${requestScope.userid}님의 비밀번호가 변경되었습니다.<br/>
       </div>
      </c:if> 
   
     <div class="login_return"><a style="font-size: 1.3em; color:#000066;" href="<%= ctxPath%>/login.lmsfinal">로그인으로 돌아가기</a></div>
	 </form>
	
    </div>
	   
   </div>

  </div>		
 </body>
	