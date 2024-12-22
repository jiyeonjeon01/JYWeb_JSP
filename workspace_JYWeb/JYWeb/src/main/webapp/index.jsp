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
		        <div class="recentPostsWrapper">
		            <ul class="recentPosts">
		                <% 
		                    if (recentPosts != null && !recentPosts.isEmpty()) {
		                        for (LoginBoardVO post : recentPosts) { 
		                %>
		                    <li class="recentPostItem">
		                        <a href="<%=request.getContextPath()%>/board/normal/normalShow.jsp?num=<%= post.getNum() %>">
		                            <span class="postTitle"><%=post.getTitle()%></span>
		                            <span class="postWriter"><%=post.getStudentId()%></span>
		                            <span class="postDate"><%=post.getRegDate()%> </span>
		                            <span class="postViews"><%=post.getReadCount()%></span>
		                            
		                        </a>
		                    </li>
		                <% 
		                        }
		                    } else { 
		                %>
		                    <li class="noPostMessage">게시물이 없습니다.</li>
		                <% 
		                    } 
		                %>
		            </ul>
		        </div>
		    </div>
		</article>


        </section>
    </main>
    
    <footer>
        <jsp:include page="/include/footer/footer.jsp" />
    </footer>
</body>
</html>
