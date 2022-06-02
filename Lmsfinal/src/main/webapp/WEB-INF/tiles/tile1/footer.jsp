<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%
   String ctxPath = request.getContextPath();
  //       /lmsfinal
%>
<%-- ======= #27. tile1 중 footer 페이지 만들기  ======= --%>

<style type="text/css">
div#page-footer {
-webkit-text-size-adjust: 100%;
    -webkit-tap-highlight-color: rgba(0,0,0,0);
    font-size: 14px;
    line-height: 1.42857143;
    box-sizing: border-box;
    font-family: NanumGothic,"나눔고딕",NanumGothic,"돋움",dotum,sans-serif;
    color: white;
    clear: both;
    border: 0;
    margin: 0;
    text-align: left;
    height: 50px;
    min-height: 50px;
    padding: 18px 30px 0;
    position: fixed;
    bottom: 0;
    width: 100%;
    background: #262626;
    }
</style>

<div id="page-footer">
	<div class="address-policy">
					<span class="privacy_policy"><a href="#" data-toggle="modal" data-target="#myModal_privacy_policy">개인정보처리방침</a></span>
		<span class="address" style="margin-left: 100px;">서울특별시 마포구 월드컵북로 21 풍성빌딩 2,3,4층 쌍용대학교<span class="tell">Tel_02-336-8546~8</span></span>
	</div>
	<div class="copyright">
	</div>
</div>


<%-- 개인정보 처리방침 모달창 부분 --%>
<div class="modal" id="myModal_privacy_policy" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content bg-white">
            <div class="modal-header">
                <h5 class="modal-title text-black" style="text-align:center; font-size: 17pt; font-weight: bold;"> 개인정보 취급방침</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body text-black">
            	<iframe src="http://localhost:9090/lmsfinal/jeongKyeongEun/privacy_policy.lmsfinal" width="100%;" height="500px" class="box"></iframe>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal" style="font-weight: bold; ">확인</button>
            </div>
        </div>
    </div>
</div>
<%-- 개인정보 처리방침 모달창 부분 끝--%>


    