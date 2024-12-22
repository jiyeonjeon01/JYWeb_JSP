<%@page import="co.kr.dev.board.login.LoginBoardVO"%>
<%@page import="co.kr.dev.board.login.LoginBoardDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");

    // 세션에서 로그인한 사용자 정보 가져오기
    String loggedInUser = (String) session.getAttribute("userId");
    String userRole = (String) session.getAttribute("role"); // 사용자 역할 (e.g., 'admin')

    if (loggedInUser == null) {
        out.println("<script>alert('로그인이 필요합니다.'); history.back();</script>");
        return;
    }

    // 업로드 설정
    String uploadPath = application.getRealPath("/uploads");
    int maxFileSize = 10 * 1024 * 1024; // 10MB

    // DAO와 VO 초기화
    LoginBoardDAO dao = LoginBoardDAO.getInstance();
    LoginBoardVO post = null;

    MultipartRequest multi = null;
    try {
        multi = new MultipartRequest(request, uploadPath, maxFileSize, "UTF-8", new DefaultFileRenamePolicy());

        // 게시글 번호로 데이터 가져오기
        int num = Integer.parseInt(multi.getParameter("num"));
        post = dao.selectOne(num);

        // 권한 확인
        if (post == null || (!loggedInUser.equals(post.getStudentId()) && !"admin".equals(userRole))) {
            out.println("<script>alert('권한이 없습니다.'); history.back();</script>");
            return;
        }

        // 게시글 정보 설정
        post.setTitle(multi.getParameter("title"));
        post.setContent(multi.getParameter("content"));
        post.setRegDate(new Timestamp(System.currentTimeMillis()));

        // 파일 처리
        String originFile = multi.getOriginalFileName("originFile");
        String sysFile = multi.getFilesystemName("originFile");
        post.setOriginFile(originFile != null ? originFile : post.getOriginFile());
        post.setSysFile(sysFile != null ? sysFile : post.getSysFile());

        // 게시글 수정
        boolean flag = dao.update(post);

        if (flag) {
            out.println("<script>");
            out.println("alert('게시글이 성공적으로 수정되었습니다.');");
            out.println("location.href='" + request.getContextPath() + "/board/normal/normalShow.jsp?num=" + post.getNum() + "&pageNum=" + multi.getParameter("pageNum") + "';");
            out.println("</script>");
        } else {
            out.println("<script>");
            out.println("alert('게시글 수정에 실패했습니다.');");
            out.println("location.href='" + request.getContextPath() + "/board/normal/update/updateForm.jsp?num=" + post.getNum() + "&pageNum=" + multi.getParameter("pageNum") + "';");
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
