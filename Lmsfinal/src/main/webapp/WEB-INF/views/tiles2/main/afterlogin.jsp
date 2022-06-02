<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%
   String ctxPath = request.getContextPath();
  //       /lmsfinal
%>

<style type="text/css">

	#myCarousel  {
		position: absolute;
		width: 1000px;
		margin-left: 60px;
	}
	
	#mycontent > div > div > div > div.second-container {
		margin-top: 600px;
		margin-bottom: 100px;
	}
	
	/* ====================================================================== */

#mycontent > div > div > div > div.second-container > div {
	height: 300px;
}
#container > div.container {
margin-top: 50px;
}

.content {
	margin: auto;
	width: calc(100% - 256px);
	float: right;
}

.tit01 {
	display: block;
	margin-top: 43px;
	margin-bottom: 43px;
	font-size: 38px;
	font-weight: bold;
	color: #484848;
	letter-spacing: -1px;
}
.content .terms .tabArea .tabBtn {
	overflow: hidden;
}
div.tabBtn.clearfix {
	display: flex;
	justify-content: space-around;
}
.tab-link {
	font-size: 18px;
	color: black;
	font-weight: bolder;
	cursor: pointer;
}
div.tab {
	text-align: left;
}



.tabArea {
	margin-bottom: 200px;}

/*css 추가*/
.content .terms .tabArea .tabBtn {
	overflow: hidden;
}

/* ---------------------------------------------------------- */
#storename2 {
	font-size: 50pt;
	font-weight: bold;
	color: #6f7375;
	padding-left: 150px;
}

#sist {
	font-size: 30pt;
	font-weight: bold;
	color: #0e83e8;
}

#myCarousel > div > div.carousel-item.active {
background-color: white;
margin-bottom: 200px;

}
</style>

<script type="text/javascript">
jQuery(function($){
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
    $('#tab1').on("click", e => {
    	$('#website').show();
    	$('#product').hide();
    	$('#personal').hide();
    	$('#order').hide();			
    });
    $('#tab2').on("click", e => {			
    	$('#website').hide();
    	$('#product').show();
    	$('#personal').hide();
    	$('#order').hide();
    });
    $('#tab3').on("click", e => {
    	$('#website').hide();
    	$('#product').hide();
    	$('#personal').show();
    	$('#order').hide();
    });
    $('#tab4').on("click", e => {
    	$('#website').hide();
    	$('#product').hide();
    	$('#personal').hide();
    	$('#order').show();
    });	

});

</script>


<div class="container" style="margin-bottom: 150px;">
<div class="row" style="margin-bottom: 150px;">
<div class="col-md-12 offset-md-1">


	<!-- ============================== marquee 시작 ============================== -->
	<p class="h3" style="margin: 20px 0;">
    	<marquee style="font-weight: bold; color: blue;"> [공지사항] 신입생 여러분들의 입학을 환영합니다. 학생처로 가셔서 학생증을 발급받으시길 바랍니다.</marquee>
    </p>
    
    
    <!-- ============================== 문구 시작 ============================== -->
    <span id="storename2">SINCE 1985.</span><br>
    <div style="text-align: left; padding-left: 210px;">
    <p id="my_title">
	       <h1>미래 IT인재의 요람 <span id="sist">쌍용대학교는</span>,</h1>
	       <h4>10년 이상의 실무경력을 갖춘 우수한 강사진과 최신교육시설,<br>
	      	 실무중심의 커리큘럼으로 현장 맞춤형 인재를 양성합니다.</h4>
	</p>
    </div>
    
    
    <!-- ============================== 캐러셀 시작 ============================== -->
    <div id="myCarousel" class="carousel slide" data-ride="carousel">
	    <!-- Indicators -->
	    <ol class="carousel-indicators">
	       <c:forEach items="${requestScope.imgfilenameList}" varStatus="status">
	          <c:if test="${status.index == 0}">
	             <li data-target="#myCarousel" data-slide-to="${status.index}" class="active"></li>
	          </c:if>
	          <c:if test="${status.index > 0}">
	             <li data-target="#myCarousel" data-slide-to="${status.index}"></li>
	          </c:if>
	       </c:forEach> 
	    </ol>
	
	    <!-- Wrapper for slides -->
	    <div class="carousel-inner">
	       <c:forEach var="filename" items="${requestScope.imgfilenameList}" varStatus="status">
	          <c:if test="${status.index == 0}">
	             <div class="carousel-item active">
	               <img src="<%= ctxPath%>/resources/images/jeongKyeongEun/${filename}" class="d-block w-100">
	              </div>   
	          </c:if>
	          <c:if test="${status.index > 0}">
	             <div class="carousel-item">
	               <img src="<%= ctxPath%>/resources/images/jeongKyeongEun/${filename}" class="d-block w-100">
                 </div>
	          </c:if>
	       </c:forEach>       
	    </div>
	    
	
	    <!-- Left and right controls -->
	    <a class="carousel-control-prev" href="#myCarousel" role="button" data-slide="prev">
	      <span class='carousel-control-prev-icon' aria-hidden='true'></span>
	      <span class="sr-only">Previous</span>
	    </a>
	    <a class="carousel-control-next" href="#myCarousel" role="button" data-slide="next">
	      <span class='carousel-control-next-icon' aria-hidden='true'></span>
	      <span class="sr-only">Next</span>
	    </a>
    </div>
	



</div>
</div>
</div>