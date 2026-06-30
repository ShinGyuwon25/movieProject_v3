<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>${myboard.title}</title>
<link rel="stylesheet" href="resources/css/bootstrap.min.css">
<link rel="stylesheet" href="resources/css/star.css" />
<style>
body {
	background-color: #E6E6E6;
}

/* 헤더 스타일 */
header {
	background-color: #8A0808;
	border-radius: 10px;
	padding: 1rem;
	height: 100px;
	margin-left: 40px;
	margin-right: 40px;
	margin-top: 30px;
	margin-bottom: 30px;
}

/* 버튼 스타일 */
.nav-link {
	margin-left: 1rem;
	text-decoration: none;
	color: #F2F2F2;
}

.container {
	margin-top: 20px;
}

.jumbotron {
	background-color: #fff;
	padding: 3rem;
	border-radius: 10px;
	margin-left: -30px;
	margin-right: -30px;
}

.poster-img {
	max-width: 100%;
	height: auto;
}
</style>
</head>
<body>

	<!-- 헤더 시작 -->
	<header>
		<!-- 상단 바 시작 -->
		<nav class="navbar">
			<!-- 메인 글씨 -->
			<a href="boardList.do" style="text-decoration: none; color: #F2F2F2;">
				<h3 style="margin-left: 30px; margin-top: 8px;"
					onclick="location.href='boardList.do'">영화 게시판 🎬</h3>
			</a>
			<!-- 로그아웃, 마이페이지, 게시물 링크 표시 -->
			<div class="d-flex">
				<!-- 로그인 상태에 따라 링크 표시 -->
				<c:choose>
					<c:when test="${not empty sessionScope.log}">						<a href="logout.do" class="nav-link" onclick="return confirm('로그아웃 하시겠습니까?')">로그아웃</a>
						<a href="myPage.do" class="nav-link">마이페이지</a>
						<a href="insertBoard.do" class="nav-link"
							style="margin-right: 30px;">게시물 작성</a>
					</c:when>
					<c:otherwise>
						<a href="login.do" class="nav-link">로그인</a>
						<a href="insertMember.do" class="nav-link"
							style="margin-right: 30px;">회원가입</a>
					</c:otherwise>
				</c:choose>
			</div>
		</nav>
		<!--  바 종료 -->
	</header>
	<!-- 헤더 종료 -->


	<!-- 내용 칸 -->
	<div class="container">
		<div class="jumbotron">
			<div style="margin-bottom: -10px;">
				<h2 class="display-7">${myboard.title}</h2>
			</div>
			<div class="d-flex justify-content-between align-items-center">
                <p class="lead" style="font-size: 14px; margin-bottom: -20px; font-weight: normal;">
                    ${myboard.name} | <fmt:formatDate value="${myboard.time}" pattern="yy-MM-dd HH:mm" /> | 조회수: ${myboard.views}</p>
                <div style="display:flex; align-items:center; gap:12px; margin-bottom: -10px;">
                    <c:choose>
                        <c:when test="${not empty sessionScope.log}">
                            <button id="likeBtn" onclick="toggleLike(${myboard.seq})"
                                style="border:none; background:none; cursor:pointer; padding:0; display:flex; align-items:center; gap:8px;">
                                <svg id="likeIcon" width="28" height="28" viewBox="0 0 24 24"
                                     fill="none" stroke="#8A0808" stroke-width="2">
                                    <path id="likePath1" d="M7 22h-4a1 1 0 0 1 -1 -1v-9a1 1 0 0 1 1 -1h4v11z" fill="${isLiked ? '#8A0808' : 'none'}"/>
                                    <path id="likePath2" d="M7 11l5 -9a2 2 0 0 1 2 2v6h5a2 2 0 0 1 2 2l-1.5 9.5a2 2 0 0 1 -2 1.5h-9.5" fill="${isLiked ? '#8A0808' : 'none'}"/>
                                </svg>
                                <span id="likeCount" style="font-size:16px; color:#555; font-weight:500;">${likeCount}</span>
                            </button>
                        </c:when>
                        <c:otherwise>
                            <span style="display:flex; align-items:center; gap:8px;">
                                <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="#aaa" stroke-width="2">
                                    <path d="M7 22h-4a1 1 0 0 1 -1 -1v-9a1 1 0 0 1 1 -1h4v11z"/>
                                    <path d="M7 11l5 -9a2 2 0 0 1 2 2v6h5a2 2 0 0 1 2 2l-1.5 9.5a2 2 0 0 1 -2 1.5h-9.5"/>
                                </svg>
                                <span style="font-size:16px; color:#555; font-weight:500;">${likeCount}</span>
                            </span>
                        </c:otherwise>
                    </c:choose>
                    <c:if test="${log != null && log.name eq myboard.name}">

						<a href="modifyBoard.do?seq=${myboard.seq}"
							class="btn btn-link text-dark"
							style="margin-right: -20px; margin-bottom: -20px; text-decoration: none;">수정</a>
						<a href="deleteBoard.do?seq=${myboard.seq}"
							class="btn btn-link text-dark"
							style="text-decoration: none; margin-bottom: -20px;">삭제</a>
					</c:if>
				</div>
			</div>
			<hr class="my-4">
			<div class="row">
				<div class="col-md-3">
					<img src="<c:url value='/poster/poster/${myboard.filename}'/>"
						alt="포스터 이미지" class="img-fluid poster-img"
						style="max-width: 100%; height: auto;">
				</div>
				<div class="col-md-8">
					<h4>${myboard.mtitle}</h4>
					<p>${myboard.myear}| ${myboard.mgenre} | ${myboard.mcountry}</p>
					<p class="star-container">
						<c:forEach var="i" begin="1" end="5">
							<span class="star ${myboard.score >= i ? 'checked' : ''}">&#9733;</span>
						</c:forEach>
					</p>
					<p>${myboard.content}</p>
				</div>
			</div>
		</div>
	</div>
	<!-- 내용 칸 종료  -->
	<br>
