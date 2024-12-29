<%-- <%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="co.kr.dev.board.login.LoginBoardDAO" %>
<%@ page import="co.kr.dev.board.login.LoginBoardVO" %>
<%
    // 페이징 설정
    int pageSize = 5; // 한 페이지에 보여줄 글 개수
    String pageNum = request.getParameter("pageNum");
    if (pageNum == null) pageNum = "1"; // 페이지 번호가 없으면 기본값 1로 설정
    int currentPage = Integer.parseInt(pageNum);
    int start = (currentPage - 1) * pageSize + 1; // 시작 번호 계산
    int end = currentPage * pageSize; // 끝 번호 계산

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    int count = 0, number = 0;
    ArrayList<LoginBoardVO> boardList = null;
    LoginBoardDAO dao = LoginBoardDAO.getInstance();

 // NORMAL 타입 게시글의 전체 개수 가져오기
    count = dao.getPostCountByType("NORMAL");

    if (count > 0) {
        // NORMAL 타입 게시글 페이징 조회
        boardList = dao.getPostsByType("NORMAL", start, end);
    }

    number = count - (currentPage - 1) * pageSize; // 글 번호 계산
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>자유게시판 목록</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/board/normal/normalList.css"> 
</head>
<body>
    <main>
    <article>
        <h2 style="text-align: center;">자유게시판 목록</h2>
        <div style="text-align: right; margin: 10px;">
            <a href="<%=request.getContextPath()%>/board/normal/write/normalForm.jsp">글쓰기</a>
        </div>
        <%
            if (count == 0) { // 게시글이 없을 경우
        %>
        <table width="700" border="1" cellpadding="5" cellspacing="0" align="center">
            <tr>
                <td style="text-align: center;">게시판에 저장된 글이 없습니다.</td>
            </tr>
        </table>
        <% } else { // 게시글이 있을 경우 %>
        <table width="700" border="1" cellpadding="5" cellspacing="0" align="center">
            <tr bgcolor="#f1f1f1">
                <th width="50">번호</th>
                <th width="250">제목</th>
                <th width="100">작성자</th>
                <th width="150">작성일</th>
                <th width="50">조회</th>
                <th width="100">IP</th>
            </tr>
            <%
                for (LoginBoardVO post : boardList) { // 게시글 리스트 출력
            %>
            <tr>
                <td align="center"><%= number-- %></td>
                <td>
                    <a href="<%=request.getContextPath()%>/board/normal/normalShow.jsp?num=<%= post.getNum() %>&pageNum=<%= currentPage %>">
                        <%
                            if (post.getDepth() > 0) { // 답글일 경우 들여쓰기
                                int indentWidth = 5 * post.getDepth();
                        %>
                        <img src="<%=request.getContextPath()%>/board/images/level.gif" width="<%= indentWidth %>" height="16">
                        <img src="<%=request.getContextPath()%>/board/images/re.gif">
                        <% } %>
                        <%= post.getTitle() %>
                    </a>
                    <% if (post.getReadCount() >= 20) { // 조회수가 20 이상이면 hot 표시 %>
                    <img src="<%=request.getContextPath()%>/board/images/hot.gif" height="16">
                    <% } %>
                </td>
                <td align="center"><%= post.getStudentId() %></td>
                <td align="center"><%= sdf.format(post.getRegDate()) %></td>
                <td align="center"><%= post.getReadCount() %></td>
                <td align="center"><%= post.getIp() %></td>
            </tr>
            <% } %>
        </table>
        <% } %>
  
    <br>
    <div style="text-align: center;">
        <%
            if (count > 0) { // 페이징 처리
                int pageBlock = 3; // 보여줄 페이지 수
                int pageCount = (int) Math.ceil((double) count / pageSize); // 전체 페이지 수
                int startPage = (currentPage - 1) / pageBlock * pageBlock + 1; // 시작 페이지 번호
                int endPage = Math.min(startPage + pageBlock - 1, pageCount); // 끝 페이지 번호

                if (startPage > 1) { // 이전 페이지로 이동
        %>
        <a href="normalList.jsp?pageNum=<%= startPage - pageBlock %>">[이전]</a>
        <% }
                for (int i = startPage; i <= endPage; i++) { // 페이지 번호 출력
                    if (i == currentPage) {
        %>
        <strong>[<%= i %>]</strong>
        <% } else { %>
        <a href="<%=request.getContextPath()%>/board/normal/normalList.jsp?pageNum=<%= i %>">[<%= i %>]</a>
        <% }
                }
                if (endPage < pageCount) { // 다음 페이지로 이동
        %>
        <a href="<%=request.getContextPath()%>/board/normal/normalList.jsp?pageNum=<%= startPage + pageBlock %>">[다음]</a>
        <% }
            }
        %>
    </div>
          </article>
    </main>
</body>
</html> --%>









