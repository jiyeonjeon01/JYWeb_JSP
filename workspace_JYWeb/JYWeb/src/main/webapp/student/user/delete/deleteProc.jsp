<%@page import="co.kr.dev.student.model.StudentVO"%>
<%@page import="co.kr.dev.student.model.StudentDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
    // 요청 파라미터 설정
    request.setCharacterEncoding("UTF-8");

    // 사용자 입력값 가져오기
    String inputPass = request.getParameter("pass");
    String userId = (String) session.getAttribute("userId"); // 세션에서 사용자 ID 가져오기

    // DAO 객체 생성
    StudentDAO sdao = StudentDAO.getInstance();

    // 비밀번호 확인
    boolean isPasswordCorrect = sdao.isPasswordCorrect(userId, inputPass);

    if (isPasswordCorrect) {
        // 비밀번호가 올바른 경우, 회원 정보 삭제
        StudentVO svo = new StudentVO();
        svo.setId(userId);
        boolean deleteSuccess = sdao.deleteDB(svo);

        if (deleteSuccess) {
            // 세션 무효화
            session.invalidate();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원 정보 삭제 진행</title>
    <meta http-equiv="Refresh" content="3;url=<%=request.getContextPath()%>/student/user/login/loginForm.jsp">
    <style>
        main {
            text-align: center;
            margin-top: 50px;
            font-family: "바탕체", sans-serif;
        }
        main font {
            font-size: 20px;
        }
    </style>
</head>
<body>
    <main>
<script>
	alert("회원정보가 삭제되었습니다. 로그인 페이지로 이동합니다.");
</script>

    </main>
</body>
</html>
<%
        } else {
            // 삭제 실패 시 에러 메시지
%>
<script>
    alert("회원정보 삭제에 실패했습니다. 다시 시도해주세요.");
    history.go(-1);
</script>
<%
        }
    } else {
        // 비밀번호가 틀린 경우
%>
<script>
    alert("비밀번호가 맞지 않습니다.");
    history.go(-1);
</script>
<%
    }
%>
