<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="co.kr.dev.board.login.LoginBoardDAO" %>
<%@ page import="co.kr.dev.board.login.LoginBoardVO" %>
<%@ page import="co.kr.dev.board.logout.LogoutBoardDAO" %>
<%@ page import="co.kr.dev.board.logout.LogoutBoardVO" %>
<%
    // 페이징 설정
    int pageSize = 10;
    String pageNum = request.getParameter("pageNum");
    int currentPage = (pageNum == null) ? 1 : Integer.parseInt(pageNum);

    int start = (currentPage - 1) * pageSize + 1;
    int end = currentPage * pageSize;

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    // DAO 인스턴스 가져오기
    LoginBoardDAO loginBoardDAO = LoginBoardDAO.getInstance();
    LogoutBoardDAO logoutBoardDAO = LogoutBoardDAO.getInstance();

    // 데이터 가져오기
    List<LoginBoardVO> loginPostsQ = loginBoardDAO.getPostsByType("QUESTION", start, end);
    List<LoginBoardVO> loginPostsA = loginBoardDAO.getPostsByType("ANSWER", start, end);
    List<LogoutBoardVO> logoutPosts = logoutBoardDAO.getPostsByType("QUESTION", start, end);

    // 총 게시글 수 계산
    int loginQuestionCount = loginBoardDAO.getPostCountByType("QUESTION");
    int loginAnswerCount = loginBoardDAO.getPostCountByType("ANSWER");
    int logoutPostCount = logoutBoardDAO.getPostCountByType("QUESTION");
    int totalPosts = loginQuestionCount + loginAnswerCount + logoutPostCount;

    int number = totalPosts - (currentPage - 1) * pageSize;

    String userId = (String) session.getAttribute("userId");

    // 디버깅 메시지 출력
    System.out.println("[DEBUG] Login 질문 수: " + loginQuestionCount);
    System.out.println("[DEBUG] Login 답변 수: " + loginAnswerCount);
    System.out.println("[DEBUG] Logout 질문 수: " + logoutPostCount);
    System.out.println("[DEBUG] 총 게시글 수: " + totalPosts);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Q&A 게시판 목록</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/common/common.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/board/qna/qnaList.css">
</head>
<body>
    <!-- Header -->
    <header>
        <% if ("admin".equals(userId)) { %>
            <jsp:include page="/include/header/admin/adminHeader.jsp" />
        <% } else if (userId != null && !userId.isEmpty()) { %>
            <jsp:include page="/include/header/login/loginHeader.jsp" />
        <% } else { %>
            <jsp:include page="/include/header/logout/logoutHeader.jsp" />
        <% } %>
    </header>
    
    <!-- Main content -->
    <main>
        <jsp:include page="/include/slideShow/slideShow.jsp" />
        <section>
            <article class="qnaListArti">
                <h2 class="qnaBoardTitle">Q&A 게시판</h2>
                <div class="qnaBorderWriteLinkDiv">
                    <a href="<%=request.getContextPath()%>/board/qna/question/<%= (userId == null ? "logout" : "login") %>/write/<%= (userId == null ? "logoutQForm.jsp" : "loginQForm.jsp") %>" class="qnaBoardWriteLink">질문 작성</a>
                </div>
                <table class="qnaBoardTable">
                    <thead>
                        <tr>
                            <th class="postNum">번호</th>
                            <th class="postTitle">제목</th>
                            <th class="postWriter">작성자</th>
                            <th class="postDate">작성일</th>
                            <th class="postViews">조회</th>
                            <th class="postIp">IP</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (totalPosts == 0) { %>
                            <tr>
                                <td colspan="6" class="noPostMessage">게시판에 게시글이 없습니다.</td>
                            </tr>
                        <% } else { 
                            // Login 질문
                            for (LoginBoardVO post : loginPostsQ) { %>
                            <tr>
                                <td class="postNum"><%= number-- %></td>
                                <td class="postTitle">
                                    <a href="<%=request.getContextPath()%>/board/qna/question/login/loginQShow.jsp?num=<%= post.getNum() %>">
                                        <%= post.getTitle() %>
                                    </a>
                                </td>
                                <td class="postWriter"><%= post.getStudentId() %></td>
                                <td class="postDate"><%= sdf.format(post.getRegDate()) %></td>
                                <td class="postViews"><%= post.getReadCount() %></td>
                                <td class="postIp"><%= post.getIp() %></td>
                            </tr>
                        <% } 
                            // Login 답변
                            for (LoginBoardVO post : loginPostsA) { %>
                            <tr>
                                <td class="postNum"><%= number-- %></td>
                                <td class="postTitle">
                                    <span style="color: green;">답변: </span>
                                    <a href="<%=request.getContextPath()%>/board/qna/question/login/loginAShow.jsp?num=<%= post.getNum() %>">
                                        <%= post.getTitle() %>
                                    </a>
                                </td>
                                <td class="postWriter"><%= post.getStudentId() %></td>
                                <td class="postDate"><%= sdf.format(post.getRegDate()) %></td>
                                <td class="postViews"><%= post.getReadCount() %></td>
                                <td class="postIp"><%= post.getIp() %></td>
                            </tr>
                        <% } 
                            // Logout 질문
                            for (LogoutBoardVO post : logoutPosts) { %>
                            <tr>
                                <td class="postNum"><%= number-- %></td>
                                <td class="postTitle">
                                    <a href="<%=request.getContextPath()%>/board/qna/question/logout/logoutQShow.jsp?num=<%= post.getNum() %>">
                                        <%= post.getTitle() %>
                                    </a>
                                </td>
                                <td class="postWriter"><%= post.getWriter() %></td>
                                <td class="postDate"><%= sdf.format(post.getRegDate()) %></td>
                                <td class="postViews"><%= post.getReadCount() %></td>
                                <td class="postIp"><%= post.getIp() %></td>
                            </tr>
                        <% } } %>
                    </tbody>
                </table>
                <div class="qnaBoardPage">
                    <% if (totalPosts > 0) { 
                        int pageBlock = 3;
                        int pageCount = (int) Math.ceil((double) totalPosts / pageSize);
                        int startPage = (currentPage - 1) / pageBlock * pageBlock + 1;
                        int endPage = Math.min(startPage + pageBlock - 1, pageCount);

                        if (startPage > 1) { %>
                            <a href="qnaList.jsp?pageNum=<%= startPage - 1 %>">[이전]</a>
                        <% } 
                        for (int i = startPage; i <= endPage; i++) { 
                            if (i == currentPage) { %>
                                <strong>[<%= i %>]</strong>
                            <% } else { %>
                                <a href="qnaList.jsp?pageNum=<%= i %>">[<%= i %>]</a>
                            <% } 
                        } 
                        if (endPage < pageCount) { %>
                            <a href="qnaList.jsp?pageNum=<%= endPage + 1 %>">[다음]</a>
                        <% } 
                    } %>
                </div>
            </article>
        </section>
    </main>
    <footer>
        <jsp:include page="/include/footer/footer.jsp" />
    </footer>
</body>
</html>
