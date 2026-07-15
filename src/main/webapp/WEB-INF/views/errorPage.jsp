<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>오류</title>
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
    text-align: center;
}
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
    <h1 style="font-size: 60px;">⚠️</h1>
    <h3 style="margin-bottom: 16px;">접근할 수 없는 페이지입니다</h3>
    <p style="color: #888; margin-bottom: 24px;">로그인이 필요하거나 권한이 없는 페이지입니다.</p>
    <a href="boardList.do" class="btn"
       style="background-color:#8A0808; color:white; padding: 10px 30px; border-radius: 6px;">
        메인으로 돌아가기
    </a>
</div>
</body>
</html>