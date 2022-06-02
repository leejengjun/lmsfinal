<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>
<style type = "text/css">


</style>
<script type ="text/javascript">

	$(document).ready(function(){
			
		<%-- === #166. 스마트 에디터 구현 시작 === --%>
    	//전역변수
        var obj = [];
       
        //스마트에디터 프레임생성
        nhn.husky.EZCreator.createInIFrame({
        	oAppRef: obj,
           	elPlaceHolder: "sncontent",
           	sSkinURI: "<%= ctxPath%>/resources/smarteditor/SmartEditor2Skin.html",
           	htParams : {
            	// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
               	bUseToolbar : true,            
               	// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
               	bUseVerticalResizer : true,    
               	// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
               	bUseModeChanger : true,
            }
       	});
    	<%-- === 스마트 에디터 구현 끝 === --%>
		
		
		
		// 글쓰기 버튼
		$("button#btnWrite").click(function(){
			
			
			<%-- === 스마트 에디터 구현 시작 === --%>
	        	//id가 content인 textarea에 에디터에서 대입
	           	obj.getById["sncontent"].exec("UPDATE_CONTENTS_FIELD", []);
       		<%-- === 스마트 에디터 구현 끝 === --%>
			
			// 글제목 유효성 검사
			const subject = $("input#snsubject").val().trim();
			if(subject == ""){
				alert("글제목을 입력하세요.");
				return;
			}
			
			// 글내용 유효성 검사(스마트에디터 사용 안 할시)
			<%-- 
			const content = $("textarea#content").val().trim();
			if(content == ""){
				alert("글내용을 입력하세요.");
				return;
			}
			--%>
			
			<%-- === 스마트에디터 구현 시작 === --%>
        	//스마트에디터 사용시 무의미하게 생기는 p태그 제거
        	var contentval = $("textarea#sncontent").val();
	              
      		// === 확인용 ===
            // alert(contentval); // content에 내용을 아무것도 입력치 않고 쓰기할 경우 알아보는것.
            // "<p>&nbsp;</p>" 이라고 나온다.
           
            // 스마트에디터 사용시 무의미하게 생기는 p태그 제거하기전에 먼저 유효성 검사를 하도록 한다.
            // 글내용 유효성 검사 
            if(contentval == "" || contentval == "<p>&nbsp;</p>") {
            	alert("글내용을 입력하세요!!");
                return;
            }
           
            // 스마트에디터 사용시 무의미하게 생기는 p태그 제거하기
            contentval = $("textarea#sncontent").val().replace(/<p><br><\/p>/gi, "<br>"); //<p><br></p> -> <br>로 변환
	        /*    
	                   대상문자열.replace(/찾을 문자열/gi, "변경할 문자열");
	           ==> 여기서 꼭 알아야 될 점은 나누기(/)표시안에 넣는 찾을 문자열의 따옴표는 없어야 한다는 점입니다. 
	                        그리고 뒤의 gi는 다음을 의미합니다.

	              g : 전체 모든 문자열을 변경 global
	              i : 영문 대소문자를 무시, 모두 일치하는 패턴 검색 ignore
	        */    
	           contentval = contentval.replace(/<\/p><p>/gi, "<br>"); //</p><p> -> <br>로 변환  
	           contentval = contentval.replace(/(<\/p><br>|<p><br>)/gi, "<br><br>"); //</p><br>, <p><br> -> <br><br>로 변환
	           contentval = contentval.replace(/(<p>|<\/p>)/gi, ""); //<p> 또는 </p> 모두 제거시
	       
	           $("textarea#sncontent").val(contentval);
	        
	           // alert(contentval);
	       <%-- === 스마트에디터 구현 끝 === --%>
			
			
			
			// 글암호 유효성 검사
			const pw = $("input#snpwd").val();
			if(pw == ""){
				alert("글암호을 입력하세요.");
				return;
			}
			
			// 폼(form)을 전송(submit)
			const frm = document.addNoticeFrm;
			frm.method = "POST";
			frm.action = "<%=ctxPath%>/addNoticeEnd.lmsfinal";
			alert("섭밋 주석처리했습니다. ");
			frm.submit();
		});
		
		
	});

</script>

<div class="conatiner w-75"style = "display: flex; margin: 250px;">
<div style = "margin: auto; padding-left:3%;">
	
	<%-- 
		<h2 style = "margin-bottom: 30px;">글쓰기</h2>
	--%>
	<%-- 원글쓰기인 경우 --%>

	<h2 style = "margin-bottom: 30px;">공지사항</h2>
	

<%-- <form name = "addFrm"> --%>
<%-- ===  파일첨부하기 ===
	먼저 위의 <form name = "addFrm">을 주석처리한 이후에 아래와 같이 해야한다.
	enctype = "multipart/form-data"를 해주어야만 한다.
 --%>
<form name = "addNoticeFrm" enctype = "multipart/form-data">
	<table style = "width: 1024px" class = "table table-bordered">
		<tr>
			<th style = "width: 15%; background-color: #DDD">성명</th>
			<td>
				<input type = "text" name = "name" value = "${sessionScope.loginuser.gyoname}" readonly/>
			</td>
		</tr>
		
		<tr>
			<th style = "width: 15%; background-color: #DDD">제목</th>
			<td>
				<input type = "text" name = "snsubject" id = "snsubject" size = "100"/>
			</td>
		</tr>
		
		<tr>
			<th style = "width: 15%; background-color: #DDD">내용</th>
			<td>
				<textarea style = "width: 100%; height: 612px;" name = "sncontent" id = "sncontent"></textarea>
			</td>
		</tr>
		
		<%-- === 파일첨부 타입  === --%>
		
		<tr>
			<th style = "width: 15%; background-color: #DDD">파일첨부</th>
			<td>
				<input type = "file" name = "attach" />
			</td>
		</tr>
		
		<tr>
			<th style = "width: 15%; background-color: #DDD">글암호</th>
			<td>
				<input type = "password" name = "snpwd" id = "snpwd"/>
			</td>
		</tr>

	</table>
	
	<%-- === subjectid majorid gyowonid를 받아옴=== --%>
	<input type="hidden"name="subjectid"value="${requestScope.smgMap.subjectid}"/>
	<input type="hidden"name="majorid"value="${requestScope.smgMap.majorid}"/>
	<input type="hidden"name="gyowonid"value="${requestScope.smgMap.gyowonid}"/>
	
	<div style = "margin: 20px; text-align: center;">
		<button type = "button" class = "btn btn-secondary btn-lg mr-3" id = "btnWrite">글쓰기</button> 
		<button type = "button" class = "btn btn-secondary btn-lg" onclick = "javascript:history.back()">취소</button> 
	</div>

</form>
</div>
</div>