<%@page import="co.kr.dev.board.logout.LogoutBoardDAO"%>
<%@page import="co.kr.dev.board.logout.LogoutBoardVO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");

    int num = Integer.parseInt(request.getParameter("num"));
    String inputPassword = request.getParameter("pass");

    LogoutBoardDAO dao = LogoutBoardDAO.getInstance();
    LogoutBoardVO post = dao.selectOne(num);

    if (post == null) {
        out.println("<script>alert('게시글이 존재하지 않습니다.'); history.back();</script>");
        return;
    }

    if (inputPassword == null || !inputPassword.equals(post.getPass())) {
        out.println("<script>alert('비밀번호가 일치하지 않습니다.'); history.back();</script>");
        return;
    }

    boolean flag = dao.delete(num);

    if (flag) {
        out.println("<script>alert('게시글이 성공적으로 삭제되었습니다.'); location.href='" + request.getContextPath() + "/board/qna/qnaList.jsp';</script>");
    } else {
        out.println("<script>alert('게시글 삭제에 실패했습니다.'); history.back();</script>");
    }
%>
