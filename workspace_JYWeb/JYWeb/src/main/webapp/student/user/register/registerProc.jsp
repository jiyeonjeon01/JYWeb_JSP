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

    // 파일 업로드 관련 설정
    String uploadPath = application.getRealPath("/uploads"); // 업로드 경로 설정
    int maxFileSize = 10 * 1024 * 1024; // 최대 파일 크기 (10MB)
    String originFile = "default-image.jpg";
    String sysFile = "default-image.jpg";

    // 업로드 디렉토리 생성
    File uploadDir = new File(uploadPath);
    if (!uploadDir.exists()) {
        uploadDir.mkdir();
    }

    // DAO 및 VO 객체 준비
    StudentDAO sdao = StudentDAO.getInstance();
    StudentVO svo = new StudentVO();

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
                    String fileName = new File(item.getName()).getName();
                    if (!fileName.isEmpty()) {
                        String filePath = uploadPath + File.separator + fileName;
                        File storeFile = new File(filePath);
                        item.write(storeFile);

                        // 파일 이름 및 경로 설정
                        originFile = fileName;
                        sysFile = filePath;
                    }
                } else {
                    // 폼 데이터 처리
                    String fieldName = item.getFieldName();
                    String fieldValue = item.getString("utf-8"); // UTF-8로 인코딩 설정
                    switch (fieldName) {
                        case "id":
                            svo.setId(fieldValue);
                            break;
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

    // 업로드된 파일 경로 설정
    svo.setOriginFile(originFile);
    svo.setSysFile(sysFile);

    // 데이터베이스에 정보 저장
    boolean flag = sdao.insertDB(svo);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원가입 확인</title>
    <link href="<%=request.getContextPath()%>/style.css" rel="stylesheet" type="text/css">
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
        a.loginBtn {
            display: inline-block;
            padding: 10px 20px;
            margin-top: 10px;
            text-decoration: none;
            color: white;
            background-color: #4CAF50;
            border-radius: 5px;
        }
        a.loginBtn:hover {
            background-color: #45a049;
        }
        a.loginBtn.grey {
            background-color: #ccc;
        }
    </style>
</head>
<body>
    <main>
        <%
            if (flag) {
        %>
            <h2 style="color: green;">회원가입을 축하 드립니다!</h2>
            <p>로그인을 진행해 주세요.</p>
            <a href="<%=request.getContextPath()%>/student/user/login/login.jsp" class="loginBtn">로그인</a>
        <%
            } else {
        %>
            <h2 style="color: red;">회원가입에 실패했습니다.</h2>
            <p>다시 입력하여 주십시오.</p>
            <a href="<%=request.getContextPath()%>/student/user/register/regForm.jsp" class="loginBtn grey">다시 가입</a>
        <%
            }
        %>
    </main>
</body>
</html>
