<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
    // 세션에서 사용자 ID 가져오기
    String userId = (String) session.getAttribute("userId");
    String userName = (String) session.getAttribute("userName");
    String profileImage = (String) session.getAttribute("profileImage");

    // 디버깅용 로그
    System.out.println("User ID: " + userId);
    System.out.println("User Name: " + userName);
    System.out.println("Profile Image: " + profileImage);

    // 기본 이미지 처리
    String profileImagePath;
    if (profileImage == null || profileImage.isEmpty()) {
        profileImagePath = request.getContextPath() + "/upload/default-image.jpg"; // 기본 이미지 경로
    } else {
        profileImagePath = request.getContextPath() + "/uploads/" + profileImage; // 사용자 업로드 이미지 경로
    }

    // 로그인이 안 된 경우 로그인 페이지로 리다이렉트
    if (userId == null || userId.isEmpty()) {
        response.sendRedirect(request.getContextPath() + "/student/user/login/loginForm.jsp");
        return;
    }
    
    
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://kit.fontawesome.com/abb02b8c73.js"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/include/aside/logout/logoutAside.css"></link>
</head>
<body>

	<aside>
			    <img src="<%=profileImagePath%>" alt="프로필 사진" class="profileImage">
			    <h3><%=userName%>(<%=userId%>)님</h3>
			    <br>
			    <br>
			    <ul>
			        <li><a href="<%=request.getContextPath()%>/myPage/myPage.jsp">마이페이지</a></li>
			        <li><a href="<%=request.getContextPath()%>/cart/cartList.jsp">장바구니</a></li>
			        <li><a href="<%=request.getContextPath()%>/board/myPosts.jsp">내가 쓴 글</a></li>
			        <li><a href="<%=request.getContextPath()%>/board/myReplies.jsp">내가 쓴 댓글</a></li>
			    </ul>
			</aside>

</body>
</html>