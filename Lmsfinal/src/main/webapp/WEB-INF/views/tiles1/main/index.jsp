<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%
   String ctxPath = request.getContextPath();
  //       /lmsfinal
%>

<style type="text/css">

	body {
		background-image: url("https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=http%3A%2F%2Fcfile3.uf.tistory.com%2Fimage%2F9947EE3D5A8958E030C7C2");
		background-repeat: no-repeat;
		background-size: cover;
	}
	#mycontent {
		margin-top: 150px;
		margin-left: 100px;
	}
	
	/* ================================================================================= */
	
	h2 {
	    text-align: left;
	    font-weight: 500;
	    line-height: 1.1;
	    font-family: NanumGothic,"나눔고딕",NanumGothic,'돋움',dotum,Helvetica,sans-serif,AppleGothic;
	    font-size: 14px;
	    color: white;
	}
	
	 div.col-login.col-login-person {
	    font-size: 14px;
	    text-align: left;
	    padding: 19px 15px 22px 16px;
	    background: rgba(29,71,107,.9);
	    width: 280px;
	    float: left;
	    height: 200px;
	}
	
	#region-main > div > div > div > div.col-loginbox > div:nth-child(1) > div.col-login.col-login-person > div {
	    -webkit-text-size-adjust: 100%;
	    -webkit-tap-highlight-color: rgba(0,0,0,0);
	    font-size: 14px;
	    line-height: 1.42857143;
	    color: #333;
	    text-align: left;
	    box-sizing: border-box;
	    font-family: NanumGothic,"나눔고딕",NanumGothic,"돋움",dotum,sans-serif;
	    display: none;
	    float: right;
	    position: relative;
	    top: -6px;
	}
	
	#region-main > div > div > div > div.col-loginbox > div:nth-child(1) {
	    margin: 0 0 10px 0;
	}
	
	#region-main > div > div > div > div.col-loginbox > div:nth-child(1) > div.col-login.col-login-person > div {
	    font-size: 14px;
	    color: #333;
	    text-align: left;
	    display: none;
	    background: rgba(29,71,107,.9);
	}
	
	form {
	    margin: 27px 0 0;
	    position: relative;
	}
	
	form > div.textform {
	    width: 165px;
	    float: left;
	}
	
	div.submitform {
	    margin-left: 168px;
	}
	
	#region-main > div > div > div > div.col-loginbox > div:nth-child(1) > div.col-login.col-login-person > form > div.submitform > input {
	    font-family: NanumGothic,"나눔고딕",NanumGothic,'돋움',dotum,Helvetica,sans-serif,AppleGothic;
	    font-size: 14px;
	    text-align: center;
	    vertical-align: middle;
	    cursor: pointer;
	    width: 80px;
	    height: 73px;
	    margin: 0;
	    border: 0;
	    border-radius: 0;
	    box-shadow: none;
	    background-color: #E77437;
	    color: white;
	}
	
	div.checkbox {
	    line-height: 1.42857143;
	    color: #333;
	    text-align: left;
	    font-family: NanumGothic,"나눔고딕",NanumGothic,"돋움",dotum,sans-serif;
	    position: relative;
	    display: block;
	    opacity: .8;
	    margin: 24px 0 0 0;
	}
	
	form > div.checkbox > label {
	    font-family: NanumGothic,"나눔고딕",NanumGothic,"돋움",dotum,sans-serif;
	    padding-left: 2px;
	    margin-bottom: 0;
	    cursor: pointer;
	    font-size: 11px;
	    color: white;
	    min-height: inherit;
	}
	
	div.loginfind {
	    color: #333;
	    font-family: NanumGothic,"나눔고딕",NanumGothic,"돋움",dotum,sans-serif;
	    text-align: right;
	    opacity: .6;
	    right: 0;
	    bottom: 0;
	    position: absolute; 
	}
	
	div.loginfind > a {
	    text-align: right;
	    font-family: NanumGothic,"나눔고딕",NanumGothic,"돋움",dotum,sans-serif;
	    color: white;
	    font-size: 11px;
	}
	
	#userid, #pwd {
	    font: inherit;
	    font-family: NanumGothic,"나눔고딕",NanumGothic,'돋움',dotum,Helvetica,sans-serif,AppleGothic;
	    display: inline;
	    max-width: 300px;
	    padding: 6px 12px;
	    color: #555;
	    margin-bottom: 1px;
	    border-radius: 0;
	    background-color: white;
	    height: 36px;
	    width: 100%;
	}
	
	
	/* ================================================================================= */
	
	div.col-loginbox > div:nth-child(1) > div.col-family {
	    background: rgba(76,76,76,.9);
	    height: 200px;
	    width: 145px;
	    margin-left: 13px;
	    float: left;
	}
	
	div.col-loginbox > div:nth-child(1) > div.col-family > ul {
	    text-align: left;
	    font-family: NanumGothic,"나눔고딕",NanumGothic,'돋움',dotum,Helvetica,sans-serif,AppleGothic;
	    padding: 15px 10px;
	    height: 200px;
	    list-style: none;
	    background: rgba(76,76,76,.9);
	}
	
	div.col-loginbox > div:nth-child(1) > div.col-family > ul > li > a {
	    line-height: 30px;    /* 위아래 줄간격 */
	    font-family: NanumGothic,"나눔고딕",NanumGothic,"돋움",dotum,sans-serif;
	    color: #edeeed;
	    font-size: 11px;
	    overflow: hidden;
	}
	
	/* ================================================================================= */
	
	div.col-loginbox > div.row.row-notice {
	    margin: 0 0 20px 0;
	}
	
	div.col-loginbox > div.row.row-notice > div {
	    padding: 20px 29px 20px 20px;
	    background-color: rgba(255,255,255,.9);
	    margin-top: 10px;
	    height: 180px;
	}
	
	div.col-loginbox > div.row.row-notice > div > div {
	    float: right;
	}
	
	div.col-loginbox > div.row.row-notice > div > div > a {
	    width: 15px;
	    margin-top: -5px;
	    display: block;
	}
	
	h3 {
	    line-height: 1.1;
	    font-family: NanumGothic,"나눔고딕",NanumGothic,'돋움',dotum,Helvetica,sans-serif,AppleGothic;
	    font-size: 14px;
	    color: #333;
	    font-weight: 700;
	}
	
	div.col-loginbox > div.row.row-notice > div > ul {
	    text-align: left;
	    box-sizing: border-box;
	    padding: 0;
	    margin: 14px 0 0 0;
	    
	}
	
	div.col-loginbox > div.row.row-notice > div > ul > li {
	    font-size: 14px;
	    color: #333;
	    font-family: NanumGothic,"나눔고딕",NanumGothic,"돋움",dotum,sans-serif;
	    padding-left: 16px;
	    line-height: 27px;
	    overflow: hidden;   /* 없애면 list 스타일?? 나온다. */
	    list-style: circle;
	}
	
	div.col-loginbox > div.row.row-notice > div > ul > li > a {
	    font-family: NanumGothic,"나눔고딕",NanumGothic,"돋움",dotum,sans-serif;
	    font-size: 12px;
	    color: #666;
	    list-style: circle;
	}

