<%-- <%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>

<%


    // 로그인 상태와 role 확인
    String userId = (String) session.getAttribute("userId");
    String role = (String) session.getAttribute("role");

    System.out.println("productForm.jsp 접근: userId=" + session.getAttribute("userId") + ", role=" + session.getAttribute("role"));

    
 // 로그인되지 않거나 admin이 아닌 경우 로그인 페이지로 리다이렉트
    if (userId == null || userId.isEmpty() || !"ADMIN".equals(role)) {
        session.setAttribute("redirectUrl", request.getRequestURI());
        response.sendRedirect(request.getContextPath() + "/student/user/login/loginForm.jsp");
        return;
    }

    System.out.println("userId: " + userId);
    System.out.println("role: " + role);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>상품 등록</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/board/shopping/product/write/productForm.css"> 
    
    <script>
        function validateForm() {
            if (document.productForm.name.value.trim() === "") {
                alert("상품 이름을 입력하세요.");
                document.productForm.name.focus();
                return false;
            }
            if (document.productForm.price.value.trim() === "" || isNaN(document.productForm.price.value)) {
                alert("상품 가격을 올바르게 입력하세요.");
                document.productForm.price.focus();
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <article class="productFormArticle">
        <h2 class="productTitle">상품 등록</h2>
        <form name="productForm" method="post" action="productProc.jsp" enctype="multipart/form-data" onsubmit="return validateForm()">
            <table class="productTable">
                <tr>
                    <th>상품 이름</th>
                    <td>
                        <input type="text" name="name" class="inputField" maxlength="40">
                    </td>
                </tr>
                <tr>
                    <th>상품 가격</th>
                    <td>
                        <input type="text" name="price" class="inputField" maxlength="15">
                    </td>
                </tr>
                <tr>
                    <th>상품 설명</th>
                    <td>
                        <textarea name="detail" class="textArea" rows="5" maxlength="300"></textarea>
                    </td>
                </tr>
                <tr>
                    <th>첨부파일</th>
                    <td>
                        <input type="file" name="originFile" class="inputField" accept="image/*">
                    </td>
                </tr>
            </table>
            <div class="productButtonGroup">
                <button type="submit" class="productButton submit">등록</button>
                <button type="reset" class="productButton reset">초기화</button>
                <button type="button" class="productButton list" onclick="window.location='productList.jsp'">목록</button>
            </div>
        </form>
    </article>
</body>
</html> --%>


















 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="co.kr.dev.board.login.LoginBoardDAO, java.util.List, co.kr.dev.board.login.LoginBoardVO" %>
 <%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="co.kr.dev.board.login.LoginBoardDAO" %>
<%@ page import="co.kr.dev.board.login.LoginBoardVO" %>
<%-- <%
    // 로그인 상태 확인
    String userId = (String) session.getAttribute("userId");
    if (userId == null || userId.isEmpty()) {
        response.sendRedirect(request.getContextPath() + "/student/user/login/loginForm.jsp");
        return;
    }

    // 게시글 관련 데이터 초기화
    int num = 0, ref = 0, step = 0, depth = 0;
    try {
        if (request.getParameter("num") != null) {
            num = Integer.parseInt(request.getParameter("num"));
            ref = Integer.parseInt(request.getParameter("ref"));
            step = Integer.parseInt(request.getParameter("step"));
            depth = Integer.parseInt(request.getParameter("depth"));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%> --%>
<%


    // 로그인 상태와 role 확인
    String userId = (String) session.getAttribute("userId");
    String role = (String) session.getAttribute("role");

    System.out.println("productForm.jsp 접근: userId=" + session.getAttribute("userId") + ", role=" + session.getAttribute("role"));

    
 // 로그인되지 않거나 admin이 아닌 경우 로그인 페이지로 리다이렉트
    if (userId == null || userId.isEmpty() || !"ADMIN".equals(role)) {
        session.setAttribute("redirectUrl", request.getRequestURI());
        response.sendRedirect(request.getContextPath() + "/student/user/login/loginForm.jsp");
        return;
    }

    System.out.println("userId: " + userId);
    System.out.println("role: " + role);
%> 
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Test Page</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/common/common.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/custom/recentPosts.css">
 <link rel="stylesheet" href="<%=request.getContextPath()%>/board/shopping/product/write/productForm.css"> 
    
    <script>
        function validateForm() {
            if (document.productForm.name.value.trim() === "") {
                alert("상품 이름을 입력하세요.");
                document.productForm.name.focus();
                return false;
            }
            if (document.productForm.price.value.trim() === "" || isNaN(document.productForm.price.value)) {
                alert("상품 가격을 올바르게 입력하세요.");
                document.productForm.price.focus();
                return false;
            }
            return true;
        }
    </script>
<style>



</style></head>
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

 <article class="productFormArticle">
        <h2 class="productTitle">상품 등록</h2>
        <form name="productForm" method="post" action="productProc.jsp" enctype="multipart/form-data" onsubmit="return validateForm()">
            <table class="productTable">
                <tr>
                    <th>상품 이름</th>
                    <td>
                        <input type="text" name="name" class="inputField" maxlength="40">
                    </td>
                </tr>
                <tr>
                    <th>상품 가격</th>
                    <td>
                        <input type="text" name="price" class="inputField" maxlength="15">
                    </td>
                </tr>
                <tr>
                    <th>상품 설명</th>
                    <td>
                        <textarea name="detail" class="textArea" rows="5" maxlength="300"></textarea>
                    </td>
                </tr>
                <tr>
                    <th>첨부파일</th>
                    <td>
                        <input type="file" name="originFile" class="inputField" accept="image/*">
                    </td>
                </tr>
            </table>
            <div class="productButtonGroup">
                <button type="submit" class="productButton submit">등록</button>
                <button type="reset" class="productButton reset">초기화</button>
                <button type="button" class="productButton list" onclick="window.location='productList.jsp'">목록</button>
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
 


