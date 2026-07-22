<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>마이페이지</title>
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

.main-content { flex: 1; padding: 28px 32px; max-width: 1100px; width: 100%; margin: 0 auto; }

/* 레이아웃 */
.page-layout { display: grid; grid-template-columns: 200px 1fr; gap: 16px; align-items: start; }

/* 사이드바 */
.sidebar { background: #161B27; border-radius: 10px; border: 0.5px solid #252B3B; padding: 24px 16px; position: sticky; top: 80px; }
.avatar { width: 64px; height: 64px; border-radius: 50%; background: #C0272D; display: flex; align-items: center; justify-content: center; font-size: 24px; color: white; font-weight: 600; margin: 0 auto 12px; }
.sidebar-name { text-align: center; font-size: 15px; color: white; font-weight: 500; margin-bottom: 4px; }
.sidebar-id { text-align: center; font-size: 12px; color: rgba(255,255,255,.3); margin-bottom: 20px; }
.sidebar-menu { display: flex; flex-direction: column; gap: 2px; }
.menu-item { padding: 9px 12px; border-radius: 6px; font-size: 13px; color: rgba(255,255,255,.45); cursor: pointer; display: block; transition: background .1s; border: none; background: none; width: 100%; text-align: left; }
.menu-item:hover { background: rgba(255,255,255,.05); color: rgba(255,255,255,.7); }
.menu-item.active { background: rgba(192,39,45,.15); color: #C0272D; font-weight: 500; }
.menu-divider { height: 0.5px; background: #252B3B; margin: 10px 0; }
.menu-item.danger { color: rgba(192,39,45,.5); }
.menu-item.danger:hover { background: rgba(192,39,45,.1); color: #C0272D; }

/* 컨텐츠 */
.content-area { display: flex; flex-direction: column; gap: 12px; }
.tab-panel { display: none; }
.tab-panel.active { display: block; }

.card { background: #161B27; border-radius: 10px; border: 0.5px solid #252B3B; overflow: hidden; }
.card-head { padding: 14px 18px; border-bottom: 0.5px solid #252B3B; display: flex; justify-content: space-between; align-items: center; }
.card-head-title { font-size: 14px; font-weight: 500; color: rgba(255,255,255,.8); }
.card-head-count { font-size: 12px; color: rgba(255,255,255,.3); }
.card-body { padding: 0; }

/* 체크 목록 */
.check-item { display: flex; align-items: center; gap: 12px; padding: 11px 18px; border-bottom: 0.5px solid #1D2335; }
.check-item:last-child { border-bottom: none; }
.check-item input[type="checkbox"] { width: 15px; height: 15px; accent-color: #C0272D; cursor: pointer; flex-shrink: 0; }
.check-item-body { flex: 1; min-width: 0; }
.check-movie { font-size: 11px; color: #C0272D; font-weight: 500; margin-bottom: 2px; }
.check-title { font-size: 13px; color: rgba(255,255,255,.75); text-decoration: none; display: block; }
.check-title:hover { color: white; }
.check-time { font-size: 11px; color: rgba(255,255,255,.25); margin-top: 2px; }
.check-content { font-size: 13px; color: rgba(255,255,255,.6); }

.delete-bar { display: flex; justify-content: flex-end; padding: 10px 18px; border-top: 0.5px solid #252B3B; }
.btn-delete-selected { padding: 6px 14px; background: rgba(192,39,45,.2); color: #C0272D; border: 0.5px solid rgba(192,39,45,.3); border-radius: 5px; font-size: 12px; cursor: pointer; }
.btn-delete-selected:hover { background: #C0272D; color: white; }

.empty-msg { padding: 28px; text-align: center; font-size: 13px; color: rgba(255,255,255,.25); }

/* 회원정보 탭 */
.info-card { background: #161B27; border-radius: 10px; border: 0.5px solid #252B3B; padding: 24px; }
.info-row { display: flex; padding: 10px 0; border-bottom: 0.5px solid #1D2335; font-size: 14px; }
.info-row:last-of-type { border-bottom: none; }
.info-label { color: rgba(255,255,255,.35); width: 80px; flex-shrink: 0; }
.info-value { color: rgba(255,255,255,.75); }

/* 정보 수정 폼 */
.edit-card { background: #161B27; border-radius: 10px; border: 0.5px solid #252B3B; padding: 24px; margin-top: 12px; }
.edit-title { font-size: 14px; font-weight: 500; color: rgba(255,255,255,.8); margin-bottom: 16px; padding-bottom: 12px; border-bottom: 0.5px solid #252B3B; }
.form-group { margin-bottom: 14px; }
.form-label { font-size: 12px; color: rgba(255,255,255,.4); margin-bottom: 6px; display: block; }
.form-input { width: 100%; padding: 10px 12px; background: #0D0F14; border: 0.5px solid #252B3B; border-radius: 6px; font-size: 14px; color: rgba(255,255,255,.8); font-family: inherit; }
.form-input:focus { outline: none; border-color: #C0272D; }
.form-input::placeholder { color: rgba(255,255,255,.2); }
.form-input[readonly] { color: rgba(255,255,255,.3); }
.pass-wrap { position: relative; }
.pass-wrap .form-input { padding-right: 50px; }
.pass-toggle { position: absolute; right: 12px; top: 50%; transform: translateY(-50%); font-size: 12px; color: rgba(255,255,255,.3); cursor: pointer; }
.email-row { display: flex; gap: 8px; }
.email-row .form-input { flex: 1; }
.form-select { padding: 10px 10px; background: #0D0F14; border: 0.5px solid #252B3B; border-radius: 6px; font-size: 13px; color: rgba(255,255,255,.6); font-family: inherit; flex: 1; }
.form-select:focus { outline: none; border-color: #C0272D; }
.edit-btn-row { display: flex; gap: 8px; margin-top: 16px; }
.btn-confirm { padding: 10px 24px; background: #C0272D; color: white; border: none; border-radius: 6px; font-size: 14px; font-weight: 500; cursor: pointer; }
.btn-cancel-edit { padding: 10px 20px; background: #252B3B; color: rgba(255,255,255,.5); border: none; border-radius: 6px; font-size: 14px; cursor: pointer; }
.error-msg { font-size: 13px; color: #C0272D; margin-bottom: 14px; padding: 10px 14px; background: rgba(192,39,45,.1); border-radius: 6px; border: 0.5px solid rgba(192,39,45,.3); }

/* FOOTER */
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
            <span class="user-chip">${sessionScope.log.name}</span>
            <a href="logout.do" class="nav-link" onclick="return confirm('로그아웃 하시겠습니까?')">로그아웃</a>
            <a href="myPage.do" class="nav-link">마이페이지</a>
            <a href="insertBoard.do" class="nav-cta">게시물 작성</a>
        </nav>
    </div>
</header>

<div class="main-content">
    <div class="page-layout">

        <!-- 사이드바 -->
        <div class="sidebar">
        <c:choose>
            <c:when test="${not empty mymember.profileImg}">
                <div class="avatar" style="padding:0; overflow:hidden;">
                    <img src="profile/${mymember.profileImg}"
                         style="width:100%; height:100%; object-fit:cover;">
                </div>
            </c:when>
            <c:otherwise>
                <div class="avatar">${fn:substring(mymember.name, 0, 1)}</div>
            </c:otherwise>
        </c:choose>
            <div class="sidebar-name">${mymember.name}</div>
            <div class="sidebar-id">${mymember.id}</div>
            <div class="sidebar-menu">
                <button class="menu-item active" onclick="showTab('boards', this)">내가 쓴 글 (${myBoards.size()})</button>
                <button class="menu-item" onclick="showTab('comments', this)">내가 쓴 댓글 (${myComments.size()})</button>
                <button class="menu-item" onclick="showTab('likes', this)">좋아요한 글 (${myLikedBoards.size()})</button>
                <div class="menu-divider"></div>
                <button class="menu-item" onclick="showTab('info', this)">회원정보</button>
                <button class="menu-item danger" onclick="openDeleteModal()">회원 탈퇴</button>
            </div>
        </div>

        <!-- 컨텐츠 -->
        <div class="content-area">

            <!-- 내가 쓴 글 -->
            <div id="tab-boards" class="tab-panel active">
                <div class="card">
                    <div class="card-head">
                        <span class="card-head-title">내가 쓴 글</span>
                        <span class="card-head-count">${myBoards.size()}개</span>
                    </div>
                    <form action="deleteSelectedBoards.do" method="post">
                        <div class="card-body">
                            <c:choose>
                                <c:when test="${empty myBoards}">
                                    <div class="empty-msg">작성한 글이 없습니다.</div>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="board" items="${myBoards}">
                                        <div class="check-item">
                                            <input type="checkbox" name="seqs" value="${board.seq}">
                                            <div class="check-item-body">
                                                <div class="check-movie">${board.mtitle}</div>
                                                <a href="boardView.do?seq=${board.seq}" class="check-title">${board.title}</a>
                                                <div class="check-time"><fmt:formatDate value="${board.time}" pattern="yy-MM-dd HH:mm"/></div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <c:if test="${not empty myBoards}">
                            <div class="delete-bar">
                                <button type="submit" class="btn-delete-selected"
                                        onclick="return confirm('선택한 글을 삭제하시겠습니까?')">선택 삭제</button>
                            </div>
                        </c:if>
                    </form>
                </div>
            </div>

            <!-- 내가 쓴 댓글 -->
            <div id="tab-comments" class="tab-panel">
                <div class="card">
                    <div class="card-head">
                        <span class="card-head-title">내가 쓴 댓글</span>
                        <span class="card-head-count">${myComments.size()}개</span>
                    </div>
                    <form action="deleteSelectedComments.do" method="post">
                        <div class="card-body">
                            <c:choose>
                                <c:when test="${empty myComments}">
                                    <div class="empty-msg">작성한 댓글이 없습니다.</div>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="comment" items="${myComments}">
                                        <div class="check-item">
                                            <input type="checkbox" name="seqs" value="${comment.seq}">
                                            <div class="check-item-body">
                                                <a href="boardView.do?seq=${comment.boardSeq}" class="check-title check-content">${comment.content}</a>
                                                <div class="check-time"><fmt:formatDate value="${comment.time}" pattern="yy-MM-dd HH:mm"/></div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <c:if test="${not empty myComments}">
                            <div class="delete-bar">
                                <button type="submit" class="btn-delete-selected"
                                        onclick="return confirm('선택한 댓글을 삭제하시겠습니까?')">선택 삭제</button>
                            </div>
                        </c:if>
                    </form>
                </div>
            </div>

            <!-- 좋아요한 글 -->
            <div id="tab-likes" class="tab-panel">
                <div class="card">
                    <div class="card-head">
                        <span class="card-head-title">좋아요한 글</span>
                        <span class="card-head-count">${myLikedBoards.size()}개</span>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty myLikedBoards}">
                                <div class="empty-msg">좋아요한 글이 없습니다.</div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="board" items="${myLikedBoards}">
                                    <div class="check-item">
                                        <div class="check-item-body">
                                            <div class="check-movie">${board.mtitle}</div>
                                            <a href="boardView.do?seq=${board.seq}" class="check-title">${board.title}</a>
                                            <div class="check-time"><fmt:formatDate value="${board.time}" pattern="yy-MM-dd HH:mm"/></div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <!-- 회원정보 + 수정 폼 -->
            <div id="tab-info" class="tab-panel">

                <!-- 프로필 + 기본정보 -->
                <div class="info-card" style="display:flex; gap:24px; align-items:center; margin-bottom:12px;">
                    <!-- 프로필 사진 -->
                    <div style="text-align:center; flex-shrink:0;">
                        <form action="updateProfile.do" method="post" enctype="multipart/form-data" id="profileForm">
                            <input type="file" name="profileFile" id="profileFile" style="display:none;"
                                   onchange="checkProfileType(this)">
                        </form>
                        <c:choose>
                            <c:when test="${not empty mymember.profileImg}">
                                <img src="profile/${mymember.profileImg}"
                                     style="width:80px; height:80px; border-radius:50%; object-fit:cover; border:0.5px solid #252B3B; display:block; margin:0 auto;">
                            </c:when>
                            <c:otherwise>
                                <div style="width:80px; height:80px; border-radius:50%; background:#C0272D; display:flex; align-items:center; justify-content:center; font-size:28px; color:white; font-weight:600; margin:0 auto;">
                                    ${fn:substring(mymember.name, 0, 1)}
                                </div>
                            </c:otherwise>
                        </c:choose>
                        <span onclick="document.getElementById('profileFile').click()"
                              style="font-size:11px; color:rgba(255,255,255,.3); cursor:pointer; text-decoration:underline; margin-top:8px; display:block;">
                            사진 변경
                        </span>
                    </div>

                    <!-- 기본 정보 -->
                    <div style="flex:1;">
                        <div class="info-row"><span class="info-label">아이디</span><span class="info-value">${mymember.id}</span></div>
                        <div class="info-row"><span class="info-label">이름</span><span class="info-value">${mymember.name}</span></div>
                        <div class="info-row" style="border-bottom:none;"><span class="info-label">이메일</span><span class="info-value">${mymember.email}</span></div>
                    </div>
                </div>

                <!-- 정보 수정 폼 -->
                <div class="edit-card">
                    <div class="edit-title">정보 수정</div>

                    <c:if test="${not empty error}">
                        <div class="error-msg">${error}</div>
                    </c:if>

                    <form action="modifyProcMember.do?seq=${mymember.seq}" method="post">
                        <input type="hidden" name="profileFile" value="">
                        <div class="form-group">
                            <label class="form-label">아이디</label>
                            <input type="text" name="id" class="form-input" readonly value="${mymember.id}">
                        </div>
                        <div class="form-group">
                            <label class="form-label">이름</label>
                            <input type="text" name="name" class="form-input"
                                   value="${not empty savedName ? savedName : mymember.name}">
                        </div>
                        <div class="form-group">
                            <label class="form-label">비밀번호</label>
                            <div class="pass-wrap">
                                <input type="password" id="pass" name="pass" class="form-input" placeholder="새 비밀번호">
                                <span class="pass-toggle" onclick="togglePassword()">보기</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="form-label">비밀번호 확인</label>
                            <input type="password" id="confirmPass" name="confirmPass" class="form-input" placeholder="비밀번호 확인">
                        </div>
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
                        <div class="edit-btn-row">
                            <button type="submit" class="btn-confirm">수정하기</button>
                            <button type="button" class="btn-cancel-edit"
                                    onclick="showTab('boards', document.querySelector('.menu-item'))">취소</button>
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
function showTab(tabName, clickedItem) {
    document.querySelectorAll('.tab-panel').forEach(function(p) { p.classList.remove('active'); });
    document.querySelectorAll('.menu-item').forEach(function(m) { m.classList.remove('active'); });
    document.getElementById('tab-' + tabName).classList.add('active');
    if (clickedItem) clickedItem.classList.add('active');
}

function togglePassword() {
    var pass = document.getElementById('pass');
    var confirm = document.getElementById('confirmPass');
    var btn = document.querySelector('.pass-toggle');
    if (pass.type === 'password') {
        pass.type = 'text'; confirm.type = 'text'; btn.textContent = '숨기기';
    } else {
        pass.type = 'password'; confirm.type = 'password'; btn.textContent = '보기';
    }
}

function checkProfileType(input) {
    var allowedExt = ['jpg', 'jpeg', 'png', 'gif'];
    var file = input.files[0];
    var ext = file.name.substring(file.name.lastIndexOf('.') + 1).toLowerCase();
    if (!allowedExt.includes(ext)) {
        alert('이미지 파일만 업로드 가능합니다.');
        input.value = '';
        return;
    }
    if (file.size > 5 * 1024 * 1024) {
        alert('파일 크기는 5MB 이하만 가능합니다.');
        input.value = '';
        return;
    }
    // 선택하면 바로 업로드
    document.getElementById('profileForm').submit();
}

function openDeleteModal() {
    document.getElementById('deleteModal').style.display = 'block';
    setTimeout(function() { document.getElementById('deletePass').focus(); }, 100);
}

function closeDeleteModal() {
    document.getElementById('deleteModal').style.display = 'none';
}

window.addEventListener('click', function(e) {
    if (e.target === document.getElementById('deleteModal')) closeDeleteModal();
});

// 기본 탭을 회원정보로
showTab('info', document.querySelectorAll('.menu-item')[3]);

// 에러 있으면 정보수정 탭 열기
<c:if test="${not empty error}">
    showTab('info', document.querySelectorAll('.menu-item')[3]);
</c:if>

<c:if test="${not empty deleteError}">
    openDeleteModal();
</c:if>

</script>
<!-- 회원 탈퇴 모달 -->
<div id="deleteModal" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,.7); z-index:9999;">
    <div style="background:#161B27; width:380px; margin:160px auto; border-radius:12px; border:0.5px solid #252B3B; padding:28px;">
        <h5 style="font-size:16px; color:white; font-weight:600; margin-bottom:8px;">회원 탈퇴</h5>
        <p style="font-size:13px; color:rgba(255,255,255,.4); margin-bottom:20px; line-height:1.6;">
            탈퇴 후에는 계정을 복구할 수 없습니다.<br>비밀번호를 입력해주세요.
        </p>

        <c:if test="${not empty deleteError}">
            <div style="font-size:13px; color:#C0272D; padding:10px 14px; background:rgba(192,39,45,.1); border-radius:6px; border:0.5px solid rgba(192,39,45,.3); margin-bottom:14px;">
                ${deleteError}
            </div>
        </c:if>

        <form action="deleteMember.do" method="post">
            <input type="password" name="deletePass" id="deletePass"
                   style="width:100%; padding:10px 14px; background:#0D0F14; border:0.5px solid #252B3B; border-radius:6px; font-size:14px; color:rgba(255,255,255,.8); margin-bottom:14px; font-family:inherit;"
                   placeholder="비밀번호 입력">
            <div style="display:flex; gap:8px;">
                <button type="button" onclick="closeDeleteModal()"
                        style="flex:1; padding:10px; background:#252B3B; color:rgba(255,255,255,.5); border:none; border-radius:6px; font-size:14px; cursor:pointer;">취소</button>
                <button type="submit"
                        style="flex:1; padding:10px; background:#C0272D; color:white; border:none; border-radius:6px; font-size:14px; font-weight:500; cursor:pointer;">탈퇴하기</button>
            </div>
        </form>
    </div>
</div>
</body>
</html>