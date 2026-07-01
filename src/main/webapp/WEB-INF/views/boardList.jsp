<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>movie.com</title>
<!-- 부트스트랩 적용 -->
<link rel="stylesheet" href="resources/css/bootstrap.min.css">
<!-- 사용자 정의 스타일 -->
<style>
body {
	background-color: #E6E6E6;
}
/* 헤더 스타일 */
header {
	background-color: #8A0808;
	border-radius: 10px;
	padding: 1rem;
	height: 100px;
	margin-left: 40px;
	margin-right: 40px;
	margin-top: 30px;
	margin-bottom: 30px;
}

/* 버튼 스타일 */
.nav-link {
	margin-left: 1rem;
	text-decoration: none;
	color: #F2F2F2;
}

/* 게시글 목록 제목 색상 */
.jumbotron tbody a {
	color: black;
}

.jumbotron {
	background-color: #fff;
	padding: 3rem;
	border-radius: 10px;
	margin-left: 40px;
	margin-right: 40px;
}

.table th, .table td {
	border: none;
	padding: 10px;
}

/* 페이징 버튼 글씨 색상 */
.pagination .page-link {
	color: black !important;
}
</style>
</head>

<script>
function toggleSearchInput(select) {
    // 전부 숨기고 비활성화
    document.getElementById('textInput').style.display = 'none';
    document.getElementById('genreInput').style.display = 'none';
    document.getElementById('countryInput').style.display = 'none';
    document.querySelector('#textInput input').disabled = true;
    document.querySelector('#genreInput select').disabled = true;
    document.querySelector('#countryInput select').disabled = true;

    // 선택한 것만 보이고 활성화
    if (select.value === 'genre') {
        document.getElementById('genreInput').style.display = 'block';
        document.querySelector('#genreInput select').disabled = false;
    } else if (select.value === 'country') {
        document.getElementById('countryInput').style.display = 'block';
        document.querySelector('#countryInput select').disabled = false;
    } else {
        document.getElementById('textInput').style.display = 'block';
        document.querySelector('#textInput input').disabled = false;
    }
}
</script>

