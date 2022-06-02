<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
	table, th, td {
		border: solid 1px gray;
		border-collapse: collapse;
	}
</style>

</head>
<body>
<div style="display: flex; margin-bottom: 50px;">   
<div style="width: 70%; min-height: 1100px; margin:auto; ">
	<h3>오라클 서버에 있는 데이터 조회</h3>
	<table>
		<tr>
			<th>학번</th>
			<th>우편번호</th>
			<th>전화번호</th>
			<th>주소</th>
		</tr>
	   
		<c:forEach var="studentvo" items="${requestScope.studentList}" varStatus="status">
			<tr>
				<td>${studentvo.stdid}</td>
				<td>${studentvo.stdpostcode}</td>
				<td>${studentvo.stdmobile}</td>
				<td>${studentvo.stdaddress}</td>			
	   		</tr>
		</c:forEach>
	</table>
</div>
</div>
</body>
</html>