<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신고 내역 - 우리만 </title>
<!-- 
link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
 -->
<link rel="stylesheet" href="<%=cp%>/css/font.css">
<link rel="stylesheet" href="<%=cp%>/css/memberHeader.css">
<link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css" rel="stylesheet">

<!-- 1. 부트스트랩 js -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<!-- 2. 부트스트랩 css -->
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
<!-- 3. jquery -->
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<!-- 4. 부트스트랩 아이콘 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">


</head>
<body>

<div>
	<br>
	<c:import url="MemberHeader.jsp"></c:import>
	<hr />
	<br>
</div>


<div>
	<table class="table border">
		<tr>
			<th>신고 번호 1</th>
			<th>신고 유형</th>
			<th>게시글 제목</th>
			<th>신고 날짜</th>
		</tr>
		<tr>
			<td colspan="4">신고 내용</td>
		</tr>
	</table>
</div>


</body>
</html>