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
    <title>글 수정</title>
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
            margin-left : -30px;
            margin-right : -30px;
            margin-bottom : 40px;
        }
    </style>
</head>
<body>

<!-- 헤더 시작 -->
    <header>
        <!-- 상단 바 시작 -->
        <nav class="navbar">
            <!-- 메인 글씨 -->
            <a href="boardList.do" style="text-decoration: none; color: #F2F2F2;">
                 <h3 style="margin-left: 30px; margin-top: 8px;" onclick="location.href='boardList.do'">영화 게시판 🎬</h3>
            </a>
             <!-- 로그아웃, 마이페이지, 게시물 링크 표시 -->
            <div class="d-flex">
                <!-- 로그인 상태에 따라 링크 표시 -->
                <c:choose>
                    <c:when test="${not empty sessionScope.log}">
                        <a href="logout.do" class="nav-link" onclick="return confirm('로그아웃 하시겠습니까?')">로그아웃</a>
                        <a href="myPage.do" class="nav-link">마이페이지</a>
                        <a href="insertBoard.do" class="nav-link" style="margin-right: 30px;">게시물 작성</a>
                    </c:when>
                    <c:otherwise>
                        <a href="login.do" class="nav-link">로그인</a>
                        <a href="insertMember.do" class="nav-link" style="margin-right: 30px;">회원가입</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </nav>
        <!-- 상단 바 종료 -->
    </header>
    <!-- 헤더 종료 -->

    <div class="container">
    <div class="jumbotron">
        <h2>글 수정</h2>
        <hr>
        <form name="myform" id="myform" action="modifyProcBoard.do?seq=${myboard.seq}" method="post" enctype="multipart/form-data">

       <div class="row mb-3">
            <div class="col-sm-12">
        <input type="text" class="form-control" id="title" name="title" placeholder="제목" value="${myboard.title}">
    </div>
    </div>

   <div class="row mb-3">
    <div class="col-sm-3" style = "margin-right: -15px;">
        <input type="text" class="form-control" id="mtitle" name="mtitle" placeholder="영화 제목" value="${myboard.mtitle}" >
    </div>


     <div class="col-sm-2" style = "margin-right: -15px;">
        <select class="form-control" id="myear" name="myear">
        <!-- 제작 연도 드롭다운 리스트-->
            <option value="" disabled ${empty myboard.myear ? 'selected' : ''}>제작 연도</option>
            <% for (int y = 2023; y >= 1900; y--) {
                pageContext.setAttribute("y", String.valueOf(y));
            %>
                <option value="${y}" ${myboard.myear eq y ? 'selected' : ''}>${y}</option>
            <% } %>
        </select>
</div>
<div class="col-sm-2" style="margin-right: -15px;">
<select class="form-control" id="mgenre" name="mgenre">
                <!-- 영화 장르 드롭다운 리스트 -->
                <option value="" disabled>영화 장르</option>
                <option value="액션" ${myboard.mgenre == '액션' ? 'selected' : ''}>액션</option>
                <option value="범죄" ${myboard.mgenre == '범죄' ? 'selected' : ''}>범죄</option>
                <option value="SF" ${myboard.mgenre == 'SF' ? 'selected' : ''}>SF</option>
                <option value="코미디" ${myboard.mgenre == '코미디' ? 'selected' : ''}>코미디</option>
                <option value="드라마" ${myboard.mgenre == '드라마' ? 'selected' : ''}>드라마</option>
                <option value="역사" ${myboard.mgenre == '역사' ? 'selected' : ''}>역사</option>
                <option value="모험" ${myboard.mgenre == '모험' ? 'selected' : ''}>모험</option>
                <option value="로맨스" ${myboard.mgenre == '로맨스' ? 'selected' : ''}>로맨스</option>
                <option value="스릴러" ${myboard.mgenre == '스릴러' ? 'selected' : ''}>스릴러</option>
                <option value="공포" ${myboard.mgenre == '공포' ? 'selected' : ''}>공포</option>
                <option value="전쟁" ${myboard.mgenre == '전쟁' ? 'selected' : ''}>전쟁</option>
                <option value="스포츠" ${myboard.mgenre == '스포츠' ? 'selected' : ''}>스포츠</option>
                <option value="판타지" ${myboard.mgenre == '판타지' ? 'selected' : ''}>판타지</option>
                <option value="음악" ${myboard.mgenre == '음악' ? 'selected' : ''}>음악</option>
                <option value="뮤지컬" ${myboard.mgenre == '뮤지컬' ? 'selected' : ''}>뮤지컬</option>
                <option value="멜로" ${myboard.mgenre == '멜로' ? 'selected' : ''}>멜로</option>
            </select>
