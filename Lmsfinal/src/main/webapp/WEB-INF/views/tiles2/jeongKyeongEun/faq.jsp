<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<%
	String ctxPath = request.getContextPath();
%>   

<style type="text/css">


#container > div.container {
margin-top: 50px;
}
/* faq_list CSS*/

.tab-link {
	width: 100%;
	margin-right: 30px;
	font-size: 18px;
	color: black;
	font-weight: bolder;
	cursor: pointer;
}
div.tab {
	text-align: left;
	width: 228px;
}
/* //////////////////////////////////////////////////////////////// */


.faq .q a {
	display:block;
	text-align:left; 
    background:/* url("faq1_icon_q.png") */ no-repeat 0 0; 
    padding: 10px 0 10px 35px;
    font-size:18px;
    color:#5e5e5e;
    background-color: white;
    /* font-weight:bold; */
    line-height: 27px;
    cursor:pointer;
    margin: 10px 0 !important;
}

/* .faq .q a:hover, .faq .q a:active, .faq .q a:focus{} */

.faq .a {
	background:#f8f8f8 /* url("faq1_icon_a.png") */ no-repeat 40px 10px;
	padding: 10px 75px 10px 75px;
    font-size: 16px;
    color: #444444;
    line-height: 22px;
    margin:5px 0 0 0;
}

.tabArea {
	margin-bottom: 200px;}


.q {
  font-weight: bold;
  color: #000;
  margin: 20px 0 0;
  cursor: pointer;
}

/*css 추가*/
.content .terms .tabArea .tabBtn {
	overflow: hidden;
}

