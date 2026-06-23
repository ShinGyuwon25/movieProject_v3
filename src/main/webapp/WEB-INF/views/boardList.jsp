<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>movie.com</title>
<!-- 부트스트랩 적용 -->
<link rel="stylesheet" href="resources/css/bootstrap.min.css">
<!-- 사용자 정의 스타일 -->
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

/* 게시글 목록 제목 색상 */
.jumbotron tbody a {
	color: black;
}

.jumbotron {
	background-color: #fff;
	padding: 3rem;
	border-radius: 10px;
	margin-left: 40px;
	margin-right: 40px;
}

.table th, .table td {
	border: none;
	padding: 10px;
}

/* 페이징 버튼 글씨 색상 */
.pagination .page-link {
	color: black !important;
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
		<!-- 상단 바 종료 -->
	</header>
	<!-- 헤더 종료 -->

	<!-- 게시글 목록 테이블 시작 -->
	<div class="jumbotron">
		<table class="table table-bordered table-hover">
			<thead class="table-light">
				<tr>
					<th scope="col" class="col-6">제목</th>
					<th scope="col" class="col-1 text-center">작성자</th>
					<th scope="col" class="col-1 text-center">작성일</th>
					<th scope="col" class="col-1 text-center">조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${not empty searchMessage}">
					<tr>
						<td colspan="4">${searchMessage}</td>
					</tr>
				</c:if>
				<!-- 게시글 목록 출력 부분 -->
				<c:forEach var="myboard" items="${bList}">
					<tr>
						<td><a href="boardView.do?seq=${myboard.seq}"
							class="text-decoration-none"> [${myboard.mtitle}]
								${myboard.title} </a></td>
						<td class="text-center">${myboard.name}</td>
						<td class="text-center"><fmt:formatDate value="${myboard.time}" pattern="HH:mm" /></td>
						<td class="text-center">${myboard.views}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<!-- 게시글 목록 테이블 종료 -->

		<!-- 페이지 시작 -->
		<div class="row justify-content-center">
			<div class="col-auto">
				<ul class="pagination">
					<!-- 페이지 숫자 출력 부분 -->
					<c:forEach var="i" begin="1" end="${totalPages}">
						<li class="page-item"><a href="boardList.do?page=${i}"
							class="page-link">${i}</a></li>
					</c:forEach>
				</ul>
			</div>
		</div>
		<!-- 페이징 종료 -->

		<!-- 검색 폼 시작 -->

		<form action="searchBoard.do" method="post" class="mb-3">
			<div class="row justify-content-center">
				<div class="col-2" style="margin-right: 0px;">
					<select name="searchCon" class="form-select">
						<option value="title">글제목</option>
						<option value="content">글내용</option>
					</select>
				</div>
				<div class="col-5" style="margin-left: -19px;">
					<input name="searchKey" type="text" class="form-control">
				</div>
				<div class="col-2" style="margin-left: -19px;">
					<input type="submit" value="검색" class="btn btn-primary"
						style="background-color: #8A0808; border-color: #8A0808; width: 60px;">
				</div>
			</div>
		</form>

		<!-- 검색 폼 종료 -->
	</div>
</body>
</html>