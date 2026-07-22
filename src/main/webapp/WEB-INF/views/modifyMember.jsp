<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>회원정보 수정</title>
<style>
* { box-sizing: border-box; margin: 0; padding: 0; }
body { background: #0D0F14; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif; min-height: 100vh; display: flex; flex-direction: column; }

.site-header { background: #0D0F14; border-bottom: 2px solid #C0272D; }
.header-inner { height: 56px; display: flex; align-items: center; justify-content: space-between; padding: 0 32px; max-width: 1100px; width: 100%; margin: 0 auto; }
.header-logo { color: white; font-size: 16px; font-weight: 500; text-decoration: none; }
.header-nav { display: flex; align-items: center; gap: 4px; }
.user-chip { font-size: 13px; color: rgba(255,255,255,.5); padding: 3px 12px; background: rgba(255,255,255,.06); border-radius: 20px; margin-right: 6px; }
.nav-link { color: rgba(255,255,255,.45); font-size: 14px; text-decoration: none; padding: 4px 10px; border-radius: 4px; }
.nav-link:hover { color: rgba(255,255,255,.8); background: rgba(255,255,255,.08); }
.nav-cta { background: #C0272D; color: white; border: none; padding: 6px 16px; border-radius: 5px; font-size: 14px; cursor: pointer; font-weight: 500; text-decoration: none; }

.main-content { flex: 1; display: flex; align-items: center; justify-content: center; padding: 48px 32px; }

.card { background: #161B27; border-radius: 12px; border: 0.5px solid #252B3B; padding: 40px; width: 100%; max-width: 440px; }
.card-title { font-size: 22px; font-weight: 600; color: white; margin-bottom: 6px; }
.card-sub { font-size: 14px; color: rgba(255,255,255,.3); margin-bottom: 32px; }

.form-group { margin-bottom: 16px; }
.form-label { font-size: 13px; color: rgba(255,255,255,.45); margin-bottom: 7px; display: block; }
.form-input { width: 100%; padding: 11px 14px; background: #0D0F14; border: 0.5px solid #252B3B; border-radius: 6px; font-size: 14px; color: rgba(255,255,255,.8); font-family: inherit; transition: border-color .15s; }
.form-input:focus { outline: none; border-color: #C0272D; }
.form-input::placeholder { color: rgba(255,255,255,.2); }
.form-input[readonly] { color: rgba(255,255,255,.35); cursor: default; }

.pass-wrap { position: relative; }
.pass-wrap .form-input { padding-right: 50px; }
.pass-toggle { position: absolute; right: 12px; top: 50%; transform: translateY(-50%); font-size: 12px; color: rgba(255,255,255,.3); cursor: pointer; }
.pass-toggle:hover { color: rgba(255,255,255,.7); }

.email-row { display: flex; gap: 8px; }
.email-row .form-input { flex: 1; }
.form-select { padding: 11px 10px; background: #0D0F14; border: 0.5px solid #252B3B; border-radius: 6px; font-size: 13px; color: rgba(255,255,255,.6); font-family: inherit; cursor: pointer; flex: 1; }
.form-select:focus { outline: none; border-color: #C0272D; }

.error-msg { font-size: 13px; color: #C0272D; margin-bottom: 16px; padding: 10px 14px; background: rgba(192,39,45,.1); border-radius: 6px; border: 0.5px solid rgba(192,39,45,.3); }

.btn-row { display: flex; gap: 8px; margin-top: 8px; }
.btn-confirm { flex: 1; padding: 12px; background: #C0272D; color: white; border: none; border-radius: 6px; font-size: 15px; font-weight: 500; cursor: pointer; }
.btn-confirm:hover { background: #A0201E; }
.btn-cancel { flex: 1; padding: 12px; background: #252B3B; color: rgba(255,255,255,.5); border: none; border-radius: 6px; font-size: 15px; cursor: pointer; }
.btn-cancel:hover { background: #2E3549; }

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
            <c:if test="${not empty sessionScope.log}">
                <span class="user-chip">${sessionScope.log.name}</span>
            </c:if>
            <a href="logout.do" class="nav-link" onclick="return confirm('로그아웃 하시겠습니까?')">로그아웃</a>
            <a href="myPage.do" class="nav-link">마이페이지</a>
            <a href="insertBoard.do" class="nav-cta">게시물 작성</a>
        </nav>
    </div>
</header>

<div class="main-content">
    <div class="card">
        <div class="card-title">회원정보 수정</div>
        <div class="card-sub">변경할 정보를 입력해주세요</div>

        <c:if test="${not empty error}">
            <div class="error-msg">${error}</div>
        </c:if>

        <form action="modifyProcMember.do?seq=${mymember.seq}" method="post">

            <!-- 아이디 (읽기 전용) -->
            <div class="form-group">
                <label class="form-label">아이디</label>
                <input type="text" name="id" class="form-input" readonly value="${mymember.id}">
            </div>

            <!-- 이름 -->
            <div class="form-group">
                <label class="form-label">이름</label>
                <input type="text" name="name" class="form-input"
                       placeholder="이름" value="${not empty savedName ? savedName : mymember.name}">
            </div>

            <!-- 비밀번호 -->
            <div class="form-group">
                <label class="form-label">비밀번호</label>
                <div class="pass-wrap">
                    <input type="password" id="pass" name="pass" class="form-input"
                           placeholder="새 비밀번호를 입력하세요">
                    <span class="pass-toggle" onclick="togglePassword('pass', this)">보기</span>
                </div>
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
                           value="${mymember.email.split('@')[0]}">
                    <select name="domain" class="form-select">
                        <option value="@naver.com" ${mymember.email.endsWith('@naver.com') ? 'selected' : ''}>@naver.com</option>
                        <option value="@gmail.com" ${mymember.email.endsWith('@gmail.com') ? 'selected' : ''}>@gmail.com</option>
                        <option value="@daum.net"  ${mymember.email.endsWith('@daum.net')  ? 'selected' : ''}>@daum.net</option>
                        <option value="@nate.com"  ${mymember.email.endsWith('@nate.com')  ? 'selected' : ''}>@nate.com</option>
                        <option value="@kakao.com" ${mymember.email.endsWith('@kakao.com') ? 'selected' : ''}>@kakao.com</option>
                        <option value="@hanmail.net" ${mymember.email.endsWith('@hanmail.net') ? 'selected' : ''}>@hanmail.net</option>
                        <option value="@icloud.com" ${mymember.email.endsWith('@icloud.com') ? 'selected' : ''}>@icloud.com</option>
                        <option value="@outlook.com" ${mymember.email.endsWith('@outlook.com') ? 'selected' : ''}>@outlook.com</option>
                    </select>
                </div>
            </div>

            <div class="btn-row">
                <button type="button" class="btn-cancel" onclick="location.href='myPage.do'">취소</button>
                <button type="submit" class="btn-confirm">수정</button>
            </div>
        </form>
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
    if (input.type === 'password') {
        input.type = 'text';
        btn.textContent = '숨기기';
        document.getElementById('confirmPass').type = 'text';
    } else {
        input.type = 'password';
        btn.textContent = '보기';
        document.getElementById('confirmPass').type = 'password';
    }
}
</script>
</body>
</html>