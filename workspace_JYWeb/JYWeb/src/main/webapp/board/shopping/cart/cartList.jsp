<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="co.kr.dev.board.login.shopping.CartVO" %>
<%@ page import="co.kr.dev.board.login.shopping.CartDAO" %>
<%@ page import="co.kr.dev.board.login.shopping.ProductDAO" %>
<%@ page import="co.kr.dev.board.login.shopping.ProductVO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>

<%
    String userId = (String) session.getAttribute("userId");

    // 로그인 확인
    if (userId == null || userId.isEmpty()) {
        out.println("<script>alert('로그인이 필요합니다.'); location.href='" + request.getContextPath() + "/student/user/login/loginForm.jsp';</script>");
        return;
    }

    // DAO 인스턴스 생성
    CartDAO cartDAO = CartDAO.getInstance();
    ProductDAO productDAO = ProductDAO.getInstance();

    // 사용자 카트 목록 조회
    List<CartVO> cartList = cartDAO.selectAll(userId);

    // 상품 ID별 수량 및 상품 정보 매핑
    Map<Integer, Integer> quantityMap = new HashMap<>();
    Map<Integer, ProductVO> productMap = new HashMap<>();

    for (CartVO cart : cartList) {
        int productNum = cart.getProductNum();
        int quantity = cart.getQuantity();

        // 수량 합산
        quantityMap.put(productNum, quantityMap.getOrDefault(productNum, 0) + quantity);

        // 상품 정보 가져오기 (없으면 DB 조회)
        if (!productMap.containsKey(productNum)) {
            ProductVO product = productDAO.selectOne(productNum);
            if (product != null) {
                productMap.put(productNum, product);
            }
        }
    }

    // 총 가격 계산
    int totalPrice = 0;
    for (Map.Entry<Integer, Integer> entry : quantityMap.entrySet()) {
        int productNum = entry.getKey();
        int quantity = entry.getValue();
        ProductVO product = productMap.get(productNum);

        if (product != null) {
            totalPrice += product.getPrice() * quantity;
        }
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>장바구니</title>
    
    <link rel="stylesheet" href="<%=request.getContextPath()%>/common/common.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/custom/recentPosts.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/board/shopping/cart/cartList.css">
    <script>
        // 수량 감소 처리
        function decreaseQuantity(productNum, quantity) {
            if (quantity === 1) {
                if (confirm("이 상품을 장바구니에서 제거하시겠습니까?")) {
                    location.href = `<%=request.getContextPath()%>/board/shopping/cart/decreaseProc.jsp?productNum=${productNum}&remove=true`;
                }
            } else {
                location.href = `<%=request.getContextPath()%>/board/shopping/cart/decreaseProc.jsp?productNum=${productNum}`;
            }
        }

        // 수량 증가 처리
        function increaseQuantity(productNum) {
            location.href = `<%=request.getContextPath()%>/board/shopping/cart/increaseProc.jsp?productNum=${productNum}`;
        }
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
        <article>
        <h2 style="text-align: center;">장바구니</h2>
        <div class="cart-list">
            <%
                if (cartList.isEmpty()) {
            %>
            <p style="text-align: center;">장바구니에 담긴 상품이 없습니다.</p>
            <%
                } else {
                    for (Map.Entry<Integer, Integer> entry : quantityMap.entrySet()) {
                        int productNum = entry.getKey();
                        int quantity = entry.getValue();
                        ProductVO product = productMap.get(productNum);

                        if (product != null) {
            %>
            <div class="cart-item">
                <div class="product-image">
                    <img src="<%=request.getContextPath()%>/uploads/<%= product.getSysFile() %>" alt="상품 이미지">
                </div>
                <div class="product-details">
                    <p class="product-name"><%= product.getName() %></p>
                    <p class="product-price">가격: <%= product.getPrice() %>원</p>
                    <div class="quantity-controls">
                        <button onclick="decreaseQuantity(<%= productNum %>, <%= quantity %>)">-</button>
                        <span><%= quantity %></span>
                        <button onclick="increaseQuantity(<%= productNum %>)">+</button>
                    </div>
                    <p class="product-total-price">합계: <%= product.getPrice() * quantity %>원</p>
                </div>
            </div>
            <%
                        }
                    }
                }
            %>
        </div>
        <div class="total-price">
            <h3>총 가격: <%= totalPrice %>원</h3>
        </div>
        </article>
      </section>
    </main>
    
    <footer>
        <jsp:include page="/include/footer/footer.jsp" />
    </footer>
</body>
</html>
