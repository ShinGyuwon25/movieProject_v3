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
			<!-- 로그아웃, 회원정보, 게시물 링크 표시 -->
			<div class="d-flex">
				<!-- 로그인 상태에 따라 링크 표시 -->
				<c:choose>
					<c:when test="${not empty sessionScope.log}">
						<a href="logout.do" class="nav-link">로그아웃</a>
						<a href="memberView.do" class="nav-link">회원정보</a>
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
				<p class="lead"
					style="font-size: 14px; margin-bottom: -20px; font-weight: normal;">
					${myboard.name} | <fmt:formatDate value="${myboard.time}" pattern="yy-MM-dd HH:mm" /> | 조회수:
					${myboard.views}</p>
				<div>
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
				<tr>
					<td style="border-bottom: none; font-weight: bold;">${mycomment.name}
						<span style="font-weight: normal; color: grey;"><fmt:formatDate value="${mycomment.time}" pattern="HH:mm" /></span>
					</td>
					<td style="border-bottom: none; color: grey; text-align: right;">
						<c:if test="${log != null && log.name eq mycomment.name}">
							<!-- 수정 삭제 버튼 클릭 시 수정 폼으로 -->
							<a href="#" class="text-decoration-none me-1 text-dark"
								onclick="openModifyForm(${mycomment.seq}, '${mycomment.content}')">수정</a>
							<a
								href="deleteComment.do?seq=${mycomment.seq}&boardSeq=${myboard.seq}"
								class="text-decoration-none text-dark">삭제</a>
						</c:if>
					</td>
				</tr>
				<tr>
					<td colspan="2" class="comment-content">${mycomment.content}</td>
				</tr>
			</c:forEach>
		</table>



		<!-- 댓글 수정 폼 -->
		<div id="modifyCommentForm" style="display: none;" class="mb-3">
			<form action="modifyProcComment.do" method="post">
				<input type="hidden" id="commentSeq" name="seq" value=""> <input
					type="hidden" name="boardSeq" value="${myboard.seq}">
				<div class="form-group">
					<div class="d-flex justify-content-end">
						<textarea class="form-control" id="content" name="content"
							rows="2"></textarea>
						<button type="submit" class="btn btn-primary ms-2"
							style="width: 60px; background-color: #8A0808; border-color: #8A0808;">수정</button>
						<button type="button" class="btn btn-secondary ms-1"
							onclick="cancelModify()" style="width: 60px;">취소</button>
					</div>
				</div>
			</form>
		</div>

		<!-- 등록 폼 -->
		<form id="insertCommentForm" action="insertComment.do" method="post"
			class="mt-3">
			<input type="hidden" name="boardSeq" value="${myboard.seq}">
			<div class="d-flex justify-content-end">
				<textarea name="content" rows="2" cols="50" class="form-control"
					placeholder="댓글을 입력하세요"></textarea>
				<button type="submit" class="btn btn-secondary ms-2"
					style="width: 60px; background-color: #8A0808; border-color: #8A0808;">등록</button>
			</div>
		</form>
	</div>

	<script
		src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
	<script> String encodedFilename = URLEncoder.encode(myboard.filename, "UTF-8");</script>
	<script>
    // 수정 폼 열기
    function openModifyForm(seq, content) {
        document.getElementById('commentSeq').value = seq;
        document.getElementById('content').value = content;
        document.getElementById('modifyCommentForm').style.display = 'block';
        document.getElementById('insertCommentForm').style.display = 'none';
    }

    // 수정 폼 닫기
    function cancelModify() {
        document.getElementById('commentSeq').value = '';
        document.getElementById('content').value = '';
        document.getElementById('modifyCommentForm').style.display = 'none';
        document.getElementById('insertCommentForm').style.display = 'block';
    }
</script>
</body>
</html>