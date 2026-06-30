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
                    <input type="text" id="id" name="id" class="form-control"
                           placeholder="아이디" value="${savedId}">
                    <div id="idError" style="color:#dc3545; font-size:12px; margin-top:4px; display:none;"></div>
                    <c:if test="${errorField == 'id'}">
                        <div style="color:#dc3545; font-size:12px; margin-top:4px;">${errorMsg}</div>
                    </c:if>
                </div>

                <div class="mb-3">
                    <label for="name" class="form-label visually-hidden">이름</label>
                    <input type="text" id="name" name="name" class="form-control"
                           placeholder="이름" value="${savedName}">
                    <div id="nameError" style="color:#dc3545; font-size:12px; margin-top:4px; display:none;"></div>
                    <c:if test="${errorField == 'name'}">
                        <div style="color:#dc3545; font-size:12px; margin-top:4px;">${errorMsg}</div>
                    </c:if>
                </div>

                <div class="mb-3">
                    <label for="pass" class="form-label visually-hidden">비밀번호</label>
                    <div style="position: relative;">
                        <input type="password" id="pass" name="pass"
                               class="form-control ${errorField == 'pass' ? 'is-invalid' : ''}"
                               placeholder="비밀번호" style="padding-right: 50px;"
                               onInput="checkKorean(this)">
                        <span onclick="togglePassword('pass', this)"
                              style="position:absolute; right:10px; top:50%; transform:translateY(-50%); cursor:pointer; color:#bbb; font-size:12px;">보기</span>
                    </div>
                    <div id="passError" style="color:#dc3545; font-size:12px; margin-top:4px; display:none;"></div>
                    <c:if test="${errorField == 'pass'}">
                        <div style="color:#dc3545; font-size:12px; margin-top:4px;">${errorMsg}</div>
                    </c:if>
                </div>


                <div class="mb-3">
                    <label for="confirmPass" class="form-label visually-hidden">비밀번호 확인</label>
                    <input type="password" id="confirmPass" name="confirmPass" class="form-control" placeholder="비밀번호 확인">
                </div>

                <div class="mb-3">
                    <label class="form-label visually-hidden">이메일</label>
                    <div class="input-group">
                        <input type="text" name="address" class="form-control"
                               placeholder="이메일" value="${savedAddress}">
                        <select id="domainSelect" name="domain" class="form-control"
                                onchange="toggleDomain(this)">
                            <option value="@naver.com">@naver.com</option>
                            <option value="@gmail.com">@gmail.com</option>
                            <option value="@daum.net">@daum.net</option>
                            <option value="@nate.com">@nate.com</option>
                            <option value="@kakao.com">@kakao.com</option>
                            <option value="@hanmail.net">@hanmail.net</option>
                            <option value="@icloud.com">@icloud.com</option>
                            <option value="@outlook.com">@outlook.com</option>
                            <option value="direct">직접입력</option>
                        </select>
                        <input type="text" id="directDomain" name="" class="form-control"
                               placeholder="@부터 입력" style="display:none;">
                    </div>
                </div>

                <div class="mb-3 register-form-btns">
                    <input type="submit" value="확인" class="btn btn-primary">
                    <input type="button" value="취소" onclick="location.href='login.do'" class="btn btn-secondary">
                </div>
            </form>
        </div>
    </div>
    <script>

            function togglePassword(inputId, icon) {
                var input = document.getElementById(inputId);
                var confirmInput = document.getElementById('confirmPass');
                if (input.type === 'password') {
                    input.type = 'text';
                    confirmInput.type = 'text';
                    icon.textContent = '숨기기';
                } else {
                    input.type = 'password';
                    confirmInput.type = 'password';
                    icon.textContent = '보기';
                }
            }

            function checkKorean(input) {
                input.value = input.value.replace(/[ㄱ-ㅎㅏ-ㅣ가-힣]/g, '');
            }

            function toggleDomain(select) {
                var directInput = document.getElementById('directDomain');
                var domainSelect = document.getElementById('domainSelect');
                if (select.value === 'direct') {
                    directInput.style.display = 'block';
                    directInput.name = 'domain';
                    domainSelect.style.display = 'none';
                    domainSelect.name = '';
                } else {
                    directInput.style.display = 'none';
                    directInput.name = '';
                    domainSelect.style.display = 'block';
                    domainSelect.name = 'domain';
                }
            }

            // 아이디 유효성 검사
            document.getElementById('id').addEventListener('blur', function() {
                var val = this.value;
                var msg = '';
                if (val.length < 5) msg = '아이디는 5자 이상이어야 합니다.';
                else if (!/[a-zA-Z]/.test(val)) msg = '아이디는 영어를 포함해야 합니다.';
                showFieldError('id', msg);
            });

            // 이름 유효성 검사
            document.getElementById('name').addEventListener('blur', function() {
                var val = this.value;
                var msg = val.length < 2 ? '이름은 2자 이상이어야 합니다.' : '';
                showFieldError('name', msg);
            });

            // 비밀번호 유효성 검사
            document.getElementById('pass').addEventListener('blur', function() {
                var val = this.value;
                var msg = '';
                if (val.length < 6 || !/[a-zA-Z]/.test(val) || !/\d/.test(val))
                    msg = '비밀번호는 6자 이상이며, 영어와 숫자를 포함해야 합니다.';
                showFieldError('pass', msg);
            });

            // 에러 표시 함수
            function showFieldError(fieldId, msg) {
                var input = document.getElementById(fieldId);
                var errorDiv = document.getElementById(fieldId + 'Error');
                if (msg) {
                    input.classList.add('is-invalid');
                    errorDiv.textContent = msg;
                    errorDiv.style.display = 'block';
                } else {
                    input.classList.remove('is-invalid');
                    errorDiv.style.display = 'none';
                }
            }
        </script>
</body>
</html>
