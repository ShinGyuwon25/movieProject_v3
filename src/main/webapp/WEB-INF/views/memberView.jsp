<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원정보</title>
    <link rel="stylesheet" href="resources/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }

        .container {
            margin-top: 50px;
        }

        .info-form {
            max-width: 400px;
            margin: auto;
            background-color: #fff;
            padding: 20px;
            border: 1px solid #dee2e6;
            border-radius: 10px;
        }

        .info-form input,
        .info-form td {
            margin-bottom: 15px;
            border: none;
        }

        .info-form table {
            border-collapse: collapse;
            width: 100%;
        }

        .info-form th,
        .info-form td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #dee2e6;
            border-radius: 10px;
        }

        .info-form-btns {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }

        .info-form-btns input[type="submit"],
        .info-form-btns input[type="button"] {
            color: #fff;
            cursor: pointer;
            border: none;
            width: 49%; /* 버튼 너비 */
            border-radius: 5px;
            padding: 10px;
            font-size: 16px;
        }

        .info-form-btns input[type="submit"] {
            background-color: #8A0808; /* 수정 버튼 */
        }

        .info-form-btns input[type="button"] {
            background-color: #6c757d; /* 취소 버튼 */
        }

    </style>
</head>
<body>
    <div class="container">
        <div class="info-form">
            <h2>회원정보</h2>
            <br>
            <table>
                <tr style="display: none;">
                    <td>번호</td>
                    <td>${mymember.seq}</td>
                </tr>

                <tr>
                    <td>아이디</td>
                    <td>${mymember.id}</td>
                </tr>

                <tr>
                    <td>이름</td>
                    <td>${mymember.name}</td>
                </tr>

                <tr style="display: none;">
                    <td>비밀번호</td>
                    <td>${mymember.pass}</td>
                </tr>

                <tr>
                    <td>이메일</td>
                    <td>${mymember.email}</td>
                </tr>
            </table>

            <div class="info-form-btns">
                <input type="submit" value="수정" onclick="location.href='modifyMember.do?seq=${mymember.seq}'" class="btn btn-primary">
                <input type="button" value="취소" onclick="location.href='boardList.do'" class="btn btn-secondary">
            </div>
        </div>
    </div>
</body>
</html>
