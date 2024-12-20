<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    // 세션에서 사용자 이름 가져오기\
    String userName = (String) session.getAttribute("userName");
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://kit.fontawesome.com/abb02b8c73.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/include/header/login/loginHeader.css"></link>
</head>
<body>

	<!-- 헤더 -->
	<header>
		<!-- 한줄의 테이블 형식, 세부 내용은 div로 나누기 -->
		<table class="headerTable">
			<tr>
				<!-- 로고: 클릭 시 새로고침 -->
				<td class="logoTd"><a href="javascript:location.reload();">
						<!-- 새로고침 -->
						<div class="logo">
						<div class="logoPic">
							<i class="fa-solid fa-house" width="10%"></i>
						</div>
						<div class="logoLetter">
							<span>JY Web</span>
						</div>
						</div>
				</a>
				</td>

				<!-- 빈공간 -->
				<td class="emptyTd"></td>

				<!-- 메뉴 -->
				<td class="menuTd">
					<!-- 공지사항 -->
					<div class="notiMenuLogin">
						<a href="<%=request.getContextPath()%>/board/noti/notiList.jsp">
							<span>공지사항</span>
						</a>
						<div class="dropdownMenuLogin">
							<a href="<%=request.getContextPath()%>/board/noti/notiList.jsp">목록보기</a>
							<!-- 공지사항 글작성은 admin 사용자만 -->
							<%-- <a href="<%=request.getContextPath()%>/board/writeForm.jsp">글작성하기</a> --%>
						</div>
					</div> 
					<!-- 게시판 -->
					<div class="normalMenuLogin">
						<a
							href="<%=request.getContextPath()%>/board/free/freeList.jsp">
							<span>자유게시판</span>
						</a>
						<div class="dropdownMenuLogin">
							<a
								href="<%=request.getContextPath()%>/board/free/freeList.jsp">목록보기</a>
							<a href="<%=request.getContextPath()%>/board/writeForm.jsp">글작성하기</a>
						</div>
					</div> 
					<!-- Q&A -->
					<div class="qnaMenuLogin">
						<a href="<%=request.getContextPath()%>/board/qna/qnaList.jsp">
							<span>Q&A</span>
						</a>
						<div class="dropdownMenuLogin">
							<a href="<%=request.getContextPath()%>/board/qna/qnaList.jsp">목록보기</a>
							<a href="<%=request.getContextPath()%>/board/qna/logoutForm.jsp">질문작성하기</a>
						</div>
					</div> 
					<!-- 쇼핑 메뉴 -->
					<div class="shoppingMenuLogin">
						<a
							href="<%=request.getContextPath()%>/board/shopping/productList.jsp">
							<span>쇼핑</span>
						</a>
						<!-- 드롭다운 메뉴 -->
						<div class="dropdownMenuLogin">
							<a href="<%=request.getContextPath()%>/board/shopping/productList.jsp">상품보기</a>
							<a href="<%=request.getContextPath()%>/board/shopping/cart.jsp">장바구니</a>
						</div>
					</div>
				</td>

				<!-- 빈공간 -->
				<td class="emptyTd"></td>

				<!-- 유저이름 버튼 -->
				<td class="userNameBtnTd">
					<div>
						<a href="<%=request.getContextPath()%>/student/myPage/myPage.jsp">
						<button class="userNameBtn"><strong><%=userName%>님</strong></button> 
						</a>
					</div>
				</td>
			</tr>
		</table>
	</header>
	
	
</body>
</html>