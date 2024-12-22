<%@ page contentType="text/html; charset=UTF-8"%>
<!-- 1. 사용자정보를 가져온다. 세션정보를 가져온다. -->
<%
   String id = (String)session.getAttribute("id");
%>
<html>
<head>
<title>Log in</title>
<link href="style.css" type="text/css" rel="stylesheet" />
</head>
<body>
	 <!-- 로그인 폼 -->
<article class="logFormArti">
    <h2 style="text-align: center; margin-bottom: 20px;">로그인</h2>
    <form action="<%=request.getContextPath()%>/student/user/login/loginProc.jsp" method="post" class="regForm">
        <table class="boardTable">
            <tr>
                <th>아이디</th>
                <td><input type="text" name="id" placeholder="아이디 입력" required class="inputField"></td>
            </tr>
            <tr>
                <th>비밀번호</th>
                <td><input type="password" name="pass" placeholder="비밀번호 입력" required class="inputField"></td>
            </tr>
        </table>
        <div class="loginButtonGroup">
            <button type="submit" class="loginBtnForm">로그인</button>
            <a href="<%=request.getContextPath()%>/student/user/register/registerForm.jsp" class="registerBtnForm">회원가입</a>
        </div>
    </form>
</article>


</body>
</html>