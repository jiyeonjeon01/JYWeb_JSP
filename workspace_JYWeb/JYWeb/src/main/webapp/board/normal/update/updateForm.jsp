<%@page import="co.kr.dev.board.login.LoginBoardVO"%>
<%@page import="co.kr.dev.board.login.LoginBoardDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");

    // 세션에서 로그인한 사용자 정보 가져오기
    String loggedInUser = (String) session.getAttribute("userId");
    String userRole = (String) session.getAttribute("role"); // 사용자 역할 (e.g., 'ADMIN')

    // 게시글 번호 가져오기
    int num = Integer.parseInt(request.getParameter("num"));
    String pageNum = request.getParameter("pageNum");

    // DAO 초기화 및 게시글 데이터 가져오기
    LoginBoardDAO dao = LoginBoardDAO.getInstance();
    LoginBoardVO post = dao.selectOne(num);

    // 게시글 존재 여부 확인
    if (post == null) {
        out.println("<script>alert('해당 게시글이 존재하지 않습니다.'); history.back();</script>");
        return;
    }

    // 권한 확인: role이 'ADMIN'이거나 작성자인 경우에만 접근 허용
    if (loggedInUser == null || (!loggedInUser.equals(post.getStudentId()) && !"ADMIN".equals(userRole))) {
        out.println("<script>alert('권한이 없습니다.'); history.back();</script>");
        return;
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시글 수정</title>
</head>
<body>
<article>
    <h2 style="text-align: center;">게시글 수정</h2>
    <form action="<%=request.getContextPath()%>/board/normal/update/updateProc.jsp" method="post" enctype="multipart/form-data">
        <input type="hidden" name="num" value="<%= post.getNum() %>">
        <input type="hidden" name="pageNum" value="<%= pageNum %>">

        <table border="1" align="center" cellpadding="10">
            <tr>
                <th>제목</th>
                <td><input type="text" name="title" size="50" maxlength="100" value="<%= post.getTitle() %>"></td>
            </tr>
            <tr>
                <th>내용</th>
                <td><textarea name="content" rows="15" cols="60"><%= post.getContent() %></textarea></td>
            </tr>
            <tr>
                <th>첨부파일</th>
                <td>
                    <% if (post.getOriginFile() != null && !post.getOriginFile().isEmpty()) { %>
                        <p>현재 파일: <%= post.getOriginFile() %></p>
                    <% } else { %>
                        <p>첨부파일 없음</p>
                    <% } %>
                    <input type="file" name="originFile">
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <button type="submit">수정</button>
                    <button type="button" onclick="location.href='<%=request.getContextPath()%>/board/normal/normalShow.jsp?num=<%= post.getNum() %>&pageNum=<%= pageNum %>'">취소</button>
                </td>
            </tr>
        </table>
    </form>
    </article>
</body>
</html>
