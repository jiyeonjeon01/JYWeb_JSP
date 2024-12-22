<%@page import="co.kr.dev.student.model.StudentVO"%>
<%@page import="co.kr.dev.student.model.StudentDAO"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    // 요청 파라미터 인코딩 설정
    request.setCharacterEncoding("utf-8");

    // 로그인 검증
    String id = request.getParameter("id");
    String pass = request.getParameter("pass");

    StudentDAO sdao = StudentDAO.getInstance();
    boolean isValid = sdao.validateLogin(id, pass); // 로그인 검증 메서드
    StudentVO svo = null;

    if (isValid) {
        // 로그인 성공 - 사용자 정보 가져오기
        svo = sdao.selectOneDB(id);

        // 세션에 사용자 정보 저장
        session.setAttribute("userId", svo.getId());
        session.setAttribute("userName", svo.getName());
        session.setAttribute("userPhone1", svo.getPhone1());
        session.setAttribute("userPhone2", svo.getPhone2());
        session.setAttribute("userPhone3", svo.getPhone3());
        session.setAttribute("userEmail", svo.getEmail());
        session.setAttribute("userZipcode", svo.getZipcode());
        session.setAttribute("userAddress1", svo.getAddress1());
        session.setAttribute("userAddress2", svo.getAddress2());
        session.setAttribute("profileImage", svo.getSysFile());

        // 디버깅 로그
        System.out.println("로그인 성공:");
        System.out.println("User ID: " + svo.getId());
        System.out.println("User Name: " + svo.getName());
        System.out.println("Profile Image: " + svo.getSysFile());
        System.out.println("Phone: " + svo.getPhone1() + "-" + svo.getPhone2() + "-" + svo.getPhone3());
        System.out.println("Email: " + svo.getEmail());
        System.out.println("Address: " + svo.getAddress1() + " " + svo.getAddress2());

        // 메인 페이지로 이동
        response.sendRedirect(request.getContextPath() + "/test.jsp");
    } else {
        // 로그인 실패
        System.out.println("로그인 실패 - 잘못된 ID 또는 비밀번호");

        // 세션 초기화
        session.invalidate();

        // 로그인 실패 페이지로 리다이렉트
        response.sendRedirect(request.getContextPath() + "/student/user/login/loginForm.jsp?error=1");
    }
%>





 <% if (isValid) { %>
            <h2 style="color: #58c170;">로그인 성공!</h2>
            <p>메인 페이지로 이동합니다.</p>
            <a href="<%=request.getContextPath()%>/test.jsp" class="loginBtn">메인 페이지</a>
        <% } else { %>
            <h2 style="color: #d57474;">로그인 실패!</h2>
            <p>아이디와 비밀번호를 다시 확인해 주세요.</p>
            <a href="<%=request.getContextPath()%>/student/user/login/loginForm.jsp" class="loginBtn grey">다시 로그인</a>
        <% } %>