<%@page import="java.util.Calendar"%>
<%@page import="sun.misc.Cleaner"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%

	Calendar cal = Calendar.getInstance();
	String date = "";
	date += cal.get(cal.YEAR);
	date += "-";
	date += cal.get(cal.MONTH);
	date += "-";
	date += cal.get(cal.DAY_OF_MONTH);
			

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1 문의사항 내역 - 우리만</title>
<!-- 
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
 -->

<link rel="stylesheet" href="<%=cp%>/css/font.css">
<link rel="stylesheet" href="<%=cp%>/css/memberHeader.css">
<link rel="stylesheet" href="<%=cp %>/css/footer.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/csList.css">
<link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css" rel="stylesheet">

<!-- 1. 부트스트랩 js -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<!-- 2. 부트스트랩 css -->
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
<!-- 3. jquery -->
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<!-- 4. 부트스트랩 아이콘 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">

<script type="text/javascript">

/* 	$(function()
	{
		var start = moment.subtract(29,"days");
		var end = moment();
		
		function date(start, end)
		{
			$("#date").html(start.format("yyyy-mm-dd") + " - " + end.format("yyyy-mm-dd"));
		}
		
		$("#date").daterangepicker(function()
		{
			  startDate: "2024-03-14"
		    , endDate: "2024-03-15"
			, ranges : {
				
				"3개월" : [moment().subtract(1,"month").startOf("month"), moment().subtract(3,"month").endOf("month")]
				,"6개월" : [moment().subtract(1,"month").startOf("month"), moment().subtract(6,"month").endOf("month")]
				,"1년" : [moment().startOf("year"), moment().endOf("year")]
				,"2년" : [moment().subtract(1,"year").startOf("year"), moment().subtract(2,"year").endOf("year")]
			}
			
		},date);
		
		date(start,end);
	}); */

</script>

</head>
<body>

<!-- 임시 헤더 영역 -->
<div>
	<br>
	<c:import url="MemberHeader.jsp"></c:import>
	<br>
</div>

