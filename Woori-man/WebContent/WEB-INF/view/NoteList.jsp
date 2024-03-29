<%@page import="com.woori.dto.UserDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.woori.dto.NoteDTO"%>
<%@page import="com.woori.dao.NoteDAO"%>
<%@page import="com.woori.util.PagingUtil"%>
<%@page import="java.net.URLDecoder"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
String cp = request.getContextPath();
%>
<%
	//페이징
	String strNum = request.getParameter("num");
	int num=0;
	if(strNum!=null)
		num = Integer.parseInt(strNum);
	
	String pageNum = request.getParameter("pageNum");
	int currentPage = 1;
	if(pageNum != null)
		currentPage = Integer.parseInt(pageNum);
	
	PagingUtil myUtil = new PagingUtil();
	
	int dataCount = (Integer)request.getAttribute("allSendNote");
	int numPerPage = 10;
	int totalPage = myUtil.getPageCount(numPerPage, dataCount);
	
	if(currentPage > totalPage)
		currentPage = totalPage;
	
	int start = (currentPage-1) * numPerPage + 1;
	int end = currentPage * numPerPage;

	NoteDAO dao = new NoteDAO();
	dao.connection();
	ArrayList<NoteDTO> sendNote = null;
	String sender = ((UserDTO)session.getAttribute("userDTO")).getUs_code();
	sendNote = dao.sendNoteList(sender, start, end);
	dao.close();
	
	String param = "";
	
	String listUrl = "notelist.woori" + param;
	
	String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);
	
	// 글 내용 보기 주소
	/*
	String articleUrl = "meetingarticle.woori";
	
	if(param.equals(""))
		articleUrl = articleUrl + "?pageNum=" + currentPage;
	else
		articleUrl = articleUrl + param + "&pageNum=" + currentPage;
	*/



%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>NoteList.jsp</title>

<!-- 부트스트랩 적용 CSS -->
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

<!-- 부트스트랩 관련 스크립트 적용 JS -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- 제이쿼리 적용 JS -->
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>

<!-- 부트스트랩 아이콘 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">

<link rel="stylesheet" href="css/memberHeader.css">
<link rel="stylesheet" href="css/footer.css">

<style>
	@font-face {
		font-family: '라인Seed';
		src:
			url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_11-01@1.0/LINESeedKR-Bd.woff2')
			format('woff2');
		font-weight: 700;
		font-style: normal;
	}
	
	body {
		font-family: 라인Seed;
		font-size: 15pt;
		margin: 0;
		padding: 0;
	}
	
	.container {
		max-width: 70%;
		margin: 20px auto;
		background-color: #fff;
		padding: 20px;
		border-radius: 5px;
		box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	}
	
	h2 {
		text-align: center;
	}
	
	.message-table th, .message-table td {
		border: 1px solid #ddd;
		padding: 10px;
		border-left: none;
		border-right: none;
	}
	
	.message-table th {
		text-align: center;
		border-color: #ff8000;
	}
	
	.message-table td {
		text-align: center;
	}
	
	.message-item:hover {
		background-color: #f9f9f9;
	}
	
	.message-item .sender {
		font-weight: bold;
	}
	
	.message-item .date {
		color: #999;
		font-size: 12px;
	}
	
	.message-item .subject {
		margin-top: 5px;
	}
	
	.btn {
		padding: 10px 20px;
		background-color: #ff8000;
		color: #fff;
		border: none;
		border-radius: 5px;
		cursor: pointer;
		text-decoration: none;
	}
	
	.btn:hover {
		color: black;
		background-color: #ff8000;
	}
	
	.compose-btn {
		display: flex;
		justify-content: space-between;
		margin-top: 20px;
	}
	
	.message {
		background-color: #ff8000;
		color: white;
		border-radius: 10px;
	}
	
	.message:hover {
		color: black;
	}
	
	.header-menu {
		padding-bottom: 100px;
	}
	
	.bi-envelope {
		font-size: 25pt;
		color: #ff8000;
	}
	
	select {
		border-radius: 10px;
		color: black;
		border: 1px solid #ff8000;
		height: 25px;
	}
	
	option {
		background-color: white;
		color: black;
	}
	
	.table-wrap {
		box-sizing: border-box;
	}
	
	table {
		/* width: 100%; */
		
	}
	
	.nav-link {
		color: black;
	}
	
	.message-kind {
		display: flex;
		justify-content: space-between;
	}
	
	a {
		color: black;
		text-decoration: none;
	}
	
	.table.active {
		display: table;
	}
	
	.title {
		cursor: pointer;
	}
	
	.modal-body
	{	overflow-y: auto; /* 수직 스크롤바 설정 */
        max-height: 400px; /* 최대 높이 설정 */
    }
     
    ::-webkit-scrollbar {
	    width: 10px;
	    height: 10px;
		}
	
		::-webkit-scrollbar-track {
		    background: #f1f1f1;
		}
		
		::-webkit-scrollbar-thumb {
		    background: #888;
		    border-radius: 5px;
		}
		
		::-webkit-scrollbar-thumb:hover {
		    background: #555;
		} 
		
		table.table.note-article>tr>th 
		{
			width: 100px;
		}
	
	div.paging
{ margin-top: 50px;}

