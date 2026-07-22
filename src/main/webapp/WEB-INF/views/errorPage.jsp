<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>접근 오류</title>
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

.error-card { text-align: center; max-width: 440px; width: 100%; }
.error-code { font-size: 80px; font-weight: 700; color: #C0272D; line-height: 1; margin-bottom: 16px; letter-spacing: -2px; }
.error-title { font-size: 22px; font-weight: 600; color: white; margin-bottom: 10px; }
.error-desc { font-size: 14px; color: rgba(255,255,255,.35); line-height: 1.7; margin-bottom: 32px; }
.divider-line { width: 40px; height: 2px; background: #C0272D; margin: 0 auto 32px; border-radius: 2px; }

.btn-row { display: flex; gap: 8px; justify-content: center; }
.btn-home { padding: 11px 28px; background: #C0272D; color: white; border: none; border-radius: 6px; font-size: 14px; font-weight: 500; cursor: pointer; text-decoration: none; }
.btn-home:hover { background: #A0201E; }
.btn-back { padding: 11px 28px; background: #252B3B; color: rgba(255,255,255,.5); border: none; border-radius: 6px; font-size: 14px; cursor: pointer; text-decoration: none; }
.btn-back:hover { background: #2E3549; }

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
    <div class="error-card">
        <div class="error-code">403</div>
        <div class="divider-line"></div>
        <div class="error-title">접근할 수 없는 페이지입니다</div>
        <div class="error-desc">
            로그인이 필요하거나 권한이 없는 페이지예요.<br>
            메인으로 돌아가거나 로그인 후 다시 시도해주세요.
        </div>
        <div class="btn-row">
            <a href="boardList.do" class="btn-home">메인으로</a>
            <a href="javascript:history.back()" class="btn-back">이전으로</a>
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

</body>
</html>