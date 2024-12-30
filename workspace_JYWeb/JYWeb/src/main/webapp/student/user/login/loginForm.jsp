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
    <title>로그인</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/common/common.css">
    <style>
/* 로그인 폼 전체 스타일 */
.logFormArti {
    width: 100%;
    max-width: 500px; /* 적당한 너비 */
    margin: 50px auto; /* 화면 중앙 배치 */
    border: 1px solid #ddd;
    border-radius: 10px;
    background-color: #f9f9f9;
    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
    padding: 30px;
    box-sizing: border-box;
}

.logTitle {
    text-align: center;
    font-size: 1.8em;
    color: #333;
    margin-bottom: 30px;
}

/* 테이블 스타일 */
.boardTable {
    width: 100%;
    margin: 0 auto;
    border-collapse: collapse;
}

.boardTable th, .boardTable td {
    padding: 15px;
    font-size: 1em;
    vertical-align: middle;
}

.boardTable th {
    background-color: #d2e5ee;
    color: #333;
    text-align: center;
    font-weight: bold;
    width: 30%;
}

.boardTable td {
    background-color: #f9f9f9;
    text-align: left;
}

/* 입력 필드 스타일 */
.inputField {
    width: 100%;
    padding: 10px;
    font-size: 1em;
    border: 1px solid #ccc;
    border-radius: 5px;
    box-sizing: border-box;
}

/* 버튼 그룹 스타일 */
.loginButtonGroup {
    text-align: center;
    margin-top: 20px;
}

.loginBtnForm, .registerBtnForm {
    padding: 10px 20px;
    font-size: 1em;
    background-color: #d2e5ee;
    color: #333;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease;
    text-decoration: none;
    display: inline-block;
}

.loginBtnForm:hover {
    background-color: #b0d4e3;
}

.registerBtnForm {
    background-color: #dadada;
    color: black;
}

.registerBtnForm:hover {
    background-color: #b1b1b1;
}
</style>
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
             <!-- 로그인 폼 -->
    <article class="logFormArti">
        <h2 class="logTitle">로그인</h2>
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


        </section>
    </main>
    
    <footer>
        <jsp:include page="/include/footer/footer.jsp" />
    </footer>
</body>
</html>
 