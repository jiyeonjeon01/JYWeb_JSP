<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ page import="co.kr.dev.board.login.LoginBoardDAO, java.util.List, co.kr.dev.board.login.LoginBoardVO" %>
<%
    // DAO 인스턴스 생성
    LoginBoardDAO loginBoardDAO = LoginBoardDAO.getInstance();

    // 최근 게시물 10개 불러오기
    List<LoginBoardVO> recentPosts = loginBoardDAO.selectRecentPosts(10); 
%>
<%
    // 세션에서 사용자 정보 가져오기
    String userId = (String) session.getAttribute("userId");
    String userName = (String) session.getAttribute("userName");
    String userPhone1 = (String) session.getAttribute("userPhone1");
    String userPhone2 = (String) session.getAttribute("userPhone2");
    String userPhone3 = (String) session.getAttribute("userPhone3");
    String userEmail = (String) session.getAttribute("userEmail");
    String userZipcode = (String) session.getAttribute("userZipcode");
    String userAddress1 = (String) session.getAttribute("userAddress1");
    String userAddress2 = (String) session.getAttribute("userAddress2");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 정보 수정</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/student/user/modify/modifyForm.css">
<script language="javascript" src="<%=request.getContextPath()%>/student/user/register/registerForm.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/common/common.css">
<script>
    const contextPath = '<%= request.getContextPath() %>';
</script>
</head>
<body>
    <!-- 헤더 -->
    <header>
        <% 
            if ("admin".equals(userId)) { 
        %>
            <jsp:include page="/include/header/admin/adminHeader.jsp" />
        <% 
            } else if (userId != null && !userId.isEmpty()) { 
        %>
            <jsp:include page="/include/header/login/loginHeader.jsp" />
        <% 
            } else { 
        %>
            <jsp:include page="/include/header/logout/logoutHeader.jsp" />
        <% 
            } 
        %>

    </header>
    
    <!-- 메인 -->
    <main>
        <jsp:include page="/include/slideShow/slideShow.jsp" />
        
        <section>

    <article class="regFormArticle">
        <h2 class="regTitle">회원정보 수정</h2>
        <form action="<%=request.getContextPath()%>/student/user/modify/modifyProc.jsp" method="post" name="modifyForm" enctype="multipart/form-data">
            <table class="boardTable">
                <tr>
                    <th>아이디</th>
                    <td><input type="text" name="id" value="<%=userId%>" class="inputField" readonly></td>
                </tr>
                <tr>
                    <th>비밀번호</th>
                    <td><input type="password" name="pass" placeholder="새 비밀번호 입력" class="inputField"></td>
                </tr>
                <tr>
                    <th>비밀번호 확인</th>
                    <td><input type="password" name="repass" placeholder="비밀번호 확인" class="inputField"></td>
                </tr>
                <tr>
                    <th>이름</th>
                    <td><input type="text" name="name" value="<%=userName%>" class="inputField"></td>
                </tr>
                <tr>
                    <th>전화번호</th>
                    <td>
                        <select name="phone1" class="selectField">
                            <option value="010" <%= "010".equals(userPhone1) ? "selected" : "" %>>010</option>
                            <option value="02" <%= "02".equals(userPhone1) ? "selected" : "" %>>02</option>
                        </select>
                        - <input type="text" name="phone2" value="<%=userPhone2%>" size="5" class="inputField">
                        - <input type="text" name="phone3" value="<%=userPhone3%>" size="5" class="inputField">
                    </td>
                </tr>
                <tr>
                    <th>이메일</th>
                    <td><input type="email" name="email" value="<%=userEmail%>" class="inputField"></td>
                </tr>
                <tr>
                    <th>우편번호</th>
                    <td>
                        <input type="text" name="zipcode" value="<%=userZipcode%>" class="inputField">
                        <button type="button" onclick="zipCheck()" class="btn">찾기</button>
                    </td>
                </tr>
                <tr>
                    <th>주소1</th>
                    <td><input type="text" name="address1" value="<%=userAddress1%>" size="50" class="inputField"></td>
                </tr>
                <tr>
                    <th>주소2</th>
                    <td><input type="text" name="address2" value="<%=userAddress2%>" size="50" class="inputField"></td>
                </tr>
                <tr>
                    <th>프로필 사진</th>
                    <td><input type="file" name="profileFile" class="inputField" accept="image/*"></td>
                </tr>
            </table>
            <div class="regButtonGroup">
                <button type="submit" class="modifyBtn" onClick="updateCheck()">회원정보 수정</button>
                <button type="reset" class="resetBtn">다시입력</button>
            </div>
        </form>
    </article>
        </section>
    </main>
    
    <footer>
        <jsp:include page="/include/footer/footer.jsp" />
    </footer>
</body>
</html>
 

