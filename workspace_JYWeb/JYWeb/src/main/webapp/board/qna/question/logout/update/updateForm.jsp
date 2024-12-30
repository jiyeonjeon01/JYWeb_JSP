<%@page import="co.kr.dev.board.logout.LogoutBoardVO"%>
<%@page import="co.kr.dev.board.logout.LogoutBoardDAO"%>
<%@page import="co.kr.dev.board.login.LoginBoardVO"%>
<%@page import="co.kr.dev.board.login.LoginBoardDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%
    String userId = (String) session.getAttribute("userId");
%>
<%
    request.setCharacterEncoding("UTF-8");

    // 세션에서 로그인한 사용자 정보 가져오기
    String loggedInUser = (String) session.getAttribute("userId");
    String userRole = (String) session.getAttribute("role"); // 사용자 역할 (e.g., 'ADMIN')

    // 게시글 번호 가져오기
    int num = Integer.parseInt(request.getParameter("num"));
    String pageNum = request.getParameter("pageNum");

    // DAO 초기화 및 게시글 데이터 가져오기
    LogoutBoardDAO dao = LogoutBoardDAO.getInstance();
    LogoutBoardVO post = dao.selectOne(num);

    LoginBoardDAO dao2 = LoginBoardDAO.getInstance();
    LoginBoardVO post2 = dao2.selectOne(num);
    

    // 게시글 존재 여부 확인
    if (post == null) {
        out.println("<script>alert('해당 게시글이 존재하지 않습니다.'); history.back();</script>");
        return;
    }

/*     // 권한 확인: role이 'ADMIN'이거나 작성자인 경우에만 접근 허용
    if (loggedInUser == null || (!loggedInUser.equals(post2.getStudentId()) && !"ADMIN".equals(userRole))) {
        out.println("<script>alert('권한이 없습니다.'); history.back();</script>");
        return;
    } */
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>질문 게시판 로그아웃 게시글 수정</title>
    
    <link rel="stylesheet" href="<%=request.getContextPath()%>/common/common.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/board/qna/question/login/update/updateForm.css">
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
            <article class="update-board-article">
                <h2 class="update-board-title">게시글 수정</h2>
                <form action="<%= "ADMIN".equals(userRole) ? request.getContextPath() + "/board/qna/question/logout/update/updateProc.jsp" : request.getContextPath() + "/board/qna/question/logout/update/updateProc2.jsp" %>" 
			      method="post" enctype="multipart/form-data" class="update-board-form">
			    <input type="hidden" name="num" value="<%= post.getNum() %>">
			    <input type="hidden" name="pageNum" value="<%= pageNum %>">
			
			    <table class="update-board-table">
			        <tr>
			            <th class="update-board-th">제목</th>
			            <td class="update-board-td">
			                <input type="text" name="title" maxlength="100" value="<%= post.getTitle() %>" class="update-board-input">
			            </td>
			        </tr>
			        <tr>
			            <th class="update-board-th">내용</th>
			            <td class="update-board-td">
			                <textarea name="content" rows="15" maxlength="1000" class="update-board-textarea"><%= post.getContent() %></textarea>
			            </td>
			        </tr>
			        <tr>
			            <th class="update-board-th">첨부파일</th>
			            <td class="update-board-td">
			                <% if (post.getOriginFile() != null && !post.getOriginFile().isEmpty()) { %>
			                    <p>현재 파일: <%= post.getOriginFile() %></p>
			                <% } else { %>
			                    <p>첨부파일 없음</p>
			                <% } %>
			                <input type="file" name="originFile" class="update-board-file">
			            </td>
			        </tr>
			        <% if (!"ADMIN".equals(userRole)) { %>
			        <tr>
			            <th class="update-board-th">비밀번호</th>
			            <td class="update-board-td">
			                <input type="password" name="pass" maxlength="12" placeholder="비밀번호 입력" class="update-board-input">
			            </td>
			        </tr>
			        <% } %>
			    </table>
			
			    <div class="update-board-button-group">
			        <button type="submit" class="update-board-submit">수정</button>
			        <button type="button" class="update-board-cancel" onclick="location.href='<%=request.getContextPath()%>/board/qna/question/logout/logoutQShow.jsp?num=<%= post.getNum() %>&pageNum=<%= pageNum %>'">취소</button>
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