<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="co.kr.dev.board.login.LoginBoardDAO, java.util.List, co.kr.dev.board.login.LoginBoardVO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="co.kr.dev.board.login.LoginBoardDAO" %>
<%@ page import="co.kr.dev.board.login.LoginBoardVO" %>
<%
    // 페이징 설정
    int pageSize = 10; // 한 페이지에 보여줄 글 개수
    String pageNum = request.getParameter("pageNum");
    int currentPage = 1; // 기본값 1로 설정
    if (pageNum != null && !pageNum.isEmpty()) {
        try {
            currentPage = Integer.parseInt(pageNum);
        } catch (NumberFormatException e) {
            currentPage = 1; // 잘못된 값이 들어온 경우 기본값 1로 설정
        }
    }

    int start = (currentPage - 1) * pageSize + 1; // 시작 번호 계산
    int end = currentPage * pageSize; // 끝 번호 계산

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    int count = 0, number = 0;
    ArrayList<LoginBoardVO> boardList = null;
    LoginBoardDAO dao = LoginBoardDAO.getInstance();

 // NORMAL 타입 게시글의 전체 개수 가져오기
    count = dao.getPostCountByType("NORMAL");

    if (count > 0) {
        // NORMAL 타입 게시글 페이징 조회
        boardList = dao.getPostsByType("NORMAL", start, end);
    }

    number = count - (currentPage - 1) * pageSize; // 글 번호 계산
%>   
<%
    // DAO 인스턴스 생성
    LoginBoardDAO loginBoardDAO = LoginBoardDAO.getInstance();

    // 최근 게시물 5개 불러오기
    List<LoginBoardVO> normalPosts = loginBoardDAO.selectRecentPosts(10); 
%>
<%
String userName = (String) session.getAttribute("userName");
String userId = (String) session.getAttribute("userId");

%>    
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>자유게시판 목록</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/common/common.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/board/normal/normalList.css">
</head>
<body>
    <!-- Header -->
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
    
    <!-- Main content -->
    <main>
        <jsp:include page="/include/slideShow/slideShow.jsp" />
        
        <section>
            <article class="normalListArti">
                <div class="normalListDiv">
                    <div class="normalBoardTitle">
                        <span class="normalBoardTitleSpan">자유게시판 목록</span>
                    </div>

                    <table class="normalBoardTable">
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
                            <% 
                                if (boardList != null && !boardList.isEmpty()) {
                                    for (LoginBoardVO post : boardList) { 
                            %>
                            <tr class="normalPostsRow">
                                <td class="postNum" align="center"><%= number-- %></td>
                                <td class="postTitle">
                                    <a href="<%=request.getContextPath()%>/board/normal/normalShow.jsp?num=<%= post.getNum() %>&pageNum=<%= currentPage %>">
                                        <% if (post.getDepth() > 0) { %>
                                            <img src="<%=request.getContextPath()%>/board/images/level.gif" width="<%= 10 * post.getDepth() %>" height="16">
                                            <img src="<%=request.getContextPath()%>/board/images/re.gif">
                                        <% } %>
                                        <%= post.getTitle() %>
                                    </a>
                                    <% if (post.getReadCount() >= 20) { %>
                                        <img src="<%=request.getContextPath()%>/board/images/hot.gif" height="16">
                                    <% } %>
                                </td>
                                <td class="postWriter" align="center"><%= post.getStudentId() %></td>
                                <td class="postDate" align="center"><%= sdf.format(post.getRegDate()) %></td>
                                <td class="postViews" align="center"><%= post.getReadCount() %></td>
                                <td class="postIp" align="center"><%= post.getIp() %></td>
                            </tr>
                            <% 
                                    } 
                                } else {
                            %>
                            <tr>
                                <td colspan="6" class="noPostMessage">게시물이 없습니다.</td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                    <div class="normalBorderWriteLinkDiv">
                        <a href="<%=request.getContextPath()%>/board/normal/write/normalForm.jsp" class="normalBoardWriteLink">글쓰기</a>
                    </div>

                    <div class="normalBoardPage">
                        <% if (count > 0) { %>
                            <% 
                                int pageBlock = 3;
                                int pageCount = (int) Math.ceil((double) count / pageSize);
                                int startPage = (currentPage - 1) / pageBlock * pageBlock + 1;
                                int endPage = Math.min(startPage + pageBlock - 1, pageCount);

                                if (startPage > 1) { 
                            %>
                            <a href="normalList.jsp?pageNum=<%= startPage - pageBlock %>">[이전]</a>
                            <% } %>
                            <% for (int i = startPage; i <= endPage; i++) { %>
                                <% if (i == currentPage) { %>
                                    <strong>[<%= i %>]</strong>
                                <% } else { %>
                                    <a href="<%=request.getContextPath()%>/board/normal/normalList.jsp?pageNum=<%= i %>">[<%= i %>]</a>
                                <% } %>
                            <% } %>
                            <% if (endPage < pageCount) { %>
                                <a href="<%=request.getContextPath()%>/board/normal/normalList.jsp?pageNum=<%= startPage + pageBlock %>">[다음]</a>
                            <% } %>
                        <% } %>
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
