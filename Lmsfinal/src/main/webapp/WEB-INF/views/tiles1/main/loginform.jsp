<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.net.InetAddress"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>    
    
<!DOCTYPE html>
<html>
<head>
<title>파이널프로젝트LMS</title>
  <!-- Required meta tags -->
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"> 
  
  <!-- Bootstrap CSS -->
  <link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 

  <!-- Font Awesome 5 Icons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
  
  <!-- 직접 만든 CSS 1 -->
  <link rel="stylesheet" type="text/css" href="<%=ctxPath %>/resources/css/style1.css" />
  
  <!-- Optional JavaScript -->
  <script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.6.0.min.js"></script>
  <script type="text/javascript" src="<%= ctxPath%>/resources/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script> 
  <script type="text/javascript" src="<%= ctxPath%>/resources/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script> 
  
  <%--  ===== 스피너 및 datepicker 를 사용하기 위해  jquery-ui 사용하기 ===== --%>
  <link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.css" />
  <script type="text/javascript" src="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.js"></script>

  <%-- *** ajax로 파일을 업로드할때 가장 널리 사용하는 방법 ==> ajaxForm *** --%>
  <script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery.form.min.js"></script>

</head>

<style type="text/css">
   
	/*//////////////////////////////////////////////////////////////////
[ FONT ]*/

@font-face {
  font-family: Poppins-Regular;
  src: url('../fonts/poppins/Poppins-Regular.ttf'); 
}

@font-face {
  font-family: Poppins-Medium;
  src: url('../fonts/poppins/Poppins-Medium.ttf'); 
}

@font-face {
  font-family: Poppins-Bold;
  src: url('../fonts/poppins/Poppins-Bold.ttf'); 
}

@font-face {
  font-family: Poppins-SemiBold;
  src: url('../fonts/poppins/Poppins-SemiBold.ttf'); 
}


	/* footer 하단 고정  */
	
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

/*==================================================================
[ Form ]*/

#body-content > div > form {
  width: 100%;
  height: 100%;
  display: -webkit-box;
  display: -webkit-flex;
  display: -moz-box;
  display: -ms-flexbox;
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
  padding: 20px 130px;
}

/*------------------------------------------------------------------*/
#body-content > div > form > fieldset > label:nth-child(1) {
	inline
}


 </style>

<script type="text/javascript">

$(document).ready(function(){   
	
   $("button#btnSubmit").click(function(){ 
		   goLogin();  
    });
	   
   $("input#pwd").bind("keydown",function(event){
	   if(event.keyCode == 13) { 
		   goLogin(); 
	   }
   });
	
//== localStorage에 저장된 key가 "saveid"인 userid값을 불러와서 input태그 userid에 넣어주기 ==//
	   const loginid = localStorage.getItem('saveid');
	   
	   if(loginid != null) {
		   $("input#loginid").val(loginid);
		   $("input:checkbox[id='saveid']").prop("checked",true);
	   }
		
	}); // end of $(document).ready(function(){})-----------------------------------------

	
	// Function Declaration
	
	//로그인 처리 
    function goLogin() {
	   
	  const loginid = $("input#userid").val().trim();
	  const loginpw = $("input#pwd").val().trim();
	  
	  if(loginid == "") {
		  alert("아이디를 입력하세요");
		  $("input#userid").val("");
		  $("input#userid").focus();
		  return; 
	  }
	  
      if(loginpw == "") {
    	  alert("비밀번호를 입력하세요");
		  $("input#pwd").val("");
		  $("input#pwd").focus();
		  return; 
	  }
      
      //아이디 저장   
      if( $("input:checkbox[id='saveid']").prop("checked") ) {
    	 localStorage.setItem('saveid', $("input#loginid").val());
      }
      else {
    	  localStorage.removeItem('saveid');
      }
       
       const frm = document.loginFrm;
       frm.action = "<%= ctxPath%>/loginEnd.lmsfinal";
       frm.method = "POST";
       frm.submit();
       
	}// end of function func_Login() {}-----------------------------------
	
</script>
<body>
<div id="body-wrapper"> 
     <div id="body-content">
          <div class="memberbox">
            <div class="login100-form-title">
				<span class="login100-form-title-1">
					로그인
				</span>
			</div>
 
            <form name="loginFrm">
             
                <fieldset>
                    <span class="label-input100" style="display: inline-block; float: left;">아이디</span>
                    <input type="text" id="userid" name="userid" placeholder="아이디를 입력하세요" style="margin-bottom: 0px;">
                    <label for="loginpw" style="margin-top: -10px;">비밀번호</label>
                    <input type="password" id="pwd" name="pwd" placeholder="비밀번호를 입력하세요">
	            	<ul>
                       <li style="float:left;"><a href="<%= ctxPath%>/idfindpage.lmsfinal">아이디/비밀번호찾기</a></li>
                     </ul>
                     <div style="text-align:left; position: relative; top:-40px;">
                       <input type="checkbox" id="saveid" name="saveid" style="width:15px; height: 15px; "/><label for="saveid" style="font-size: 14px;">아이디저장</label>
                     </div>
                 
                    <div class="text-center">
	            	<button type="button" id="btnSubmit" class="btn btn-primary btn-sm" style="position: relative; top: 40px;">로그인</button>
                    </div>
                    
				</fieldset>
            </form>

		</div>
	</div>
	 
  </div> 
</body>
</html>    


