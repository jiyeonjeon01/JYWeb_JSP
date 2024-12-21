<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://kit.fontawesome.com/abb02b8c73.js"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/include/aside/logout/logoutAside.css"></link>
</head>
<body>

	<aside>
		<div class="asideLogout">
			<div class="aslideLogoutBox">
				<div class="asideLogin">
					<p>
						로그아웃된<br> 상태입니다
					</p>
					<br> <a
						href="<%=request.getContextPath()%>/student/login/loginForm/loginForm.jsp">
						<button class="asideLoginBtn">로그인</button>
					</a>
				</div>

				<div class="asideRegister"></div>
				<p>
					혹은<br> 회원가입<br> 하시겠습니까?
				</p>
				<br> <a
					href="<%=request.getContextPath()%>/student/register/registerForm/registerForm.jsp">
					<button class="asideRegisterBtn">회원가입</button>
				</a>

			</div>
		</div>
	</aside>

</body>
</html>