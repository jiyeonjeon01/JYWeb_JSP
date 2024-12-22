<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="co.kr.dev.board.login.LoginBoardDAO" %>
<%@ page import="co.kr.dev.board.login.LoginBoardVO" %>
<%
    // 세션에서 사용자 정보 가져오기
    String userId = (String) session.getAttribute("userId");
    String userRole = (String) session.getAttribute("role");

    // 로그인 확인
    if (userId == null || userId.isEmpty()) {
        response.sendRedirect(request.getContextPath() + "/student/user/login/loginForm.jsp");
        return;
    }

    // DAO 인스턴스 생성
    LoginBoardDAO loginBoardDAO = LoginBoardDAO.getInstance();

    // 사용자 작성 글 목록 가져오기
    List<LoginBoardVO> loginBoardPosts = loginBoardDAO.getPostsByUserId(userId);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>내가 작성한 글</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/board/myPosts.css">
    
    <link rel="stylesheet" href="<%=request.getContextPath()%>/common/common.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/custom/recentPosts.css">
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
        <article>
            <h2>내가 작성한 글</h2>
            <% if (loginBoardPosts.isEmpty()) { %>
                <p>작성한 글이 없습니다.</p>
            <% } else { %>
                <div class="my-posts-list">
                    <!-- <h3>로그인 게시판 글</h3> -->
                    <ul>
                        <% for (LoginBoardVO post : loginBoardPosts) { %>
                            <li>
                                <a href="<%=request.getContextPath()%>/board/normal/normalShow.jsp?num=<%= post.getNum() %>">
                                    <strong>[<%= post.getTitle() %>]</strong> 작성일: <%= post.getRegDate() %>
                                </a>
                            </li>
                        <% } %>
                    </ul>
                </div>
            <% } %>
</article>
             </section>
    </main>
    
    <footer>
        <jsp:include page="/include/footer/footer.jsp" />
    </footer>
</body>
</html>