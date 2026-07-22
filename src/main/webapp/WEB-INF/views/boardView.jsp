<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${myboard.title}</title>
<style>
* { box-sizing: border-box; margin: 0; padding: 0; }
body { background: #0D0F14; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif; min-height: 100vh; display: flex; flex-direction: column; }

/* HEADER */
.site-header { background: #0D0F14; border-bottom: 2px solid #C0272D; position: sticky; top: 0; z-index: 100; }
.header-inner { height: 56px; display: flex; align-items: center; justify-content: space-between; padding: 0 32px; max-width: 1100px; width: 100%; margin: 0 auto; }
.header-logo { color: white; font-size: 16px; font-weight: 500; text-decoration: none; }
.header-nav { display: flex; align-items: center; gap: 4px; }
.user-chip { font-size: 13px; color: rgba(255,255,255,.5); padding: 3px 12px; background: rgba(255,255,255,.06); border-radius: 20px; margin-right: 6px; }
.nav-link { color: rgba(255,255,255,.45); font-size: 14px; text-decoration: none; padding: 4px 10px; border-radius: 4px; }
.nav-link:hover { color: rgba(255,255,255,.8); background: rgba(255,255,255,.08); }
.nav-cta { background: #C0272D; color: white; border: none; padding: 6px 16px; border-radius: 5px; font-size: 14px; cursor: pointer; font-weight: 500; text-decoration: none; }

/* MAIN */
.main-content { flex: 1; padding: 28px 32px; max-width: 1100px; width: 100%; margin: 0 auto; }

/* CARD */
.card { background: #161B27; border-radius: 10px; border: 0.5px solid #252B3B; margin-bottom: 16px; }

/* 제목 영역 */
.card-head { padding: 22px 24px 18px; border-bottom: 0.5px solid #252B3B; }
.review-title { font-size: 22px; font-weight: 600; color: white; margin-bottom: 12px; }
.meta-row { display: flex; justify-content: space-between; align-items: center; }
.meta-left { display: flex; align-items: center; gap: 10px; }
.meta-author { font-size: 14px; color: rgba(255,255,255,.5); }
.meta-sep { color: rgba(255,255,255,.2); font-size: 12px; }
.meta-date { font-size: 13px; color: rgba(255,255,255,.35); }
.meta-views { font-size: 13px; color: rgba(255,255,255,.35); }
.meta-right { display: flex; align-items: center; gap: 12px; }
.like-btn { display: flex; align-items: center; gap: 6px; background: none; border: 0.5px solid #252B3B; color: rgba(255,255,255,.4); padding: 5px 14px; border-radius: 6px; font-size: 14px; cursor: pointer; }
.like-btn:hover { border-color: #C0272D; }
.action-link { font-size: 13px; color: rgba(255,255,255,.3); text-decoration: none; cursor: pointer; background: none; border: none; }
.action-link:hover { color: rgba(255,255,255,.7); }

/* 영화 정보 */
.movie-section { padding: 22px 24px; display: flex; gap: 24px; border-bottom: 0.5px solid #252B3B; }
.poster { width: 130px; height: 190px; border-radius: 6px; background: #252B3B; overflow: hidden; flex-shrink: 0; cursor: pointer; }
.poster img { width: 100%; height: 100%; object-fit: cover; }
.movie-info { flex: 1; }
.movie-name { font-size: 20px; font-weight: 600; color: white; margin-bottom: 6px; cursor: pointer; }
.movie-name:hover { color: #C0272D; }
.movie-meta { font-size: 14px; color: rgba(255,255,255,.4); margin-bottom: 16px; }
.star-lg { width: 26px; height: 26px; clip-path: polygon(50% 0%,63% 32%,98% 35%,70% 60%,80% 95%,50% 75%,20% 95%,30% 60%,2% 35%,37% 32%); }
.star-md { width: 20px; height: 20px; clip-path: polygon(50% 0%,63% 32%,98% 35%,70% 60%,80% 95%,50% 75%,20% 95%,30% 60%,2% 35%,37% 32%); }
.star-gold { background: #F5C842; }
.star-dark { background: #2A3040; }
.star-row { display: flex; gap: 4px; align-items: center; }

.avg-row { font-size: 13px; color: rgba(255,255,255,.4); display: flex; align-items: center; gap: 4px; }
.avg-stars { color: #F5C842; font-size: 13px; }
.avg-score { color: #C0272D; font-weight: 500; }
.detail-btn { display: inline-flex; align-items: center; gap: 4px; margin-top: 14px; font-size: 12px; color: rgba(255,255,255,.3); border: 0.5px solid #252B3B; padding: 5px 12px; border-radius: 4px; cursor: pointer; background: none; }
.detail-btn:hover { border-color: #C0272D; color: #C0272D; }

/* 본문 */
.review-content { padding: 22px 24px; font-size: 15px; color: rgba(255,255,255,.75); line-height: 1.85; }

/* COMMENTS */
.comment-card { background: #161B27; border-radius: 10px; border: 0.5px solid #252B3B; }
.comment-head { padding: 18px 24px; border-bottom: 0.5px solid #252B3B; }
.comment-title { font-size: 15px; font-weight: 500; color: rgba(255,255,255,.8); }

/* 댓글 아이템 */
.comment-item { padding: 14px 24px; border-bottom: 0.5px solid #1D2335; }
.reply-item { padding: 12px 24px 12px 48px; border-bottom: 0.5px solid #1D2335; background: #111622; }
.c-top { display: flex; justify-content: space-between; align-items: center; margin-bottom: 6px; }
.c-author { font-size: 14px; font-weight: 500; color: rgba(255,255,255,.7); }
.c-badge { font-size: 10px; background: #C0272D; color: white; padding: 1px 6px; border-radius: 3px; margin-left: 6px; vertical-align: middle; }
.c-time { font-size: 12px; color: rgba(255,255,255,.3); margin-left: 8px; }
.c-actions { display: flex; gap: 10px; }
.c-action { font-size: 12px; color: rgba(255,255,255,.3); text-decoration: none; cursor: pointer; background: none; border: none; }
.c-action:hover { color: rgba(255,255,255,.7); }
.c-content { font-size: 14px; color: rgba(255,255,255,.6); line-height: 1.6; }
.reply-mark { font-size: 12px; color: rgba(255,255,255,.2); margin-right: 4px; }
.empty-comment { padding: 24px; text-align: center; font-size: 14px; color: rgba(255,255,255,.25); }

/* 댓글 수정 폼 */
.modify-form-wrap { padding: 12px 24px; background: #111622; border-bottom: 0.5px solid #252B3B; }
.modify-form-row { display: flex; gap: 8px; }

/* 댓글 입력 */
.comment-form { padding: 16px 24px; border-top: 0.5px solid #252B3B; display: flex; gap: 8px; }
.comment-input { flex: 1; padding: 10px 14px; background: #0D0F14; border: 0.5px solid #252B3B; border-radius: 6px; font-size: 14px; color: rgba(255,255,255,.7); resize: none; font-family: inherit; }
.comment-input::placeholder { color: rgba(255,255,255,.2); }
.comment-submit { padding: 0 20px; background: #C0272D; color: white; border: none; border-radius: 6px; font-size: 14px; font-weight: 500; cursor: pointer; }
.form-control-dark { padding: 8px 12px; background: #0D0F14; border: 0.5px solid #252B3B; border-radius: 6px; font-size: 14px; color: rgba(255,255,255,.7); font-family: inherit; flex: 1; resize: none; }
.btn-red { padding: 8px 16px; background: #C0272D; color: white; border: none; border-radius: 6px; font-size: 13px; cursor: pointer; }
.btn-gray { padding: 8px 16px; background: #252B3B; color: rgba(255,255,255,.5); border: none; border-radius: 6px; font-size: 13px; cursor: pointer; }

/* 답글 폼 */
.reply-form-wrap { background: #0D0F14; border-bottom: 0.5px solid #252B3B; padding: 10px 24px 10px 48px; display: none; }
.reply-form-row { display: flex; gap: 8px; }

/* 영화 상세 모달 */
.modal-bg { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,.7); z-index: 9999; }
.modal-box { background: #161B27; width: 580px; max-height: 80vh; margin: 80px auto; border-radius: 12px; overflow: hidden; display: flex; flex-direction: column; border: 0.5px solid #252B3B; }
.modal-head { padding: 16px 20px; border-bottom: 0.5px solid #252B3B; display: flex; justify-content: space-between; align-items: center; }
.modal-head h5 { font-size: 15px; color: white; font-weight: 500; }
.modal-close { background: none; border: none; color: rgba(255,255,255,.5); font-size: 20px; cursor: pointer; }
.modal-body { overflow-y: auto; flex: 1; padding: 20px; }
.modal-loading { text-align: center; color: rgba(255,255,255,.3); padding: 24px; font-size: 14px; }

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

<!-- HEADER -->
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

<!-- MAIN -->
<div class="main-content">

    <!-- 리뷰 카드 -->
    <div class="card">

        <!-- 제목 + 메타 -->
        <div class="card-head">
            <div class="review-title">${myboard.title}</div>
            <div class="meta-row">
                <div class="meta-left">
                <c:choose>
                        <c:when test="${not empty authorProfileImg}">
                            <img src="profile/${authorProfileImg}"
                                 style="width:30px; height:30px; border-radius:50%; object-fit:cover;">
                        </c:when>
                        <c:otherwise>
                            <span style="width:30px; height:30px; border-radius:50%; background:#C0272D; display:inline-flex; align-items:center; justify-content:center; font-size:11px; color:white; font-weight:600; flex-shrink:0;">
                                ${fn:substring(myboard.name, 0, 1)}
                            </span>
                        </c:otherwise>
                    </c:choose>
                    <span class="meta-author">${myboard.name}</span>
                    <span class="meta-sep">|</span>
                    <span class="meta-date"><fmt:formatDate value="${myboard.time}" pattern="yy-MM-dd HH:mm"/></span>
                    <span class="meta-sep">|</span>
                    <span class="meta-views">조회 ${myboard.views}</span>
                </div>
                <div class="meta-right">
                    <!-- 좋아요 버튼 -->
                    <c:choose>
                        <c:when test="${not empty sessionScope.log}">
                            <button id="likeBtn" onclick="toggleLike(${myboard.seq})" class="like-btn">
                                <svg id="likeIcon" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#C0272D" stroke-width="2">
                                    <path id="likePath1" d="M7 22h-4a1 1 0 0 1 -1 -1v-9a1 1 0 0 1 1 -1h4v11z" fill="${isLiked ? '#C0272D' : 'none'}"/>
                                    <path id="likePath2" d="M7 11l5 -9a2 2 0 0 1 2 2v6h5a2 2 0 0 1 2 2l-1.5 9.5a2 2 0 0 1 -2 1.5h-9.5" fill="${isLiked ? '#C0272D' : 'none'}"/>
                                </svg>
                                <span id="likeCount">${likeCount}</span>
                            </button>
                        </c:when>
                        <c:otherwise>
                            <span class="like-btn">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="rgba(255,255,255,0.3)" stroke-width="2">
                                    <path d="M7 22h-4a1 1 0 0 1 -1 -1v-9a1 1 0 0 1 1 -1h4v11z"/>
                                    <path d="M7 11l5 -9a2 2 0 0 1 2 2v6h5a2 2 0 0 1 2 2l-1.5 9.5a2 2 0 0 1 -2 1.5h-9.5"/>
                                </svg>
                                ${likeCount}
                            </span>
                        </c:otherwise>
                    </c:choose>
                    <!-- 수정/삭제 -->
                    <c:if test="${not empty sessionScope.log && sessionScope.log.seq == myboard.memberSeq}">
                        <a href="modifyBoard.do?seq=${myboard.seq}" class="action-link">수정</a>
                        <a href="deleteBoard.do?seq=${myboard.seq}" class="action-link" onclick="return confirm('게시글을 삭제하시겠습니까?')">삭제</a>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- 영화 정보 -->
        <div class="movie-section">
            <div class="poster" onclick="openMovieDetail('${myboard.mtitle}')">
                <c:choose>
                    <c:when test="${fn:startsWith(myboard.filename, 'http')}">
                        <img src="${myboard.filename}" alt="포스터">
                    </c:when>
                    <c:otherwise>
                        <img src="poster/poster/${myboard.filename}" alt="포스터">
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="movie-info">
                <div class="movie-name" onclick="openMovieDetail('${myboard.mtitle}')">${myboard.mtitle}</div>
                <div class="movie-meta">${myboard.myear} · ${myboard.mgenre} · ${myboard.mcountry}</div>

                <div class="star-row" style="margin-bottom:8px;">
                    <div class="star-lg ${myboard.score >= 1 ? 'star-gold' : 'star-dark'}"></div>
                    <div class="star-lg ${myboard.score >= 2 ? 'star-gold' : 'star-dark'}"></div>
                    <div class="star-lg ${myboard.score >= 3 ? 'star-gold' : 'star-dark'}"></div>
                    <div class="star-lg ${myboard.score >= 4 ? 'star-gold' : 'star-dark'}"></div>
                    <div class="star-lg ${myboard.score >= 5 ? 'star-gold' : 'star-dark'}"></div>
                </div>

                <c:if test="${not empty avgScore && not empty myboard.mtitle}">
                    <div class="avg-row">
                        이 영화 평균 별점 :
                        <span class="avg-score"><fmt:formatNumber value="${avgScore}" maxFractionDigits="1"/>점</span>
                        <span style="color:rgba(255,255,255,.25);">(리뷰 ${reviewCount}개)</span>
                    </div>
                </c:if>
                <button class="detail-btn" onclick="openMovieDetail('${myboard.mtitle}')">상세 정보 보기 &#8250;</button>
            </div>
        </div>

        <!-- 본문 -->
        <div class="review-content">${myboard.content}</div>
    </div>

    <!-- 댓글 -->
    <div class="comment-card">
        <div class="comment-head">
            <span class="comment-title">댓글 [${fn:length(cList)}]</span>
        </div>

        <c:if test="${empty cList}">
            <div class="empty-comment">첫 번째 댓글을 남겨보세요!</div>
        </c:if>

        <c:forEach var="mycomment" items="${cList}">
            <c:if test="${empty mycomment.parentSeq}">
                <!-- 일반 댓글 -->
                <div class="comment-item">
                    <div class="c-top">
                        <div style="display:flex; align-items:center; gap:7px;">
                                <c:choose>
                                    <c:when test="${not empty commentProfileMap[mycomment.name]}">
                                        <img src="profile/${commentProfileMap[mycomment.name]}"
                                             style="width:28px; height:28px; border-radius:50%; object-fit:cover;">
                                    </c:when>
                                    <c:otherwise>
                                        <span style="width:28px; height:28px; border-radius:50%; background:#252B3B; display:inline-flex; align-items:center; justify-content:center; font-size:10px; color:rgba(255,255,255,.6); font-weight:600; flex-shrink:0;">
                                            ${fn:substring(mycomment.name, 0, 1)}
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                                <span class="c-author">${mycomment.name}</span>
                                <c:if test="${mycomment.name eq authorName}">
                                    <span class="c-badge">작성자</span>
                                </c:if>
                                <span class="c-time"><fmt:formatDate value="${mycomment.time}" pattern="HH:mm"/></span>
                            </div>
                        <div class="c-actions">
                            <c:if test="${not empty sessionScope.log}">
                                <button class="c-action" onclick="openReplyForm(${mycomment.seq})">답글</button>
                            </c:if>
                            <c:if test="${not empty sessionScope.log && sessionScope.log.seq == mycomment.memberSeq}">
                                <button class="c-action" onclick="openModifyForm(${mycomment.seq}, '${mycomment.content}')">수정</button>
                                <a href="deleteComment.do?seq=${mycomment.seq}&boardSeq=${myboard.seq}" class="c-action" onclick="return confirm('댓글을 삭제하시겠습니까?')">삭제</a>
                            </c:if>
                        </div>
                    </div>
                    <div class="c-content">${mycomment.content}</div>
                </div>

                <!-- 답글 폼 -->
                <div class="reply-form-wrap" id="replyForm-${mycomment.seq}">
                    <form action="insertComment.do" method="post" class="reply-form-row" onsubmit="return validateReply(this)">
                        <input type="hidden" name="boardSeq" value="${myboard.seq}">
                        <input type="hidden" name="parentSeq" value="${mycomment.seq}">
                        <textarea name="content" rows="2" class="form-control-dark" placeholder="답글을 입력하세요"></textarea>
                        <button type="submit" class="btn-red">등록</button>
                    </form>
                </div>

                <!-- 답글 목록 -->
                <c:forEach var="reply" items="${cList}">
                    <c:if test="${reply.parentSeq == mycomment.seq}">
                        <div class="reply-item">
                            <div class="c-top">
                                <div style="display:flex; align-items:center; gap:7px;">
                                        <span class="reply-mark">↳</span>
                                        <c:choose>
                                            <c:when test="${not empty commentProfileMap[reply.name]}">
                                                <img src="profile/${commentProfileMap[reply.name]}"
                                                     style="width:28px; height:28px; border-radius:50%; object-fit:cover;">
                                            </c:when>
                                            <c:otherwise>
                                                <span style="width:28px; height:28px; border-radius:50%; background:#252B3B; display:inline-flex; align-items:center; justify-content:center; font-size:10px; color:rgba(255,255,255,.6); font-weight:600; flex-shrink:0;">
                                                    ${fn:substring(reply.name, 0, 1)}
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                        <span class="c-author">${reply.name}</span>
                                        <c:if test="${reply.name eq authorName}">
                                            <span class="c-badge">작성자</span>
                                        </c:if>
                                        <span class="c-time"><fmt:formatDate value="${reply.time}" pattern="HH:mm"/></span>
                                    </div>
                                <div class="c-actions">
                                    <c:if test="${not empty sessionScope.log && sessionScope.log.seq == reply.memberSeq}">
                                        <button class="c-action" onclick="openModifyForm(${reply.seq}, '${reply.content}')">수정</button>
                                        <a href="deleteComment.do?seq=${reply.seq}&boardSeq=${myboard.seq}" class="c-action" onclick="return confirm('답글을 삭제하시겠습니까?')">삭제</a>
                                    </c:if>
                                </div>
                            </div>
                            <div class="c-content">${reply.content}</div>
                        </div>
                    </c:if>
                </c:forEach>
            </c:if>
        </c:forEach>

        <!-- 댓글 수정 폼 -->
        <div id="modifyCommentForm" class="modify-form-wrap" style="display:none;">
            <form action="modifyProcComment.do" method="post" class="modify-form-row" onsubmit="return validateModifyComment()">
                <input type="hidden" id="commentSeq" name="seq" value="">
                <input type="hidden" name="boardSeq" value="${myboard.seq}">
                <textarea class="form-control-dark" id="content" name="content" rows="2"></textarea>
                <button type="submit" class="btn-red">수정</button>
                <button type="button" class="btn-gray" onclick="cancelModify()">취소</button>
            </form>
        </div>

        <!-- 댓글 입력 -->
        <c:if test="${not empty sessionScope.log}">
            <form id="insertCommentForm" action="insertComment.do" method="post" class="comment-form" onsubmit="return validateComment()">
                <input type="hidden" name="boardSeq" value="${myboard.seq}">
                <textarea name="content" rows="2" class="comment-input" placeholder="댓글을 입력하세요"></textarea>
                <button type="submit" class="comment-submit">등록</button>
            </form>
        </c:if>
        <c:if test="${empty sessionScope.log}">
            <div style="padding:16px 24px; text-align:center; font-size:13px; color:rgba(255,255,255,.3);">
                <a href="login.do" style="color:#C0272D;">로그인</a> 후 댓글을 작성할 수 있습니다.
            </div>
        </c:if>
    </div>
</div>

<!-- 영화 상세 모달 -->
<div id="movieDetailModal" class="modal-bg">
    <div class="modal-box">
        <div class="modal-head">
            <h5>영화 상세정보</h5>
            <button class="modal-close" onclick="closeMovieDetail()">&#10005;</button>
        </div>
        <div id="movieDetailContent" class="modal-body">
            <p class="modal-loading">불러오는 중...</p>
        </div>
    </div>
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

<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<script>
function openModifyForm(seq, content) {
    document.getElementById('commentSeq').value = seq;
    document.getElementById('content').value = content;
    document.getElementById('modifyCommentForm').style.display = 'block';
    document.getElementById('insertCommentForm') && (document.getElementById('insertCommentForm').style.display = 'none');
}

function cancelModify() {
    document.getElementById('commentSeq').value = '';
    document.getElementById('content').value = '';
    document.getElementById('modifyCommentForm').style.display = 'none';
    document.getElementById('insertCommentForm') && (document.getElementById('insertCommentForm').style.display = 'flex');
}

function openReplyForm(seq) {
    var form = document.getElementById('replyForm-' + seq);
    form.style.display = form.style.display === 'none' || form.style.display === '' ? 'block' : 'none';
}

function validateComment() {
    var content = document.querySelector('#insertCommentForm textarea[name="content"]').value.trim();
    if (!content) { alert('댓글 내용을 입력해주세요.'); return false; }
    return true;
}

function validateModifyComment() {
    if (!document.getElementById('content').value.trim()) { alert('댓글 내용을 입력해주세요.'); return false; }
    return true;
}

function validateReply(form) {
    var content = form.querySelector('textarea[name="content"]').value.trim();
    if (!content) { alert('답글 내용을 입력해주세요.'); return false; }
    return true;
}

function toggleLike(boardSeq) {
    fetch('toggleLike.do?seq=' + boardSeq)
        .then(response => response.text())
        .then(result => {
            var parts = result.split(':');
            var liked = parts[0] === 'true';
            var count = parts[1];
            var fillValue = liked ? '#C0272D' : 'none';
            document.getElementById('likePath1').setAttribute('fill', fillValue);
            document.getElementById('likePath2').setAttribute('fill', fillValue);
            document.getElementById('likeCount').textContent = count;
        });
}

function openMovieDetail(mtitle) {
    document.getElementById('movieDetailModal').style.display = 'block';
    document.getElementById('movieDetailContent').innerHTML = '<p class="modal-loading">불러오는 중...</p>';

    fetch('movieDetail.do?mtitle=' + encodeURIComponent(mtitle))
        .then(response => response.json())
        .then(movie => {
            if (!movie.title) {
                document.getElementById('movieDetailContent').innerHTML = '<p class="modal-loading">정보를 찾을 수 없습니다.</p>';
                return;
            }
            var castStr = movie.cast && movie.cast.length > 0 ? movie.cast.join(', ') : '정보 없음';
            var runtimeStr = movie.runtime > 0 ? movie.runtime + '분' : '정보 없음';
            document.getElementById('movieDetailContent').innerHTML =
                '<div style="display:flex;gap:20px;">' +
                    '<img src="' + movie.poster + '" style="width:130px;border-radius:6px;flex-shrink:0;" onerror="this.style.display=\'none\'">' +
                    '<div style="flex:1;">' +
                        '<h4 style="font-size:18px;color:white;margin-bottom:8px;">' + movie.title + '</h4>' +
                        '<table style="font-size:14px;width:100%;border-collapse:collapse;">' +
                            '<tr><td style="color:rgba(255,255,255,.4);width:80px;padding:5px 0;">개봉연도</td><td style="color:rgba(255,255,255,.75);">' + movie.year + '</td></tr>' +
                            '<tr><td style="color:rgba(255,255,255,.4);padding:5px 0;">장르</td><td style="color:rgba(255,255,255,.75);">' + movie.genre + '</td></tr>' +
                            '<tr><td style="color:rgba(255,255,255,.4);padding:5px 0;">국가</td><td style="color:rgba(255,255,255,.75);">' + movie.country + '</td></tr>' +
                            '<tr><td style="color:rgba(255,255,255,.4);padding:5px 0;">상영시간</td><td style="color:rgba(255,255,255,.75);">' + runtimeStr + '</td></tr>' +
                            '<tr><td style="color:rgba(255,255,255,.4);padding:5px 0;">출연진</td><td style="color:rgba(255,255,255,.75);">' + castStr + '</td></tr>' +
                        '</table>' +
                    '</div>' +
                '</div>' +
                '<div style="margin-top:18px;padding-top:16px;border-top:0.5px solid #252B3B;">' +
                    '<p style="color:rgba(255,255,255,.4);font-size:12px;margin-bottom:8px;">줄거리</p>' +
                    '<p style="font-size:14px;color:rgba(255,255,255,.65);line-height:1.7;">' + (movie.overview || '줄거리 정보가 없습니다.') + '</p>' +
                '</div>';
        })
        .catch(() => {
            document.getElementById('movieDetailContent').innerHTML = '<p class="modal-loading">오류가 발생했습니다.</p>';
        });
}

function closeMovieDetail() {
    document.getElementById('movieDetailModal').style.display = 'none';
}

window.addEventListener('click', function(e) {
    if (e.target === document.getElementById('movieDetailModal')) closeMovieDetail();
});
</script>
</body>
</html>