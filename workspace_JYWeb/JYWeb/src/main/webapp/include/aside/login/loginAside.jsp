<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    // 세션에서 사용자 ID 가져오기
    String userId = (String) session.getAttribute("userId");
    String userName = (String) session.getAttribute("userName");
    String profileImage = (String) session.getAttribute("profileImage");

    // 기본 이미지 경로 설정
    String defaultImagePath = request.getContextPath() + "/upload/default-image.jpg";

    // 프로필 이미지 경로 설정
    String profileImagePath;

    if (profileImage == null || profileImage.isEmpty()) {
        profileImagePath = defaultImagePath; // 기본 이미지 사용
    } else {
        // sysfile에서 파일 이름만 추출
        String fileName = profileImage.substring(profileImage.lastIndexOf("\\") + 1); // 윈도우 경로 처리
        profileImagePath = request.getContextPath() + "/uploads/" + fileName; // 상대 경로 생성
    }

    // 로그인이 안 된 경우 로그인 페이지로 리다이렉트
    if (userId == null || userId.isEmpty()) {
        response.sendRedirect(request.getContextPath() + "/student/user/login/loginForm.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>사용자 정보</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/include/aside/login/loginAside.css">
</head>
<body>
    <aside class="asideDiv">
        <img src="<%=profileImagePath%>" alt="프로필 사진" class="profileImage">
        <h3><%=userName%>(<%=userId%>)님</h3>
        <ul>
            <li><a href="<%=request.getContextPath()%>/student/user/myPage/showMyPage.jsp">마이페이지</a></li>
            <li><a href="<%=request.getContextPath()%>/board/shopping/cart/cartList.jsp">장바구니</a></li>
            <li><a href="<%=request.getContextPath()%>/board/myPosts.jsp">내가 쓴 글</a></li>
            <li><a href="<%=request.getContextPath()%>/student/user/logout/logoutProc.jsp">로그아웃</a></li>
        </ul>
    </aside>
</body>
</html>
