<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>영화 게시판</title>
<style>
* { box-sizing: border-box; margin: 0; padding: 0; }
body { background: #0D0F14; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif; min-height: 100vh; display: flex; flex-direction: column; }

/* HEADER */
.site-header { background: #0D0F14; border-bottom: 2px solid #C0272D; position: sticky; top: 0; z-index: 100; }
.header-inner { height: 84px; display: flex; align-items: center; justify-content: space-between; padding: 0 32px; max-width: 1100px; width: 100%; margin: 0 auto; }
.header-logo { display: flex; align-items: center; gap: 6px; color: white; font-size: 30px; font-weight: 500; text-decoration: none; }
.header-nav { display: flex; align-items: center; gap: 4px; }
.user-chip { display: flex; align-items: center; gap: 5px; color: rgba(255,255,255,.5); font-size: 13px; padding: 3px 12px; background: rgba(255,255,255,.06); border-radius: 20px; margin-right: 6px; }
.nav-link { color: rgba(255,255,255,.45); font-size: 14px; text-decoration: none; padding: 4px 10px; border-radius: 4px; }
.nav-link:hover { color: rgba(255,255,255,.8); background: rgba(255,255,255,.08); }
.nav-cta { background: #C0272D; color: white; border: none; padding: 6px 16px; border-radius: 5px; font-size: 14px; cursor: pointer; font-weight: 500; text-decoration: none; }

/* MAIN */
.main-content { flex: 1; padding: 36px 32px; max-width: 1100px; width: 100%; margin: 0 auto; }

/* SECTION LABEL */
.section-label { font-size: 14px; font-weight: 500; color: rgba(255,255,255,.9); margin-bottom: 12px; display: flex; align-items: center; gap: 6px; }
.section-label::before { content: ''; width: 3px; height: 14px; background: #C0272D; border-radius: 2px; display: inline-block; }

/* TOP 3 */
.top3-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 12px; margin-bottom: 40px; }
.review-card { background: #161B27; border-radius: 8px; border: 0.5px solid #252B3B; padding: 14px; text-decoration: none; display: block; transition: border-color .15s; }
.review-card:hover { border-color: #C0272D; }
.rc-top { display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px; }
.rc-author { font-size: 13px; color: rgba(255,255,255,.45); }
.rc-stars { color: #F5C842; font-size: 12px; }
.rc-body { display: flex; gap: 10px; margin-bottom: 10px; }
.rc-poster { width: 50px; height: 70px; border-radius: 4px; background: #252B3B; overflow: hidden; flex-shrink: 0; }
.rc-poster img { width: 100%; height: 100%; object-fit: cover; }
.rc-info { flex: 1; min-width: 0; }
.rc-movie { font-size: 14px; font-weight: 500; color: white; margin-bottom: 4px; }
.rc-review { font-size: 12px; color: rgba(255,255,255,.35); line-height: 1.6; display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical; overflow: hidden; }
.rc-footer { display: flex; gap: 12px; padding-top: 8px; border-top: 0.5px solid #252B3B; }
.rc-stat { font-size: 12px; color: rgba(255,255,255,.22); }

/* BOARD CONTROLS */
.board-controls { display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px; }
.sort-group { display: flex; align-items: center; }
.sort-btn { font-size: 13px; padding: 2px 10px; background: none; border: none; color: rgba(255,255,255,.28); cursor: pointer; text-decoration: none; position: relative; }
.sort-btn::after { content: '·'; position: absolute; right: -1px; color: rgba(255,255,255,.15); font-size: 10px; }
.sort-btn:last-child::after { display: none; }
.sort-btn.active { color: #C0272D; font-weight: 500; }

/* BOARD TABLE */
.board-table { background: #161B27; border-radius: 8px; border: 0.5px solid #252B3B; overflow: hidden; }
.board-thead { display: grid; grid-template-columns: 1fr 70px 80px 56px 42px; padding: 8px 16px; border-bottom: 0.5px solid #252B3B; }
.board-thead span { font-size: 12px; color: rgba(255,255,255,.2); font-weight: 500; }
.board-row { display: grid; grid-template-columns: 1fr 70px 80px 56px 42px; padding: 11px 16px; border-bottom: 0.5px solid #1D2335; align-items: center; text-decoration: none; transition: background .1s; }
.board-row:last-child { border-bottom: none; }
.board-row:hover { background: #1A2030; }
.title-cell { display: flex; flex-direction: column; gap: 2px; }
.movie-tag { font-size: 12px; color: #C0272D; font-weight: 500; }
.review-title-text { font-size: 15px; color: rgba(255,255,255,.82); }
.comment-count { font-size: 13px; color: rgba(255,255,255,.35); margin-left: 4px; }
.cell-center { font-size: 14px; color: rgba(255,255,255,.35); text-align: center; }
.cell-stars { text-align: center; display: flex; justify-content: center; align-items: center; }
.star-sm { width: 13px; height: 13px; clip-path: polygon(50% 0%,63% 32%,98% 35%,70% 60%,80% 95%,50% 75%,20% 95%,30% 60%,2% 35%,37% 32%); }
.star-gold { background: #F5C842; }
.star-dark { background: #2A3040; }
.star-row { display: flex; gap: 2px; align-items: center; }
.empty-msg { padding: 32px; text-align: center; color: rgba(255,255,255,.3); font-size: 14px; }

/* PAGINATION */
.pagination-wrap { display: flex; justify-content: center; align-items: center; gap: 3px; margin-top: 24px; }
.page-btn { width: 30px; height: 30px; display: flex; align-items: center; justify-content: center; border-radius: 5px; border: none; background: none; color: rgba(255,255,255,.3); font-size: 13px; cursor: pointer; text-decoration: none; }
.page-btn.active { background: #C0272D; color: white; }
.page-btn:hover:not(.active) { background: #1D2335; color: rgba(255,255,255,.6); }

/* SEARCH */
.search-bar { margin-top: 36px; margin-bottom: 40px; display: flex; gap: 5px; justify-content: center; align-items: center; }
.search-select-small { padding: 6px 8px; border: 0.5px solid #252B3B; border-radius: 5px; font-size: 13px; background: #161B27; color: rgba(255,255,255,.5); height: 34px; width: 80px; }
.search-input { padding: 6px 12px; border: 0.5px solid #252B3B; border-radius: 5px; font-size: 13px; background: #161B27; color: rgba(255,255,255,.75); width: 260px; height: 34px; }
.search-input::placeholder { color: rgba(255,255,255,.25); }
.search-select-full { padding: 6px 8px; border: 0.5px solid #252B3B; border-radius: 5px; font-size: 13px; background: #161B27; color: rgba(255,255,255,.55); height: 34px; width: 260px; }
.search-btn { padding: 6px 16px; background: #C0272D; color: white; border: none; border-radius: 5px; font-size: 13px; cursor: pointer; height: 34px; }

/* FOOTER */
.site-footer { background: #080A0F; padding: 27px 32px; border-top: 0.5px solid #1D2335; margin-top: auto; }
.footer-inner { display: flex; justify-content: space-between; align-items: center; max-width: 1100px; margin: 0 auto; }
.footer-logo { font-size: 13px; color: rgba(255,255,255,.3); font-weight: 500; }
.footer-links { display: flex; gap: 16px; }
.footer-links a { font-size: 12px; color: rgba(255,255,255,.2); text-decoration: none; }
.footer-copy { font-size: 11px; color: rgba(255,255,255,.15); text-align: center; max-width: 1100px; margin: 8px auto 0; }
</style>
</head>
<body>

<jsp:useBean id="now" class="java.util.Date" />

<!-- HEADER -->
<header class="site-header">
    <div class="header-inner">
        <a href="boardList.do" class="header-logo">
            <svg width="165" height="45" viewBox="0 0 165 45" xmlns="http://www.w3.org/2000/svg">
                <text x="0" y="33" font-family="-apple-system,BlinkMacSystemFont,'Segoe UI',sans-serif" font-size="33" font-weight="700" fill="white" letter-spacing="-0.5">CINE<tspan fill="#C0272D">LOG</tspan></text>
            </svg>
        </a>
        <nav class="header-nav">
            <c:choose>
                <c:when test="${not empty sessionScope.log}">
                    <span class="user-chip">${sessionScope.log.name}</span>
                    <a href="logout.do" class="nav-link" onclick="return confirm('로그아웃 하시겠습니까?')">로그아웃</a>
                    <a href="myPage.do" class="nav-link">마이페이지</a>
                    <a href="insertBoard.do" class="nav-cta">게시물 작성</a>
                </c:when>
                <c:otherwise>
                    <a href="login.do" class="nav-link">로그인</a>
                    <a href="insertMember.do" class="nav-cta">회원가입</a>
                </c:otherwise>
            </c:choose>
        </nav>
    </div>
</header>

<!-- MAIN -->
<div class="main-content">

    <!-- TOP 3 -->
    <c:if test="${not empty top3List}">
        <p class="section-label">인기 리뷰 TOP 3</p>
        <div class="top3-grid">
            <c:forEach var="board" items="${top3List}">
                <a href="boardView.do?seq=${board.seq}" class="review-card">
                    <div class="rc-top">
                         <span class="rc-author" style="display:flex; align-items:center; gap:6px;">
                                <c:choose>
                                    <c:when test="${not empty profileMap[board.name]}">
                                        <img src="profile/${profileMap[board.name]}"
                                             style="width:24px; height:24px; border-radius:50%; object-fit:cover;">
                                    </c:when>
                                    <c:otherwise>
                                        <span style="width:24px; height:24px; border-radius:50%; background:#C0272D; display:inline-flex; align-items:center; justify-content:center; font-size:10px; color:white; font-weight:600; flex-shrink:0;">
                                            ${fn:substring(board.name, 0, 1)}
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                                ${board.name}
                            </span>
                        <span class="rc-stars">
                            <div class="star-row" style="gap:1.5px;">
                                <div class="star-sm ${board.score >= 1 ? 'star-gold' : 'star-dark'}"></div>
                                <div class="star-sm ${board.score >= 2 ? 'star-gold' : 'star-dark'}"></div>
                                <div class="star-sm ${board.score >= 3 ? 'star-gold' : 'star-dark'}"></div>
                                <div class="star-sm ${board.score >= 4 ? 'star-gold' : 'star-dark'}"></div>
                                <div class="star-sm ${board.score >= 5 ? 'star-gold' : 'star-dark'}"></div>
                            </div>
                        </span>
                    </div>
                    <div class="rc-body">
                        <div class="rc-poster">
                            <c:choose>
                                <c:when test="${fn:startsWith(board.filename, 'http')}">
                                    <img src="${board.filename}" alt="포스터">
                                </c:when>
                                <c:otherwise>
                                    <img src="poster/poster/${board.filename}" alt="포스터">
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="rc-info">
                            <div class="rc-movie">${board.mtitle}</div>
                            <p class="rc-review">${fn:replace(board.content, '<br>', ' ')}</p>
                        </div>
                    </div>
                    <div class="rc-footer">
                        <span class="rc-stat">좋아요 ${board.likeCount}</span>
                        <span class="rc-stat">댓글 ${board.commentCount}</span>
                    </div>
                </a>
            </c:forEach>
        </div>
    </c:if>

    <!-- BOARD LIST -->
    <div class="board-controls">
        <p class="section-label" style="margin-bottom:0;">전체 리뷰</p>
        <div class="sort-group">
            <a href="boardList.do?sort=latest" class="sort-btn ${currentSort == 'latest' || empty currentSort ? 'active' : ''}">최신순</a>
            <a href="boardList.do?sort=likes"  class="sort-btn ${currentSort == 'likes'  ? 'active' : ''}">인기순</a>
            <a href="boardList.do?sort=score"  class="sort-btn ${currentSort == 'score'  ? 'active' : ''}">별점순</a>
        </div>
    </div>

    <div class="board-table">
        <div class="board-thead">
            <span>제목</span>
            <span style="text-align:center;">별점</span>
            <span style="text-align:center;">작성자</span>
            <span style="text-align:center;">작성일</span>
            <span style="text-align:center;">조회</span>
        </div>
        <c:if test="${not empty searchMessage}">
            <div class="empty-msg">${searchMessage}</div>
        </c:if>
        <c:forEach var="myboard" items="${bList}">
            <a href="boardView.do?seq=${myboard.seq}" class="board-row">
                <div class="title-cell">
                    <span class="movie-tag">${myboard.mtitle}</span>
                    <span>
                        <span class="review-title-text">${myboard.title}</span>
                        <span class="comment-count">[${myboard.commentCount}]</span>
                    </span>
                </div>
                <span style="display:flex; justify-content:center;">
                    <span style="display:inline-flex; gap:1.5px; align-items:center;">
                        <div class="star-sm ${myboard.score >= 1 ? 'star-gold' : 'star-dark'}"></div>
                        <div class="star-sm ${myboard.score >= 2 ? 'star-gold' : 'star-dark'}"></div>
                        <div class="star-sm ${myboard.score >= 3 ? 'star-gold' : 'star-dark'}"></div>
                        <div class="star-sm ${myboard.score >= 4 ? 'star-gold' : 'star-dark'}"></div>
                        <div class="star-sm ${myboard.score >= 5 ? 'star-gold' : 'star-dark'}"></div>
                    </span>
                </span>
                <span class="cell-center">${myboard.name}</span>
                <span class="cell-center">
                    <c:choose>
                        <c:when test="${(now.time - myboard.time.time) > 86400000}">
                            <fmt:formatDate value="${myboard.time}" pattern="MM.dd"/>
                        </c:when>
                        <c:otherwise>
                            <fmt:formatDate value="${myboard.time}" pattern="HH:mm"/>
                        </c:otherwise>
                    </c:choose>
                </span>
                <span class="cell-center">${myboard.views}</span>
            </a>
        </c:forEach>
    </div>

    <!-- PAGINATION -->
    <div class="pagination-wrap">
        <c:if test="${currentPage > 1}">
            <a href="boardList.do?page=${currentPage-1}&sort=${currentSort}" class="page-btn">&#8249;</a>
        </c:if>
        <c:forEach var="i" begin="1" end="${totalPages}">
            <a href="boardList.do?page=${i}&sort=${currentSort}"
               class="page-btn ${i == currentPage ? 'active' : ''}">${i}</a>
        </c:forEach>
        <c:if test="${currentPage < totalPages}">
            <a href="boardList.do?page=${currentPage+1}&sort=${currentSort}" class="page-btn">&#8250;</a>
        </c:if>
    </div>

    <!-- SEARCH -->
    <form action="searchBoard.do" method="get" class="search-bar">
        <select name="searchCon" class="search-select-small" onchange="toggleSearchInput(this)">
            <option value="title">글제목</option>
            <option value="content">글내용</option>
            <option value="genre">장르</option>
            <option value="country">국가</option>
        </select>
        <input name="searchKey" id="textInput" type="text" class="search-input" placeholder="검색어를 입력하세요">
        <select name="searchKey" id="genreInput" class="search-select-full" style="display:none;" disabled>
            <option value="액션">액션</option>
            <option value="범죄">범죄</option>
            <option value="SF">SF</option>
            <option value="드라마">드라마</option>
            <option value="코미디">코미디</option>
            <option value="로맨스">로맨스</option>
            <option value="스릴러">스릴러</option>
            <option value="공포">공포</option>
            <option value="판타지">판타지</option>
            <option value="역사">역사</option>
            <option value="모험">모험</option>
            <option value="전쟁">전쟁</option>
            <option value="음악">음악</option>
            <option value="뮤지컬">뮤지컬</option>
            <option value="멜로">멜로</option>
        </select>
        <select name="searchKey" id="countryInput" class="search-select-full" style="display:none;" disabled>
            <option value="한국">한국</option>
            <option value="미국">미국</option>
            <option value="일본">일본</option>
            <option value="영국">영국</option>
            <option value="프랑스">프랑스</option>
            <option value="중국">중국</option>
            <option value="캐나다">캐나다</option>
            <option value="호주">호주</option>
            <option value="독일">독일</option>
            <option value="이탈리아">이탈리아</option>
            <option value="스페인">스페인</option>
            <option value="러시아">러시아</option>
            <option value="인도">인도</option>
            <option value="대만">대만</option>
            <option value="홍콩">홍콩</option>
        </select>
        <button type="submit" class="search-btn">검색</button>
    </form>
</div>

<!-- FOOTER -->
<footer class="site-footer">
    <div class="footer-inner">
        <span class="footer-logo">
            <svg width="90" height="24" viewBox="0 0 110 30" xmlns="http://www.w3.org/2000/svg">
                <text x="0" y="22" font-family="-apple-system,BlinkMacSystemFont,'Segoe UI',sans-serif" font-size="22" font-weight="700" fill="rgba(255,255,255,0.3)" letter-spacing="-0.5">CINE<tspan fill="rgba(192,39,45,0.5)">LOG</tspan></text>
            </svg>
        </span>
        <div class="footer-links">
            <a href="#">이용약관</a>
            <a href="#">개인정보처리방침</a>
            <a href="#">문의</a>
        </div>
    </div>
    <p class="footer-copy">&copy; 2026 영화 게시판. All rights reserved.</p>
</footer>

<script>
function toggleSearchInput(select) {
    var textInput = document.getElementById('textInput');
    var genreInput = document.getElementById('genreInput');
    var countryInput = document.getElementById('countryInput');

    textInput.style.display = 'none';
    genreInput.style.display = 'none';
    countryInput.style.display = 'none';
    textInput.disabled = true;
    genreInput.disabled = true;
    countryInput.disabled = true;

    if (select.value === 'genre') {
        genreInput.style.display = 'block';
        genreInput.disabled = false;
    } else if (select.value === 'country') {
        countryInput.style.display = 'block';
        countryInput.disabled = false;
    } else {
        textInput.style.display = 'block';
        textInput.disabled = false;
    }
}
</script>
</body>
</html>