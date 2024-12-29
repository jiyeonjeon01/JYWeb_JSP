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
    // 요청 인코딩 설정
    request.setCharacterEncoding("UTF-8");

    // 업로드 설정
    String uploadPath = application.getRealPath("/uploads"); // 파일 저장 경로
    int maxFileSize = 10 * 1024 * 1024; // 10MB 파일 크기 제한
    String originFile = ""; // 원본 파일명
    String sysFile = ""; // 시스템 파일명

    // 업로드 디렉토리 생성
    File uploadDir = new File(uploadPath);
    if (!uploadDir.exists()) {
        uploadDir.mkdir(); // 디렉토리 생성
    }

    // 게시글 데이터 초기화
    LoginBoardVO vo = new LoginBoardVO();
    boolean isMultipart = ServletFileUpload.isMultipartContent(request);

    if (isMultipart) {
        DiskFileItemFactory factory = new DiskFileItemFactory();
        factory.setRepository(new File(System.getProperty("java.io.tmpdir"))); // 임시 디렉토리 설정
        ServletFileUpload upload = new ServletFileUpload(factory);
        upload.setSizeMax(maxFileSize); // 최대 파일 크기 설정

        try {
            List<FileItem> items = upload.parseRequest(request);
            for (FileItem item : items) {
                if (!item.isFormField()) {
                    // 파일 처리
                    String originalFileName = new File(item.getName()).getName();
                    if (!originalFileName.isEmpty()) {
                        // 고유한 파일 이름 생성
                        String uniqueFileName = System.currentTimeMillis() + "_" + originalFileName;
                        String filePath = uploadPath + File.separator + uniqueFileName;
                        File storeFile = new File(filePath);
                        item.write(storeFile);

                        // 파일 이름 설정
                        originFile = originalFileName; // 원본 파일 이름
                        sysFile = uniqueFileName;      // 저장된 파일 이름
                    }
                } else {
                    // 폼 데이터 처리
                    String fieldName = item.getFieldName();
                    String fieldValue = item.getString("UTF-8");
                    switch (fieldName) {
                        case "type":
                            vo.setType(fieldValue);
                            break;
                        case "studentId":
                            vo.setStudentId(fieldValue);
                            break;
                        case "num":
                            vo.setNum(Integer.parseInt(fieldValue));
                            break;
                        case "ref":
                            vo.setRef(Integer.parseInt(fieldValue));
                            break;
                        case "step":
                            vo.setStep(Integer.parseInt(fieldValue));
                            break;
                        case "depth":
                            vo.setDepth(Integer.parseInt(fieldValue));
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
    

    // 파일 정보 설정
    vo.setOriginFile(originFile);
    vo.setSysFile(sysFile);

    // 게시글 등록 시간 및 IP 설정
    vo.setRegDate(new Timestamp(System.currentTimeMillis()));
    vo.setIp(request.getRemoteAddr());

    // DAO를 사용하여 게시글 저장
    LoginBoardDAO dao = LoginBoardDAO.getInstance();
    boolean flag = dao.insert(vo);

    if (flag) {
    	response.sendRedirect(request.getContextPath() + "/board/noti/notiList.jsp");
    } else {
        out.println("<script>alert('게시글 등록 실패'); history.back();</script>");
    }
%>
