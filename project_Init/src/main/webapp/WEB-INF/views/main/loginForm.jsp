<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title> LOGIN  | init </title>
<link rel="icon" href="" type="image/png">
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/login.css">
</head>

<body>

	<div id="container">
	
		<!-- intro_area -->
		<div class="intro_area">
		
				<div class="intro_area text">
					<h2>MEMBER</h2>
					<p>LOGIN</p>
				</div>
				
				<div class="intro_area img">
				</div>	
				
		</div>	
		<!-- intro_area -->
		<!-- box_total -->
		<div class = "box_total">
			<!-- box_left -->
			<div class= "box_left">
			</div>
			<!-- box_left -->
					
					<!-- bodytext_area -->
					<div class="bodytext_area box_center">
							<form action="" method="post" class="info" id="loginForm">
									<ul class="form">
										<li class="clear">
											<label class="tit must">아이디</label>
											<div class="blank"><input type="text" name="emp_id" placeholder="아이디를 입력해주세요."/></div>
										</li>
										<li class="clear">
											<label class="tit must">비밀번호</label>
											<div class="blank"><input type="password" name="emp_pw" placeholder="비밀번호를 입력해주세요."/></div>
										</li>
									</ul>
									<p class="btn_line" >
										<a><input type= "submit" value="로그인" class="btn_basic"></a> 
										<a href="./MemberJoin.me"><input type= "button" value="회원가입" class="btn_basic"></a>
										<a href="./Main.me"><input type= "button" value="메인으로" class="btn_basic"></a>
									</p>	
							</form>
					</div>
					<!-- //bodytext_area -->
					
			<!-- box_right -->
			<div class= "box_right">
			</div>
			<!-- box_light -->
		</div>
		<!-- box_total -->
	</div>
	<!-- //container -->
		

	<%@ include file="/resources/assets/inc/footer.jsp" %>
</body>
</html>