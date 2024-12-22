<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String userName = (String) session.getAttribute("userName");
String userId = (String) session.getAttribute("userId");

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
/* 마이페이지 전체 섹션 스타일 */
.mypageArticle {
    width: 100%;
    max-width: 400px; /* 최대 너비 제한 */
    margin: 30px auto; /* 화면 중앙 정렬 */
    border: 1px solid #ddd;
    border-radius: 10px;
    background-color: #f9f9f9; /* 배경색 */
    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
    padding: 20px;
    box-sizing: border-box; /* padding과 border를 포함하여 크기 계산 */
    text-align: center;
}

/* 환영 메시지 스타일 */
.welcomeMessage h2 {
    font-size: 1.5em;
    color: #333;
    margin-bottom: 20px;
}

/* 메뉴 리스트 스타일 */
.menuList {
    list-style: none;
    padding: 0;
    margin: 0;
}

.menuList li {
    margin-bottom: 15px; /* 각 버튼 간격 */
}

/* 버튼 스타일 */
.menuBtn {
    display: block; /* 블록으로 설정해 버튼이 가로 영역을 차지 */
    width: 100%; /* 버튼이 부모 요소의 너비에 맞게 */
    padding: 10px 15px; /* 텍스트와 버튼 간격 설정 */
    background-color: #d2e5ee; /* 하늘색 버튼 */
    color: #333;
    border-radius: 5px;
    text-decoration: none;
    font-size: 1em;
    transition: background-color 0.3s ease;
    box-sizing: border-box; /* padding을 포함한 크기 계산 */
}

.menuBtn:hover {
    background-color: #b0d4e3; /* 버튼 호버 효과 */
    color: white;
}

</style>
</head>
<body>
<article class="mypageArticle">
    <div class="welcomeMessage">
        <h2><%=userName%>(<%=userId%>)님 안녕하세요</h2>
    </div>
    <ul class="menuList">
        <li><a href="<%=request.getContextPath()%>/student/user/myPage/myBoardList.jsp" class="menuBtn">내가 작성한 글 보기</a></li>
        <li><a href="<%=request.getContextPath()%>/student/user/myPage/cart.jsp" class="menuBtn">장바구니 보기</a></li>
        <li><a href="<%=request.getContextPath()%>/student/user/modify/modifyForm.jsp" class="menuBtn">회원정보 수정하기</a></li>
        <li><a href="<%=request.getContextPath()%>/student/user/delete/deleteForm.jsp" class="menuBtn">회원 탈퇴하기</a></li>
        <li><a href="<%=request.getContextPath()%>/test.jsp" class="menuBtn">홈으로 가기</a></li>
    </ul>
</article>
</body>
</html>
