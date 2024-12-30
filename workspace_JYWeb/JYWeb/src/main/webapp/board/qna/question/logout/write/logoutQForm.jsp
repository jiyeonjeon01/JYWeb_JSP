<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="co.kr.dev.board.logout.LogoutBoardDAO, co.kr.dev.board.logout.LogoutBoardVO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
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

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>질문 게시판 로그아웃 질문하기</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/common/common.css">
    <script>
        function validateForm() {
            if (document.writeForm.writer.value.trim() === "") {
                alert("작성자 이름을 입력하세요.");
                document.writeForm.writer.focus();
                return false;
            }
            if (document.writeForm.email.value.trim() === "") {
                alert("이메일을 입력하세요.");
                document.writeForm.email.focus();
                return false;
            }
            if (document.writeForm.pass.value.trim() === "") {
                alert("비밀번호를 입력하세요.");
                document.writeForm.pass.focus();
                return false;
            }
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
    <link rel="stylesheet" href="<%=request.getContextPath()%>/board/qna/question/logout/write/logoutQForm.css">
</head>
<body>
    <!-- 헤더 -->
    <header>
        <jsp:include page="/include/header/logout/logoutHeader.jsp" />
    </header>
    
    <!-- 메인 -->
    <main>
        <jsp:include page="/include/slideShow/slideShow.jsp" />
        
        <section>
            <article class="write-board-article">

                <h2 class="write-board-title">질문하기 (비회원)</h2>
                <form name="writeForm" method="post" action="logoutQProc.jsp" enctype="multipart/form-data" onsubmit="return validateForm()" class="write-board-form">
                    <input type="hidden" name="type" value="QUESTION">
                    <input type="hidden" name="num" value="<%= num %>">
                    <input type="hidden" name="ref" value="<%= ref %>">
                    <input type="hidden" name="step" value="<%= step %>">
                    <input type="hidden" name="depth" value="<%= depth %>">

                    <table class="write-board-table">
                        <tr>
                            <th class="write-board-th">작성자 이름</th>
                            <td class="write-board-td">
                                <input type="text" name="writer" maxlength="20" class="write-board-input">
                            </td>
                        </tr>
                        <tr>
                            <th class="write-board-th">이메일</th>
                            <td class="write-board-td">
                                <input type="email" name="email" maxlength="50" class="write-board-input">
                            </td>
                        </tr>
                        <tr>
                            <th class="write-board-th">비밀번호</th>
                            <td class="write-board-td">
                                <input type="password" name="pass" maxlength="30" class="write-board-input">
                            </td>
                        </tr>
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
