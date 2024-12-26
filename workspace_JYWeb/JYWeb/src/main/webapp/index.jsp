<%@page import="java.text.SimpleDateFormat"%>
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
            <aside>
                <%
                    if ("admin".equals(userId)) { 
                %>
                    <jsp:include page="/include/aside/admin/adminAside.jsp" /> 
                <% 
                    } else if (userId != null && !userId.isEmpty()) { 
                %>
                    <jsp:include page="/include/aside/login/loginAside.jsp" /> 
                <%    
                    } else { 
                %>
                    <jsp:include page="/include/aside/logout/logoutAside.jsp" />
                <% 
                    }
                %>
            </aside>
            
<article>
    <div class="artiDiv">
        <h2 class="recentTitle">📰 최근 게시물</h2>
        <table class="recentPostsTable">
            <thead>
                <tr>
                    <th class="postType">분류</th>
                    <th class="postTitle">제목</th>
                    <th class="postWriter">작성자</th>
                    <th class="postDate">작성일</th>
                    <th class="postViews">조회수</th>
                </tr>

            </thead>
            <tbody>
                <% 
                    if (recentPosts != null && !recentPosts.isEmpty()) {
                        for (LoginBoardVO post : recentPosts) { 
                %>
                
                <%
                    String displayType = post.getType();
                    if ("NORMAL".equals(post.getType())) {
                        displayType = "자유"; 
                    } else if ("NOTI".equals(post.getType())) {
                        displayType = "공지"; 
                    }
                %>
             
                <tr class="recentPostRow">
                    <td class="postType">[<%= displayType %>]</td>
                    <td class="postTitle">
    <a href="<%=request.getContextPath()%>/board/<%=post.getType().toLowerCase()%>/<%=post.getType().toLowerCase()%>Show.jsp?num=<%= post.getNum() %>">
        <%= post.getTitle() %>
    </a>
</td>

                    <td class="postWriter"><%= post.getStudentId() %></td>
                    <%
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
                    <td class="postDate"><%= dateFormat.format(post.getRegDate()) %></td>
                    <td class="postViews"><%= post.getReadCount() %></td>
                </tr>
                <% }
                    } else { 
                %>
                <tr>
                    <td colspan="5" class="noPostMessage">게시물이 없습니다.</td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</article>



        </section>
    </main>
    
    <footer>
        <jsp:include page="/include/footer/footer.jsp" />
    </footer>
</body>
</html>
