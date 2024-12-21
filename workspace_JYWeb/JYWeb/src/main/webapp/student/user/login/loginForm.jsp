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
	<main>
		<!-- 회원이 로그인을 완료함. -->
<%
		if (id != null) {
%>
		<table border="1" width="300">
			<tr>
				<td colspan="3" align="center"><%= id%>님 환영합니다.</td>
			</tr>
			<tr>
				<td align="center" width="100"><a href="modifyForm.jsp">정보수정</a></td>
				<td align="center" width="100"><a href="deleteForm.jsp">회원탈퇴</a></td>
				<td align="center" width="100"><a href="logout.jsp">로그아웃</a></td>
			</tr>
		</table>
<%
		} else {
%>
		<form method="post" action="loginProc.jsp">
			<table width="300" border="1">
				<tr>
					<td colspan="2" align="center">회원 로그인</td>
				</tr>
				<tr>
					<td align="right" width="100">아이디 :</td>
					<td width="200">&nbsp;&nbsp; <input type="text" name="id"
						size="20" /></td>
				</tr>
				<tr>
					<td align="right" width="100">비밀번호 :</td>
					<td width="200">&nbsp;&nbsp; <input type="password"
						name="pass" size="20" /></td>
				</tr>
				<tr>
					<td colspan="2" align="center"><input type="submit"
						value="로그인" />&nbsp;&nbsp; <input type="button" value="회원가입"
						onClick="javascript:window.location='regForm.jsp'" /></td>
				</tr>
			</table>
		</form>
<%		
		}
%>
	</main>
</body>
</html>