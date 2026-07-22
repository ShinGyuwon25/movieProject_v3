<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>회원가입</title>
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

.register-card { background: #161B27; border-radius: 12px; border: 0.5px solid #252B3B; padding: 40px; width: 100%; max-width: 440px; }
.register-title { font-size: 22px; font-weight: 600; color: white; margin-bottom: 6px; }
.register-sub { font-size: 14px; color: rgba(255,255,255,.3); margin-bottom: 32px; }

.form-group { margin-bottom: 16px; }
.form-label { font-size: 13px; color: rgba(255,255,255,.45); margin-bottom: 7px; display: block; }
.form-input { width: 100%; padding: 11px 14px; background: #0D0F14; border: 0.5px solid #252B3B; border-radius: 6px; font-size: 14px; color: rgba(255,255,255,.8); font-family: inherit; transition: border-color .15s; }
.form-input:focus { outline: none; border-color: #C0272D; }
.form-input::placeholder { color: rgba(255,255,255,.2); }
.form-input.error { border-color: #C0272D; }
.form-input[readonly] { color: rgba(255,255,255,.35); cursor: default; }

.pass-wrap { position: relative; }
.pass-wrap .form-input { padding-right: 50px; }
.pass-toggle { position: absolute; right: 12px; top: 50%; transform: translateY(-50%); font-size: 12px; color: rgba(255,255,255,.3); cursor: pointer; }
.pass-toggle:hover { color: rgba(255,255,255,.7); }

.field-error { font-size: 12px; color: #C0272D; margin-top: 5px; display: none; }

.email-row { display: flex; gap: 8px; }
.email-row .form-input { flex: 1; }
.form-select { padding: 11px 10px; background: #0D0F14; border: 0.5px solid #252B3B; border-radius: 6px; font-size: 13px; color: rgba(255,255,255,.6); font-family: inherit; cursor: pointer; flex: 1; }
.form-select:focus { outline: none; border-color: #C0272D; }
.domain-input { display: none; flex: 1; }

.error-msg { font-size: 13px; color: #C0272D; margin-bottom: 16px; padding: 10px 14px; background: rgba(192,39,45,.1); border-radius: 6px; border: 0.5px solid rgba(192,39,45,.3); }

.btn-register { width: 100%; padding: 12px; background: #C0272D; color: white; border: none; border-radius: 6px; font-size: 15px; font-weight: 500; cursor: pointer; margin-top: 8px; }
.btn-register:hover { background: #A0201E; }

.divider { display: flex; align-items: center; gap: 12px; margin: 20px 0; }
.divider-line { flex: 1; height: 0.5px; background: #252B3B; }
.divider-text { font-size: 12px; color: rgba(255,255,255,.2); }

.login-link { text-align: center; font-size: 14px; color: rgba(255,255,255,.35); }
.login-link a { color: #C0272D; text-decoration: none; font-weight: 500; }

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
    <div class="register-card">
        <div class="register-title">회원가입</div>
        <div class="register-sub">영화 커뮤니티에 함께하세요</div>

        <c:if test="${not empty errorMsg}">
            <div class="error-msg">${errorMsg}</div>
        </c:if>

        <form action="insertProcMember.do" method="post">

            <!-- 아이디 -->
            <div class="form-group">
                <label class="form-label">아이디</label>
                <input type="text" id="id" name="id" class="form-input"
                       placeholder="5자 이상, 영어 포함" value="${savedId}">
                <div id="idError" class="field-error"></div>
                <c:if test="${errorField == 'id'}">
                    <div class="field-error" style="display:block;">${errorMsg}</div>
                </c:if>
            </div>

            <!-- 이름 -->
            <div class="form-group">
                <label class="form-label">이름</label>
                <input type="text" id="name" name="name" class="form-input"
                       placeholder="2자 이상" value="${savedName}">
                <div id="nameError" class="field-error"></div>
                <c:if test="${errorField == 'name'}">
                    <div class="field-error" style="display:block;">${errorMsg}</div>
                </c:if>
            </div>

            <!-- 비밀번호 -->
            <div class="form-group">
                <label class="form-label">비밀번호</label>
                <div class="pass-wrap">
                    <input type="password" id="pass" name="pass" class="form-input"
                           placeholder="6자 이상, 영어+숫자 포함"
                           onInput="checkKorean(this)">
                    <span class="pass-toggle" onclick="togglePassword('pass', this)">보기</span>
                </div>
                <div id="passError" class="field-error"></div>
                <c:if test="${errorField == 'pass'}">
                    <div class="field-error" style="display:block;">${errorMsg}</div>
                </c:if>
            </div>

            <!-- 비밀번호 확인 -->
            <div class="form-group">
                <label class="form-label">비밀번호 확인</label>
                <input type="password" id="confirmPass" name="confirmPass" class="form-input"
                       placeholder="비밀번호를 한 번 더 입력하세요">
            </div>

            <!-- 이메일 -->
            <div class="form-group">
                <label class="form-label">이메일</label>
                <div class="email-row">
                    <input type="text" name="address" class="form-input"
                           placeholder="이메일" value="${savedAddress}">
                    <select id="domainSelect" name="domain" class="form-select"
                            onchange="toggleDomain(this)">
                        <option value="@naver.com" ${savedDomain == '@naver.com' ? 'selected' : ''}>@naver.com</option>
                        <option value="@gmail.com" ${savedDomain == '@gmail.com' ? 'selected' : ''}>@gmail.com</option>
                        <option value="@daum.net"  ${savedDomain == '@daum.net'  ? 'selected' : ''}>@daum.net</option>
                        <option value="@nate.com"  ${savedDomain == '@nate.com'  ? 'selected' : ''}>@nate.com</option>
                        <option value="@kakao.com" ${savedDomain == '@kakao.com' ? 'selected' : ''}>@kakao.com</option>
                        <option value="@hanmail.net">@hanmail.net</option>
                        <option value="@icloud.com">@icloud.com</option>
                        <option value="@outlook.com">@outlook.com</option>
                        <option value="direct">직접입력</option>
                    </select>
                    <input type="text" id="directDomain" name="" class="form-input domain-input"
                           placeholder="@naver.com 형식으로 입력">
                </div>
            </div>

            <button type="submit" class="btn-register">가입하기</button>
        </form>

        <div class="divider">
            <div class="divider-line"></div>
            <span class="divider-text">또는</span>
            <div class="divider-line"></div>
        </div>

        <div class="login-link">
            이미 계정이 있으신가요? <a href="login.do">로그인</a>
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
function togglePassword(inputId, btn) {
    var input = document.getElementById(inputId);
    if (input.type === 'password') { input.type = 'text'; btn.textContent = '숨기기'; }
    else { input.type = 'password'; btn.textContent = '보기'; }
    var confirmInput = document.getElementById('confirmPass');
    if (confirmInput) confirmInput.type = input.type;
}

function checkKorean(input) {
    input.value = input.value.replace(/[ㄱ-ㅎㅏ-ㅣ가-힣]/g, '');
}

function toggleDomain(select) {
    var directInput = document.getElementById('directDomain');
    var domainSelect = document.getElementById('domainSelect');
    if (select.value === 'direct') {
        directInput.style.display = 'block';
        directInput.name = 'domain';
        domainSelect.style.display = 'none';
        domainSelect.name = '';
    } else {
        directInput.style.display = 'none';
        directInput.name = '';
        domainSelect.style.display = 'block';
        domainSelect.name = 'domain';
    }
}

function showFieldError(fieldId, msg) {
    var input = document.getElementById(fieldId);
    var errorDiv = document.getElementById(fieldId + 'Error');
    if (!input || !errorDiv) return;
    if (msg) { input.classList.add('error'); errorDiv.textContent = msg; errorDiv.style.display = 'block'; }
    else { input.classList.remove('error'); errorDiv.style.display = 'none'; }
}

document.getElementById('id').addEventListener('blur', function() {
    var val = this.value;
    var msg = '';
    if (val.length < 5) msg = '아이디는 5자 이상이어야 합니다.';
    else if (!/[a-zA-Z]/.test(val)) msg = '아이디는 영어를 포함해야 합니다.';
    showFieldError('id', msg);
});

document.getElementById('name').addEventListener('blur', function() {
    var msg = this.value.length < 2 ? '이름은 2자 이상이어야 합니다.' : '';
    showFieldError('name', msg);
});

document.getElementById('pass').addEventListener('blur', function() {
    var val = this.value;
    var msg = '';
    if (val.length < 6 || !/[a-zA-Z]/.test(val) || !/\d/.test(val))
        msg = '비밀번호는 6자 이상이며, 영어와 숫자를 포함해야 합니다.';
    showFieldError('pass', msg);
});
</script>
</body>
</html>