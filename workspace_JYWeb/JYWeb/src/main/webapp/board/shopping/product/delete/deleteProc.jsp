<%@page import="co.kr.dev.board.login.LoginBoardVO"%>
<%@ page import="co.kr.dev.board.login.LoginBoardDAO" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");

    // 세션에서 사용자 정보 가져오기
    String userId = (String) session.getAttribute("userId");
    String userRole = (String) session.getAttribute("role"); // 사용자 역할 ('ADMIN')

    // 디버깅: 세션 정보 확인
    if (userRole == null) {
        System.out.println("Session role is null. Please check loginProc.jsp or session management.");
        out.println("<script>");
        out.println("alert('권한 확인 중 문제가 발생했습니다. 다시 로그인해주세요.');");
        out.println("location.href='" + request.getContextPath() + "/student/login/loginForm.jsp';");
        out.println("</script>");
        return;
    }
    
    // 디버깅: 세션 정보 출력
    System.out.println("Session userId: " + userId);
    System.out.println("Session role: " + userRole);

    if (userId == null) {
        out.println("<script>");
        out.println("alert('로그인이 필요합니다.');");
        out.println("location.href='" + request.getContextPath() + "/student/login/loginForm.jsp';");
        out.println("</script>");
        return;
    }

    // 게시글 번호 가져오기
    int num = Integer.parseInt(request.getParameter("num"));
    String pageNum = request.getParameter("pageNum");

    // 디버깅: 전달된 파라미터 출력
    System.out.println("Received num: " + num);
    System.out.println("Received pageNum: " + pageNum);

    // DAO 초기화 및 게시글 데이터 가져오기
    LoginBoardDAO dao = LoginBoardDAO.getInstance();
    LoginBoardVO post = dao.selectOne(num);

    // 디버깅: 게시글 정보 출력
    System.out.println("Post Number: " + (post != null ? post.getNum() : "Not Found"));
    System.out.println("Post Writer: " + (post != null ? post.getStudentId() : "Unknown"));

    if (post == null) {
        out.println("<script>");
        out.println("alert('해당 게시글이 존재하지 않습니다.');");
        out.println("history.back();");
        out.println("</script>");
        return;
    }

    // 권한 확인
    boolean isAdmin = "ADMIN".equals(userRole);
    boolean isOwner = userId.equals(post.getStudentId());

    System.out.println("isAdmin: " + isAdmin);
    System.out.println("isOwner: " + isOwner);

    if (!isAdmin && !isOwner) {
        out.println("<script>");
        out.println("alert('삭제 권한이 없습니다.');");
        out.println("history.back();");
        out.println("</script>");
        return;
    }

    // 게시글 삭제
    boolean flag = dao.delete(num);

    // 디버깅: 삭제 결과 출력
    System.out.println("Delete executed for num: " + num + ", Success: " + flag);

    if (flag) {
        out.println("<script>");
        out.println("alert('게시글이 성공적으로 삭제되었습니다.');");
        out.println("location.href='" + request.getContextPath() + "/board/normal/normalList.jsp?pageNum=" + pageNum + "';");
        out.println("</script>");
    } else {
        out.println("<script>");
        out.println("alert('게시글 삭제에 실패했습니다. 다시 시도해주세요.');");
        out.println("history.back();");
        out.println("</script>");
    }
%>
