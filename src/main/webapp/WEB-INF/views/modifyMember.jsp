<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원정보 수정</title>
    <link rel="stylesheet" href="resources/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }

        .container {
            margin-top: 50px;
        }

        .register-form {
            max-width: 400px;
            margin: auto;
            background-color: #fff;
            padding: 20px;
            border: 1px solid #dee2e6;
            border-radius: 10px;
        }

        .register-form input,
        .register-form select {
            margin-bottom: 15px;
            padding: 10px;
            font-size: 16px;
            color: #555;
            border-radius: 5px;
        }

        .register-form select {
            height: 46px;
        }

        .register-form-btns {
            display: flex;
            justify-content: space-between;
        }

        .register-form-btns input[type="submit"],
        .register-form-btns input[type="button"] {
            background-color: #8A0808;
            color: #fff;
            cursor: pointer;
            border: none;
            width: 49%;
            border-radius: 5px;
        }

        .register-form-btns input[type="button"] {
            background-color: #6c757d;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="register-form">
            <h2>회원정보 수정</h2>
            <br>
            <form action="modifyProcMember.do?seq=${mymember.seq}" method="post">
                <div class="mb-3">
                    <label for="id" class="form-label visually-hidden">아이디</label>
                    <input type="text" name="id" class="form-control" placeholder="아이디" value="${mymember.id}" readonly>
                </div>

                <div class="mb-3">
                    <label for="name" class="form-label visually-hidden">이름</label>
                    <input type="text" name="name" class="form-control" placeholder="이름" value="${mymember.name}">
                </div>

                <div class="mb-3">
                    <label for="pass" class="form-label visually-hidden">비밀번호</label>
                    <input type="password" name="pass" class="form-control" placeholder="비밀번호">
                </div>

                <div class="mb-3">
                    <label for="confirmPass" class="form-label visually-hidden">비밀번호 확인</label>
                    <input type="password" name="confirmPass" class="form-control" placeholder="비밀번호 확인">
                </div>

                <div class="mb-3">
                    <label for="email" class="form-label visually-hidden">이메일</label>
                    <div class="input-group">
                        <input type="text" name="address" class="form-control" placeholder="이메일" value="${mymember.email.split('@')[0]}" readonly>
                        <select name="domain" class="form-control">
                            <option value="@naver.com" ${mymember.email.endsWith('@naver.com') ? 'selected' : ''}>@naver.com</option>
                            <option value="@gmail.com" ${mymember.email.endsWith('@gmail.com') ? 'selected' : ''}>@gmail.com</option>
                            <option value="@daum.net" ${mymember.email.endsWith('@daum.net') ? 'selected' : ''}>@daum.net</option>
                            <option value="@nate.com" ${mymember.email.endsWith('@nate.com') ? 'selected' : ''}>@nate.com</option>
                            <option value="@kakao.com" ${mymember.email.endsWith('@kakao.com') ? 'selected' : ''}>@kakao.com</option>
                        </select>
                    </div>
                </div>

                <div class="mb-3 register-form-btns">
                    <input type="submit" value="수정" class="btn btn-primary">
                    <input type="button" value="취소" onclick="location.href='memberView.do'" class="btn btn-secondary">
                </div>

                <c:if test="${not empty error}">
                    <div class="mb-3" style="color: red;">
                        <c:out value="${error}" />
                    </div>
                </c:if>
            </form>
        </div>
    </div>
</body>
</html>
