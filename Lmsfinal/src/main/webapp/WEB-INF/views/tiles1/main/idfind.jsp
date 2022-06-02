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
  
</style>

<script type="text/javascript">

	$(document).ready(function(){ 
		
		const method = "${requestScope.method}";  //POST 또는 GET 이므로 "${requestScope.method}"
		
		if( method == "GET") {  // GET이면 폼태그만 보여준다
		     $("div#div_findResult").hide();
		} 
		else if(method == "POST") {
			$("input#name").val("${requestScope.name}");
			$("input#email").val("${requestScope.email}");   // 표시가 안 되넹!!!  -->  컨트롤러에서 request.setAttribute("email", email); 로 넘겨주지 않았기 때문!
		}
		
	//찾기		div_findResult
		$("button#btnFind").click(function(){
			goFind();
		});
		
		$("input#email").bind("keydown", function(event){
			
			if(event.keyCode == 13) {
				goFind();
			}
		});
		
		const str_findId = "${sessionScope.status}";
		
	});// end of $(document).ready(function()--------------------
			
	
			
	// Function Declration    여기를 ajax 로 했어야 됐는데..
	  function goFind() {
		
		  const name = $("input#name").val().trim();
		  const email = $("input#email").val().trim();
		  
		  if(name == "") {
			  alert("이름을 입력하세요");
			  $("input#name").val("");
			  $("input#name").focus();
			  return; 
		  }
		  
	      if(email == "") {
	    	  alert("이메일을 입력하세요");
			  $("input#email").val("");
			  $("input#email").focus();
			  return; 
		  }
		
		
		const userType = $("input:radio[name=userType]:checked").val();
		
		  const frm = document.idFindFrm;
		  	frm.userType.value = userType;
		  
			frm.action = "<%= ctxPath%>/idfind.lmsfinal";
			frm.method = "post";
			frm.submit();
	}

</script>


<body>
	<div id="body-wrapper"> 
     <div id="body-content">
     
       <div class="memberbox">
            <div class="login100-form-title">
				<span class="login100-form-title-1">
					아이디 찾기
				</span>
			</div>
     
	   <form name="idFindFrm">
                     
        <input type="radio" id="userType" name="userType" value="std" checked="checked">학생
	 	<input type="radio" id="userType" name="userType" value="gyo">교직원
		
	     <ul style="list-style-type: none">
	         <li style="text-align:left;">
	            <label for="name">이름</label>
	            <input type="text" name="name" id="name" size="50" placeholder="이름을 입력해 주세요" autocomplete="off" required />
	         </li>
	         <li style="text-align:left; margin: 25px 0">
	            <label for="email">이메일</label>
	            <input type="text" name="email" id="email" size="50" placeholder="이메일을 입력해 주세요" autocomplete="off" required />
	         </li>
	     </ul>
		 <ul>
		    <li><a href="<%= ctxPath%>/pwdFindpage.lmsfinal">비밀번호 찾기</a></li>
		 </ul>
	    
	     <div class="my-3">
		     <p class="text-center">
		       <button type="button" class="btn btn-primary btn-sm" id="btnFind" style="position: relative; top: 20px;">찾기</button>
		     </p>
	     </div>
	   
	     <div class="my-3" id="div_findResult"> 
	        <p class="text-center">     
	           <span id="findId" style="color: red; font-size: 16pt; font-weight: bold; position: relative; top: 60px;">회원 ID: ${requestScope.userid} </span> 
	      	</p>
	     </div>
	   
	     <div class="login_return"><a style="font-size: 1.3em; color:#000066;" href="<%= ctxPath%>/login.lmsfinal">로그인하기</a></div>
	              
	 <%--   <input type="hidden" name="str_findId" /> --%> 
	                    
	   </form>
	
	  </div>
	 </div>	   
    </div>
</body>