</div>


           <div class="col-sm-2" style="margin-right: -15px;">
           <select class="form-control" id="mcountry" name="mcountry">
           <!-- 제작 국가 드롭다운 리스트 -->
        <option value="" disabled ${myboard.mcountry == null ? 'selected' : ''}>제작 국가</option>
        <option value="한국" ${myboard.mcountry == '한국' ? 'selected' : ''}>한국</option>
        <option value="미국" ${myboard.mcountry == '미국' ? 'selected' : ''}>미국</option>
        <option value="캐나다" ${myboard.mcountry == '캐나다' ? 'selected' : ''}>캐나다</option>
        <option value="중국" ${myboard.mcountry == '중국' ? 'selected' : ''}>중국</option>
        <option value="일본" ${myboard.mcountry == '일본' ? 'selected' : ''}>일본</option>
        <option value="영국" ${myboard.mcountry == '영국' ? 'selected' : ''}>영국</option>
        <option value="프랑스" ${myboard.mcountry == '프랑스' ? 'selected' : ''}>프랑스</option>
        <option value="인도" ${myboard.mcountry == '인도' ? 'selected' : ''}>인도</option>
        <option value="독일" ${myboard.mcountry == '독일' ? 'selected' : ''}>독일</option>
        <option value="멕시코" ${myboard.mcountry == '멕시코' ? 'selected' : ''}>멕시코</option>
        <option value="러시아" ${myboard.mcountry == '러시아' ? 'selected' : ''}>러시아</option>
        <option value="호주" ${myboard.mcountry == '호주' ? 'selected' : ''}>호주</option>
        <option value="이탈리아" ${myboard.mcountry == '이탈리아' ? 'selected' : ''}>이탈리아</option>
        <option value="스페인" ${myboard.mcountry == '스페인' ? 'selected' : ''}>스페인</option>
        <option value="브라질" ${myboard.mcountry == '브라질' ? 'selected' : ''}>브라질</option>
        <option value="대만" ${myboard.mcountry == '대만' ? 'selected' : ''}>대만</option>
        <option value="네덜란드" ${myboard.mcountry == '네덜란드' ? 'selected' : ''}>네덜란드</option>
        <option value="홍콩" ${myboard.mcountry == '홍콩' ? 'selected' : ''}>홍콩</option>
    </select>
</div>

            <!-- 별점 표시 -->
            <label for="score" class="col-sm-1 col-form-label no-star-effect" style = "font-size: 17px; margin-right : -35px; margin-left : 10px;">별점</label>
    <div class="col-sm-3 rating-stars star-container" style = "margin-left : -20px;">
                    <fieldset>
                        <input type="radio" name="score" value="5" id="rate1" ${myboard.score == 5 ? 'checked' : ''}>
                        <label for="rate1">★</label>
                        <input type="radio" name="score" value="4" id="rate2" ${myboard.score == 4 ? 'checked' : ''}>
                        <label for="rate2">★</label>
                        <input type="radio" name="score" value="3" id="rate3" ${myboard.score == 3 ? 'checked' : ''}>
                        <label for="rate3">★</label>
                        <input type="radio" name="score" value="2" id="rate4" ${myboard.score == 2 ? 'checked' : ''}>
                        <label for="rate4">★</label>
                        <input type="radio" name="score" value="1" id="rate5" ${myboard.score == 1 ? 'checked' : ''}>
                        <label for="rate5">★</label>
                    </fieldset>
                </div>
            </div>
<div class="row mb-3">
    <div class="col-sm-12">
        <textarea class="form-control" id="content" name="content" rows="10" placeholder="내용을 입력하세요.">${myboard.content}</textarea>
    </div>
</div>


     <div class="row mb-3">
    <label for="uploadFile" class="col-sm-2 col-form-label no-star-effect" style="font-size: 17px; margin-right: -90px; margin-top: -2px;">영화 포스터</label>
    <div class="col-sm-3">
        <input type="file" name="uploadFile" onchange="checkFileType(this)" class="form-control-file">
        <div id="posterPreviewContainer" style="display: none;">
            <img id="posterPreview" src="#" alt="포스터 이미지" style="max-width: 100%; display: block;">
        </div>
</div>

                <div class="col-sm-7 d-flex justify-content-end">
                    <input type="submit" class="btn btn-primary" value="수정" style = "width: 60px; background-color: #8A0808; border-color: #8A0808; margin-right : 5px;">
                    <input type="button" class="btn btn-secondary ml-2" value="취소" onclick="location.href='boardList.do'" style = "width: 60px; margin-right : -90px;">

                    <input type="hidden" name="seq" value="${myboard.seq}" style = "width: 60px; margin-right : -90px;">
                </div>
            </div>
        </form>
    </div>
    <!-- 글쓴이 숨기기 -->
                <label for="name" class="col-sm-2 col-form-label visually-hidden">글 쓴이</label>
                <div class="col-sm-10">
                    <input type="hidden" class="form-control" id="name" name="name" value="${myboard.name}" readonly>
                </div>
<!-- hidden -->
</div>
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
</body>
</html>
