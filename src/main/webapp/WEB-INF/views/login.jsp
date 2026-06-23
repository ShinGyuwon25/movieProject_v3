<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }

        .container {
            margin-top: 50px;
        }

        .login-form {
            max-width: 400px;
            margin: auto;
            background-color: #fff;
            padding: 20px;
            border: 1px solid #dee2e6;
            border-radius: 10px;
        }

        .login-form input {
            margin-bottom: 15px;
            padding: 10px;
            font-size: 16px;
            color: #555;
            border-radius: 5px;
        }

        .login-form hr {
            margin-top: 20px;
            margin-bottom: 20px;
        }

        .login-form span {
            color: red;
            display: block;
            margin-bottom: 10px;
            text-align: center;
        }

        .login-form input[type="submit"],
        .login-form input[type="button"] {
            background-color: #8A0808;
            color: #fff;
            cursor: pointer;
            border: none;
            width: 100%;
            border-radius: 5px;
            margin-top: 10px;
        }

        .signup-link {
            display: block;
            text-align: right;
            color: #007bff;
            cursor: pointer;
            text-decoration: underline;
            padding: 10px;
            font-size: 16px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="login-form">
            <h2>로그인</h2>
            <br>
            <form action="loginProc.do" method="post">
                <div class="mb-3">
                    <label for="id" class="form-label" style="display: none;">ID</label>
                    <input type="text" name="id" class="form-control" placeholder="아이디">
                </div>

                <div class="mb-3">
                    <label for="pass" class="form-label" style="display: none;">Password</label>
                    <input type="password" name="pass" class="form-control" placeholder="비밀번호">
                </div>

                <div class="mb-3">
                    <input type="submit" value="로그인">
                    <!-- 실패 메시지  -->
                    <span>${loginError}</span>
                    <!-- 회원가입 버튼 -->
<div class="signup-link" onclick="location.href='insertMember.do'" style="color: black; text-decoration: none; cursor: pointer;">회원가입</div>
                </div>

            </form>
        </div>
    </div>
</body>
</html>