<div>
	<h3 class="aaa">1:1 문의 내역</h3>
	<hr />
	<!-- <div class="date">
		<select name="" id="">
			<option value="3">3개월</option>
			<option value="6">6개월</option>
			<option value="12">1년</option>
			<option value="24">2년</option>
			<option value="">직접설정</option>
		</select>
		<div id="date">
			<i class="fa fa-calendar"></i>
		</div>
		<button class="btn btnSelect">조회</button>
	</div> -->
	<div class="date">
		<button class="btn btnInsert" onclick="location.href='inquiryinsertform.woori'">1:1문의 작성</button>
	</div>
	<br>
	<div class="Mycontent">
		<nav class="nav nav-tabs reporttab" role="tablist">
   			<div class="nav nav-tabs" id="nav-tab" role="tablist">
			    <button class="nav-link active" id="nav-all-tab" data-bs-toggle="tab" data-bs-target="#allInquiry" 
			    type="button" role="tab" aria-controls="allInquiry" aria-selected="true">전체</button>
			    
			    <button class="nav-link" id="nav-inquiryL-tab" data-bs-toggle="tab" data-bs-target="#inquiryL" 
			    type="button" role="tab" aria-controls="inquiryL" aria-selected="false">접수완료</button>
			    
			    <button class="nav-link" id="nav-review-tab" data-bs-toggle="tab" data-bs-target="#inquiryReview" 
			    type="button" role="tab" aria-controls="inquiryReview" aria-selected="false">관리자 검토중</button>
			    
			    <button class="nav-link" id="nav-completed-tab" data-bs-toggle="tab" data-bs-target="#inquiryCompleted" 
			    type="button" role="tab" aria-controls="inquiryCompleted" aria-selected="false">처리완료</button>
			</div>
		</nav>	
	</div>
	 <div class="tab-content csList" id="nav-tabContent">
		 <div class="tab-pane fade show active" id="allInquiry" role="tabpanel" aria-labelledby="nav-all-tab">
			<table class="table table-hover">
				<tr>
					<th>문의번호</th>
					<th>문의유형</th>
					<th>제목</th>
					<th>문의날짜</th>
					<th>상태</th>
				</tr>
				<c:forEach var="inquiryList" items="${inquiryList }">
				<tr onclick="location.href='inquirypost.woori?iq_code=${inquiryList.iq_code }'">
					<td>${inquiryList.iq_code }</td>
					<td>${inquiryList.iqc_name }</td>
					<td>${inquiryList.iq_title }</td>
					<td>${inquiryList.iq_date }</td>
					<td>${inquiryList.iq_state }</td>
				</tr>
				</c:forEach>
			</table>
		 </div>
		 <div class="tab-pane fade" id="inquiryL" role="tabpanel" aria-labelledby="nav-inquiryL-tab">
			<table class="table table-hover">
				<tr>
					<th>문의번호</th>
					<th>문의유형</th>
					<th>제목</th>
					<th>문의날짜</th>
					<th>상태</th>
				</tr>
				<c:forEach var="inquiryList" items="${inquiryList }">
				<c:if test="${inquiryList.iq_state=='접수완료' }">
				<tr onclick="location.href='inquirypost.woori?iq_code=${inquiryList.iq_code }'">
					<td>${inquiryList.iq_code }</td>
					<td>${inquiryList.iqc_name }</td>
					<td>${inquiryList.iq_title }</td>
					<td>${inquiryList.iq_date }</td>
					<td>${inquiryList.iq_state }</td>
				</tr>
				</c:if>
				</c:forEach>
			</table>
		 </div>
		 <div class="tab-pane fade" id="inquiryReview" role="tabpanel" aria-labelledby="nav-review-tab">
			<table class="table table-hover">
				<tr>
					<th>문의번호</th>
					<th>문의유형</th>
					<th>제목</th>
					<th>문의날짜</th>
					<th>상태</th>
				</tr>
				<c:forEach var="inquiryList" items="${inquiryList }">
				<c:if test="${inquiryList.iq_state=='관리자 검토중' }">
				<tr onclick="location.href='inquirypost.woori?iq_code=${inquiryList.iq_code }'">
					<td>${inquiryList.iq_code }</td>
					<td>${inquiryList.iqc_name }</td>
					<td>${inquiryList.iq_title }</td>
					<td>${inquiryList.iq_date }</td>
					<td>${inquiryList.iq_state }</td>
				</tr>
				</c:if>
				</c:forEach>
			</table>
		 </div>
		 <div class="tab-pane fade" id="inquiryCompleted" role="tabpanel" aria-labelledby="nav-completed-tab">
			<table class="table table-hover">
				<tr>
					<th>문의번호</th>
					<th>문의유형</th>
					<th>제목</th>
					<th>문의날짜</th>
					<th>상태</th>
				</tr>
				<c:forEach var="inquiryList" items="${inquiryList }">
				<c:if test="${inquiryList.iq_state=='처리완료' }">
				<tr onclick="location.href='inquirypost.woori?iq_code=${inquiryList.iq_code }'">
					<td>${inquiryList.iq_code }</td>
					<td>${inquiryList.iqc_name }</td>
					<td>${inquiryList.iq_title }</td>
					<td>${inquiryList.iq_date }</td>
					<td>${inquiryList.iq_state }</td>
				</tr>
				</c:if>
				</c:forEach>
			</table>
		 </div>
	</div>
	<%-- <table class="table">
		<tr>
		<thead>
			<th>문의번호</th>
			<th>문의유형</th>
			<th>제목</th>
			<th>문의날짜</th>
			<th>상태</th>
		</thead>
		</tr>
		<tbody class="table-group-divider">
		<c:forEach var="inquiryList" items="${inquiryList }">
			<tr>
				<td>${inquiryList.iq_code }</td>
				<td>${inquiryList.iqc_name }</td>
				<td>${inquiryList.iq_title }</td>
				<td>${inquiryList.iq_date }</td>
				<td>${inquiryList.iq_state }</td>
			</tr>
		</c:forEach> --%>
		<!-- <tr>
			<td>1</td>
			<td>친구</td>
			<td>친구 추가가 안됩니다.</td>
			<td>2024-02-13</td>
			<td>대기중</td>
		</tr>
		<tr>
			<td>2</td>
			<td>포인트</td>
			<td>제 포인트 돌려주세요</td>
			<td>2024-02-10</td>
			<td>처리중</td>
		</tr>
		<tr>
			<td>3</td>
			<td>신고</td>
			<td>신고 포상같은거 없나요?</td>
			<td>2024-01-10</td>
			<td>처리완료</td>
		</tr> -->



<!-- 푸터 영역 -->
<div class="footer">
<c:import url="MemberFooter.jsp"></c:import>
</div>

</body>
</html>