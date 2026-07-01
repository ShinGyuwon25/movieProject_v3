<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link rel="stylesheet" href="resources/css/bootstrap.min.css">
<style>
body { background-color: #E6E6E6; }
header {
    background-color: #8A0808;
    border-radius: 10px;
    padding: 1rem;
    height: 100px;
    margin: 30px 40px;
}
.nav-link { margin-left: 1rem; text-decoration: none; color: #F2F2F2; }
.jumbotron {
    background-color: #fff;
    padding: 3rem;
    border-radius: 10px;
    margin: 0 40px;
}
.section-title { font-size: 16px; font-weight: 600; margin-bottom: 16px; border-bottom: 1px solid #eee; padding-bottom: 10px; }
.info-row { display: flex; padding: 8px 0; border-bottom: 1px solid #f0f0f0; font-size: 14px; }
.info-label { color: #888; width: 80px; flex-shrink: 0; }
.board-item { padding: 8px 0; border-bottom: 1px solid #f0f0f0; font-size: 14px; }
.board-item a { color: #333; text-decoration: none; }
.board-item a:hover { color: #8A0808; }
.comment-item { padding: 8px 0; border-bottom: 1px solid #f0f0f0; font-size: 14px; color: #555; }
.empty-msg { color: #aaa; font-size: 13px; padding: 12px 0; }
</style>
</head>
<body>

<header>
    <nav class="navbar">
        <a href="boardList.do" style="text-decoration: none; color: #F2F2F2;">
            <h3 style="margin-left: 30px; margin-top: 8px;">영화 게시판 🎬</h3>
        </a>
        <div class="d-flex">
            <c:choose>
                <c:when test="${not empty sessionScope.log}">
                    <a href="logout.do" class="nav-link" onclick="return confirm('로그아웃 하시겠습니까?')">로그아웃</a>
                    <a href="myPage.do" class="nav-link">마이페이지</a>
                    <a href="insertBoard.do" class="nav-link" style="margin-right: 30px;">게시물 작성</a>
                </c:when>
                <c:otherwise>
                    <a href="login.do" class="nav-link">로그인</a>
                    <a href="insertMember.do" class="nav-link" style="margin-right: 30px;">회원가입</a>
                </c:otherwise>
            </c:choose>
        </div>
    </nav>
</header>

<div class="jumbotron">

    <!-- 회원정보 -->
    <div style="margin-bottom: 40px;">
        <div class="section-title">👤 회원정보</div>
        <div class="info-row"><span class="info-label">아이디</span><span>${mymember.id}</span></div>
        <div class="info-row"><span class="info-label">이름</span><span>${mymember.name}</span></div>
        <div class="info-row"><span class="info-label">이메일</span><span>${mymember.email}</span></div>
        <div style="margin-top: 16px; display: flex; gap: 8px;">
            <button onclick="location.href='modifyMember.do'"
                style="background-color:#8A0808; color:white; border:none; padding:8px 20px; border-radius:6px;">
                정보 수정
            </button>
            <button onclick="if(confirm('정말 탈퇴하시겠습니까?')) location.href='deleteMember.do'"
                style="background-color:#888; color:white; border:none; padding:8px 20px; border-radius:6px;">
                회원 탈퇴
            </button>
        </div>
    </div>

    <!-- 내가 좋아요한 글 -->
    <div style="margin-bottom: 40px;">
        <div class="section-title">👍 좋아요한 글 (${myLikedBoards.size()})</div>
        <c:choose>
            <c:when test="${empty myLikedBoards}">
                <p class="empty-msg">좋아요한 글이 없습니다.</p>
            </c:when>
            <c:otherwise>
                <c:forEach var="board" items="${myLikedBoards}">
                    <div class="board-item">
                        <a href="boardView.do?seq=${board.seq}">[${board.mtitle}] ${board.title}</a>
                        <span style="color:#aaa; font-size:12px; margin-left:8px;">${board.time}</span>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- 내가 쓴 글 -->
    <div style="margin-bottom: 40px;">
        <div class="section-title">📝 내가 쓴 글 (${myBoards.size()})</div>
        <c:choose>
            <c:when test="${empty myBoards}">
                <p class="empty-msg">작성한 글이 없습니다.</p>
            </c:when>
            <c:otherwise>
                <c:forEach var="board" items="${myBoards}">
                    <div class="board-item">
                        <a href="boardView.do?seq=${board.seq}">[${board.mtitle}] ${board.title}</a>
                        <span style="color:#aaa; font-size:12px; margin-left:8px;">${board.time}</span>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- 내가 쓴 댓글 -->
    <div>
        <div class="section-title">💬 내가 쓴 댓글 (${myComments.size()})</div>
        <c:choose>
            <c:when test="${empty myComments}">
                <p class="empty-msg">작성한 댓글이 없습니다.</p>
            </c:when>
            <c:otherwise>
                <c:forEach var="comment" items="${myComments}">
                    <div class="comment-item">
                        <a href="boardView.do?seq=${comment.boardSeq}" style="color:#555; text-decoration:none;">
                            ${comment.content}
                        </a>
                        <span style="color:#aaa; font-size:12px; margin-left:8px;">${comment.time}</span>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>

</div>
</body>
</html>