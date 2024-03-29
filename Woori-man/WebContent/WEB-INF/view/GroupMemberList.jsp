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
<title>그룹원 목록 - 우리만 </title>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/font.css">
<link rel="stylesheet" href="<%=cp %>/css/footer.css" />
<link rel="stylesheet" href="<%=cp %>/css/groupMemberlist.css" />



<!-- 1. 부트스트랩 js -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<!-- 2. 부트스트랩 css -->
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
<!-- 3. jquery -->
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<!-- 4. 부트스트랩 아이콘 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css" rel="stylesheet">

<script type="text/javascript">

	$(function()
	{
		$("#modal-btn").click(function()
		{
			param = "";
			
			$.ajax(
			{
				type: "GET"
				, url: "groupinvitelist.woori"
				, data: param
				, success: function(args)
				{
					//alert("다녀옴");
					//alert(args);
					$(".lists").html(args);
					$("#messageModal1").modal("show");
				}
				, error: function(e)
				{
					alert(e.responseText);
				}
			});
			
		});
		
		// 초대 전송 확인
		//function inviteCheck()
		//{
			//var us_name = "";
			
			//if (confirm(us_name + "님에게 그룹 초대를 보내시겠습니까?"))
			//{
				//$(location).attr("href", "groupinvite.woori");
			//}
			
		//}
		
	});

</script>

</head>
<body>

<c:import url="MemberHeader.jsp"></c:import>
<c:import url="GroupHeader.jsp"></c:import>

<div class="groupMain_side" >
	<c:import url="GroupSideBar.jsp"></c:import>
</div>	
<div class="groupMemberlist">
	<h2>그룹원 목록</h2>
	<table class="table table-hover">
		<tr>
			<th>프로필사진</th>
			<th>닉네임</th>
			<th>상태메세지</th>
			<th>그룹직책</th>
			<th>그룹가입일</th>
		</tr>
		<c:forEach var="groupMemberList" items="${groupMemberList }">
			<tr>
				<td>${groupMemberList.gm_profile }</td>
				<td>${groupMemberList.gm_nickname }</td>
				<td>${groupMemberList.gm_intro }</td>
				<td>${groupMemberList.pos_name }</td>
				<td>${groupMemberList.gm_regdate }</td>
			</tr>
		</c:forEach>
	</table>
	<c:if test="${groupMemberDTO.pos_code == 1 || groupMemberDTO.pos_code == 2 }">
		<button type="button" id="modal-btn" data-toggle="modal" data-target="#messageModal1">그룹원 초대하기</button>
	</c:if>
</div>

<div class="footer">
	<c:import url="MemberFooter.jsp"></c:import>
</div>

<div class="modal fade" id="messageModal1" tabindex="-1" aria-labelledby="messageModalLabel1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title fs-5" id="messageModalLabel1">초대 가능한 친구 목록(${count } 명)</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" >
                </button>
            </div>
            <div class="modal-body">
            <div class="card">
         	
            <div class="card-body friends">
            
				<ul class="lists">
				
				
				
				</ul>
				
			</div>
             
            </div>
            </div>
            </div>
        </div>
    </div>

</body>
</html>