nav.page-nav
{
	display: flex;
    justify-content: space-around;
    align-items: baseline;
}

ul.page-list
{
	display: flex;
    justify-content: space-between;
    list-style: none;
}

a.page-control
{
	padding: 3.5px 6px;
	border: 1px solid #b5b5b5;
	margin: 4px;
	text-decoration: none;
	color: #363636;
	font-size: 10pt;
	border-radius: 4px;
	display: inline-flex;
}

a.page-control:hover
{
	background-color: #ff8a3d;
	border: 1px solid #ff8a3d;
	color: white;
}

a.page-control.now-page
{
	background-color: #ff8000;
	border: 1px solid #ff8000;
	color: white;
	font-weight: bold;
}

a.first-page-control, a.last-page-control
{ margin: 4px 20px;}
     
</style>

<script>
	$(document).ready(function()
	{
		// 보낸쪽지 탭 클릭 시 
		$("#send-tab").click(function()
		{
			$(".form-check-input").removeAttr("checked");
			$(".compose-btn").find(".btn-delete").attr("onclick", "deleteSendNote()");
		});
		
		
		/*
		$(".nav-link").click(function() {
	        var tabId = $(this).attr("id");
	        // 현재 선택된 탭에 해당하는 테이블의 체크박스들을 선택/해제
	        $("#" + tabId).find("input[type='checkbox']").prop("checked", $("#selectAll-" + tabId).prop("checked"));
	    });

	    // 각 탭의 체크박스 중 하나라도 선택되었을 때 전체 선택/해제 버튼의 상태를 조정
	    $("input[type='checkbox']").click(function() {
	        var tabId = $(this).closest("table").attr("id");
	        var totalCheckbox = $("#" + tabId).find("input[type='checkbox']").length;
	        var checkedCheckbox = $("#" + tabId).find("input[type='checkbox']:checked").length;
	        if (totalCheckbox === checkedCheckbox) {
	            $("#selectAll-" + tabId).prop("checked", true);
	        } else {
	            $("#selectAll-" + tabId).prop("checked", false);
	        }
	    });
		*/
		
		
		// 전체 수신 쪽지 클릭 시
		$("li.receive-note").click(function()
		{
			$(".form-check-input").removeAttr("checked");
			$(".compose-btn").find(".btn-delete").attr("onclick", "deleteReceiveNote()");
		});
		
		// 제목 클릭 시 쪽지 내용 보여주기
		$(".title").click(function()
		{
			//		 클릭한 타이틀   td  안에 있는    안에 있는   의 input  의 value
			var note_code = $(this).prev().find("div").children().first().val(); 
			//alert(note_code);
			// 보류..
			//alert($(this).find(".read-status").children().first().text());
			
			var params = "note_code=" + note_code;
			//alert(params);
			
			$.ajax(
			{
				type: "GET"
				, url: "notearticle.woori"
				, data: params
				, success: function(args)
				{
					//alert("다녀옴");
					//alert(args);
					$("#modal-result").html(args);
					$("#messageModal1").modal("show");
					
				}
				, error: function(e)
				{
					alert(e.responseText);
				}
			});
			
			
			
			//var note_code = $("#receiveNote");
			//alert(note_code);

			/* $(location).attr("href", "notearticle.action?note_code=" + note_code); */

			/* var note_code = $("")
			
			var params = "note_code=" + note_code; 
			
			}); */
		});


		// 쪽지 체크박스 전체 선택
		/* $('#selectAll').click(function(event)
		{
			$(":checkbox").prop("checked",true);
			$(":checkbox").prop("checked",false);
			 
			if ($("#selectAll").prop("checked")) 
			{
		        //$("input[name=selectAll]").prop("checked", true)
				$(":checkbox").prop("checked",true);
	        }
			else 
			{
	            //$("input[name=selectAll]").prop("checked", false)
				$(":checkbox").prop("checked",false);
	        }
		}); */
		
		$(".btn-close").click(function()
		{
			$(location).attr("href", "notelist.woori");
		});

			
		// 누른 탭의 쪽지 전체 선택
		/*$("#selectAll").click(function()
		{
			if (".nav-link active")
			{
			    if($("#selectAll").is(":checked"))
		    	{
			        $("input[type=checkbox]").prop("checked", true);
		    	}
			    else
		    	{
			        $("input[type=checkbox]").prop("checked", false);
		    	}
			
			}
		    
		});
		  
		$("input[name=selectReceive]").click(function()
		{
		    var totalArr = $("input[name=selectReceive]").length;
		    var checked = $("input[name=selectReceive]:checked").length;
		    
		    if(totalArr != ckecked)
		    {
		      $("#selectAll").prop("checked", false);
		    }
		    else
		    {
		      $("#selectAll").prop("checked", true);
		    }
	   });*/
	   

		
		

	});
	
	// 각 탭에서 전체 선택 체크박스를 클릭할 때 해당 탭에 있는 모든 쪽지 체크박스를 선택하는 함수
	function selectAllMessagesInTab(tabId) {
	    $("#" + tabId + " input[type='checkbox']").prop("checked", $("#" + tabId + " #selectAll-" + tabId).prop("checked"));
	}
	
	// 각 탭에서 선택된 모든 쪽지를 삭제하는 함수
	function deleteAllMessagesInTab(tabId) {
	    var check = $("#" + tabId + " .form-check-input:checked");
	    var delCode = "";
	    for (var i = 0; i < check.length; i++) {
	        delCode += check[i].value + "/";
	    }
	    var index = delCode.length;
	    delCode = delCode.substring(0, index - 1);

	    
	}
	
	// 받은 쪽지 삭제
	function deleteReceiveNote()
	{
		//alert("수신 삭제~");
		var check = $(".form-check-input:checked");
		var delCode = "";
		for(var i=0; i<check.length; i++)
		{
			delCode += check[i].value + "/";
		}
		var index = delCode.length;
		delCode = delCode.substring(0, index-1);
		
		$(location).attr("href", "receivenotedelete.woori?del_code=" + delCode);
	}
	
	// 보낸 쪽지 삭제
	function deleteSendNote()
	{
		//alert("발신 삭제~");
		var check = $(".form-check-input:checked");
		var delCode = "";
		for(var i=0; i<check.length; i++)
		{
			delCode += check[i].value + "/";
		}
		var index = delCode.length;
		delCode = delCode.substring(0, index-1);
		
		$(location).attr("href", "sendnotedelete.woori?del_code=" + delCode);
	}