</style> 


<script type="text/javascript">

	$(document).ready(function(){
		
		$("input#goLOGIN").click(function(){
			func_Login();
		});
		
		
		$("input#pwd").keydown(function(event){
			
			if(event.keyCode == 13) {  // 엔터를 했을 경우
				func_Login();
			}
		});
		
	}); // end of $(document).ready(function(){})-----------------------------------------

	
	// Function Declaration
	
	function func_Login() {
		
	   const userid = $("input#userid").val(); 
	   const pwd = $("input#pwd").val(); 
      
       if(userid.trim()=="") {
           alert("아이디를 입력하세요!!");
          $("input#userid").val(""); 
          $("input#userid").focus();
          return; // 종료 
       }
      
       if(pwd.trim()=="") {
          alert("비밀번호를 입력하세요!!");
          $("input#pwd").val(""); 
          $("input#pwd").focus();
          return; // 종료 
       }
       
       const frm = document.loginFrm;
                                             /* 로그인 성공하면 홈페이지말고 메뉴가 있는 메인으로 */
       frm.action = "<%= ctxPath%>/loginEnd.lmsfinal";  
       frm.method = "POST";
       frm.submit();
       
	}// end of function func_Login() {}-----------------------------------
	
</script>



<!-- <div class="container"> -->
<div id="region-main">

	<div role="main">
	<span id="maincontent"></span>
	
		<div class="login-box container-fluid login-box-nohtml">
			<div class="row">
				<div class="col-loginbox">
				
					<div class="row">
					<div class="col-login col-login-person">
						<div class="login-form-close">
							<button type="button" class="nobtn">&nbsp;</button>
						</div>
					<!--					<h2 class="login-title">로그인</h2>//-->
						<h2 class="login-title">LOGIN</h2>
						
						<form name="loginFrm" class="mform form-login">
													<div class="textform">
								<input type="text" id="userid" name="userid" placeholder="사용자 아이디" value="" class="required form-control">
								<input type="password" id="pwd" name="pwd" placeholder="비밀번호" class="required form-control">
							</div>
							<div class="submitform">
								<input type="submit" id="goLOGIN" name="loginbutton" class="btn btn-success" value="로그인">
							</div>
							
							<div class="checkbox">
								<label>
									<input type="checkbox" id="remember" name="rememberuserid">
									사용자이름 기억							</label>
							</div>
							<div class="loginfind">
								<a href="<%= ctxPath%>/idfindpage.lmsfinal">아이디 / 비밀번호 찾기</a>
							</div>
						</form>
					</div>
					<div class="col-family">
						<ul>
							<li class="family-1"><a href="https://www.sist.co.kr/index.jsp" target="_blank">대학홈페이지</a></li>
							<li class="family-2"><a href="<%=ctxPath%>/home.lmsfinal">메인페이지</a></li>
							<li class="family-2"><a href="<%=ctxPath%>/noticeList.lmsfinal">공지사항</a></li>
							<li class="family-4"><a href="<%=ctxPath%>/faq.lmsfinal">FAQ</a></li>
							<li class="family-6"><a href="https://instagram.com/sist3482?igshid=YmMyMTA2M2Y=" target="_blank">Instagram</a></li>
							<li class="family-5"><a href="https://place.map.kakao.com/16530319" target="_blank">오시는 길</a></li>
						</ul>
					</div>
					
					</div>
					
					<div class="row row-notice">
						<div class="col-notice">
							<div class="more">
								<a href="<%= ctxPath%>/noticeList.lmsfinal">➕</a>
							</div>
							<h3>공지사항</h3>
							<ul>
								<li><a href="<%=ctxPath%>/noticeView.lmsfinal?noticeno=21&gobackURL=/noticeList.lmsfinal&searchType=nsubject&searchWord=">2022학년도 1학기 학습관리시스템(LMS) 온라인 시험 진행 방법 안내</a></li>
								<li><a href="<%=ctxPath%>/noticeView.lmsfinal?noticeno=15&gobackURL=/noticeList.lmsfinal&searchType=nsubject&searchWord=">[실시간 강의] 출석 기능 수정 내용 (학생용)</a></li>
								<li><a href="<%=ctxPath%>/noticeView.lmsfinal?noticeno=16&gobackURL=/noticeList.lmsfinal&searchType=nsubject&searchWord=">[실시간 강의] 출석 기능 수정 내용 (교수자용)</a></li>
								<li><a href="<%=ctxPath%>/noticeView.lmsfinal?noticeno=14&gobackURL=/noticeList.lmsfinal&searchType=nsubject&searchWord=">[원격교육지원센터] HelloLMS APP 다운로드 방법</a></li>
							</ul>
						</div>
					</div>
					
				</div>
			</div>
		</div>
	</div>
	
</div>