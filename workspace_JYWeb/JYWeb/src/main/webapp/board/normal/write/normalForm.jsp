<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
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
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>자유게시판 글쓰기</title>
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
</head>
<body>
    <h2 style="text-align: center;">자유게시판 글쓰기</h2>
    <!-- enctype 설정 -->
    <form name="writeForm" method="post" action="normalProc.jsp" enctype="multipart/form-data" onsubmit="return validateForm()">
        <input type="hidden" name="type" value="NORMAL">
        <input type="hidden" name="studentId" value="<%= userId %>">
        <input type="hidden" name="num" value="<%= num %>">
        <input type="hidden" name="ref" value="<%= ref %>">
        <input type="hidden" name="step" value="<%= step %>">
        <input type="hidden" name="depth" value="<%= depth %>">

        <table border="1" align="center" cellpadding="10">
            <tr>
                <th>제목</th>
                <td>
                    <input type="text" name="title" size="50" maxlength="100">
                </td>
            </tr>
            <tr>
                <th>내용</th>
                <td>
                    <textarea name="content" rows="15" cols="60"></textarea>
                </td>
            </tr>
            <tr>
    <th>첨부파일</th>
    <td>
        <input type="file" name="originFile" accept="image/*">
    </td>
</tr>

            <tr>
                <td colspan="2" style="text-align: center;">
                    <input type="submit" value="등록">
                    <input type="reset" value="초기화">
                    <input type="button" value="목록" onclick="window.location='normalList.jsp'">
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
