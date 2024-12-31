<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="co.kr.dev.board.login.shopping.ProductDAO" %>
<%@ page import="co.kr.dev.board.login.shopping.ProductVO" %>
<%@ page import="java.util.List" %>

<%
    String userId = (String) session.getAttribute("userId");
    String role = (String) session.getAttribute("role");
%>
<%
    // DAO 인스턴스 생성
    ProductDAO productDAO = ProductDAO.getInstance();

    // 상품 목록 조회
    List<ProductVO> productList = productDAO.selectAll();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>상품 목록</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/board/shopping/product/productList.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/common/common.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/custom/recentPosts.css">
</head>
<body>
    <!-- 헤더 -->
    <header>
        <% 
            if ("admin".equalsIgnoreCase(role)) { 
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
        <article class="product-list-container">
	    <div class="productBoardTitle">
	        <span class="productBoardTitleSpan">상품 목록</span>
	    </div>
	    <div class="product-list">
	        <%
	            if (productList.isEmpty()) {
	        %>
	        <p style="text-align: center; color: #666;">등록된 상품이 없습니다.</p>
	        <%
	            } else {
	                for (ProductVO product : productList) {
	        %>
	        <div class="product-item">
	            <div class="product-image">
	                <%
	                    if (product.getSysFile() != null && !product.getSysFile().isEmpty()) {
	                %>
	                <img src="<%=request.getContextPath()%>/uploads/<%= product.getSysFile() %>" alt="상품 이미지">
	                <%
	                    } else {
	                %>
	                <img src="<%=request.getContextPath()%>/images/no-image.png" alt="이미지 없음">
	                <%
	                    }
	                %>
	            </div>
	            <div class="product-details">
	                <p class="product-name"><%= product.getName() %></p>
	                <p class="product-price">가격: <%= product.getPrice() %>원</p>
	                <p class="product-description"><%= product.getDetail() %></p>
	                <!-- 관리자용 버튼 -->
	                <%
	                    if ("admin".equalsIgnoreCase(role)) {
	                %>
	                <div class="admin-buttons">
	                    <form method="get" action="<%=request.getContextPath()%>/board/shopping/product/update/updateForm.jsp" style="display: inline;">
	                        <input type="hidden" name="productNum" value="<%= product.getNum() %>">
	                        <button type="submit" class="admin-button update">수정</button>
	                    </form>
	                    <form method="post" action="<%=request.getContextPath()%>/board/shopping/product/delete/deleteProc.jsp" style="display: inline;">
	                        <input type="hidden" name="productNum" value="<%= product.getNum() %>">
	                        <button type="submit" class="admin-button delete" onclick="return confirm('상품을 삭제하시겠습니까?');">삭제</button>
	                    </form>
	                </div>
	                <%
	                    }
	                %>
	                <!-- 카트에 담기 -->
	                <form method="post" action="<%=request.getContextPath()%>/board/shopping/cart/cartProc.jsp">
	                    <input type="hidden" name="productNum" value="<%= product.getNum() %>">
	                    <label for="quantity-<%= product.getNum() %>">수량:</label>
	                    <select name="quantity" id="quantity-<%= product.getNum() %>" class="quantity-select">
	                        <% for (int i = 1; i <= 10; i++) { %>
	                        <option value="<%= i %>"><%= i %></option>
	                        <% } %>
	                    </select>
	                    <button type="submit" class="add-to-cart-button">카트에 담기</button>
	                </form>
	            </div>
	        </div>
	        <%
	                }
	            }
	        %>
	    </div>
	</article>


        
        </section>
    </main>
    
    <footer>
        <jsp:include page="/include/footer/footer.jsp" />
    </footer>
</body>
</html>
