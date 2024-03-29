<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminInquiryList.jsp</title>

<!-- 부트스트랩 적용 CSS -->
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

<!-- 부트스트랩 관련 스크립트 적용 JS -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- 부트스트랩 아이콘 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">

<!-- 제이쿼리 적용 JS -->
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>

<link rel="stylesheet" type="text/css" href="<%=cp%>/css/adminHeader.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/adminList.css">

<script type="text/javascript">

	// 리스트 카테고리별 분기
	function categoryFilter()
	{
		var category = $("#category").val();
		$(location).attr("href", "admininquirycategorylist.woori?category=" + category);
	}

	// 리스트 처리상태(접수완료/관리자검토중/처리완료)별 분기
    function statusFilter() 
    {
    	
        var iq_status = $("#iq_status").val();        
        //var count = $("#count").val();
        //$(location).attr("href", "inquirystatuslist.action?status=" + status + "&count=" + count);
        $(location).attr("href", "admininquirystatuslist.woori?iq_status=" + iq_status);
        
    }
    
    $(document).ready(function() 
	{	
    	// 이전에 저장된 카테고리 값을 가져옴
        var savedCategory = localStorage.getItem("savedCategory");
        if (savedCategory) 
        {
        	// 이전에 저장된 카테고리가 있으면 해당 값을 #category 요소의 값으로 설정
            $("#category").val(savedCategory);
        }
		
        // #category 요소의 값이 변경될 때마다 실행될 함수
        $("#category").change(function() 
  		{
        	// 변경된 카테고리 값을 로컬 스토리지에 저장
            localStorage.setItem("savedCategory", $(this).val());
        });

     	// 이전에 저장된 IQ 상태 값을 가져옴
        var savedStatus = localStorage.getItem("savedStatus");
        if (savedStatus) 
        {
        	// 이전에 저장된 IQ 상태가 있으면 해당 값을 #iq_status 요소의 값으로 설정
            $("#iq_status").val(savedStatus);
        }
        
     	// #iq_status 요소의 값이 변경될 때마다 실행될 함수
        $("#iq_status").change(function() 
   		{
        	// 변경된 IQ 상태 값을 로컬 스토리지에 저장
            localStorage.setItem("savedStatus", $(this).val());
        });
     	
		
     	
    });
</script>



</head>
<body>



<div class="header">
	<c:import url="AdminHeader.jsp"></c:import>
</div>


<div class="container">

<h1>문의사항</h1><hr>
<div class="list_result">
	<!-- 게시물 갯수 -->
    <p class="result_count">
   	    <span id="count">${count }</span>건
    </p>
    
    <!-- 검색창 -->
    <div class="inquiry_category">
	    <form action="" class="searchForm">
           <input type="text" class="search_input" id="search_input" name="search_input">
           <button type="submit" class="search_btn" id="search_btn" name="search_btn"><i class="bi bi-search"></i></button> 
	   </form>
   </div>
   
</div>
<!-- 리스트 -->
<div class="tbl_col_wrap">
	<table class="tbl_col_line">
		<colgroup>
	        <col style="width: 75px" />
	        <col style="width: 100px" />
	        <col style="width: 200px;" />
	        <col style="width: 125px;" />
	        <col style="width: 125px;" />
	        <col style="width: 125px;" />
	        <col style="width: 125px;" />
		</colgroup>
		<thead>
		    <tr>
	            <th scope="col">NO</th>
	            <th scope="col">
					<select class="category" id="category" onchange="categoryFilter()">
		               <option value="">문의유형(전체)</option>
		               <!-- 
		               <option value="" >전체</option>
		               <option value="1">로그인</option>
		               <option value="2">그룹</option>
		               <option value="3">모임</option>
		               <option value="4">기타</option> -->
		               <c:forEach var="category" items="${inquiryCategory }">
		               <option value="${category.iqc_code }">${category.iqc_name }</option>
		               </c:forEach>
		               
		            </select>
				</th>
	            <th scope="col">제목</th>
	            <th scope="col">문의자</th>
	            <th scope="col">문의일</th>
	            <th scope="col">담당자</th>
	            <th scope="col">
					<select class="iq_status" id="iq_status" onchange="statusFilter()">
					    <option>처리상태</option>
					    <option value="" >전체</option>
					    <option value="1">접수완료</option>
					    <option value="2">관리자 검토중</option>
					    <option value="3">처리완료</option>	
					</select>
				</th>
	        </tr>
		</thead>
		<tbody>
			<c:forEach var="inquiry" items="${inquiryList }">
			<c:set var="i" value="${i+1 }"></c:set>
			<tr>
				<td>${i }</td>
				<td>${inquiry.iqc_name }</td>
				<td><a href="admininquiryarticle.woori?iq_code=${inquiry.iq_code }&ad_code=${inquiry.ad_code }">${inquiry.iq_title }</a></td>
				<td>${inquiry.us_id }</td>
				<td>${inquiry.iq_date }</td>
				<td>${inquiry.ad_code== 0 ? "" : inquiry.ad_code }</td>				
				<c:choose>
					<c:when test="${inquiry.iq_status==1 }">
						<td><span class="badge bg-danger">접수완료</span></td>
					</c:when>
					<c:when test="${inquiry.iq_status==2 }">
						<td><span class="badge bg-primary">관리자 검토중</span></td>
					</c:when>
					<c:otherwise>
						<td><span class="badge bg-secondary">처리완료</span></td>
					</c:otherwise>
				</c:choose>
			</tr>
			</c:forEach>
			
			
		</tbody>
	</table>
	
	<!-- 페이징 처리 영억 -->
      <div class="paging" align="center">
         <nav class="page-nav">
            <a href="" class="page-control pre-page">이전 페이지</a>
            <ul class="page-list">
               <li>
                  <a href="" class="page-control first-page-control">1</a>
               </li>
               <li><a href="" class="page-control pre-page">...</a></li>
               <li><a href="" class="page-control">11</a></li>
               <li><a href="" class="page-control">12</a></li>
               <li><a href="" class="page-control">13</a></li>
               <li><a href="" class="page-control">14</a></li>
               <li><a href="" class="page-control now-page">15</a></li>
               <li><a href="" class="page-control">16</a></li>
               <li><a href="" class="page-control">17</a></li>
               <li><a href="" class="page-control">18</a></li>
               <li><a href="" class="page-control">19</a></li>
               <li><a href="" class="page-control">20</a></li>
               <li><a href="" class="page-control next-page">...</a></li>
               <li>
                  <a href="" class="page-control last-page-control">68</a>
               </li>
            </ul>
            <a href="" class="page-control next-page">다음 페이지</a>
         </nav>
      </div>
	
	
</div>

</div>
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
</body>
</html>