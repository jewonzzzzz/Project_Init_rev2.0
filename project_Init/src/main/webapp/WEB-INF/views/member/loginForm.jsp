<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html>
<head>
<style>
	*{
	    padding: 0;
	    margin: 0;
	    border: none;
	}
	body{
	    font-size: 14px;
	    font-family: 'Roboto', sans-serif;
	}
	
	.login-wrapper{
	    width: 400px;
	    height: 450px;
	    padding: 40px;
	    box-sizing: border-box;
	    position: absolute;
	    text-align: center;
	    margin-left: -200px;
	    margin-top: -200px;
	    left: 50%;
	    top: 40%;
	}
	
	.login-wrapper > h2{
	    font-size: 24px;
	    color: #0055FF;
	    margin-bottom: 20px;
	}
	
	#login-form > input{
	    width: 100%;
	    height: 48px;
	    padding: 0 10px;
	    box-sizing: border-box;
	    margin-bottom: 16px;
	    border-radius: 6px;
	    background-color: #F8F8F8;
	}
	
	#login-form > input::placeholder{
	    color: #D2D2D2;
	}
	
	#login-form > input[type="submit"]{
	    color: #fff;
	    font-size: 16px;
	    background-color: #0055FF;
	    margin-top: 20px;
	}
	
	#login-form > input[type="checkbox"]{
	    display: none;
	}
	
	#login-form > label{
	    color: #999999;
	    float: left;
	}
	
	#login-form input[type="checkbox"] + label{
	    cursor: pointer;
	    padding-left: 26px;
	    background-image: url("checkbox.png");
	    background-repeat: no-repeat;
	    background-size: contain;
	}
	
	#login-form input[type="checkbox"]:checked + label{
	    background-image: url("checkbox-active.png");
	    background-repeat: no-repeat;
	    background-size: contain;  
	}
	
	.divider {
	    margin: 20px 0;
	    text-align: center;
	    position: relative;
	}
	
	.divider::before,
	.divider::after {
	    content: "";
	    position: absolute;
	    top: 50%;
	    width: 45%;
	    height: 1px;
	    background-color: #ddd;
	}
	
	.divider::before {
	    left: 0;
	}
	
	.divider::after {
	    right: 0;
	}
	
	.kakao-login-btn {
	    width: 100%;
	    height: 48px;
	    border-radius: 6px;
	    background-color: #FEE500;
	    display: flex;
	    align-items: center;
	    justify-content: center;
	    text-decoration: none;
	    color: #000000;
	    font-weight: 500;
	    margin-top: 20px;
	    cursor: pointer;
	}
	
	.kakao-login-btn img {
	    margin-right: 8px;
	    width: 24px;
	    height: 24px;
	}
	
	.forgot-password {
	    display: block;
	    margin-top: 15px;
	    color: #666;
	    text-decoration: none;
	}
	
	.forgot-password:hover {
	    color: #0055FF;
	}
</style>

<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
</head>
<body>
	<div class="login-wrapper">
        <h2>Login</h2>
        <form method="post" id="login-form" onsubmit="return frm_check();">
            <input type="text" name="emp_id" id="logId" placeholder="사원번호">
            <input type="password" name="emp_pw" placeholder="비밀번호">
            <label for="remember-check">
                <input type="checkbox" class="save_id" name="checkId" id="saveId"> 사원번호 저장
            </label>
            <input type="submit" value="로그인">
            <a href="/member/forgotPassword" class="forgot-password">비밀번호를 잊으셨나요?</a>
        </form>

        <div class="divider">또는</div>
        
        <a id="kakao-login-btn" class="kakao-login-btn">
            <img src="/resources/assets/img/kakao_login.png" alt="카카오 로고">
            카카오로 시작하기
        </a>
    </div>
    
    <c:if test="${not empty loginError}">
	    <script type="text/javascript">
	        alert("${loginError}");
	    </script>
	</c:if>

<script type="text/javascript">
     $(function() {        
           fnInit();         
     });
     
     function frm_check(){
         saveid();
     }
 
    function fnInit(){
        var cookieid = getCookie("saveid");
        console.log(cookieid);
        if(cookieid !=""){
            $("input:checkbox[id='saveId']").prop("checked", true);
            $('#logId').val(cookieid);
        }       
    }    
 
    function setCookie(name, value, expiredays) {
        var todayDate = new Date();
        todayDate.setTime(todayDate.getTime() + 0);
        if(todayDate > expiredays){
            document.cookie = name + "=" + escape(value) + "; path=/; expires=" + expiredays + ";";
        }else if(todayDate < expiredays){
            todayDate.setDate(todayDate.getDate() + expiredays);
            document.cookie = name + "=" + escape(value) + "; path=/; expires=" + todayDate.toGMTString() + ";";
        }            
        console.log(document.cookie);
    }
 
    function getCookie(Name) {
        var search = Name + "=";
        console.log("search : " + search);
        
        if (document.cookie.length > 0) { // 쿠키가 설정되어 있다면 
            offset = document.cookie.indexOf(search);
            console.log("offset : " + offset);
            if (offset != -1) { // 쿠키가 존재하면 
                offset += search.length;
                // set index of beginning of value
                end = document.cookie.indexOf(";", offset);
                console.log("end : " + end);
                // 쿠키 값의 마지막 위치 인덱스 번호 설정 
                if (end == -1)
                    end = document.cookie.length;
                console.log("end위치  : " + end);              
                return unescape(document.cookie.substring(offset, end));
            }
        }
        return "";
    }
 
    function saveid() {
        var expdate = new Date();
        if ($("#saveId").is(":checked")){
            expdate.setTime(expdate.getTime() + 1000 * 3600 * 24 * 30);
            setCookie("saveid", $("#logId").val(), expdate);
            }else{
           expdate.setTime(expdate.getTime() - 1000 * 3600 * 24 * 30);
            setCookie("saveid", $("#logId").val(), expdate);           
        }
    }
    
 	// 카카오 로그인 초기화
    Kakao.init('b59cfb49b44bf23cb150690f9c2d0179'); // JavaScript 키 입력

    // 카카오 로그인 버튼 클릭 이벤트
    document.getElementById('kakao-login-btn').addEventListener('click', function() {
    Kakao.Auth.login({
        success: function(authObj) {
            console.log('Login Success:', authObj);
            // 사용자 정보 요청
            Kakao.API.request({
                url: '/v2/user/me',
                success: function(response) {
                    console.log('User Info:', response);
                    const data = {
                        emp_email: response.kakao_account.email
                    };
                    
                    // 서버에 카카오 로그인 정보 전송
                    $.ajax({
                        url: '/member/kakaoLogin',
                        type: 'POST',
                        data: JSON.stringify(data),
                        contentType: 'application/json',
                        success: function(serverResponse) {
                            if(serverResponse.success) {
                                location.href = '/main/home';
                            } else {
                                alert(serverResponse.message || '등록되지 않은 사용자입니다.');
                            }
                        },
                        error: function(xhr, status, error) {
                            console.error('Login Error:', error);
                            alert('로그인 처리 중 오류가 발생했습니다.');
                        }
                    });
                },
                fail: function(error) {
                    console.error('User Info Error:', error);
                    alert('사용자 정보를 가져오는데 실패했습니다.');
                }
            });
        },
        fail: function(err) {
            console.error('Auth Error:', err);
            alert('카카오 로그인에 실패했습니다.');
        },
        // 필요한 동의항목 추가
        scope: 'account_email'
	    });
	});
    
</script>
</body>
</html>
