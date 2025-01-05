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
        System.out.println("게시글 번호(num): " + num);

        vo.setNum(num);

        // 기존 게시글 정보 가져오기
        LoginBoardVO existingPost = dao.selectOne(num);

        if (existingPost == null) {
            throw new Exception("해당 게시글이 존재하지 않습니다.");
        }

        // 권한 확인
        if (!"ADMIN".equals(userRole) && !userId.equals(existingPost.getStudentId())) {
            throw new Exception("권한이 없습니다.");
        }

        // 데이터 처리
        vo.setTitle(multi.getParameter("title"));
        vo.setContent(multi.getParameter("content"));
        
        // type 처리
        String type = multi.getParameter("type");
        if (type == null || type.isEmpty()) {
            type = "NOTI"; // 기본값 설정
        }
        vo.setType(type);

        // 디버깅: type 확인
        System.out.println("게시글 유형(type): " + type);

        // 파일 처리
        String originFile = multi.getOriginalFileName("originFile");
        String sysFile = multi.getFilesystemName("originFile");
        System.out.println("파일 이름(originFile): " + originFile);
        System.out.println("파일 시스템 이름(sysFile): " + sysFile);

        vo.setOriginFile(originFile != null ? originFile : existingPost.getOriginFile());
        vo.setSysFile(sysFile != null ? sysFile : existingPost.getSysFile());

        // 게시글 수정
        if (dao.update(vo)) {
            response.sendRedirect(request.getContextPath() + "/board/noti/notiShow.jsp?num=" + vo.getNum() + "&pageNum=" + multi.getParameter("pageNum"));
        } else {
            throw new Exception("게시글 수정에 실패했습니다.");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('" + e.getMessage() + "'); history.back();</script>");
    }
%>
