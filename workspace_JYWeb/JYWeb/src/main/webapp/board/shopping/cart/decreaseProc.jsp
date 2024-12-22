<%@page import="co.kr.dev.board.login.shopping.CartDAO"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    String userId = (String) session.getAttribute("userId");
    int productNum = Integer.parseInt(request.getParameter("productNum"));
    boolean remove = "true".equals(request.getParameter("remove"));

    CartDAO cartDAO = CartDAO.getInstance();

    if (remove) {
        cartDAO.deleteByProduct(userId, productNum); // 해당 상품을 장바구니에서 삭제
    } else {
        cartDAO.decreaseQuantity(userId, productNum); // 해당 상품의 수량 감소
    }

    response.sendRedirect(request.getContextPath() + "/board/shopping/cart/cartList.jsp");
%>