<!-- 댓글 테이블 -->
<div class="jumbotron"
    style="margin-left: 40px; margin-right: 40px; margin-bottom: 40px;">
    <h5 style="margin-left: 8px; margin-bottom: 20px;">댓글</h5>
    <table class="comment-table table">
       <c:forEach var="mycomment" items="${cList}">
          <c:if test="${empty mycomment.parentSeq}">
             <!-- 일반 댓글 -->
             <tr>
                <td style="border-bottom: none; font-weight: bold;">
                   ${mycomment.name}
                   <c:if test="${mycomment.name eq authorName}">
                      <span style="background:#8A0808; color:white; font-size:11px; padding:1px 6px; border-radius:4px; margin-left:4px; font-weight:normal;">작성자</span>
                   </c:if>
                   <span style="font-weight: normal; color: grey;"><fmt:formatDate value="${mycomment.time}" pattern="HH:mm" /></span>
                </td>
                <td style="border-bottom: none; color: grey; text-align: right;">
                   <c:if test="${not empty sessionScope.log}">
                      <a href="#" class="text-decoration-none me-1 text-dark"
                         onclick="openReplyForm(${mycomment.seq})">답글</a>
                   </c:if>
                   <c:if test="${log != null && log.name eq mycomment.name}">
                      <a href="#" class="text-decoration-none me-1 text-dark"
                         onclick="openModifyForm(${mycomment.seq}, '${mycomment.content}')">수정</a>
                      <a href="deleteComment.do?seq=${mycomment.seq}&boardSeq=${myboard.seq}"
                         class="text-decoration-none text-dark">삭제</a>
                   </c:if>
                </td>
             </tr>
             <tr>
                <td colspan="2" class="comment-content">${mycomment.content}</td>
             </tr>

             <!-- 답글 입력 폼 (해당 댓글용, 평소엔 숨김) -->
             <tr id="replyForm-${mycomment.seq}" style="display:none;">
                <td colspan="2" style="border-bottom:none; padding-left:30px;">
                   <form action="insertComment.do" method="post" class="d-flex">
                      <input type="hidden" name="boardSeq" value="${myboard.seq}">
                      <input type="hidden" name="parentSeq" value="${mycomment.seq}">
                      <textarea name="content" rows="1" class="form-control" placeholder="답글을 입력하세요"></textarea>
                      <button type="submit" class="btn btn-secondary ms-2"
                         style="width: 60px; background-color: #8A0808; border-color: #8A0808;">등록</button>
                   </form>
                </td>
             </tr>

             <!-- 답글 목록 -->
             <c:forEach var="reply" items="${cList}">
                <c:if test="${reply.parentSeq == mycomment.seq}">
                   <tr style="background:#f9f9f9;">
                      <td style="border-bottom: none; font-weight: bold; padding-left:30px;">
                         ↳ ${reply.name}
                         <c:if test="${reply.name eq authorName}">
                            <span style="background:#8A0808; color:white; font-size:11px; padding:1px 6px; border-radius:4px; margin-left:4px; font-weight:normal;">작성자</span>
                         </c:if>
                         <span style="font-weight: normal; color: grey;"><fmt:formatDate value="${reply.time}" pattern="HH:mm" /></span>
                      </td>
                      <td style="border-bottom: none; color: grey; text-align: right;">
                         <c:if test="${log != null && log.name eq reply.name}">
                            <a href="#" class="text-decoration-none me-1 text-dark"
                               onclick="openModifyForm(${reply.seq}, '${reply.content}')">수정</a>
                            <a href="deleteComment.do?seq=${reply.seq}&boardSeq=${myboard.seq}"
                               class="text-decoration-none text-dark">삭제</a>
                         </c:if>
                      </td>
                   </tr>
                   <tr style="background:#f9f9f9;">
                      <td colspan="2" class="comment-content" style="padding-left:30px;">${reply.content}</td>
                   </tr>
                </c:if>
             </c:forEach>
          </c:if>
       </c:forEach>
    </table>

    <!-- 댓글 수정 폼 -->
    <div id="modifyCommentForm" style="display: none;" class="mb-3">
       <form action="modifyProcComment.do" method="post">
          <input type="hidden" id="commentSeq" name="seq" value="">
          <input type="hidden" name="boardSeq" value="${myboard.seq}">
          <div class="form-group">
             <div class="d-flex justify-content-end">
                <textarea class="form-control" id="content" name="content" rows="2"></textarea>
                <button type="submit" class="btn btn-primary ms-2"
                   style="width: 60px; background-color: #8A0808; border-color: #8A0808;">수정</button>
                <button type="button" class="btn btn-secondary ms-1"
                   onclick="cancelModify()" style="width: 60px;">취소</button>
             </div>
          </div>
       </form>
    </div>

    <!-- 등록 폼 -->
    <form id="insertCommentForm" action="insertComment.do" method="post" class="mt-3">
       <input type="hidden" name="boardSeq" value="${myboard.seq}">
       <div class="d-flex justify-content-end">
          <textarea name="content" rows="2" cols="50" class="form-control"
             placeholder="댓글을 입력하세요"></textarea>
          <button type="submit" class="btn btn-secondary ms-2"
             style="width: 60px; background-color: #8A0808; border-color: #8A0808;">등록</button>
       </div>
    </form>
</div>

<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<script>
   function openModifyForm(seq, content) {
       document.getElementById('commentSeq').value = seq;
       document.getElementById('content').value = content;
       document.getElementById('modifyCommentForm').style.display = 'block';
       document.getElementById('insertCommentForm').style.display = 'none';
   }

   function cancelModify() {
       document.getElementById('commentSeq').value = '';
       document.getElementById('content').value = '';
       document.getElementById('modifyCommentForm').style.display = 'none';
       document.getElementById('insertCommentForm').style.display = 'block';
   }

   function openReplyForm(seq) {
       var form = document.getElementById('replyForm-' + seq);
       form.style.display = form.style.display === 'none' ? 'table-row' : 'none';
   }

   function toggleLike(boardSeq) {
       fetch('toggleLike.do?seq=' + boardSeq)
           .then(response => response.text())
           .then(result => {
               var parts = result.split(':');
               var liked = parts[0] === 'true';
               var count = parts[1];
               var fillValue = liked ? '#8A0808' : 'none';
               document.getElementById('likePath1').setAttribute('fill', fillValue);
               document.getElementById('likePath2').setAttribute('fill', fillValue);
               document.getElementById('likeCount').textContent = count;
           });
   }
</script>
</body>
</html>