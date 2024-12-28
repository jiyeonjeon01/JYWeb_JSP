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
    count = dao.getPostCountByType("NOTI");

    if (count > 0) {
        // NORMAL 타입 게시글 페이징 조회
        boardList = dao.getPostsByType("NOTI", start, end);
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
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/common/common.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/board/noti/notiList.css"> 
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
        
<section class="noti-board-section">
<article>
    <h2 class="noti-board-title">공지사항 게시판 목록</h2>
    <div class="noti-board-write-link">
        <a href="<%=request.getContextPath()%>/board/noti/write/notiForm.jsp">글쓰기</a>
    </div>
    <%
        if (count == 0) { // 게시글이 없을 경우
    %>
    <table class="noti-board-table">
        <tr>
            <td class="noti-board-empty" colspan="6">게시판에 저장된 글이 없습니다.</td>
        </tr>
    </table>
    <% } else { // 게시글이 있을 경우 %>
    <table class="noti-board-table">
        <tr class="noti-board-header">
            <th>번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일</th>
            <th>조회</th>
            <th>IP</th>
        </tr>
        <%
            for (LoginBoardVO post : boardList) { // 게시글 리스트 출력
        %>
        <tr>
            <td align="center"><%= number-- %></td>
            <td>
                <a href="<%=request.getContextPath()%>/board/noti/notiShow.jsp?num=<%= post.getNum() %>&pageNum=<%= currentPage %>">
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
    <div class="noti-board-pagination">
        <%
            if (count > 0) { // 페이징 처리
                int pageBlock = 3; // 보여줄 페이지 수
                int pageCount = (int) Math.ceil((double) count / pageSize); // 전체 페이지 수
                int startPage = (currentPage - 1) / pageBlock * pageBlock + 1; // 시작 페이지 번호
                int endPage = Math.min(startPage + pageBlock - 1, pageCount); // 끝 페이지 번호

                if (startPage > 1) { // 이전 페이지로 이동
        %>
        <a href="notiList.jsp?pageNum=<%= startPage - pageBlock %>">[이전]</a>
        <% }
                for (int i = startPage; i <= endPage; i++) { // 페이지 번호 출력
                    if (i == currentPage) {
        %>
        <strong>[<%= i %>]</strong>
        <% } else { %>
        <a href="<%=request.getContextPath()%>/board/noti/notiList.jsp?pageNum=<%= i %>">[<%= i %>]</a>
        <% }
                }
                if (endPage < pageCount) { // 다음 페이지로 이동
        %>
        <a href="<%=request.getContextPath()%>/board/noti/notiList.jsp?pageNum=<%= startPage + pageBlock %>">[다음]</a>
        <% }
            }
        %>
    </div>
</article>
</section>

    </main>
    
    <footer>
        <jsp:include page="/include/footer/footer.jsp" />
    </footer>
</body>
</html>
 
