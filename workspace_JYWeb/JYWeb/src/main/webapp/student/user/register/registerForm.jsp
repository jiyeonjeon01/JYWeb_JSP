<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/student/user/register/registerForm.css">
<script language="javascript"
	src="<%=request.getContextPath()%>/student/user/register/registerForm.js"></script>
<script>
    const contextPath = '<%= request.getContextPath() %>';
</script>

<style>

</style>
</head>
<body>
	<article class="regFormArticle">
		<h2 class="regTitle">회원가입</h2>
		<form
			action="<%=request.getContextPath()%>/student/user/register/registerProc.jsp"
			method="post" name="regForm" enctype="multipart/form-data">
			<table class="boardTable">
				<tr>
					<th>아이디</th>
					<td><input type="text" name="id" required
						placeholder="영문자나 숫자, 3~15자" class="inputField">
						<button type="button" onclick="idCheck()" class="btn">중복확인</button>
					</td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="password" name="pass" required
						placeholder="영문자와 숫자, 6~15" class="inputField"></td>
				</tr>
				<tr>
					<th>비밀번호 확인</th>
					<td><input type="password" name="repass" required
						placeholder="비밀번호 확인" class="inputField"></td>
				</tr>
				<tr>
					<th>이름</th>
					<td><input type="text" name="name" required
						placeholder="이름 입력" class="inputField"></td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td><select name="phone1" class="selectField">
							<option value="02">02</option>
							<option value="010">010</option>
					</select> - <input type="text" name="phone2" size="5" class="inputField">
						- <input type="text" name="phone3" size="5" class="inputField">
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><input type="email" name="email" required
						placeholder="이메일 입력" class="inputField"></td>
				</tr>
				<tr>
					<th>우편번호</th>
					<td><input type="text" name="zipcode" placeholder="우편번호 입력"
						class="inputField">
						<button type="button" onclick="zipCheck()" class="btn">찾기</button>
					</td>
				</tr>
				<tr>
					<th>주소1</th>
					<td><input type="text" name="address1" size="50"
						placeholder="기본 주소" class="inputField"></td>
				</tr>
				<tr>
					<th>주소2</th>
					<td><input type="text" name="address2" size="50"
						placeholder="상세 주소" class="inputField"></td>
				</tr>
				<tr>
					<th>프로필 사진</th>
					<td><input type="file" name="profileFile" class="inputField"
						accept="image/*"></td>
				</tr>
			</table>
			<div class="regButtonGroup">
				<button type="button" onclick="inputCheck()" class="registerBtn">회원가입</button>
				<button type="reset" class="resetBtn">다시입력</button>
			</div>
		</form>
	</article>
</body>
</html>
 --%>


 
 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="co.kr.dev.board.login.LoginBoardDAO, java.util.List, co.kr.dev.board.login.LoginBoardVO" %>
<%
    // DAO 인스턴스 생성
    LoginBoardDAO loginBoardDAO = LoginBoardDAO.getInstance();

    // 최근 게시물 10개 불러오기
    List<LoginBoardVO> recentPosts = loginBoardDAO.selectRecentPosts(10); 
%>
<%
    String userId = (String) session.getAttribute("userId");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Test Page</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/common/common.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/custom/recentPosts.css">
    <link rel="stylesheet"
	href="<%=request.getContextPath()%>/student/user/register/registerForm.css">
<script language="javascript"
	src="<%=request.getContextPath()%>/student/user/register/registerForm.js"></script>
<script>
    const contextPath = '<%= request.getContextPath() %>';
</script>
</head>
<body>
    <!-- 헤더 -->
    <header>
        <% 
            if ("admin".equals(userId)) { 
        %>
            <jsp:include page="/include/header/admin/adminHeader.jsp" />
        <% 
            } else if (userId != null && !userId.isEmpty()) { 
        %>
            <jsp:include page="/include/header/login/loginHeader.jsp" />
        <% 
            } else { 
        %>
            <jsp:include page="/include/header/logout/logoutHeader.jsp" />
        <% 
            } 
        %>

    </header>
    
    <!-- 메인 -->
    <main>
        <jsp:include page="/include/slideShow/slideShow.jsp" />
        
        <section>
      <article class="regFormArticle">
		<h2 class="regTitle">회원가입</h2>
		<form
			action="<%=request.getContextPath()%>/student/user/register/registerProc.jsp"
			method="post" name="regForm" enctype="multipart/form-data">
			<table class="boardTable">
				<tr>
					<th>아이디</th>
					<td><input type="text" name="id" required
						placeholder="영문자나 숫자, 3~15자" class="inputField">
						<button type="button" onclick="idCheck()" class="btn">중복확인</button>
					</td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="password" name="pass" required
						placeholder="영문자와 숫자, 6~15" class="inputField"></td>
				</tr>
				<tr>
					<th>비밀번호 확인</th>
					<td><input type="password" name="repass" required
						placeholder="비밀번호 확인" class="inputField"></td>
				</tr>
				<tr>
					<th>이름</th>
					<td><input type="text" name="name" required
						placeholder="이름 입력" class="inputField"></td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td><select name="phone1" class="selectField">
							<option value="02">02</option>
							<option value="010">010</option>
					</select> - <input type="text" name="phone2" size="5" class="inputField">
						- <input type="text" name="phone3" size="5" class="inputField">
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><input type="email" name="email" required
						placeholder="이메일 입력" class="inputField"></td>
				</tr>
				<tr>
					<th>우편번호</th>
					<td><input type="text" name="zipcode" placeholder="우편번호 입력"
						class="inputField">
						<button type="button" onclick="zipCheck()" class="btn">찾기</button>
					</td>
				</tr>
				<tr>
					<th>주소1</th>
					<td><input type="text" name="address1" size="50"
						placeholder="기본 주소" class="inputField"></td>
				</tr>
				<tr>
					<th>주소2</th>
					<td><input type="text" name="address2" size="50"
						placeholder="상세 주소" class="inputField"></td>
				</tr>
				<tr>
					<th>프로필 사진</th>
					<td><input type="file" name="profileFile" class="inputField"
						accept="image/*"></td>
				</tr>
			</table>
			<div class="regButtonGroup">
				<button type="button" onclick="inputCheck()" class="registerBtn">회원가입</button>
				<button type="reset" class="resetBtn">다시입력</button>
			</div>
		</form>
	</article>

        </section>
    </main>
    
    <footer>
        <jsp:include page="/include/footer/footer.jsp" />
    </footer>
</body>
</html>
 
