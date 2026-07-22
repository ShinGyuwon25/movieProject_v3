<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>글 수정</title>
<style>
* { box-sizing: border-box; margin: 0; padding: 0; }
body { background: #0D0F14; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif; min-height: 100vh; display: flex; flex-direction: column; }

.site-header { background: #0D0F14; border-bottom: 2px solid #C0272D; position: sticky; top: 0; z-index: 100; }
.header-inner { height: 56px; display: flex; align-items: center; justify-content: space-between; padding: 0 32px; max-width: 1100px; width: 100%; margin: 0 auto; }
.header-logo { color: white; font-size: 16px; font-weight: 500; text-decoration: none; }
.header-nav { display: flex; align-items: center; gap: 4px; }
.user-chip { font-size: 13px; color: rgba(255,255,255,.5); padding: 3px 12px; background: rgba(255,255,255,.06); border-radius: 20px; margin-right: 6px; }
.nav-link { color: rgba(255,255,255,.45); font-size: 14px; text-decoration: none; padding: 4px 10px; border-radius: 4px; }
.nav-link:hover { color: rgba(255,255,255,.8); background: rgba(255,255,255,.08); }
.nav-cta { background: #C0272D; color: white; border: none; padding: 6px 16px; border-radius: 5px; font-size: 14px; cursor: pointer; font-weight: 500; text-decoration: none; }

.main-content { flex: 1; padding: 32px; max-width: 1100px; width: 100%; margin: 0 auto; }

.card { background: #161B27; border-radius: 10px; border: 0.5px solid #252B3B; padding: 32px; }
.page-title { font-size: 20px; font-weight: 600; color: white; margin-bottom: 28px; padding-bottom: 16px; border-bottom: 0.5px solid #252B3B; }

.form-group { margin-bottom: 20px; }
.form-label { font-size: 13px; color: rgba(255,255,255,.45); margin-bottom: 7px; display: block; }
.form-input { width: 100%; padding: 11px 14px; background: #0D0F14; border: 0.5px solid #252B3B; border-radius: 6px; font-size: 14px; color: rgba(255,255,255,.8); font-family: inherit; transition: border-color .15s; }
.form-input:focus { outline: none; border-color: #C0272D; }
.form-input::placeholder { color: rgba(255,255,255,.2); }
.form-input[readonly] { color: rgba(255,255,255,.35); cursor: default; }
.form-textarea { width: 100%; padding: 12px 14px; background: #0D0F14; border: 0.5px solid #252B3B; border-radius: 6px; font-size: 14px; color: rgba(255,255,255,.8); font-family: inherit; resize: vertical; min-height: 200px; transition: border-color .15s; }
.form-textarea:focus { outline: none; border-color: #C0272D; }
.form-select { padding: 11px 14px; background: #0D0F14; border: 0.5px solid #252B3B; border-radius: 6px; font-size: 14px; color: rgba(255,255,255,.7); font-family: inherit; cursor: pointer; }
.form-select:focus { outline: none; border-color: #C0272D; }

.movie-row { display: grid; grid-template-columns: auto 1fr 120px 140px 140px; gap: 8px; align-items: start; }
.search-btn { padding: 11px 16px; background: #C0272D; color: white; border: none; border-radius: 6px; font-size: 14px; cursor: pointer; white-space: nowrap; font-weight: 500; }
.search-btn:hover { background: #A0201E; }

.star-input { width: 30px; height: 30px; background: #2A3040; clip-path: polygon(50% 0%,63% 32%,98% 35%,70% 60%,80% 95%,50% 75%,20% 95%,30% 60%,2% 35%,37% 32%); cursor: pointer; transition: background .1s; }
.star-input.on { background: #F5C842; }

.btn-row { display: flex; justify-content: flex-end; gap: 8px; margin-top: 28px; padding-top: 20px; border-top: 0.5px solid #252B3B; }
.btn-confirm { padding: 10px 28px; background: #C0272D; color: white; border: none; border-radius: 6px; font-size: 14px; font-weight: 500; cursor: pointer; }
.btn-confirm:hover { background: #A0201E; }
.btn-cancel { padding: 10px 20px; background: #252B3B; color: rgba(255,255,255,.5); border: none; border-radius: 6px; font-size: 14px; cursor: pointer; }
.btn-cancel:hover { background: #2E3549; }

.modal-bg { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,.7); z-index: 9999; }
.modal-box { background: #161B27; width: 560px; max-height: 70vh; margin: 80px auto; border-radius: 12px; overflow: hidden; display: flex; flex-direction: column; border: 0.5px solid #252B3B; }
.modal-head { padding: 16px 20px; border-bottom: 0.5px solid #252B3B; display: flex; justify-content: space-between; align-items: center; flex-shrink: 0; }
.modal-head h5 { font-size: 15px; color: white; font-weight: 500; }
.modal-close { background: none; border: none; color: rgba(255,255,255,.5); font-size: 20px; cursor: pointer; }
.modal-search-wrap { padding: 14px 16px; border-bottom: 0.5px solid #252B3B; flex-shrink: 0; }
.modal-input { width: 100%; padding: 10px 14px; background: #0D0F14; border: 0.5px solid #252B3B; border-radius: 6px; font-size: 14px; color: rgba(255,255,255,.8); font-family: inherit; }
.modal-input:focus { outline: none; border-color: #C0272D; }
.modal-input::placeholder { color: rgba(255,255,255,.25); }
.modal-results { overflow-y: auto; flex: 1; }
.modal-item { display: flex; align-items: center; gap: 12px; padding: 12px 16px; border-bottom: 0.5px solid #1D2335; cursor: pointer; transition: background .1s; }
.modal-item:hover { background: #1A2030; }
.modal-item:last-child { border-bottom: none; }
.modal-poster { width: 40px; height: 56px; border-radius: 3px; background: #252B3B; overflow: hidden; flex-shrink: 0; }
.modal-poster img { width: 100%; height: 100%; object-fit: cover; }
.modal-title { font-size: 14px; color: white; font-weight: 500; margin-bottom: 3px; }
.modal-meta { font-size: 12px; color: rgba(255,255,255,.4); }
.modal-empty { padding: 24px; text-align: center; font-size: 14px; color: rgba(255,255,255,.3); }

.site-footer { background: #080A0F; padding: 18px 32px; border-top: 0.5px solid #1D2335; margin-top: auto; }
.footer-inner { display: flex; justify-content: space-between; align-items: center; max-width: 1100px; margin: 0 auto; }
.footer-logo { font-size: 13px; color: rgba(255,255,255,.3); font-weight: 500; }
.footer-links { display: flex; gap: 16px; }
.footer-links a { font-size: 12px; color: rgba(255,255,255,.2); text-decoration: none; }
.footer-copy { font-size: 11px; color: rgba(255,255,255,.15); text-align: center; max-width: 1100px; margin: 8px auto 0; }
</style>
</head>
<body>

<header class="site-header">
    <div class="header-inner">
        <a href="boardList.do" class="header-logo">
            <svg width="110" height="30" viewBox="0 0 110 30" xmlns="http://www.w3.org/2000/svg">
                <text x="0" y="22" font-family="-apple-system,BlinkMacSystemFont,'Segoe UI',sans-serif" font-size="22" font-weight="700" fill="white" letter-spacing="-0.5">CINE<tspan fill="#C0272D">LOG</tspan></text>
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

<div class="main-content">
    <div class="card">
        <div class="page-title">글 수정</div>

        <form id="myform" action="modifyProcBoard.do" method="post"
              enctype="multipart/form-data" onsubmit="return validateForm()">
            <input type="hidden" name="seq" value="${myboard.seq}">

            <!-- 제목 -->
            <div class="form-group">
                <label class="form-label">제목</label>
                <input type="text" id="title" name="title" class="form-input"
                       placeholder="제목을 입력하세요" value="${myboard.title}">
            </div>

            <!-- 영화 정보 -->
            <div class="form-group">
                <label class="form-label">영화 정보</label>
                <div class="movie-row">
                    <button type="button" class="search-btn" onclick="openMovieSearch()">영화 검색</button>
                    <input type="text" class="form-input" id="mtitle" name="mtitle"
                           placeholder="영화 제목" value="${myboard.mtitle}">
                    <select id="myear" name="myear" class="form-select">
                        <option value="">연도</option>
                        <c:forEach var="year" begin="1950" end="2030" step="1">
                            <c:set var="y" value="${2030 - (year - 1950)}"/>
                            <option value="${y}" ${myboard.myear == y ? 'selected' : ''}>${y}</option>
                        </c:forEach>
                    </select>
                    <select id="mgenre" name="mgenre" class="form-select">
                        <option value="">장르</option>
                        <option value="액션" ${myboard.mgenre == '액션' ? 'selected' : ''}>액션</option>
                        <option value="범죄" ${myboard.mgenre == '범죄' ? 'selected' : ''}>범죄</option>
                        <option value="SF" ${myboard.mgenre == 'SF' ? 'selected' : ''}>SF</option>
                        <option value="드라마" ${myboard.mgenre == '드라마' ? 'selected' : ''}>드라마</option>
                        <option value="코미디" ${myboard.mgenre == '코미디' ? 'selected' : ''}>코미디</option>
                        <option value="로맨스" ${myboard.mgenre == '로맨스' ? 'selected' : ''}>로맨스</option>
                        <option value="스릴러" ${myboard.mgenre == '스릴러' ? 'selected' : ''}>스릴러</option>
                        <option value="공포" ${myboard.mgenre == '공포' ? 'selected' : ''}>공포</option>
                        <option value="판타지" ${myboard.mgenre == '판타지' ? 'selected' : ''}>판타지</option>
                        <option value="역사" ${myboard.mgenre == '역사' ? 'selected' : ''}>역사</option>
                        <option value="모험" ${myboard.mgenre == '모험' ? 'selected' : ''}>모험</option>
                        <option value="전쟁" ${myboard.mgenre == '전쟁' ? 'selected' : ''}>전쟁</option>
                        <option value="음악" ${myboard.mgenre == '음악' ? 'selected' : ''}>음악</option>
                        <option value="뮤지컬" ${myboard.mgenre == '뮤지컬' ? 'selected' : ''}>뮤지컬</option>
                        <option value="멜로" ${myboard.mgenre == '멜로' ? 'selected' : ''}>멜로</option>
                        <option value="애니메이션" ${myboard.mgenre == '애니메이션' ? 'selected' : ''}>애니메이션</option>
                    </select>
                    <select id="mcountry" name="mcountry" class="form-select">
                        <option value="">국가</option>
                        <option value="한국" ${myboard.mcountry == '한국' ? 'selected' : ''}>한국</option>
                        <option value="미국" ${myboard.mcountry == '미국' ? 'selected' : ''}>미국</option>
                        <option value="일본" ${myboard.mcountry == '일본' ? 'selected' : ''}>일본</option>
                        <option value="영국" ${myboard.mcountry == '영국' ? 'selected' : ''}>영국</option>
                        <option value="프랑스" ${myboard.mcountry == '프랑스' ? 'selected' : ''}>프랑스</option>
                        <option value="중국" ${myboard.mcountry == '중국' ? 'selected' : ''}>중국</option>
                        <option value="캐나다" ${myboard.mcountry == '캐나다' ? 'selected' : ''}>캐나다</option>
                        <option value="호주" ${myboard.mcountry == '호주' ? 'selected' : ''}>호주</option>
                        <option value="독일" ${myboard.mcountry == '독일' ? 'selected' : ''}>독일</option>
                        <option value="이탈리아" ${myboard.mcountry == '이탈리아' ? 'selected' : ''}>이탈리아</option>
                        <option value="스페인" ${myboard.mcountry == '스페인' ? 'selected' : ''}>스페인</option>
                        <option value="러시아" ${myboard.mcountry == '러시아' ? 'selected' : ''}>러시아</option>
                        <option value="인도" ${myboard.mcountry == '인도' ? 'selected' : ''}>인도</option>
                        <option value="대만" ${myboard.mcountry == '대만' ? 'selected' : ''}>대만</option>
                        <option value="홍콩" ${myboard.mcountry == '홍콩' ? 'selected' : ''}>홍콩</option>
                    </select>
                </div>
            </div>

            <!-- 별점 -->
            <div class="form-group">
                <label class="form-label">별점</label>
                <div id="starRating" style="display:flex; gap:4px;">
                    <div class="star-input" data-value="1"></div>
                    <div class="star-input" data-value="2"></div>
                    <div class="star-input" data-value="3"></div>
                    <div class="star-input" data-value="4"></div>
                    <div class="star-input" data-value="5"></div>
                </div>
                <input type="hidden" id="scoreInput" name="score" value="${myboard.score}">
            </div>

            <!-- 내용 -->
            <div class="form-group">
                <label class="form-label">내용</label>
                <textarea id="content" name="content" class="form-textarea"></textarea>
            </div>

            <!-- 포스터 업로드 -->
            <div class="form-group">
                <input type="file" name="uploadFile" id="uploadFile" style="display:none;"
                       onchange="checkFileType(this)">
                <input type="hidden" id="posterUrl" name="posterUrl" value="">
                <span onclick="document.getElementById('uploadFile').click()"
                      style="font-size:12px; color:rgba(255,255,255,.25); cursor:pointer; text-decoration:underline;">
                    영화 포스터 수동 업로드
                </span>
                <span id="fileName" style="font-size:12px; color:rgba(255,255,255,.2); margin-left:8px;">선택된 파일 없음</span>
            </div>

            <!-- 버튼 -->
            <div class="btn-row">
                <button type="button" class="btn-cancel" onclick="history.back()">취소</button>
                <button type="submit" class="btn-confirm">수정</button>
            </div>
        </form>
    </div>
</div>

<!-- 영화 검색 모달 -->
<div id="movieModal" class="modal-bg">
    <div class="modal-box">
        <div class="modal-head">
            <h5>영화 검색</h5>
            <button class="modal-close" onclick="closeMovieSearch()">&#10005;</button>
        </div>
        <div class="modal-search-wrap">
            <input type="text" id="modalSearchInput" class="modal-input"
                   placeholder="영화 제목을 입력하세요" autocomplete="off">
        </div>
        <div id="modalResults" class="modal-results">
            <div class="modal-empty">영화 제목을 입력해주세요</div>
        </div>
    </div>
</div>

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
function checkFileType(input) {
    var allowedExt = ['jpg', 'jpeg', 'png', 'gif'];
    var fileName = input.files[0].name;
    var ext = fileName.substring(fileName.lastIndexOf('.') + 1).toLowerCase();
    if (!allowedExt.includes(ext)) {
        alert('이미지 파일만 업로드 가능합니다 (jpg, jpeg, png, gif)');
        input.value = '';
        document.getElementById('fileName').textContent = '선택된 파일 없음';
    } else {
        document.getElementById('fileName').textContent = fileName;
    }
}

function validateForm() {
    if (!document.getElementById('title').value.trim()) { alert('제목을 입력해주세요.'); return false; }
    if (!document.getElementById('mtitle').value.trim()) { alert('영화 제목을 입력해주세요.'); return false; }
    if (!document.getElementById('myear').value) { alert('제작 연도를 선택해주세요.'); return false; }
    if (!document.getElementById('mgenre').value) { alert('영화 장르를 선택해주세요.'); return false; }
    if (!document.getElementById('mcountry').value) { alert('제작 국가를 선택해주세요.'); return false; }
    if (!document.getElementById('scoreInput').value) { alert('별점을 선택해주세요.'); return false; }
    if (!document.getElementById('content').value.trim()) { alert('내용을 입력해주세요.'); return false; }
    return true;
}

// 별점 초기화
var stars = document.querySelectorAll('.star-input');
var scoreInput = document.getElementById('scoreInput');
var currentScore = parseInt(scoreInput.value) || 0;
stars.forEach(function(s, i) { s.classList.toggle('on', i < currentScore); });

stars.forEach(function(star) {
    star.addEventListener('click', function() {
        var val = parseInt(this.getAttribute('data-value'));
        scoreInput.value = val;
        stars.forEach(function(s, i) { s.classList.toggle('on', i < val); });
    });
    star.addEventListener('mouseover', function() {
        var val = parseInt(this.getAttribute('data-value'));
        stars.forEach(function(s, i) { s.classList.toggle('on', i < val); });
    });
});
document.getElementById('starRating').addEventListener('mouseleave', function() {
    var current = parseInt(scoreInput.value) || 0;
    stars.forEach(function(s, i) { s.classList.toggle('on', i < current); });
});

// 모달
var searchTimer;
function openMovieSearch() {
    document.getElementById('movieModal').style.display = 'block';
    setTimeout(function() { document.getElementById('modalSearchInput').focus(); }, 100);
}
function closeMovieSearch() {
    document.getElementById('movieModal').style.display = 'none';
    document.getElementById('modalSearchInput').value = '';
    document.getElementById('modalResults').innerHTML = '<div class="modal-empty">영화 제목을 입력해주세요</div>';
}
window.addEventListener('click', function(e) {
    if (e.target === document.getElementById('movieModal')) closeMovieSearch();
});
document.getElementById('modalSearchInput').addEventListener('input', function() {
    clearTimeout(searchTimer);
    var query = this.value.trim();
    if (query.length < 2) { document.getElementById('modalResults').innerHTML = '<div class="modal-empty">영화 제목을 입력해주세요</div>'; return; }
    document.getElementById('modalResults').innerHTML = '<div class="modal-empty">검색 중...</div>';
    searchTimer = setTimeout(function() {
        fetch('searchMovie.do?query=' + encodeURIComponent(query))
            .then(response => response.json())
            .then(movies => {
                var resultsDiv = document.getElementById('modalResults');
                resultsDiv.innerHTML = '';
                if (movies.length === 0) { resultsDiv.innerHTML = '<div class="modal-empty">검색 결과가 없습니다.</div>'; return; }
                movies.forEach(function(movie) {
                    var item = document.createElement('div');
                    item.className = 'modal-item';
                    item.innerHTML =
                        '<div class="modal-poster">' + (movie.poster ? '<img src="' + movie.poster + '" alt="">' : '') + '</div>' +
                        '<div><div class="modal-title">' + movie.title + '</div><div class="modal-meta">' + movie.year + ' · ' + movie.genre + ' · ' + movie.country + '</div></div>';
                    item.addEventListener('click', function() {
                        document.getElementById('mtitle').value = movie.title;
                        var yearSelect = document.getElementById('myear');
                        for (var i = 0; i < yearSelect.options.length; i++) { if (yearSelect.options[i].value == movie.year) { yearSelect.selectedIndex = i; break; } }
                        var genreSelect = document.getElementById('mgenre');
                        for (var i = 0; i < genreSelect.options.length; i++) { if (genreSelect.options[i].value === movie.genre) { genreSelect.selectedIndex = i; break; } }
                        var countrySelect = document.getElementById('mcountry');
                        for (var i = 0; i < countrySelect.options.length; i++) { if (countrySelect.options[i].value === movie.country) { countrySelect.selectedIndex = i; break; } }
                        document.getElementById('posterUrl').value = movie.poster;
                        closeMovieSearch();
                    });
                    resultsDiv.appendChild(item);
                });
            })
            .catch(() => { document.getElementById('modalResults').innerHTML = '<div class="modal-empty">오류가 발생했습니다.</div>'; });
    }, 500);
});

// 페이지 로드 시 content 채우기
window.onload = function() {
    document.getElementById('content').value = `${myboard.content}`.replace(/<br>/gi, '\n');
};

</script>
</body>
</html>