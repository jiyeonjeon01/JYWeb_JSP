<%@page import="co.kr.dev.board.logout.LogoutBoardVO"%>
<%@page import="co.kr.dev.board.logout.LogoutBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="co.kr.dev.board.login.LoginBoardDAO, java.util.List, co.kr.dev.board.login.LoginBoardVO" %>
<%
    // 세션에서 로그인 정보와 역할 확인
    String userId = (String) session.getAttribute("userId");
    String userRole = (String) session.getAttribute("role"); // 세션에 저장된 역할 이름 확인
    

    // 역할 확인: admin이 아닌 경우 접근 제한
    if (userId == null || userId.isEmpty() || !"ADMIN".equals(userRole)) {
        System.out.println("[DEBUG] 접근 제한 - userId: " + userId + ", userRole: " + userRole);
        response.sendRedirect(request.getContextPath() + "/error/accessDenied.jsp");
        return;
    }

    // 질문 번호 가져오기
    int questionNum = Integer.parseInt(request.getParameter("num"));

    // 로그인 여부 확인 및 DAO 호출
    String questionTitle = "";
    if (userId != null) {
        // 로그인 사용자의 질문
        LoginBoardDAO loginBoardDAO = LoginBoardDAO.getInstance();
        LoginBoardVO loginBoard = loginBoardDAO.selectOne(questionNum);
        questionTitle = (loginBoard != null) ? loginBoard.getTitle() : "제목 없음";
    } else {
        // 로그아웃 사용자의 질문
        LogoutBoardDAO logoutBoardDAO = LogoutBoardDAO.getInstance();
        LogoutBoardVO logoutBoard = logoutBoardDAO.selectOne(questionNum);
        questionTitle = (logoutBoard != null) ? logoutBoard.getTitle() : "제목 없음";
    }

%>
<%
    int ref = 0, step = 0, depth = 0; // 기본값 초기화
    try {
        ref = Integer.parseInt(request.getParameter("ref"));
        step = Integer.parseInt(request.getParameter("step"));
        depth = Integer.parseInt(request.getParameter("depth"));
    } catch (NumberFormatException e) {
        e.printStackTrace();
        System.out.println("[DEBUG] ref, step, depth 값 초기화 오류: " + e.getMessage());
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>답변게시판 게시글 작성</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/common/common.css">
    <script>
        function validateForm() {
            if (document.answerForm.title.value.trim() === "") {
                /* alert("제목을 입력하세요."); */
                document.answerForm.title.focus();
                return false;
            }
            if (document.answerForm.content.value.trim() === "") {
                alert("내용을 입력하세요.");
                document.answerForm.content.focus();
                return false;
            }
            return true;
        }
    </script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/board/qna/answer/write/answerForm.css">
</head>
<body>
    <!-- 헤더 -->
    <header>
        <jsp:include page="/include/header/admin/adminHeader.jsp" />
    </header>
    
    <!-- 메인 -->
    <main>
        <jsp:include page="/include/slideShow/slideShow.jsp" />
        
        <section>
            <article class="write-board-article">
                <h2 class="write-board-title">답변 작성</h2>
                <form name="answerForm" method="post" action="answerProc.jsp" enctype="multipart/form-data" onsubmit="return validateForm()" class="write-board-form">
                    <input type="hidden" name="type" value="ANSWER">
                    <input type="hidden" name="adminId" value="<%= userId %>">
                    <input type="hidden" name="questionNum" value="<%= questionNum %>">
                    <input type="hidden" name="ref" value="<%= ref %>">
                    <input type="hidden" name="step" value="<%= step + 1 %>">
                    <input type="hidden" name="depth" value="<%= depth + 1 %>">
                    <input type="hidden" name="title" value="[<%= questionTitle%>] 답변">
                    <input type="hidden" name="title" value="[<%= questionTitle %>]">

                    <table class="write-board-table">
						<tr>
						    <th class="write-board-th">제목</th>
						    <td class="write-board-td">
						        <input type="text" name="displayTitle" value="[<%= questionTitle %>]" class="write-board-input" readonly>
						        <input type="hidden" name="title" value="[<%= questionTitle %>]">
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
