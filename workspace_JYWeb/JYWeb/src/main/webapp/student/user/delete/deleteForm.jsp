<%-- <%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>회원탈퇴</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/student/user/delete/deleteForm.css">
<style>

</style>
<script>
    function begin() {
        document.myForm.pass.focus();
    }
    function checkPass() {
        if (!document.myForm.pass.value) {
            alert("비밀번호를 입력하지 않았습니다");
            document.myForm.pass.focus();
            return false;
        }
    }
</script>
</head>
<body onload="begin()">
  <article class="deleteFormArticle">
    <h2 class="deleteTitle">회원 탈퇴</h2>
    <form name="myForm" method="post" action="<%=request.getContextPath()%>/student/user/delete/deleteProc.jsp" onsubmit="return checkPass()">
        <table class="deleteTable">
            <tr>
                <td><b>비밀번호 입력</b></td>
                <td><input type="password" name="pass" class="inputField"></td>
            </tr>
        </table>
        <div class="deleteButtonGroup">
            <input type="submit" value="회원탈퇴" class="deleteBtn">
            <button type="button" class="cancelBtn" onclick="window.location='<%=request.getContextPath()%>/student/user/myPage/showMyPage.jsp'">취소</button>
        </div>
    </form>
  </article>
</body>
</html>
 --%>














 
 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="co.kr.dev.board.login.LoginBoardDAO, java.util.List, co.kr.dev.board.login.LoginBoardVO" %>
<%
    // DAO 인스턴스 생성
    LoginBoardDAO loginBoardDAO = LoginBoardDAO.getInstance();

    // 최근 게시물 10개 불러오기
    List<LoginBoardVO> recentPosts = loginBoardDAO.selectRecentPosts(10); 
%>
<%
    String userId = (String) session.getAttribute("userId");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Test Page</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/common/common.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/custom/recentPosts.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/student/user/delete/deleteForm.css">
<style>

</style>
<script>
    function begin() {
        document.myForm.pass.focus();
    }
    function checkPass() {
        if (!document.myForm.pass.value) {
            alert("비밀번호를 입력하지 않았습니다");
            document.myForm.pass.focus();
            return false;
        }
    }
</script>
</head>
<body onload="begin()">
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

  <article class="deleteFormArticle">
    <h2 class="deleteTitle">회원 탈퇴</h2>
    <form name="myForm" method="post" action="<%=request.getContextPath()%>/student/user/delete/deleteProc.jsp" onsubmit="return checkPass()">
        <table class="deleteTable">
            <tr>
                <td><b>비밀번호 입력</b></td>
                <td><input type="password" name="pass" class="inputField"></td>
            </tr>
        </table>
        <div class="deleteButtonGroup">
            <input type="submit" value="회원탈퇴" class="deleteBtn">
            <button type="button" class="cancelBtn" onclick="window.location='<%=request.getContextPath()%>/student/user/myPage/showMyPage.jsp'">취소</button>
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
 

