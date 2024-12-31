<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import="co.kr.dev.board.login.shopping.ProductDAO" %>
<%@ page import="co.kr.dev.board.login.shopping.ProductVO" %>

<%
    // 로그인 상태와 role 확인
    String userId = (String) session.getAttribute("userId");
    String role = (String) session.getAttribute("role");

    // 로그인되지 않거나 admin이 아닌 경우 접근 제한
    if (userId == null || userId.isEmpty() || !"ADMIN".equalsIgnoreCase(role)) {
        response.sendRedirect(request.getContextPath() + "/student/user/login/loginForm.jsp");
        return;
    }

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

    // 상품 데이터 초기화
    ProductVO vo = new ProductVO();
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
                        case "productNum":
                            vo.setNum(Integer.parseInt(fieldValue));
                            break;
                        case "studentId":
                            vo.setStudentId(fieldValue);
                            break;
                        case "name":
                            vo.setName(fieldValue);
                            break;
                        case "price":
                            vo.setPrice(Integer.parseInt(fieldValue));
                            break;
                        case "detail":
                            vo.setDetail(fieldValue);
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

    // 기존 파일 유지 여부 확인
    if (!originFile.isEmpty() && !sysFile.isEmpty()) {
        vo.setOriginFile(originFile);
        vo.setSysFile(sysFile);
    }

    // DAO를 사용하여 상품 업데이트
    ProductDAO dao = ProductDAO.getInstance();
    boolean flag = dao.update(vo);

    if (flag) {
        response.sendRedirect(request.getContextPath() + "/board/shopping/product/productList.jsp");
    } else {
        out.println("<script>alert('상품 수정 실패'); history.back();</script>");
    }
%>