<body>
	<!-- 헤더 시작 -->
	<header>
		<!-- 상단 바 시작 -->
		<nav class="navbar">
			<!-- 메인 글씨 -->
			<a href="boardList.do" style="text-decoration: none; color: #F2F2F2;">
				<h3 style="margin-left: 30px; margin-top: 8px;"
					onclick="location.href='boardList.do'">영화 게시판 🎬</h3>
			</a>
			<!-- 로그아웃, 마이페이지, 게시물 링크 표시 -->
			<div class="d-flex">
				<!-- 로그인 상태에 따라 링크 표시 -->
				<c:choose>
					<c:when test="${not empty sessionScope.log}">
						<a href="logout.do" class="nav-link" onclick="return confirm('로그아웃 하시겠습니까?')">로그아웃</a>
						<a href="myPage.do" class="nav-link">마이페이지</a>
						<a href="insertBoard.do" class="nav-link"
							style="margin-right: 30px;">게시물 작성</a>
					</c:when>
					<c:otherwise>
						<a href="login.do" class="nav-link">로그인</a>
						<a href="insertMember.do" class="nav-link"
							style="margin-right: 30px;">회원가입</a>
					</c:otherwise>
				</c:choose>
			</div>
		</nav>
		<!-- 상단 바 종료 -->
	</header>
	<!-- 헤더 종료 -->

	<!-- 게시글 목록 테이블 시작 -->
	<div class="jumbotron">

	<!-- 정렬 버튼 -->
    <div style="margin-bottom: 10px; text-align: right;">
        <a href="boardList.do?sort=latest"
           style="margin-right: 6px; text-decoration: none; padding: 4px 12px; border-radius: 4px; font-size: 13px;
                  ${currentSort == 'latest' ? 'background-color:#8A0808; color:white;' : 'background-color:#eee; color:#333;'}">
            최신순
        </a>
        <a href="boardList.do?sort=views"
           style="margin-right: 6px; text-decoration: none; padding: 4px 12px; border-radius: 4px; font-size: 13px;
                  ${currentSort == 'views' ? 'background-color:#8A0808; color:white;' : 'background-color:#eee; color:#333;'}">
            조회순
        </a>
        <a href="boardList.do?sort=likes"
           style="margin-right: 6px; text-decoration: none; padding: 4px 12px; border-radius: 4px; font-size: 13px;
                  ${currentSort == 'likes' ? 'background-color:#8A0808; color:white;' : 'background-color:#eee; color:#333;'}">
            인기순
        </a>
        <a href="boardList.do?sort=score"
           style="text-decoration: none; padding: 4px 12px; border-radius: 4px; font-size: 13px;
                  ${currentSort == 'score' ? 'background-color:#8A0808; color:white;' : 'background-color:#eee; color:#333;'}">
            별점순
        </a>
    </div>

		<table class="table table-bordered table-hover">
			<thead class="table-light">
				<tr>
					<th scope="col" class="col-6">제목</th>
					<th scope="col" class="col-1 text-center">작성자</th>
					<th scope="col" class="col-1 text-center">작성일</th>
					<th scope="col" class="col-1 text-center">조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${not empty searchMessage}">
					<tr>
						<td colspan="4">${searchMessage}</td>
					</tr>
				</c:if>
				<!-- 게시글 목록 출력 부분 -->
				<c:forEach var="myboard" items="${bList}">
					<tr>
						<td><a href="boardView.do?seq=${myboard.seq}"
							class="text-decoration-none"> [${myboard.mtitle}]
								${myboard.title} </a></td>
						<td class="text-center">${myboard.name}</td>
						<td class="text-center"><fmt:formatDate value="${myboard.time}" pattern="HH:mm" /></td>
						<td class="text-center">${myboard.views}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<!-- 게시글 목록 테이블 종료 -->

		<!-- 페이지 시작 -->
		<div class="row justify-content-center">
			<div class="col-auto">
				<ul class="pagination">
					<!-- 페이지 숫자 출력 부분 -->
					<c:forEach var="i" begin="1" end="${totalPages}">
						<li class="page-item"><a href="boardList.do?page=${i}"
							class="page-link">${i}</a></li>
					</c:forEach>
				</ul>
			</div>
		</div>
		<!-- 페이징 종료 -->

		<!-- 검색/필터 폼 시작 -->
		<form action="searchBoard.do" method="get" id="searchForm" class="mb-3">
            <div class="row justify-content-center">
                <div class="col-2" style="margin-right: 0px;">
                    <select name="searchCon" class="form-select" onchange="toggleSearchInput(this)">
                        <option value="title">글제목</option>
                        <option value="content">글내용</option>
                        <option value="genre">장르</option>
                        <option value="country">국가</option>
                    </select>
                </div>

                <!-- 텍스트 입력 (글제목, 글내용) -->
                <div class="col-5" style="margin-left: -19px;" id="textInput">
                    <input name="searchKey" type="text" class="form-control">
                </div>

                <!-- 장르 드롭다운 -->
                <div class="col-5" style="margin-left: -19px; display:none;" id="genreInput">
                    <select name="searchKey" class="form-select" disabled>
                        <option value="액션">액션</option>
                                <option value="범죄">범죄</option>
                                <option value="SF">SF</option>
                                <option value="코미디">코미디</option>
                                <option value="드라마">드라마</option>
                                <option value="역사">역사</option>
                                <option value="모험">모험</option>
                                <option value="로맨스">로맨스</option>
                                <option value="스릴러">스릴러</option>
                                <option value="공포">공포</option>
                                <option value="전쟁">전쟁</option>
                                <option value="스포츠">스포츠</option>
                                <option value="판타지">판타지</option>
                                <option value="음악">음악</option>
                                <option value="뮤지컬">뮤지컬</option>
                                <option value="멜로">멜로</option>
                    </select>
                </div>

                <!-- 국가 드롭다운 -->
                <div class="col-5" style="margin-left: -19px; display:none;" id="countryInput">
                    <select name="searchKey" class="form-select" disabled>
                        <option value="한국">한국</option>
                                <option value="미국">미국</option>
                                <option value="캐나다">캐나다</option>
                                <option value="중국">중국</option>
                                <option value="일본">일본</option>
                                <option value="영국">영국</option>
                                <option value="프랑스">프랑스</option>
                                <option value="인도">인도</option>
                                <option value="독일">독일</option>
                                <option value="멕시코">멕시코</option>
                                <option value="러시아">러시아</option>
                                <option value="호주">호주</option>
                                <option value="이탈리아">이탈리아</option>
                                <option value="스페인">스페인</option>
                                <option value="브라질">브라질</option>
                                <option value="대만">대만</option>
                                <option value="네덜란드">네덜란드</option>
                                <option value="홍콩">홍콩</option>
                    </select>
                </div>

                <div class="col-2" style="margin-left: -19px;">
                    <input type="submit" value="검색" class="btn btn-primary"
                        style="background-color: #8A0808; border-color: #8A0808; width: 60px;">
                </div>
            </div>
        </form>
        <!-- 검색/필터 폼 종료 -->
	</div>
</body>
</html>