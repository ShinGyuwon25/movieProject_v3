<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <script>
        function checkFileType(input) {
            var allowedExt = ['jpg', 'jpeg', 'png', 'gif'];
            var fileName = input.files[0].name;
            var ext = fileName.substring(fileName.lastIndexOf('.') + 1).toLowerCase();

            if (!allowedExt.includes(ext)) {
                alert('이미지 파일만 업로드 가능합니다 (jpg, jpeg, png, gif)');
                input.value = '';
            }
        }
    </script>
    <title>글 쓰기</title>
    <link rel="stylesheet" href="resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/star.css"/>
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
            margin-left : 40px;
            margin-right : 40px;
            margin-top : 30px;
            margin-bottom : 30px;
        }

        /* 버튼 스타일 */
        .nav-link {
            margin-left: 1rem;
            text-decoration: none;
            color: #F2F2F2;
        }


        .container {
            margin-top: 20px;
        }
        .jumbotron {
            background-color: #fff;
            padding: 3rem;
            border-radius: 10px;
            margin-left : -45px;
            margin-right : -45px;
            margin-bottom : 40px;
        }
    </style>
</head>

<body>
 <!-- 헤더 시작 -->
    <header>
        <!-- 상단 네비게이션 바 시작 -->
        <nav class="navbar">
            <!-- 메인 글씨 -->
            <a href="boardList.do" style="text-decoration: none; color: #F2F2F2;">
                 <h3 style="margin-left: 30px; margin-top: 8px;" onclick="location.href='boardList.do'">영화 게시판 🎬</h3>
            </a>
             <!-- 로그아웃, 회원정보, 게시물 링크 표시 -->
            <div class="d-flex">
                <!-- 로그인 상태에 따라 링크 표시 -->
                <c:choose>
                    <c:when test="${not empty sessionScope.log}">
                        <a href="logout.do" class="nav-link">로그아웃</a>
                        <a href="memberView.do" class="nav-link">회원정보</a>
                        <a href="insertBoard.do" class="nav-link" style="margin-right: 30px;">게시물 작성</a>
                    </c:when>
                    <c:otherwise>
                        <a href="login.do" class="nav-link">로그인</a>
                        <a href="insertMember.do" class="nav-link" style="margin-right: 30px;">회원가입</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </nav>
        <!-- 상단 네비게이션 바 종료 -->
    </header>
    <!-- 헤더 종료 -->

     <div class="container">
    <div class="jumbotron">
    <h2>글 쓰기</h2>
    <hr>
    <form name="myform" id="myform" action="insertProcBoard.do" method="post" enctype="multipart/form-data">

        <div class="row mb-3">
            <div class="col-sm-12">
        <input type="text" class="form-control" id="title" name="title" placeholder="제목">
    </div>
    </div>

<div class="row mb-3">
    <div class="col-sm-3" style = "margin-right: -15px;">
        <input type="text" class="form-control" id="mtitle" name="mtitle" placeholder="영화 제목">
    </div>

    <div class="col-sm-2" style = "margin-right: -15px;">
        <select class="form-control" id="myear" name="myear" >
            <!-- 제작 연도 드롭다운 리스트-->
            <option value="" disabled selected>제작 연도</option>
            <!-- 역순으로 옵션 생성 -->
            <% for (int year = 2023; year >= 1900; year--) { %>
                <option value="<%= year %>"><%= year %></option>
            <% } %>
        </select>
    </div>
<div class="col-sm-2" style="margin-right: -15px;">
    <select class="form-control" id="mgenre" name="mgenre">
        <!-- 영화 장르 드롭다운 리스트 -->
        <option value="" disabled selected>영화 장르</option>
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

<div class="col-sm-2" style="margin-right: -15px;">
    <select class="form-control" id="mcountry" name="mcountry">
        <!-- 제작 국가 드롭다운 리스트 -->
        <option value="" disabled selected>제작 국가</option>
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

    <!-- 별점 표시 -->
    <label for="score" class="col-sm-1 col-form-label no-star-effect" style = "font-size: 17px; margin-right : -35px; margin-left : 10px;">별점</label>
    <div class="col-sm-3 rating-stars star-container" style = "margin-left : -20px;">
        <fieldset>
            <input type="radio" name="score" value="5" id="rate1">
            <label for="rate1" class="star">★</label>
            <input type="radio" name="score" value="4" id="rate2">
            <label for="rate2" class="star">★</label>
            <input type="radio" name="score" value="3" id="rate3">
            <label for="rate3" class="star">★</label>
            <input type="radio" name="score" value="2" id="rate4">
            <label for="rate4" class="star">★</label>
            <input type="radio" name="score" value="1" id="rate5">
            <label for="rate5" class="star">★</label>
        </fieldset>
    </div>
        </div>

        <div class="row mb-3">
            <div class="col-sm-12">
                <textarea class="form-control" id="content" name="content" rows="10" placeholder="내용을 입력하세요."></textarea>
            </div>
        </div>

    <div class="row mb-3">
    <label for="uploadFile" class="col-sm-2 col-form-label no-star-effect" style="font-size: 17px; margin-right: -90px; margin-top: -2px;">영화 포스터</label>
    <div class="col-sm-3">
        <input type="file" name="uploadFile" onchange="checkFileType(this)" class="form-control-file">
        <!-- <img id="posterPreview" src="#" alt="포스터 미리보기" style="max-width: 100%; max-height: 100%;"> -->
    </div>

    <div class="col-sm-7 d-flex justify-content-end">
        <input type="submit" value="확인" class="btn btn-primary" style = "width: 60px; background-color: #8A0808; border-color: #8A0808; margin-right : 5px;">
        <input type="button" value="취소" onclick="location.href='boardList.do'" class="btn btn-secondary ml-2" style = "width: 60px; margin-right : -90px;">
    </div>
    </div>

    </form>
    </div>

    <!-- 글쓴이 숨기기 -->
<label for="name" class="col-sm-2 col-form-label no-star-effect visually-hidden">글쓴이</label>
<div class="col-sm-4">
    <input type="hidden" class="form-control" id="name" name="name" value="${mymember.name}" readonly>
</div>
<!-- hidden -->
    </div>
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
</body>
</html>
