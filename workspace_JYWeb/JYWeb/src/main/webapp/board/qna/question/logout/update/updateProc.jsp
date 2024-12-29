<%@ page import="co.kr.dev.board.login.LoginBoardDAO" %>
<%@ page import="co.kr.dev.board.login.LoginBoardVO" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");

    // 세션에서 사용자 정보 가져오기
    String userId = (String) session.getAttribute("userId");
    String userRole = (String) session.getAttribute("role");

    // 디버깅 메시지 출력
    System.out.println("Session userId: " + userId);
    System.out.println("Session role: " + userRole);

    if (userId == null) {
        out.println("<script>");
        out.println("alert('로그인이 필요합니다.');");
        out.println("location.href='" + request.getContextPath() + "/student/login/loginForm.jsp';");
        out.println("</script>");
        return;
    }

    // DAO와 VO 초기화
    LoginBoardDAO dao = LoginBoardDAO.getInstance();
    LoginBoardVO vo = new LoginBoardVO();

    // 업로드 설정
    String uploadPath = application.getRealPath("/uploads");
    int maxFileSize = 10 * 1024 * 1024; // 10MB

    try {
        // MultipartRequest 처리
        MultipartRequest multi = new MultipartRequest(request, uploadPath, maxFileSize, "UTF-8", new DefaultFileRenamePolicy());

        // 게시글 번호 가져오기
        int num = Integer.parseInt(multi.getParameter("num"));
        vo.setNum(num);

        // 기존 게시글 정보 가져오기
        LoginBoardVO existingPost = dao.selectOne(num);

        if (existingPost == null) {
            out.println("<script>");
            out.println("alert('해당 게시글이 존재하지 않습니다.');");
            out.println("history.back();");
            out.println("</script>");
            return;
        }

        // 권한 확인: role이 'ADMIN'이거나 작성자인 경우에만 허용
        if (!"ADMIN".equals(userRole) && !userId.equals(existingPost.getStudentId())) {
            out.println("<script>");
            out.println("alert('권한이 없습니다.');");
            out.println("history.back();");
            out.println("</script>");
            return;
        }

        // 게시글 수정 데이터 설정
        vo.setTitle(multi.getParameter("title"));
        vo.setContent(multi.getParameter("content"));
        vo.setRegDate(new Timestamp(System.currentTimeMillis()));

        // 파일 처리
        String originFile = multi.getOriginalFileName("originFile");
        String sysFile = multi.getFilesystemName("originFile");
        vo.setOriginFile(originFile != null ? originFile : existingPost.getOriginFile());
        vo.setSysFile(sysFile != null ? sysFile : existingPost.getSysFile());

        // 게시글 수정
        boolean flag = dao.update(vo);

        if (flag) {
            out.println("<script>");
            out.println("alert('게시글이 성공적으로 수정되었습니다.');");
            out.println("location.href='" + request.getContextPath() + "/board/qna/question/login/loginQShow.jsp?num=" + vo.getNum() + "&pageNum=" + multi.getParameter("pageNum") + "';");
            out.println("</script>");
        } else {
            out.println("<script>");
            out.println("alert('게시글 수정에 실패했습니다.');");
            out.println("history.back();");
            out.println("</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>");
        out.println("alert('게시글 수정 중 오류가 발생했습니다.');");
        out.println("history.back();");
        out.println("</script>");
    }
%>
