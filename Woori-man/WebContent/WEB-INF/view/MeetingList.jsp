<%@page import="java.util.ArrayList"%>
<%@page import="com.woori.dto.MeetingDTO"%>
<%@page import="com.project.woori.PagingUtil"%>
<%@page import="java.net.URLDecoder"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%
	// 2024-02-24 노은하
	// 페이징
	String strNum = request.getParameter("num");
	int num=0;
	if(strNum!=null)
		num = Integer.parseInt(strNum);
	
	String pageNum = request.getParameter("pageNum");
	int currentPage = 1;
	if(pageNum != null)
		currentPage = Integer.parseInt(pageNum);
	
	String searchKey = request.getParameter("searchKey");
	String searchValue = request.getParameter("searchValue");
	
	if(searchKey != null)
	{
		if(request.getMethod().equalsIgnoreCase("GET"))
			// 디코딩 처리
			searchValue = URLDecoder.decode(searchValue, "UTF-8");
	}
	else
	{
		searchKey = "title";
		searchValue = "";
	}
	
	PagingUtil myUtil = new PagingUtil();
	
	ArrayList<MeetingDTO> lists = (ArrayList<MeetingDTO>)request.getAttribute("meetingList");
	int dataCount = lists.size();
	
	int numPerPage = 10;
	int totalPage = myUtil.getPageCount(numPerPage, dataCount);
	
	if(currentPage > totalPage)
		currentPage = totalPage;
	
	int start = (currentPage-1) * numPerPage + 1;
	int end = currentPage * numPerPage;
	
	
	String param = "";
	
	if(!searchValue.equals(""))
	{
		param += "?searchKey=" + searchKey;
		param += "&searchValue=" + searchValue;
	}
	
	String listUrl = "/groupmeetinglist.woori" + param;
	
	String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);
	
	// 글 내용 보기 주소
	String articleUrl = cp + "/Article.jsp";
	
	if(param.equals(""))
		articleUrl = articleUrl + "?pageNum=" + currentPage;
	else
		articleUrl = articleUrl + param + "&pageNum=" + currentPage;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MeetingList</title>
<link rel="stylesheet" href="<%=cp %>/css/footer.css" />
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/main.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/articleList.css" />

