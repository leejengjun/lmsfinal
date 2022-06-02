<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
%>

<style type="text/css">

div#content {
	width: 500px;
	height: 300px;
}

h3 {
	text-align: center;
	font-weight: bold;
	margin-top: 70px;
}

div#button {
	margin-top: 70px;
	text-align: center;
}

</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("button#btnDelete").click(function(){
			
				// 폼(form)을 전송(submit)
				const frm = document.delFrm;
				frm.method = "POST";
				frm.action = "<%= ctxPath%>/delEnd.lmsfinal";
				frm.submit();
		});
		
	});// end of $(document).ready(function(){})-----------------------------------------------------------------

</script>

<div style="display: flex; margin: 50px 0;">
<div style="margin: auto; padding-left: 3%;">

	<h2 style="text-align: center; margin-top: 50px; font-weight: bold; margin: -10px 0 40px 0; "><font size="15" color="#84c1f5">공지사항 글 삭제하기</font></h2>

<form name="delFrm">
	<input type="hidden" name="noticeno" value="${requestScope.noticeno}" readonly />
	
	<div id="content" style="margin: 20px;">
		<div>
			<h3>작성된 글을 삭제하시겠습니까?</h3>
		</div>
		<div id="button">
			<button type="button" class="btn btn-primary btn-sm mr-3" id="btnDelete">삭제</button>
			<button type="button" class="btn btn-primary btn-sm" onclick="javascript:history.back()">취소</button>
		</div>
	</div>

</form>
</div>
</div>