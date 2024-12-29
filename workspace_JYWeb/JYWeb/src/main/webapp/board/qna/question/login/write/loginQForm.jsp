<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="co.kr.dev.board.login.LoginBoardDAO, java.util.List, co.kr.dev.board.login.LoginBoardVO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="co.kr.dev.board.login.LoginBoardDAO" %>
<%@ page import="co.kr.dev.board.login.LoginBoardVO" %>
<%
    // 로그인 상태 확인
    String userId = (String) session.getAttribute("userId");
    if (userId == null || userId.isEmpty()) {
        response.sendRedirect(request.getContextPath() + "/student/user/login/loginForm.jsp");
        return;
    }

    // 게시글 관련 데이터 초기화
    int num = 0, ref = 0, step = 0, depth = 0;
    try {
        if (request.getParameter("num") != null) {
            num = Integer.parseInt(request.getParameter("num"));
            ref = Integer.parseInt(request.getParameter("ref"));
            step = Integer.parseInt(request.getParameter("step"));
            depth = Integer.parseInt(request.getParameter("depth"));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<%
    // DAO 인스턴스 생성
    LoginBoardDAO loginBoardDAO = LoginBoardDAO.getInstance();

    // 최근 게시물 10개 불러오기
    List<LoginBoardVO> recentPosts = loginBoardDAO.selectRecentPosts(10); 
%>
<%
/* String userName = (String) session.getAttribute("userName");
String userId = (String) session.getAttribute("userId"); */

%>    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>자유 게시판 글쓰기</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/common/common.css">

    <script>
        function validateForm() {
            if (document.writeForm.title.value.trim() === "") {
                alert("제목을 입력하세요.");
                document.writeForm.title.focus();
                return false;
            }
            if (document.writeForm.content.value.trim() === "") {
                alert("내용을 입력하세요.");
                document.writeForm.content.focus();
                return false;
            }
            return true;
        }
    </script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/board/qna/question/login/write/loginQForm.css">
<style>



</style></head>
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
<article class="write-board-article">

    <h2 class="write-board-title">QNA 질문하기</h2>
    <form name="writeForm" method="post" action="normalProc.jsp" enctype="multipart/form-data" onsubmit="return validateForm()" class="write-board-form">
        <input type="hidden" name="type" value="QUESTION">
        <input type="hidden" name="studentId" value="<%= userId %>">
        <input type="hidden" name="num" value="<%= num %>">
        <input type="hidden" name="ref" value="<%= ref %>">
        <input type="hidden" name="step" value="<%= step %>">
        <input type="hidden" name="depth" value="<%= depth %>">

        <table class="write-board-table">
            <tr>
                <th class="write-board-th">제목</th>
                <td class="write-board-td">
                    <input type="text" name="title" maxlength="100" class="write-board-input">
                </td>
            </tr>
            <tr>
                <th class="write-board-th">내용</th>
                <td class="write-board-td">
                    <textarea name="content" rows="10" maxlength="1000" class="write-board-textarea"></textarea>
                </td>
            </tr>
            <tr>
                <th class="write-board-th">첨부파일</th>
                <td class="write-board-td">
                    <input type="file" name="originFile" accept="image/*" class="write-board-file">
                </td>
            </tr>
        </table>
        <div class="write-board-button-group">
            <input type="submit" value="등록" class="write-board-submit">
            <input type="reset" value="초기화" class="write-board-reset">
            <input type="button" value="목록" class="write-board-list" onclick="window.location='<%=request.getContextPath()%>/board/qna/qnaList.jsp'">
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
 

