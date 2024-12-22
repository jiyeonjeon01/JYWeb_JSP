<%@ page import="co.kr.dev.student.model.StudentVO"%>
<%@ page import="co.kr.dev.student.model.StudentDAO"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.FileItem"%>
<%@ page import="java.io.File"%>
<%@ page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // 요청 파라미터 인코딩 설정
    request.setCharacterEncoding("utf-8");

    // 세션에서 사용자 ID 가져오기 (아이디는 수정 불가)
    String userId = (String) session.getAttribute("userId");
    System.out.println("아이디 가져왓나? ");

    // 파일 업로드 관련 설정
    String uploadPath = application.getRealPath("/uploads"); // 업로드 경로 설정
    int maxFileSize = 10 * 1024 * 1024; // 최대 파일 크기 (10MB)
    String originFile = null;
    String sysFile = null;

    // 업로드 디렉토리 생성
    File uploadDir = new File(uploadPath);
    if (!uploadDir.exists()) {
        uploadDir.mkdir();
    }

    // DAO 및 VO 객체 준비
    StudentDAO sdao = StudentDAO.getInstance();
    StudentVO svo = new StudentVO();
    svo.setId(userId); // 수정 불가능한 아이디 설정

    System.out.println("dao,vo 준비완 ");

    // 파일 및 폼 데이터 처리
    boolean isMultipart = ServletFileUpload.isMultipartContent(request);
    if (isMultipart) {
        DiskFileItemFactory factory = new DiskFileItemFactory();
        factory.setRepository(new File(System.getProperty("java.io.tmpdir"))); // 임시 디렉토리 설정
        ServletFileUpload upload = new ServletFileUpload(factory);
        upload.setSizeMax(maxFileSize); // 파일 크기 제한

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

                        // 파일 이름 및 경로 설정
                        originFile = originalFileName; // 원본 파일 이름
                        sysFile = uniqueFileName;      // 저장된 파일 이름
                    }
                } else {
                    // 폼 데이터 처리
                    String fieldName = item.getFieldName();
                    String fieldValue = item.getString("utf-8"); // UTF-8로 인코딩 설정
                    switch (fieldName) {
                        case "pass":
                            svo.setPass(fieldValue);
                            break;
                        case "name":
                            svo.setName(fieldValue);
                            break;
                        case "phone1":
                            svo.setPhone1(fieldValue);
                            break;
                        case "phone2":
                            svo.setPhone2(fieldValue);
                            break;
                        case "phone3":
                            svo.setPhone3(fieldValue);
                            break;
                        case "email":
                            svo.setEmail(fieldValue);
                            break;
                        case "zipcode":
                            svo.setZipcode(fieldValue);
                            break;
                        case "address1":
                            svo.setAddress1(fieldValue);
                            break;
                        case "address2":
                            svo.setAddress2(fieldValue);
                            break;
                    }
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    // 업로드된 파일 설정 (파일 업로드가 없는 경우 기존 파일 유지)
    svo.setOriginFile(originFile != null ? originFile : (String) session.getAttribute("originFile"));
    svo.setSysFile(sysFile != null ? sysFile : (String) session.getAttribute("sysFile"));

    // 데이터베이스 업데이트
    boolean updateSuccess = sdao.updateDB(svo);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원정보 수정</title>
   <%--  /<link href="<%=request.getContextPath()%>/style.css" rel="stylesheet" type="text/css"> --%>
    <style>
        main {
            text-align: center;
            margin-top: 50px;
            line-height: 1.8;
        }
        h2 {
            margin-bottom: 20px;
        }
        p {
            margin-bottom: 30px;
        }
        a {
            display: inline-block;
            padding: 10px 20px;
            margin-top: 10px;
            text-decoration: none;
            color: white;
            background-color: #4CAF50;
            border-radius: 5px;
        }
        a:hover {
            background-color: #45a049;
        }
        a.grey {
            background-color: #ccc;
        }
    </style>
</head>
<body>
    <main>
        <%
            if (updateSuccess) {
                // 세션 정보 갱신
                session.setAttribute("userName", svo.getName());
                session.setAttribute("userPhone1", svo.getPhone1());
                session.setAttribute("userPhone2", svo.getPhone2());
                session.setAttribute("userPhone3", svo.getPhone3());
                session.setAttribute("userEmail", svo.getEmail());
                session.setAttribute("userZipcode", svo.getZipcode());
                session.setAttribute("userAddress1", svo.getAddress1());
                session.setAttribute("userAddress2", svo.getAddress2());
                session.setAttribute("originFile", svo.getOriginFile());
                session.setAttribute("sysFile", svo.getSysFile());
        %>
            <h2 style="color: green;">회원정보가 성공적으로 수정되었습니다!</h2>
            <p>마이페이지로 이동합니다.</p>
            <a href="<%=request.getContextPath()%>/student/user/myPage/showMyPage.jsp">마이페이지</a>
        <%
            } else {
        %>
            <h2 style="color: red;">회원정보 수정에 실패했습니다.</h2>
            <p>다시 시도해 주세요.</p>
            <a href="<%=request.getContextPath()%>/student/user/modify/modifyForm.jsp" class="grey">회원정보 수정</a>
        <%
            }
        %>
    </main>
</body>
</html>
