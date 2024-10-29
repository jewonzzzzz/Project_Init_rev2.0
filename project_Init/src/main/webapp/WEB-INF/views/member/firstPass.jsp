<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/bootstrap.min.css" />
<style>
.password-reset-wrapper {
    width: 400px;
    padding: 40px;
    box-sizing: border-box;
    position: absolute;
    text-align: center;
    margin-left: -200px;
    margin-top: -200px;
    left: 50%;
    top: 40%;
}

.password-reset-wrapper > h2 {
    font-size: 24px;
    color: #0055FF;
    margin-bottom: 20px;
}

.form-control {
    margin-bottom: 15px;
}

.btn-primary {
    background-color: #0055FF;
    border-color: #0055FF;
    width: 100%;
    margin-top: 20px;
}
</style>
</head>
<body>
    <div class="password-reset-wrapper">
        <h2>비밀번호 변경</h2>
        <form id="passwordResetForm">
            <input type="password" class="form-control" id="newPassword" 
                   placeholder="새 비밀번호" required>
            <input type="password" class="form-control" id="confirmPassword" 
                   placeholder="비밀번호 확인" required>
            <div class="text-muted small mb-3">
                *영문, 숫자, 특수문자 조합 8자리 이상 입력하세요.
            </div>
            <button type="submit" class="btn btn-primary">변경하기</button>
        </form>
    </div>

    <script src="${pageContext.request.contextPath}/resources/assets/js/core/jquery-3.7.1.min.js"></script>
    <script type="text/javascript">
    $(document).ready(function() {
        // 최초 로그인시 비밀번호 변경 알림
        <c:if test="${needPasswordChange}">
            alert("비밀번호가 생년월일로 설정되어 있습니다. 보안을 위해 비밀번호를 변경해주세요.");
        </c:if>
        
        $('#passwordResetForm').submit(function(e) {
            e.preventDefault();
            
            var newPassword = $('#newPassword').val();
            var confirmPassword = $('#confirmPassword').val();
            
            // 비밀번호 유효성 검사
            var passwordRegex = /^(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[!@#$%^&+=])(?=\S+$).{8,}$/;
            if (!passwordRegex.test(newPassword)) {
                alert("비밀번호는 숫자, 영문, 특수문자[!, @, #, $, %, ^, &]를 포함하여 8자리 이상이어야 합니다.");
                return;
            }

            if (newPassword !== confirmPassword) {
                alert("새 비밀번호와 확인 비밀번호가 일치하지 않습니다.");
                return;
            }
            
            $.ajax({
                url: '${pageContext.request.contextPath}/member/resetPassword',
                type: 'POST',
                data: {
                    emp_id: '${emp_id}',
                    newPassword: newPassword
                },
                success: function(response) {
                    if (response.message) {
                        alert(response.message);
                        // 비밀번호 변경 성공 후 update 페이지로 이동
                        window.location.href = '${pageContext.request.contextPath}/member/update';
                    }
                },
                error: function() {
                    alert('비밀번호 변경 중 오류가 발생했습니다.');
                }
            });
        });
    });
    </script>
</body>
</html>