</script>

</head>
<body>

	<div class="header">
		<c:import url="MemberHeader.jsp"></c:import>
	</div>	
	
	<div class="container">
		<h2>
			<i class="bi bi-envelope"></i> 쪽지함 <i class="bi bi-envelope"></i>
		</h2>
		<hr>
		<div class="message-kind">
			
			<div class="nav nav-tabs" id="nav-tab" role="tablist">
				    <button class="nav-link active" id="nav-receive-tab" data-bs-toggle="tab" data-bs-target="#receive" 
				    type="button" role="tab" aria-controls="receive" aria-selected="true">전체 수신 쪽지</button>
				    <button class="nav-link" id="nav-friend-tab" data-bs-toggle="tab" data-bs-target="#friend" 
				    type="button" role="tab" aria-controls="friend" aria-selected="false">친구 수신 쪽지</button>
				    <button class="nav-link" id="nav-admin-tab" data-bs-toggle="tab" data-bs-target="#admin" 
				    type="button" role="tab" aria-controls="admin" aria-selected="false">관리자 수신 쪽지</button>
				    <button class="nav-link" id="nav-send-tab" data-bs-toggle="tab" data-bs-target="#send" 
				    type="button" role="tab" aria-controls="send" aria-selected="false">발신 쪽지</button>
				    
				</div>
			
		</div>

		<div class="table-wrap tab-content">
			<!-- <table class="table message-table tab-pane fade in active" id="receive"> -->
			<table class="table message-table tab-pane fade show active" id="receive" role="tabpanel" aria-labelledby="nav-receive-tab">
				<thead>
					<tr>
						<th>
							<div class="form-check">
								<input class="form-check-input" type="checkbox" id="selectAll"
									name="selectAll" onclick="selectAllMessagesInTab()"> <label class="form-check-label"
									for="selectAll"></label>
							</div>
						</th>
						<th>제목</th>
						<th>발신자</th>
						<th>수신자</th>
						<th>날짜</th>
						<th><select>
								<option>읽음상태</option>
								<option>읽음</option>
								<option>읽지않음</option>
						</select></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="receive" items="${receiveNote }">
						<tr class="message-item">
							<td>
								<div class="form-check">
									<input class="form-check-input" type="checkbox"
										value="${receive.note_code }" id="selectReceive" name="selectReceive"> <label
										class="form-check-label" for="selectReceive"></label>
								</div>
							</td>
							<td class="title">${receive.note_title }</td>
							<td>${receive.senderid }</td>
							<td>${receive.receiverid }</td>
							<td>${receive.note_date }</td>
							<td class="read-status">
							<c:choose>
								<c:when test="${receive.note_status=='1' }">
									<span class="badge bg-secondary">읽음</span>
								</c:when>
								<c:otherwise>
									<span class="badge bg-danger">읽지않음</span>
								</c:otherwise>
							</c:choose>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<table class="table message-table tab-pane fade" id="send" role="tabpanel" aria-labelledby="nav-send-tab">
				<thead>
					<tr>
						<th>
							<div class="form-check">
								<input class="form-check-input" type="checkbox" id="selectAll"
									name="selectAll"> <label class="form-check-label"
									for="selectAll"></label>
							</div>
						</th>
						<th>제목</th>
						<th>발신자</th>
						<th>수신자</th>
						<th>날짜</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="send" items="<%= sendNote %>">
						<tr class="message-item">
							<td>
								<div class="form-check">
									<input class="form-check-input" type="checkbox"
										value="${send.note_code }" id="selectSend" name="selectSend">
									<label class="form-check-label" for="selectSend"></label>
								</div>
							</td>
							<td class="title">${send.note_title }</td>
							<td>${send.senderid }</td>
							<td>${send.receiverid }</td>
							<td>${send.note_date }</td>
						</tr>
					</c:forEach>
					<tr>
					
					</tr>
				</tbody>
			</table>
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
			<table class="table message-table tab-pane fade" id="admin" role="tabpanel" aria-labelledby="nav-admin-tab">
				<thead>
					<tr>
						<th>
							<div class="form-check">
								<input class="form-check-input" type="checkbox" value=""
									id="selectAll" name="selectAll"> <label class="form-check-label"
									for="selectAll"></label>
							</div>
						</th>
						<th>제목</th>
						<th>발신자</th>
						<th>수신자</th>
						<th>날짜</th>
						<th><select>
								<option>읽음상태</option>
								<option>읽음</option>
								<option>읽지않음</option>
						</select></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="receiveAdmin" items="${receiveAdminNote }">
						<tr class="message-item">
							<td>
								<div class="form-check">
									<input class="form-check-input" type="checkbox"
										value="${receiveAdmin.note_code }" id="selectAdmin"
										name="selectAdmin"> <label class="form-check-label"
										for="selectAdmin"></label>
								</div>
							</td>
							<td class="title">${receiveAdmin.note_title }</td>
							<td>${receiveAdmin.senderid }</td>
							<td>${receiveAdmin.receiverid }</td>
							<td>${receiveAdmin.note_date }</td>
							<c:choose>
								<c:when test="${receiveAdmin.note_status=='1' }">
									<td><span class="badge bg-secondary">읽음</span></td>
								</c:when>
								<c:otherwise>
									<td><span class="badge bg-danger">읽지않음</span></td>
								</c:otherwise>
							</c:choose>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<table class="table message-table tab-pane fade" id="friend" role="tabpanel" aria-labelledby="nav-friend-tab">
				<thead>
					<tr>
						<th>
							<div class="form-check">
								<input class="form-check-input" type="checkbox" id="selectAll"
									name="selectAll"> <label class="form-check-label"
									for="selectAll"></label>
							</div>
						</th>
						<th>제목</th>
						<th>발신자</th>
						<th>수신자</th>
						<th>날짜</th>
						<th><select>
								<option>읽음상태</option>
								<option>읽음</option>
								<option>읽지않음</option>
						</select></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="receiveFriend" items="${receiveFriendNote }">
						<tr class="message-item">
							<td>
								<div class="form-check">
									<input class="form-check-input" type="checkbox"
										value="${receiveFriend.note_code }" id="selectFriend"
										name="selectFriend"> <label class="form-check-label"
										for="selectFriend"></label>
								</div>
							</td>
							<td class="title">${receiveFriend.note_title }</td>
							<td>${receiveFriend.senderid }</td>
							<td>${receiveFriend.receiverid }</td>
							<td>${receiveFriend.note_date }</td>
							<c:choose>
								<c:when test="${receiveFriend.note_status=='1' }">
									<td><span class="badge bg-secondary">읽음</span></td>
								</c:when>
								<c:otherwise>
									<td><span class="badge bg-danger">읽지않음</span></td>
								</c:otherwise>
							</c:choose>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		

		</div>
		<div class="compose-btn">
			<button type="button" class="btn btn-delete" onclick="deleteReceiveNote()">쪽지 삭제</button>
			<button type="button" class="btn btn-write"	onclick="location.href='notewriteform.woori'">쪽지 작성</button>
		</div>
	</div>
	
	<div class="footer">
		<c:import url="MemberFooter.jsp"></c:import>
	</div>

	<div class="modal fade" id="messageModal1" tabindex="-1" aria-labelledby="messageModalLabel1" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title fs-5" id="messageModalLabel1">쪽지 내용</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"	aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="card">
						<div class="card-header">
							<i class="bi bi-envelope"></i>
						</div>
						<div class="card-body" id="modal-result">
							
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	



</body>
</html>
