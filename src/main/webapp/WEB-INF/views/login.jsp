<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>로그인</title>
<style>
* { box-sizing: border-box; margin: 0; padding: 0; }
body { background: #0D0F14; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif; min-height: 100vh; display: flex; flex-direction: column; }

.site-header { background: #0D0F14; border-bottom: 2px solid #C0272D; }
.header-inner { height: 56px; display: flex; align-items: center; justify-content: space-between; padding: 0 32px; max-width: 1100px; width: 100%; margin: 0 auto; }
.header-logo { color: white; font-size: 16px; font-weight: 500; text-decoration: none; }
.header-nav { display: flex; align-items: center; gap: 4px; }
.nav-link { color: rgba(255,255,255,.45); font-size: 14px; text-decoration: none; padding: 4px 10px; border-radius: 4px; }
.nav-link:hover { color: rgba(255,255,255,.8); background: rgba(255,255,255,.08); }
.nav-cta { background: #C0272D; color: white; border: none; padding: 6px 16px; border-radius: 5px; font-size: 14px; cursor: pointer; font-weight: 500; text-decoration: none; }

.main-content { flex: 1; display: flex; align-items: center; justify-content: center; padding: 48px 32px; }

.login-card { background: #161B27; border-radius: 12px; border: 0.5px solid #252B3B; padding: 40px; width: 100%; max-width: 400px; }
.login-title { font-size: 22px; font-weight: 600; color: white; margin-bottom: 6px; }
.login-sub { font-size: 14px; color: rgba(255,255,255,.3); margin-bottom: 32px; }

.form-group { margin-bottom: 16px; }
.form-label { font-size: 13px; color: rgba(255,255,255,.45); margin-bottom: 7px; display: block; }
.form-input { width: 100%; padding: 11px 14px; background: #0D0F14; border: 0.5px solid #252B3B; border-radius: 6px; font-size: 14px; color: rgba(255,255,255,.8); font-family: inherit; transition: border-color .15s; }
.form-input:focus { outline: none; border-color: #C0272D; }
.form-input::placeholder { color: rgba(255,255,255,.2); }
.pass-wrap { position: relative; }
.pass-wrap .form-input { padding-right: 50px; }
.pass-toggle { position: absolute; right: 12px; top: 50%; transform: translateY(-50%); font-size: 12px; color: rgba(255,255,255,.3); cursor: pointer; }
.pass-toggle:hover { color: rgba(255,255,255,.7); }

.save-id-row { display: flex; align-items: center; gap: 8px; margin-bottom: 20px; }
.save-id-row input[type="checkbox"] { width: 15px; height: 15px; accent-color: #C0272D; cursor: pointer; }
.save-id-row label { font-size: 13px; color: rgba(255,255,255,.35); cursor: pointer; }

.error-msg { font-size: 13px; color: #C0272D; margin-bottom: 16px; padding: 10px 14px; background: rgba(192,39,45,.1); border-radius: 6px; border: 0.5px solid rgba(192,39,45,.3); }

.btn-login { width: 100%; padding: 12px; background: #C0272D; color: white; border: none; border-radius: 6px; font-size: 15px; font-weight: 500; cursor: pointer; }
.btn-login:hover { background: #A0201E; }

.divider { display: flex; align-items: center; gap: 12px; margin: 20px 0; }
.divider-line { flex: 1; height: 0.5px; background: #252B3B; }
.divider-text { font-size: 12px; color: rgba(255,255,255,.2); }

.register-link { text-align: center; font-size: 14px; color: rgba(255,255,255,.35); }
.register-link a { color: #C0272D; text-decoration: none; font-weight: 500; }

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
            <a href="login.do" class="nav-link">로그인</a>
            <a href="insertMember.do" class="nav-cta">회원가입</a>
        </nav>
    </div>
</header>

<div class="main-content">
    <div class="login-card">
        <div class="login-title">로그인</div>
        <div class="login-sub">영화 리뷰를 작성하려면 로그인하세요</div>

        <c:if test="${not empty loginError}">
            <div class="error-msg">${loginError}</div>
        </c:if>

        <form action="loginProc.do" method="post">
            <div class="form-group">
                <label class="form-label">아이디</label>
                <input type="text" id="id" name="id" class="form-input"
                       placeholder="아이디를 입력하세요" value="${savedId}">
            </div>

            <div class="form-group">
                <label class="form-label">비밀번호</label>
                <div class="pass-wrap">
                    <input type="password" id="pass" name="pass" class="form-input"
                           placeholder="비밀번호를 입력하세요"
                           onInput="checkKorean(this)">
                    <span class="pass-toggle" onclick="togglePassword('pass', this)">보기</span>
                </div>
            </div>

            <div class="save-id-row">
                <input type="checkbox" id="saveId" onchange="handleSaveId()">
                <label for="saveId">아이디 저장</label>
            </div>

            <button type="submit" class="btn-login">로그인</button>
        </form>

        <div class="divider">
            <div class="divider-line"></div>
            <span class="divider-text">또는</span>
            <div class="divider-line"></div>
        </div>

        <div class="register-link">
            아직 계정이 없으신가요? <a href="insertMember.do">회원가입</a>
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
// 아이디 저장 불러오기
window.onload = function() {
    var savedId = localStorage.getItem('savedLoginId');
    if (savedId) {
        document.getElementById('id').value = savedId;
        document.getElementById('saveId').checked = true;
    }
};

function handleSaveId() {
    var checked = document.getElementById('saveId').checked;
    if (!checked) localStorage.removeItem('savedLoginId');
}

// 로그인 버튼 클릭 시 아이디 저장
document.querySelector('form').addEventListener('submit', function() {
    if (document.getElementById('saveId').checked) {
        localStorage.setItem('savedLoginId', document.getElementById('id').value);
    } else {
        localStorage.removeItem('savedLoginId');
    }
});

function togglePassword(inputId, btn) {
    var input = document.getElementById(inputId);
    if (input.type === 'password') {
        input.type = 'text';
        btn.textContent = '숨기기';
    } else {
        input.type = 'password';
        btn.textContent = '보기';
    }
}

function checkKorean(input) {
    input.value = input.value.replace(/[ㄱ-ㅎㅏ-ㅣ가-힣]/g, '');
}
</script>
</body>
</html>