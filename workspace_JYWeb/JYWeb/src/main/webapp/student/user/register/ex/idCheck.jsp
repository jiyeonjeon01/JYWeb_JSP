<%@page import="co.kr.dev.student.model.StudentVO"%>
<%@page import="co.kr.dev.student.model.StudentDAO"%>
<%@page contentType="text/html; charset=UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");

    // 입력된 ID 값 가져오기
    String id = request.getParameter("id");

    // ID 값 검증
    boolean flag = false;
    if (id != null && !id.trim().isEmpty()) {
        // VO 객체 준비
        StudentVO svo = new StudentVO();
        svo.setId(id);

        // DAO 객체 준비
        StudentDAO sdao = StudentDAO.getInstance();

        // ID 중복 확인 수행
        flag = sdao.selectIdCheck(svo);
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>ID 중복체크</title>
    <link href="style.css" rel="stylesheet" type="text/css">
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            text-align: center;
            background-color: #f8f9fa;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .popup-container {
            width: 100%;
            text-align: center;
        }

        .message {
            font-size: 16px;
            color: #333;
            margin: 20px 0;
        }

        .message p {
            margin: 10px 0;
        }

        .closeBtn {
            padding: 8px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .closeBtn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="popup-container">
        <div class="message">
            <% if (id == null || id.trim().isEmpty()) { %>
                <p style="color: red;">ID를 입력하지 않았습니다.</p>
            <% } else if (flag) { %>
                <p style="color: red;"><b><%=id%></b>는 이미 존재하는 ID입니다.</p>
            <% } else { %>
                <p style="color: green;"><b><%=id%></b>는 사용 가능한 ID입니다.</p>
            <% } %>
        </div>
        <button class="closeBtn" onClick="javascript:self.close()">닫기</button>
    </div>
</body>
</html>
