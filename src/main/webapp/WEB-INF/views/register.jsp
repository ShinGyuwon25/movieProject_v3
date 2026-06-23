<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
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
        <h2>회원가입</h2>
        <br>
            <h2 style="display: none;">아이디</h2>
            <form action="insertProcMember.do" method="post">
                <div class="mb-3">
                    <label for="id" class="form-label visually-hidden">아이디</label>
                    <input type="text" name="id" class="form-control" placeholder="아이디">
                </div>

                <div class="mb-3">
                    <label for="name" class="form-label visually-hidden">이름</label>
                    <input type="text" name="name" class="form-control" placeholder="이름">
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
                        <input type="text" name="address" class="form-control" placeholder="이메일">
                        <select name="domain" class="form-control">
                            <option value="@naver.com">@naver.com</option>
                            <option value="@gmail.com">@gmail.com</option>
                            <option value="@daum.net">@daum.net</option>
                            <option value="@nate.com">@nate.com</option>
                            <option value="@kakao.com">@kakao.com</option>
                        </select>
                    </div>
                </div>

                <div class="mb-3 register-form-btns">
                    <input type="submit" value="확인" class="btn btn-primary">
                    <input type="button" value="취소" onclick="location.href='login.do'" class="btn btn-secondary">
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
