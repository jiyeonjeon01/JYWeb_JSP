<%@ page import="co.kr.dev.board.login.LoginBoardDAO" %>
<%@ page import="co.kr.dev.board.login.LoginBoardVO" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");

    // 세션에서 로그인한 사용자 정보 가져오기
    String loggedInUser = (String) session.getAttribute("userId");
    String userRole = (String) session.getAttribute("role"); // 사용자 역할 (e.g., 'admin')

    // 게시글 번호와 현재 페이지 번호 가져오기
    int num = Integer.parseInt(request.getParameter("num"));
    String pageNum = request.getParameter("pageNum");

    // DAO 인스턴스 가져오기
    LoginBoardDAO dao = LoginBoardDAO.getInstance();
    LoginBoardVO post = dao.selectOne(num); // 게시글 데이터 가져오기

    if (loggedInUser == null) {
        out.println("<script>");
        out.println("alert('로그인이 필요합니다.');");
        out.println("history.back();");
        out.println("</script>");
        return;
    }

    if (post == null || (!loggedInUser.equals(post.getStudentId()) && !"admin".equals(userRole))) {
        out.println("<script>");
        out.println("alert('권한이 없습니다. 삭제할 수 없습니다.');");
        out.println("history.back();");
        out.println("</script>");
        return;
    }

    boolean flag = false;

    try {
        // 게시글 삭제
        flag = dao.delete(num);
    } catch (Exception e) {
        e.printStackTrace();
    }

    // 삭제 결과에 따른 처리
    if (flag) {
        // 삭제 성공 시 목록 페이지로 이동
        out.println("<script>");
        out.println("alert('게시글이 성공적으로 삭제되었습니다.');");
        out.println("location.href='" + request.getContextPath() + "/board/normal/normalList.jsp?pageNum=" + pageNum + "';");
        out.println("</script>");
    } else {
        // 삭제 실패 시 상세보기 페이지로 이동
        out.println("<script>");
        out.println("alert('게시글 삭제에 실패했습니다. 다시 시도해주세요.');");
        out.println("location.href='" + request.getContextPath() + "/board/normal/normalShow.jsp?num=" + num + "&pageNum=" + pageNum + "';");
        out.println("</script>");
    }
%>
