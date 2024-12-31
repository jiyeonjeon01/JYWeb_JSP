<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="co.kr.dev.board.login.LoginBoardDAO"%>
<%@page import="co.kr.dev.board.login.LoginBoardVO"%>
<%
    request.setCharacterEncoding("UTF-8");

    // 업로드 설정
    String uploadPath = application.getRealPath("/uploads");
    int maxFileSize = 10 * 1024 * 1024; // 10MB 파일 크기 제한
    String originFile = "";
    String sysFile = "";

    File uploadDir = new File(uploadPath);
    if (!uploadDir.exists()) {
        uploadDir.mkdir();
    }

    LoginBoardVO vo = new LoginBoardVO();
    boolean isMultipart = ServletFileUpload.isMultipartContent(request);

    if (isMultipart) {
        DiskFileItemFactory factory = new DiskFileItemFactory();
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));
        ServletFileUpload upload = new ServletFileUpload(factory);
        upload.setSizeMax(maxFileSize);

        try {
            List<FileItem> items = upload.parseRequest(request);
            for (FileItem item : items) {
                if (!item.isFormField()) {
                    // 파일 처리
                    String originalFileName = new File(item.getName()).getName();
                    if (!originalFileName.isEmpty()) {
                        String uniqueFileName = System.currentTimeMillis() + "_" + originalFileName;
                        String filePath = uploadPath + File.separator + uniqueFileName;
                        File storeFile = new File(filePath);
                        item.write(storeFile);

                        originFile = originalFileName;
                        sysFile = uniqueFileName;
                    }
                } else {
                    // 폼 데이터 처리
                    String fieldName = item.getFieldName();
                    String fieldValue = item.getString("UTF-8");
                    switch (fieldName) {
                        case "type":
                            vo.setType(fieldValue);
                            break;
                        case "num":
                            vo.setNum(Integer.parseInt(fieldValue));
                            break;
                        case "title":
                            vo.setTitle(fieldValue);
                            break;
                        case "content":
                            vo.setContent(fieldValue);
                            break;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('파일 업로드 중 오류가 발생했습니다.'); history.back();</script>");
            return;
        }
    }

    vo.setOriginFile(originFile);
    vo.setSysFile(sysFile);
    vo.setRegDate(new Timestamp(System.currentTimeMillis()));
    vo.setIp(request.getRemoteAddr());

    LoginBoardDAO dao = LoginBoardDAO.getInstance();

    // 기존 게시글의 type 값 유지
    LoginBoardVO existingPost = dao.selectOne(vo.getNum());
    if (vo.getType() == null || vo.getType().isEmpty()) {
        vo.setType(existingPost.getType());
    }

    boolean flag = dao.update(vo);

    if (flag) {
        response.sendRedirect(request.getContextPath() + "/board/qna/answer/answerShow.jsp?num=" + vo.getNum());
    } else {
        out.println("<script>alert('답변 수정 실패'); history.back();</script>");
    }
%>
