<%@page import="co.kr.dev.board.login.shopping.CartDAO"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    String userId = (String) session.getAttribute("userId");
    int productNum = Integer.parseInt(request.getParameter("productNum"));

    CartDAO cartDAO = CartDAO.getInstance();
    cartDAO.increaseQuantity(userId, productNum); // 해당 상품의 수량 증가

    response.sendRedirect(request.getContextPath() + "/board/shopping/cart/cartList.jsp");
%>
