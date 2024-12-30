<%@page import="co.kr.dev.board.logout.LogoutBoardDAO"%>
<%@page import="co.kr.dev.board.logout.LogoutBoardVO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");

    LogoutBoardDAO dao = LogoutBoardDAO.getInstance();
    LogoutBoardVO vo = new LogoutBoardVO();

    String uploadPath = application.getRealPath("/uploads");
    int maxFileSize = 10 * 1024 * 1024;

    try {
        MultipartRequest multi = new MultipartRequest(request, uploadPath, maxFileSize, "UTF-8", new DefaultFileRenamePolicy());

        int num = Integer.parseInt(multi.getParameter("num"));
        vo.setNum(num);

        LogoutBoardVO existingPost = dao.selectOne(num);
        if (existingPost == null) {
            out.println("<script>alert('게시글이 존재하지 않습니다.'); history.back();</script>");
            return;
        }

        String inputPassword = multi.getParameter("pass");
        if (!existingPost.getPass().equals(inputPassword)) {
            out.println("<script>alert('비밀번호가 일치하지 않습니다.'); history.back();</script>");
            return;
        }

        vo.setTitle(multi.getParameter("title"));
        vo.setContent(multi.getParameter("content"));
        vo.setRegDate(new Timestamp(System.currentTimeMillis()));

        String originFile = multi.getOriginalFileName("originFile");
        String sysFile = multi.getFilesystemName("originFile");
        vo.setOriginFile(originFile != null ? originFile : existingPost.getOriginFile());
        vo.setSysFile(sysFile != null ? sysFile : existingPost.getSysFile());

        boolean flag = dao.update(vo);

        if (flag) {
            out.println("<script>alert('게시글이 수정되었습니다.'); location.href='" + request.getContextPath() + "/board/qna/question/logout/logoutQShow.jsp?num=" + vo.getNum() + "';</script>");
        } else {
            out.println("<script>alert('수정에 실패했습니다.'); history.back();</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('오류가 발생했습니다.'); history.back();</script>");
    }
%>