*, *:before, *:after {-webkit-box-sizing: inherit;-moz-box-sizing: inherit;box-sizing: inherit}
html {-webkit-box-sizing: border-box;-moz-box-sizing: border-box;box-sizing: border-box;-ms-text-size-adjust:none; -webkit-text-size-adjust:none;height:100%}
body {height: 100%; font-family: 'Noto Sans KR', sans-serif; font-size: 16px; color: #454545;line-height: 1.5;background-color:#fff}
h1, h2, h3, h4, h5, h6 {font-weight:600}
html, body, div, span, applet, object, iframe, h1, h2, h3, h4, h5, h6, p, blockquote, pre, a, abbr, acronym, address, big, cite,
code, del, dfn, em, img, ins, kbd, q, s, samp, small, strike, strong, sub, sup, tt, var, b, u, i, center, dl, dt, dd,
ol, ul, li, fieldset, form, label, legend, table, caption, tbody, tfoot, thead, tr, th, td, article, aside, canvas,
details, embed, figure,  figcaption, footer, header, hgroup, menu, nav, output, ruby, section, summary, time, mark, audio, video, hr {margin:0; padding:0;border:0}
ul li, ol li {list-style: none}
em, address {font-style:normal}
a {text-decoration: none; cursor: pointer;color: #666}


.faqBody > li:nth-child(n+2){ /* 아이템 구분 점선 */
  border-top: 1px dashed #aaa;
}

.q::before { /* 제목 앞 화살표 */
  display: block;
  content: "";
  width: 0;
  height: 0;
  border: 8px solid transparent;
  border-left: 8px solid #a00;
  margin: 16px 0 0 8px;
  float: left;
}

.tabBtn { display:table; width:100%; table-layout:fixed; border-left:1px solid #e7e7e7;position:relative;background-color: #f1f1f1}
.tabBtn div { display:table-cell; height:50px}
.tabBtn div p { display:block;position:relative;height:50px;border-top:1px solid #e7e7e7;border-bottom:1px solid #e7e7e7;line-height:50px;text-align:center;background-color: #fff}
.tabBtn div p:after { content:''; display:block; position:absolute; top:0; right:0; bottom:0; width:1px; background:#e6e3df}
.tabBtn div.on p, .tabBtn div:hover p {border-bottom-color:#f34b53; border-top:1px solid #f34b53;z-index: 1;background-color: #fd7c82;color:#fff}
.tabBtn div.on p:after, .tabBtn div:hover p:after { content:''; display:block; position:absolute; top:0; right:0; bottom:-1px; width:1px; background:#f34b53}
.tabBtn div.on p:before, .tabBtn div:hover p:before { content:''; display:block; position:absolute; top:0; left:0; bottom:-1px; width:1px; background:#f34b53}

</style>

<script type="text/javascript">

$(document).ready(function(){
	
	$("#tab1 p").css('color', 'inherit');
	$("#tab1 p").css('color', '#fd7c82');
	
    // 자주묻는질문(FAQs)
    var article = $('.faq>.faqBody>.article');
    article.addClass('hide');
    article.find('.a').hide();
    article.eq(0).removeClass('hide');
    article.eq(0).find('.a').show();
    $('.faq>.faqBody>.article>.q>a').click(function(){
        var myArticle = $(this).parents('.article:first');
        if(myArticle.hasClass('hide')){
            article.addClass('hide').removeClass('show');
            article.find('.a').slideUp(100);
            myArticle.removeClass('hide').addClass('show');
            myArticle.find('.a').slideDown(100);
        } else {
            myArticle.removeClass('show').addClass('hide');
            myArticle.find('.a').slideUp(100);
        }
        return false;
    });
    

    $(document).on("load")
    $('#tab1').on("click", function () {
    	$("#tab1 p").css('color', 'inherit');
    	$("#tab1 p").css('color', '#fd7c82');
  	    
  	    $("#tab2 p").css('color', '');
  	    $("#tab2 p").css('color', '');
	  	$("#tab3 p").css('color', '');
	  	$("#tab3 p").css('color', '');
	    $("#tab4 p").css('color', '');
	    $("#tab4 p").css('color', '');
    	$('#website').show();
    	$('#product').hide();
    	$('#personal').hide();
    	$('#order').hide();			
    });
    $('#tab2').on("click", function () {
    	$("#tab2 p").css('color', 'inherit');
    	$("#tab2 p").css('color', '#fd7c82');
    	
    	$("#tab1 p").css('color', '');
    	$("#tab1 p").css('color', '');
  	  	$("#tab3 p").css('color', '');
  	    $("#tab3 p").css('color', '');
	    $("#tab4 p").css('color', '');
	    $("#tab4 p").css('color', '');
    	$('#website').hide();
    	$('#product').show();
    	$('#personal').hide();
    	$('#order').hide();
    });
    $('#tab3').on("click", function () {
    	$("#tab3 p").css('color', 'inherit');
    	$(this).css('color', '#fd7c82');
    	
    	$("#tab1 p").css('color', '');
    	$("#tab1 p").css('color', '');
  	    $("#tab2 p").css('color', '');
  	    $("#tab2 p").css('color', '');
	    $("#tab4 p").css('color', '');
	    $("#tab4 p").css('color', '');
    	$('#website').hide();
    	$('#product').hide();
    	$('#personal').show();
    	$('#order').hide();
    });
    $('#tab4').on("click", function () {
    	$("#tab4 p").css('color', 'inherit');
  	    $(this).css('color', '#fd7c82');
    	
    	$("#tab1 p").css('color', '');
    	$("#tab1 p").css('color', '');
  	    $("#tab2 p").css('color', '');
  	    $("#tab2 p").css('color', '');
	    $("#tab3 p").css('color', '');
	    $("#tab3 p").css('color', '');
    	$('#website').hide();
    	$('#product').hide();
    	$('#personal').hide();
    	$('#order').show();
    });	
    

});


</script>
<div class="container">
<div class="row">
<div class="col-md-12 offset-md-1">
	
	<h2 style="text-align: center; margin-top: 50px"><font size="15" color="#fd7c82">FAQ</font></h2>
	<div class="terms" style="margin: 50px 100px;">
		<div class="tabArea" style="margin-top: 50px;">
			<div class="tabBtn clearfix">
				<div class="tab" id="tab1">
						<p class="tab-link">시작하기</p>
				</div>
				<div class="tab" id="tab2">
						<p class="tab-link">온라인 강의보기</p>
				</div>
				<div class="tab" id="tab3">
					<p class="tab-link">출석</p>
				</div>
				<div class="tab" id="tab4">
					<p class="tab-link">과제</p>
				</div>
			</div>		

				<hr />
				<%-- 게시글 리스트 출력부분 시작 --%>
						<%-- 시작하기 --%>				
						<div class="tabCont" id="website">
							<div class="faq">
							    <div class="faqHeader"></div>
							    <ul class="faqBody">
							    <li class="article" id="a1">
							            <p class="q"><a href="#a1">[공통] 로그인 아이디, 비밀번호는 어떻게 되나요?</a></p>
							            <p class="a">우리 학교 포탈 아이디, 패스워드를 동일하게 사용하시면 됩니다.<br>
							        <br></p>
							        </li>
							        <li class="article" id="a2">
							            <p class="q"><a href="#a2">[공통] 아이디, 비밀번호 찾기는 어떻게 하나요?</a></p>
							            <p class="a"> 학교 메인페이지에 아이디, 비밀번호 찾기를 이용해 주세요.<br>
									<br></p>
							        </li>
							         <li class="article" id="a3">
							            <p class="q"><a href="#a3">[공통] 이전 학기 과목은 어떻게 들어가나요?</a></p>
							            <p class="a"> 1. 사용자가 로그인 한 상태에서 우측 상단에 위치한 자신의 프로필 이미지 혹은 이름을 클릭하여 마이페이지로 이동합니다.<br><br>
													  2. 마이페이지의 좌측 메뉴에 강의과목, 수강과목 항목이 나타나며 조회할 과목성격에 해당하는 항목을 클릭하면 과목 목록화면이 나타납니다.<br><br>
													  3. 목록 하단에 나타난 '이전 학기 더보기' 버튼을 클릭하면 버튼이 사라지고 그 밑에 이전 학기 과목 목록이 나타납니다.<br><br> 
													  4. 나타난 과목 목록에서 과목명을 클릭하면 해당 과목으로 이동하게 됩니다.<br>
													  ※ 위 안내서는 강의과목 화면을 기준으로 만들어져 있으며, 수강과목도 동일한 방법으로 접근이 가능합니다.<br>
													  ※ 이전 학기 과목 접근에 대해서는 학교에서 지정한 정책에 따라선 접근이 불가능할수도 있습니다.<br>
									<br></p>
							        </li>   
							        <li class="article" id="a4">
							            <p class="q"><a href="#a4">[교수] 학습활동 애플리케이션 성격이 궁금합니다.</a></p>
							            <p class="a"> 강의계획서 : 학사시스템과 연계되어있으며, 새벽 2시~3시 사이에 동기화됩니다.<br><br>
													    온라인강의 : 학습에 필요한 온라인강의들을 등록하는 공간입니다.<br><br>
 													    강의자료 : 교수님께서 학생들에게 강의자료를 제공하는 공간입니다. (교수님만 등록가능)<br><br>
													    출석 : 학생들의 출석을 관리합니다.<br><br>
													    과제 : 교수님이 과제를 출제하고 학생들이 제출한 과제를 평가할 수 있는 공간입니다.<br><br> 
													    시험 : 시험을 출제하고, 학생들의 제출답안을 평가할 수 있는 공간입니다.<br><br>
 													    성적 : 시스템 상에서 채점한 성적을 기반으로 성적을 산출할 수 있으며, 학점을 부여하거나<br> 
  											                      학생들에게 성적을 공개할 수 있는 공간입니다.<br>
									<br></p>
							        </li>  
							        <li class="article" id="a5">
							            <p class="q"><a href="#a5">[교수] 과목개설 어떻게 하나요?</a></p>
							            <p class="a"> 로그인 후 나타나는 '메인화면'의 메뉴에서 '내 강의실' > '강의신청' 탭에서 바로 과목개설을 할 수 있습니다.<br>
									<br></p>
							        </li>   
							        <li class="article" id="a6">
							            <p class="q"><a href="#a6">[교수] 강의과목 파일용량 증설은 어떻게 하나요?</a></p>
							            <p class="a"> 강의과목 당 사용할 수 있는 디스크 공간이 500MB 할당됩니다.<br>
													    되도록 파일 사이즈를 작게 해서 파일 업로드 해야겠지만 불가피하게 디스크 공간을 다 사용했을 경우 관리자에게 증설 요청해야 합니다.<br>
													    요청방법은 홈 > 이용안내 > Q&A에 글을 올리거나 급한 경우 하단에 있는 전화번호로 문의하세요.<br>
									<br></p>
							        </li>   
							        <li class="article" id="a7">
							            <p class="q"><a href="#a7">[교수] 강의하는 과목과 이클래스에 나타나는 과목이 다릅니다.</a></p>
							            <p class="a"> 학사 시스템과 이클래스간에 강의정보 동기화는 매일 새벽 3시~4시 사이에 합니다.<br>
													    학사 시스템 변경이 있을 경우 다음날 오전에 확인하시면 됩니다.<br>
													    만약 급하신 경우 홈 > 이용안내 > Q&A 에 글을 올리거나 홈 하단에 있는 전화번호로 문의하세요.<br>
									<br></p>
							        </li>   
							        <li class="article" id="a8">
							            <p class="q"><a href="#a8">[공통] 비정규과목을 수강취소하고 싶어요.</a></p>
							            <p class="a"> 수강중인 비정규과목은 과목 상세 조회화면 또는 마이페이지에서 수강취소 할 수 있습니다.<br><br>
													  '교육현황' - '개설과목 검색' - '비정규과목' 메뉴로 이동하여 수강취소 할 비정규과목을 클릭합니다.<br><br>
													    조회화면에서 '수강취소' 버튼을 클릭하여 수강을 취소합니다.<br><br> 
													  '마이페이지' 의 수강과목 메뉴에서도 수강취소를 할 수 있습니다.<br><br>
													  수강취소할 비정규과목의 '수강취소' 를 클릭하여 수강을 취소합니다.<br>
									<br></p>
							        </li>   
							        <li class="article" id="a9">
							            <p class="q"><a href="#a9">[공통] 사이트 화면이 깨져서 나와요.</a></p>
							            <p class="a"> 1. 크롬 우측 상단 'Chrome 맞춤설정 및 제어' 아이콘  설정아이콘 을 클릭한 후 '도구 더보기' > '인터넷 사용 기록 삭제'를 클릭하세요.<br><br>
												      2. '인터넷 사용 기록 삭제' 팝업에서 '전체'를 선택한 후  '쿠키 및 기타 사이트 데이터'와 '캐시된 이미지 또는 파일' 앞 체크박스에 체크를 하고 '인터넷 사용 기록 삭제' 버튼을 클릭합니다.<br><br>
													  3. 이전 화면으로 돌아가서 왼쪽 상단의 새로고침 버튼  새로고침아이콘을 클릭하면 화면 깨짐 없이 제대로 나타납니다.<br>
									<br></p>
							        </li>   
							    </ul>
							</div>							
						</div><!-- tabContent -->
						<%-- 온라인 강의보기 --%>
						<div class="tabContent" id="product" style="display:none;">
							<div class="faq">
							    <div class="faqHeader"></div>
							    <ul class="faqBody">
							        <li class="article" id="a1">
							            <p class="q"><a href="#a1">[공통] 익스플로어에서 강의 동영상이 안 나타납니다.</a></p>
							            <p class="a">  1. 익스플로러 우측 상단 Tool button 을 클릭하고 "호환성 보기 설정"을 클릭하세요.<br>
    													(또는 단축키 [ALT] + T 로 익스플로러 도구 메뉴를 열어 "호환성 보기 설정"을 클릭하세요.)<br><br>
										2. 이 웹사이트를 호환성 보기에 추가하세요.<br>
										호환성 보기 설정이 보이지 않는 경우
										인터넷 익스플로러의 버전이 낮을 경우 호환성 보기 설정이 보이지 않을 수 있습니다.
   										 인터넷 익스플로러 버전을 최신 버전으로 업그레이드 해 주시기 바랍니다.<br>
							        <br></p>
							        </li>
							        <li class="article" id="a2">
							            <p class="q"><a href="#a2">[공통] 유튜브 동영상 연결 어떻게 하나요?</a></p>
							            <p class="a">  먼저 유튜브 사이트에서 연결을 희망하는 동영상 화면으로 이동합니다.<br>
													      동영상 위에 마우스를 올려 놓고 마우스 우 클릭 합니다.<br>
													      메뉴의 '동영상 URL 복사' 를 클릭하여 동영상 주소를 복사합니다.<br>
														<br><br>
														에디터의 유튜브 연결 아이콘을 클릭합니다.<br><br>
														'주소 입력' 을 선택한 후, 복사한 url을 입력하고 '삽입' 버튼을 클릭하면 유튜브 동영상이 글에 삽입됩니다.<br><br>
									<br></p>
							        </li>
							         <li class="article" id="a3">
							            <p class="q"><a href="#a3">[공통] 파일을 첨부하려고 하면 인터넷 브라우저가 종료돼요.</a></p>
							            <p class="a"> 파일을 첨부하려고 할 때, 파일을 첨부하는 창이 열린 뒤 한글 파일에 마우스가 올라가면 인터넷 브라우저가 종료되는 현상이 있습니다.<br>
													    이는 한글 프로그램 자체의 문제이며 저희 시스템이 아닌 다른 곳에서도 보실 수 있는 현상입니다.<br>
													    해결 방법은 다음과 같습니다.<br><br> 
													  1. C:\Program Files (x86)\Hnc 의 경로로 이동합니다.<br>
													  2. HncShellExt64.dll파일은 한글 버전에 따라 상세 경로가 다르니, HncShellExt64.dll 파일을 검색하여 이름을 변경하거나 삭제합니다.
									<br></p>
							        </li>   
							        <li class="article" id="a4">
							            <p class="q"><a href="#a4">[공통] [동영상] 윈도우 미디어 플레이어가 영상 재생이 안돼요.</a></p>
							            <p class="a"> 온라인 강의 콘텐츠가 윈도우미디어플레이어인 경우 자동업데이트 및 설정에 의해 작동이 안되는 경우입니다.<br><br>
													    1. 윈도우 미디어 플레이어 (Windows Media Player)를 실행하세요.<br>
 														- 시작 > 모든 프로그렘 > Windows Media Player<br><br>
													    2. Windows Media Player 실행 후 옵션 메뉴를 실행하세요.<br>
														- alt키 > 도구 > 옵션 클릭<br><br> 
													    3. 옵션창 실행 후 보안영역을 기본세팅으로 초기화 하세요.<br> 
 														- 보안텝 > 영역설정 > 모든 영역을 기본 수준으로 다시 설정 클릭 > 확인<br><br>
														4. 개인정보 탭에서 Windows Media Player 사용자 환경 개선 프로그렘 체크해제<br>
														- 개인 정보 > Windows Media Player 사용자 환경 개선 프로그렘 체크박스 해제<br><br>
														5. 인터넷 익스플로러로 인터넷 강의 시청하세요.<br>
									<br></p>
							        </li>   
							        <li class="article" id="a5">
							            <p class="q"><a href="#a5">[공통] 인터넷 익스플로러 옵션 설정을 초기화하는 방법</a></p>
							            <p class="a"> 크롬이나 파이어폭스 등 다른 브라우저로 접속하면 잘 되는데 인터넷 익스플로러로 접속했을 때 스크롤 바가 보이지 않거나, 화면이 틀어지거나, 사이트 기능이 잘 안된다면<br>
													    인터넷 익스플로러의 설정을 초기화 해주면 됩니다.<br><br>
													  1. 먼저, 열려있는 인터넷 익스플로러를 모두 닫은 후 인터넷 익스플로러 창을 하나만 띄워주세요.<br>
													    주의! 여러 개의 인터넷 익스플로러가 열려있으면 설정이 제대로 초기화되지 않습니다.<br><br> 
													  2. 인터넷 옵션을 연다.<br>
													  - 'Alt' 키 -> '도구' -> '인터넷 옵션' 클릭<br><br> 
													  3. '고급' 탭으로 이동 후 '원래대로' 클릭<br><br> 
													  4. '다시 설정' 클릭<br><br> 
													  5. 설정이 완료되면 인터넷 익스플로러를 모두 종료한 후 다시 사이트에 접속하여 설정이 초기화된 것을 확인합니다.<br>
									<br></p>
							        </li>   
							     </ul>   
							</div>
						</div>
						<%-- 출석 --%>
						<div class="tabContent" id="personal" style="display:none;">
							<div class="faq">
							    <div class="faqHeader"></div>
							    <ul class="faqBody">
						        <li class="article" id="a1">
							            <p class="q"><a href="#a1">[교수] 스마트출석 안내</a></p>
							            <p class="a">과목형태에 따라 출석화면이 달라집니다. 과목형태는 e-Class(이클래스)와 e-Learning(이러닝)이 있습니다.<br><br>
										* e-Class(이클래스) : 오프라인 강의를 지원합니다.<br>
										* e-Learning(이러닝) : 온라인으로 진행되는 강의(인터넷 수업)를 지원합니다.<br><br>
										[스마트출석]<br>
										스마트출석은 e-Class(이클래스) 형태의 과목에서 이용가능합니다. <br>
										오프라인 강의실에서 수강생이 자신의 스마트 기기를 이용해 자율적으로 출석을 하는 새로운 방식의 출석형태입니다.<br>
										단, 인터넷 익스플로러 10버전 이상에서만 원활히 이용가능하므로 10버전 이하의 사용자는 인터넷 익스플로러를 업그레이드 해주세요.<br><br>
										[스마트출석의 흐름]<br>
										1. 교수님이 출석시작 버튼을 클릭해 출석을 시작합니다.<br>
										2. 출석시작 후 나타나는 인증번호를 수강생에게 알려줍니다.<br>
										3. 수강생은 자신의 스마트 기기로 접속해 자율적으로 출석을 체크합니다. 이때 인증번호를 정확히 입력해야 출석이 인정됩니다.<br>
										4. 교수님은 시스템 내에 출석이 체크된 수강생의 정보와 실제 강의실에 있는 수강생을 확인합니다.<br>
										5. 강의실 내 모든 수강생이 출석체크 했다면 교수님이 출석종료 버튼을 클릭해 출석을 종료합니다.<br>
										6. 출석정보가 저장됩니다.<br>
							        <br></p>
							        </li>
							        <li class="article" id="a2">
							            <p class="q"><a href="#a2">[교수] e-Learning(온라인) 과목 온라인강의 출석 안내</a></p>
							            <p class="a">과목형태에 따라 출석화면이 달라집니다. 과목형태는 e-Class(이클래스)와 e-Learning(이러닝)이 있습니다.<br><br>
										* e-Class(이클래스) : 오프라인 강의를 지원합니다.<br>
										* e-Learning(이러닝) : 온라인으로 진행되는 강의(인터넷 수업)를 지원합니다.<br><br>
										강의과목의 형태가 e-Learning(온라인)인 과목은 온라인강의로 강의를 진행하는 과목입니다.<br>
										과목 내 '온라인강의' 에 등록된 주차에 따라 자동으로 출석이 생성됩니다.<br><br>
										수강생이 학습기간에 온라인강의를 시청하게 되면 자동으로 출석정보가 입력됩니다.<br>
										각 주차의 '제목'을 클릭하면 해당 주차 출석 조회화면으로 이동합니다.<br><br>
										출석 조회화면에서 해당 주차 온라인강의의 정보와 수강생의 출석률 목록이 표시됩니다.<br>
										수강생의 '이름'을 클릭하면 해당 수강생의 출석정보를 상세히 확인하고 출석이력을 수정할 수 있습니다.<br><br>
										수강생의 이름을 클릭해 나타난 '출석이력상세' 팝업에는 수강생의 출석이력이 상세하게 나타납니다.<br>
										강제로 출석인정을 하려면 출석을 인정할 콘텐츠의 체크박스에 체크한 뒤 '출석' 버튼을 클릭합니다.<br><br>
										하단의 콘텐츠 시청 이력 내역에서 콘텐츠 명을 클릭하면 콘텐츠 시청 이력을 수정할 수 있습니다.<br><br>
										시작시간과 종료시간을 설정한 뒤 '저장' 버튼을 클릭하면 수정이 완료됩니다.<br>
							        <br></p>
							        </li>
							        <li class="article" id="a3">
							            <p class="q"><a href="#a3">[교수] e-Class(오프라인) 과목 온라인강의 출석 안내</a></p>
							            <p class="a">과목형태에 따라 출석화면이 달라집니다. 과목형태는 e-Class(이클래스)와 e-Learning(이러닝)이 있습니다.<br><br>
										* e-Class(이클래스) : 오프라인 강의를 지원합니다.<br>
										* e-Learning(이러닝) : 온라인으로 진행되는 강의(인터넷 수업)를 지원합니다.<br><br>
										e-Class(오프라인) 형태의 강의과목에서도 온라인강의를 등록할 수 있습니다.<br>
										등록한 온라인 강의 시청 여부를 통해 수강생의 출석을 체크할 수 있습니다.<br>
										ex) 교수님께서 피치못할 사정으로 휴강하게 된 경우 온라인강의를 등록하여 시청 여부로 출석을 확인합니다.<br><br>
										과목 내 '온라인강의' 메뉴로 이동한 후 '등록' 버튼을 클릭합니다.<br><br>
										등록 화면에서 수강생의 출석을 체크하기 위해 '출석'을 '체크'로 지정하고 출석으로 인정할 출석일과 학습기간을 입력합니다.<br>
										하단의 '콘텐츠 연결' 부분에 온라인강의로 등록할 콘텐츠를 찾아 연결한 후 '저장' 버튼을 클릭하면 온라인강의가 등록됩니다.<br><br>
										'출석'을 '체크'로 지정한 온라인강의가 등록되면 과목 내 '출석' 메뉴에 자동으로 온라인강의출석 정보가 생성됩니다.<br><br>
										연결된 온라인강의의 학습기간 내에 수강생의 시청 여부에 따라 출석 여부가 자동으로 반영됩니다.<br>
										(연결된 온라인강의의 출석인정시간 동안 시청한 수강생은 출석, 출석인정시간 보다 적게 시청한 수강생은 지각,<br>
										그 외에 시청하지 않은 수강생은 결석으로 처리됩니다.)<br><br>
										'출석일'을 클릭하면 일반출석을 관리하듯 수강생의 출석 상태를 수정할 수 있습니다.<br><br>
										온라인강의출석에 연결된 온라인강의를 삭제하면 출석정보도 같이 삭제됩니다.<br><br>
										수강생들의 시청 이력을 확인하기 위해서는 '온라인강의' 메뉴에서 온라인강의 항목을 클릭하여 조회화면으로 이동합니다.<br><br>
										온라인강의 조회화면에서 '진도율보기' 버튼을 클릭하여 진도율보기 화면으로 이동합니다.<br><br>
										진도율보기 화면에서 수강생의 '이름'을 클릭하면 해당 수강생의 출석이력조회 및 수정이 가능합니다.<br><br>
										하단의 콘텐츠 시청 이력 내역에서 콘텐츠 명을 클릭하면 콘텐츠 시청 이력을 수정할 수 있습니다.<br><br>
										시작시간과 종료시간을 설정한 뒤 '저장' 버튼을 클릭하면 수정이 완료됩니다.<br><br><br><br><br>
							        <br></p>
							        </li>
							     </ul>   								        
							</div>						
						 </div>
						<%-- 과제 --%>
						<div class="tabContent" id="order" style="display:none;">
							<div class="faq">
							    <div class="faqHeader"></div>
							    <ul class="faqBody">
							        <li class="article" id="a1">
							            <p class="q"><a href="#a1">[교수] 학생들이 제출한 과제를 일괄 다운받으려면 어떻게 해야 하나요?</a></p>
							            <p class="a">  과제메뉴에서 과제 선택후 [평가]버튼을 눌러 수강생을 확인합니다.<br>
										수강생을 선택하지 마시고 바로 [과제일괄다운로드] 버튼을 클릭하시면, 제출한 과제 파일이 (강좌명)과제명.zip 으로 생성되어 다운로드 받으시게 됩니다.<br>
										다운로드 받은 zip파일을 열어 보시면 제출한 수강생의 이름-학번을 확인하실 수 있습니다.<br>
									<br></p>
							        </li>
							        <li class="article" id="a2">
							            <p class="q"><a href="#a2">[교수] 과제 평가할때 학생이 작성한 내용이 길어 평가화면이 안보입니다.</a></p>
							            <p class="a">  과제 평가화면에 왼쪽 학생 리스트가 나타납니다.<br><br>
										한 학생을 클릭하면 오른쪽에 학생 제출내용과 평가 화면이 나타납니다.<br><br>
										제출내용이 있는 오른쪽 상단에 핀 모양의 아이콘을 클릭하면 평가 화면이 고정되어 전체 글 내용을 확인하실 수 있습니다.<br>
						    	    <br></p>
						    	    </li>						    	    
					    	    </ul> 
							</div>
						</div>
					</div>
				</div>

				
</div>
</div>
</div>