<style type="text/css">

	div.content-column {display: block;}
	form.filter-form {display: flex; justify-content: space-between;}
	select.column-filter {background-color: #ff8a3d; border: none; text-align: center; color: white; border-radius: 30px; padding: 5px;}
	select.column-filter:hover {background-color: #ff6f0f;}
	option {background: white; text-align: center; color: black; font-family: 맑은 고딕;}
	
	span.meeting-vote {font-family: 라인Seed; background-color: red; border-radius: 50px; vertical-align: top; color: white;}
	span.meeting-complete {font-family: 라인Seed; background-color: blue; border-radius: 50px; vertical-align: top; color: white;}
	span.meeting-cancel {font-family: 라인Seed; background-color: gray; border-radius: 50px; vertical-align: top; color: white;}
	
	.meeting-category {width: 100px;}
	.article-title {width: 350px;}
	.meeting-date {width: 120px;}
	.meeting-status {width: 120px;}
	
	span.meeting-badge {display: inline-block; border-radius: 20px; font-family: 라인Seed; color: white; background: #ff8000; padding: 5px 7px 1px 7px;}
	span.meeting-regular {background-color: #ff8a3d;}
	span.meeting-irregular {background-color: #ffd400;}
	span.meeting-vote {background-color: #d1180b;}
	span.meeting-complete {background-color: #0067a3;}
	span.meeting-cancel {background-color: gray;}
	
	@media screen and (min-width: 0px)
	{
		.container {max-width: 1320px; width: 1320px;}
	}
	
</style>
<script type="text/javascript">

	$(function()
	{
		// 2024-03-03 노은하
		// 정기모임 발의가 가능한 직위는 정기모임, 번개모임 무엇을 발의할것인지 분기
		$(".create-article").click(function()
		{
			var position = ${member.pos_code};
			if (position == '1' || position == '2')
				$("#modal-btn").click();
			else
				window.location.href="meetinginsertform.woori?mc_code=2";
		});
	});

</script>

</head>
<body>

<!-- 2024-02-11 노은하 -->
<!-- 각 그룹별 모임 목록 페이지 -->

<!-- 헤더 영역 -->
<div class="header">
	<c:import url="MemberHeader.jsp"></c:import>
</div>

<!-- 상단메뉴 영역 -->
<div class="menuList">
	이런메뉴... 저런메뉴... 조런메뉴...
</div>

<div class="mainContent">

	<!-- 좌측 고정메뉴 -->
	<div class="leftMenu">
		여기 좌측 메뉴가 들어갑ㄴ미다
	</div>
	
	<!-- 중앙 주요 컨텐츠 영역 -->
	<div class="centerContent">
	
		<!-- 게시판 정보 -->
		<div class="board-info">
		
			<!-- 추후 세션에서 그룹명 받아오기 -->
			<div class="board-title">[ <span class="group-name">약속해조</span> ] 모임 게시판</div>
		
		</div>
		
		<!-- 게시글 검색 영역 -->
		<div class="content-search">
		
				<div class="count-article">
					새글 <span id="new-article">${articleCount }</span> / <span id="total-article">${fn:length(meetingList) }</span>
				</div>
				
			<form action="" class="search-form">
				<select name="searchCategory" id="searchCategory" class="search-category">
					<option value="mt_title">제목</option>
					<option value="mt_wrtite">발의자</option>
					<option value="mt_meet">모임일</option>
				</select>
				<input type="text" name="searchContent" class="search-bar" />
				<button type="submit" class="btn-search"><i class="bi bi-search"></i></button>
			</form>
			
		</div><!-- .content-search -->
		
		<div class="content-list-div">
		
			<!-- 게시글 컬럼명 영역 -->
			<div class="content-column">
			
				<form action="" class="filter-form">
					<div class="content-column-name article-number">글번호</div>
	
					<!-- 전체보기 / 정기모임 / 번개모임 -->
					<div class="content-column-name meeting-category">
					
						<select class="column-filter" name="meeting-category" id="meeting-category">
							<option selected="selected">모임종류</option>
							<option value="regular">정기모임</option>
							<option value="irregular">번개모임</option>
						</select>
						
					</div>
					
					<div class="content-column-name article-title">제목</div>
					<div class="content-column-name write-user">발의자</div>
					<div class="content-column-name write-date">발의일</div>
					
					<!-- 전체보기 / 빠른순 / 느린순 -->
					<div class="content-column-name meeting-date">
					
						<select name="meeting-date" id="meeting-date" class="column-filter">
							<option selected="selected">모임일시</option>
							<option value="asc">빠른순</option>
							<option value="desc">느린순</option>
						</select>
						
					</div>
				
					<!-- 전체보기 / 참석여부 확인중 / 확정된 모임 / 철회된 모임 -->
					<div class="content-column-name meeting-status">
					
						<select class="column-filter" name="meeting-state" id="meeting-state">
							<option selected="selected">모임상태</option>
							<option value="">참석여부 확인중</option>
							<option value="">확정된 모임</option>
							<option value="">철회된 모임</option>
						</select>
									
					</div>
				</form>
			</div><!-- div.content-column -->
			
			
			<!-- 게시글 목록 영역 -->
			<div class="content-list">
			
				<!-- 컨트롤러에서 받아온 게시글 정보 배열 lists에서 하나씩 꺼내오기 -->
				<c:forEach var='meeting' items="<%=lists %>">
				
				<div class="article">
				
					<div class="article-number article-element">${meeting.num }</div>
					
					<!-- 정기모임 / 번개모임 뱃지 달아주기 -->						
					<div class="meeting-category article-element">
					<c:choose>
						<c:when test="${meeting.mc_code==1}">
							<span class="meeting-regular meeting-badge">정기모임</span>
						</c:when>
						
						<c:when test="${meeting.mc_code==2}">
							<span class="meeting-irregular meeting-badge">번개모임</span>
						</c:when>
					</c:choose>
					</div><!-- .meeting-category -->
					
					<!-- 모임 제목(글제목) -->
					<div class="article-title article-element">
						<a href="meetingarticle.woori?mt_code=${meeting.mt_code }">${meeting.mt_title }</a>
					</div>
					
					<!-- 발의자(작성자) -->
					<div class="write-user article-element">
						${meeting.gm_nickname }
					</div>
						
					<!-- 발의일(작성일) -->
					<div class="write-date article-element">
						${meeting.mt_date }
					</div>
					
					<!-- 모임 예정일 -->
					<div class="meeting-date article-element">
						${meeting.mt_meet }
					</div>
					
					<!-- 모임 상태 -->
					<c:set var="mt_status" value="${meeting.mt_status }"></c:set>
					<div class="meeting-status article-element">
						<c:choose>
							<c:when test="${mt_status==1 }">
								<span class="meeting-vote meeting-badge">참석여부 확인중</span>
							</c:when>
							<c:when test="${mt_status==2 }">
								<span class="meeting-complete meeting-badge">모임확정</span>
							</c:when>
							<c:when test="${mt_status==3 }">
								<span class="meeting-cancel meeting-badge">모임철회</span>
							</c:when>
						</c:choose>
					</div>
				</div><!-- .article -->
				<!-- 모임글 하나 forEach 끝 이제 다음 객체로 다시 반복 -->
				</c:forEach>
				
			</div><!-- .content-list -->
			<!-- 모임글 목록 출력 끝 -->
			
		</div><!-- content-list-div -->
		
		<!-- 하단 모임발의(새글쓰기) / 내글보기 버튼 영역 -->
		<div class="button-div">
			<button type="button" class="article-button create-article">모임발의</button>
			<button type="button" class="article-button my-article">내글보기</button>
		</div>
		
		<!-- 페이징 처리 영역 -->
		<div class="paging" align="center">
			<nav class="page-nav">
				<%
				if (dataCount != 0)
				{
				%>
					<%=pageIndexList %>
				<%
				}
				else
				{
				%>
					등록된 게시물이 존재하지 않습니다.
				<%
				}
				%>
			</nav>
		</div><!-- .paging -->
	</div><!-- centerContent -->
</div><!-- mainContent -->

<c:import url="MeetingCategoryModal.jsp"></c:import>

<!-- 푸터 영역 -->
<div class="footer">
<c:import url="MemberFooter.jsp"></c:import>
</div>



</body>
</html>