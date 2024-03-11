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
<title>자유게시판 - ${boardArticle.brd_subject }</title>
<link rel="stylesheet" href="<%=cp %>/css/footer.css" />
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/main.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/article.css" />
<script type="text/javascript" src="<%=cp %>/js/freeBoardArticle.js"></script>
<style type="text/css">
	div.article-content {text-align: left; padding: 0px 50px;}
</style>

</head>
<body>

<!-- 2024-02-19 노은하 -->
<!-- 그룹내 자유게시판 상세내용 페이지 -->

<!-- 헤더 영역 -->
<div class="header">
	<c:import url="MemberHeader.jsp"></c:import>
</div>

<!-- 상단메뉴 영역 -->
<div class="menuList">
	이런메뉴... 저런메뉴... 조런메뉴...
</div>

<!-- 주요 콘텐츠 영역 -->
<div class="container">

	<!-- 좌측 고정메뉴 -->
	<div class="leftMenu">
		여기 좌측 메뉴 들어가용
	</div>
	
	<!-- 중앙 주요 컨텐츠 영역 -->
	<div class="centerContent">
	
		<!-- 게시판 정보 영역 -->
		<div class="board-info">
			<div class="board-title">[ <span class="group-name">약속해조</span> ] 자유 게시판</div>
			
			<div class="button-zone">
				<!-- 목록으로 / 이전글 / 다음글 버튼 영역 -->
				<div class="button-div">
					<button type="button" class="article-button article-list">목록으로</button>
					<button type="button" class="article-button pre-article">이전글</button>
					<button type="button" class="article-button next-article">다음글</button>
				</div>
				<div class="button-div">
					<!-- 세션에서 회원코드 받아오고 작성자랑 분기 -->
					<c:choose>
					<c:when test="${boardArticle.gm_code ==  gm_code}">
					<button type="button" class="article-button article-modify" value="${boardArticle.brd_code }">수정하기</button>
					<button type="button" class="article-button article-delete" value="${boardArticle.brd_code }">삭제하기</button>
					</c:when>
					
					<c:otherwise>
					<button type="button" class="article-button">신고하기</button>
					</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div><!-- .board-info -->
		
		<!-- 게시글 영역 -->
		<div class="content">
			
			<!-- 게시글 제목 영역 -->
			<div class="article-title">
				<div class="article-number">
					${boardArticle.num }
				</div>
				<div class="article-subject">
					${boardArticle.brd_subject }
				</div>
				<div class="wirte-user">
					작성자 : ${boardArticle.gm_nickname }
				</div>
				<div class="wirte-date">
					작성일 : ${boardArticle.brd_date }
				</div>
				<div class="article-view">
					조회수 : ${boardArticle.brd_view }
				</div>
			</div>
			
			<!-- 게시글 상세정보 영역 -->
			<div class="article-content">
				
				<!-- 게시글 내용 -->
				<div class="article-detail">
					${boardArticle.brd_content }
				</div>
			</div>
			
			<!-- 게시글 좋아요 영역 -->
			<div class="article-like">
				<c:choose>
				<c:when test="${checkArticleLike <= 0}">
				<button type="button" class="article-like-btn" value="${boardArticle.brd_code }" onclick="articleLike(this)">
					<i class="bi bi-heart" id="article-like-icon"></i>
					<span class="article-like-count">${boardArticle.brd_like }</span>
				</button>
				</c:when>
				
				<c:otherwise>
				<button type="button" class="article-unlike-btn" value="${boardArticle.brd_code }" onclick="articleUnlike(this)">
					<i class="bi bi-heart-fill" id="article-like-icon"></i>
					<span class="article-like-count">${boardArticle.brd_like }</span>
				</button>
				</c:otherwise>
				</c:choose>
			</div>
		</div>
		
		<!-- 댓글 영역 -->
		<div class="comment-list">
			<div class="comment-title">
				댓글 <span>${commentCount }</span>개
			</div>
			
			<!-- 개별 댓글 영역 -->
			<c:forEach items="${comments }" var="comment">
				<div class="comment ${gm_code == comment.commentWriterCode ? 'my-comment' : '' }">
				
					<div class="commenter-profile">
						<img src="${comment.commentWriterProfile==null ? 'images/basic-profile.png' : comment.commentWriterProfile }" alt="profile" class="profile-img" />
					</div> <!-- .commenter-profile -->
					
					<div class="comment-info">
						<div class="commenter-info">
							<div class="commenter-name">${comment.commentWriterName }</div>
							<div class="comment-create">${comment.commentDate }</div>
							
							<div class="comment-menu">
								<button type="button" class="dropdown-toggle btn" data-bs-toggle="dropdown" aria-expanded="false">
									<i class="bi bi-three-dots"></i>
								</button>
								
								<!-- 메뉴 목록 -->
								<ul class="dropdown-menu dropdown-menu-end dropdown-menu-start">
									<li><a class="dropdown-item" onclick="insertRecomment(${comment.commentCode})">댓글달기</a></li>
									<c:choose>
									<c:when test="${comment.commentWriterCode == gm_code }">
										<li><a class="dropdown-item" onclick="modifyComment(${comment.commentCode})">수정하기</a></li>
										<li><a class="dropdown-item" onclick="deleteComment(${comment.commentCode})">삭제하기</a></li>
									</c:when>
									<c:otherwise>
										<li><a class="dropdown-item" onclick="reportComment(${comment.commentCode})">신고하기</a></li>
									</c:otherwise>
									</c:choose>
								</ul>							
							</div><!-- .comment-menu -->
						</div><!-- .commenter-info -->
					
						<!-- 댓글 내용&수정하기 공간 -->
						<div class="temp">
						
							<!-- 수정하기(내 댓글에서만 사용) -->
							<div class="modify-comment-div" id="${comment.commentCode }-modify">
								<form action="" class="write-recomment write-area update-comment-form">
									<div class="write-area">
										<textarea class="comment-input" name="commentContent" id="commentContent" placeholder="타인을 비방하는 내용의 댓글은 블라인드 처리됩니다." >${comment.commentContent }</textarea>
										<input type="hidden" name="commentCode" id="commentCode" value="${comment.commentCode }">
										<input type="hidden" name="articleCode" id="articleCode" value="${comment.articleCode }">
									</div><!-- .write-area -->
									<button type="submit" class="comment-submit-btn">수정</button>
									<button type="button" class="comment-cancel-btn">취소</button>
								</form>
							</div><!-- .modify-comment-div -->
							
							<!-- 댓글 내용 -->
							<div class="comment-detail">${comment.commentContent }</div>
							
							<!-- 댓글 좋아요 정보 -->
							<div class="comment-like">
								<div class="like-button position-relative">
									<c:choose>
									<c:when test="${checkCommentLike[comment.commentCode] <= 0 }">
									<button type="button" class="comment-like-btn position-relative" onclick="insertCommentLike(this)" value="${comment.commentCode }">
										<i class="bi bi-heart"></i>
									</button>
									</c:when>
									
									<c:otherwise>
									<button type="button" class="comment-like-btn position-relative" onclick="deleteCommentLike(this)" value="${comment.commentCode }">
										<i class="bi bi-heart-fill"></i>
									</button>
									</c:otherwise>
									</c:choose>
									
									<c:if test="${comment.commentLikeCount != '0' }">
									<span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-like">${comment.commentLikeCount }</span>	
									</c:if>
								</div>
							</div><!-- .commet-like -->
							
						</div><!-- .temp -->
						
						<!-- 대댓글 달기 -->
						<div class="write-recomment" id="${comment.commentCode }-recomment">
							<form action="" method="post" class="write-recomment">
								<div class="">
									<textarea name="br_content" id="br_content" placeholder="타인을 비방하는 내용의 댓글은 블라인드 처리됩니다."></textarea>
									<input type="hidden" name="bc_code" id="bc_code" value="${comment.commentCode }">
									<input type="hidden" name="brd_code" id="brd_code" value="${boardArticle.brd_code }">
								</div>
								<button type="submit" class="comment-submit-btn">등록</button>
								<button type="button" class="comment-cancel-btn">취소</button>
							</form>
						</div><!-- .write-recomment -->
						
					</div><!-- .comment-info -->
				</div><!-- .comment -->
			</c:forEach>
			
			
			
			
			<div class="comment">
				<div class="commenter-profile">
					<img src="<%=cp %>/images/basic-profile.png" alt="profile" class="profile-img" />
				</div>
				
				<div class="comment-info">
					<div class="commenter-info">
						<div class="commenter-name">금하</div>
						<div class="comment-create">2024-02-17</div>
						<div class="comment-menu">
							<button type="button" class="dropdown-toggle btn" data-bs-toggle="dropdown" aria-expanded="false">
								<i class="bi bi-three-dots"></i>
							</button>
							<ul class="dropdown-menu dropdown-menu-end dropdown-menu-start">
								<li><a href="" class="dropdown-item">댓글달기</a></li>
								<li><a href="" class="dropdown-item">신고하기</a></li>
							</ul>
						</div>
					</div>
					<div class="comment-detail">
						투썸가서 스초생 한판먹장
					</div>
					<div class="comment-like">
						<div class="like-button position-relative">
							<i class="bi bi-heart"></i>
							<span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-like">
								99
							</span>						
						</div>
					</div>
					
					<!-- 댓글별 대댓글 영역 -->
					<div class="recomment">
						<div class="commenter-profile">
							<img src="<%=cp %>/images/basic-profile.png" alt="profile" class="profile-img"/>
						</div>
						
						<div class="comment-info">
							<div class="commenter-info">
								<div class="commenter-name">부적응자</div>
								<div class="comment-create">2024-02-17</div>
								<div class="comment-menu">
									<i class="bi bi-three-dots"></i>
								</div>
							</div>
							<div class="comment-detail recomment-detail">
								아이스박스 아니면 안 감
							</div>
							<div class="comment-like">
								<div class="like-button position-relative">
									<i class="bi bi-heart"></i>
								</div>
							</div>
						</div>
					</div>
					
					<div class="recomment">
						<div class="commenter-profile">
							<img src="<%=cp %>/images/basic-profile.png" alt="profile" class="profile-img"/>
						</div>
						
						<div class="comment-info">
							<div class="commenter-info">
								<div class="commenter-name">금하</div>
								<div class="comment-create">2024-02-17</div>
								<div class="comment-menu">
									<i class="bi bi-three-dots"></i>
								</div>
							</div>
							<div class="comment-detail recomment-detail">
								걍 오지마
							</div>
							<div class="comment-like">
								<div class="like-button position-relative">
									<i class="bi bi-heart-fill"></i>
									<span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-like">
										5
									</span>
								</div>
							</div>
						</div>
					</div>
					
				</div>
			
			</div>
			
			<div class="comment my-comment">
				<div class="comment-info">
					<div class="commenter-info mycomment-info">
						<div class="commenter-name">노은하(나)</div>
						<div class="comment-create">2024-02-17</div>
						<div class="comment-menu">
							<i class="bi bi-three-dots"></i>
						</div>
					</div>
					
					<div class="comment-like">
						<div class="like-button position-relative">
							<i class="bi bi-heart"></i>
							<span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-like">
								4
							</span>						
						</div>
					</div>
					
					<div class="comment-detail mycomment-detail">
						여기서 싸우지말고 나가<br>
						줄바꿈
					</div>
				</div>
					
				<div class="commenter-profile">
					<img src="<%=cp %>/images/basic-profile.png" alt="profile" class="profile-img" />
				</div>
			
			</div>
			
			
		</div><!-- div.comment-list -->
		
		<!-- 댓글 입력하기 창 -->
		<div class="write-comment">
			<form action="freeboardcommentinsert.woori" class="board-comment-form write-area" method="post"  id="boardCommentForm">
				<textarea class="comment-input" id="commentContent" name="commentContent" placeholder="타인을 비방하는 내용의 댓글은 블라인드 처리됩니다."></textarea>
				<input type="hidden" name="articleCode" id="articleCode" value="${boardArticle.brd_code }">
				<input type="hidden" name="commentWriterCode" id="commentWriterCode" value="${gm_code }">
				<div class="submit-and-count">
					<button type="button" class="comment-submit-btn">등록</button>
					<span class="count"><span class="now-count">0</span> / 200</span>
				</div>
			</form>
		</div>
		
	</div>
</div>

<!-- 푸터 영역 -->
<div class="footer">
<c:import url="MemberFooter.jsp"></c:import>
</div>

</body>
</html>