<%@page import="co.kr.dev.board.login.shopping.CartDAO"%>
<%@page import="co.kr.dev.board.login.shopping.CartVO"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
    // 사용자 ID 확인
    String userId = (String) session.getAttribute("userId");
    if (userId == null || userId.isEmpty()) {
        // 로그인이 필요할 경우 로그인 페이지로 리다이렉트
        out.println("<script>alert('로그인이 필요합니다.'); location.href='" + request.getContextPath() + "/student/user/login/loginForm.jsp';</script>");
        return;
    }

    // 요청 파라미터 가져오기
    String productNumParam = request.getParameter("productNum");
    String quantityParam = request.getParameter("quantity");

    if (productNumParam == null || productNumParam.isEmpty() || quantityParam == null || quantityParam.isEmpty()) {
        // 유효하지 않은 요청
        out.println("<script>alert('유효하지 않은 요청입니다.'); history.back();</script>");
        return;
    }

    int productNum = Integer.parseInt(productNumParam);
    int quantity = Integer.parseInt(quantityParam);

    // 장바구니 데이터 설정
    CartVO cart = new CartVO();
    cart.setStudentId(userId);
    cart.setProductNum(productNum);
    cart.setQuantity(quantity);

    // 장바구니 추가
    CartDAO cartDAO = CartDAO.getInstance();
    boolean result = cartDAO.insert(cart);

    if (result) {
        // 성공 시 상품 목록 페이지로 이동
        out.println("<script>alert('장바구니에 상품이 담겼습니다.'); location.href='" + request.getContextPath() + "/board/shopping/product/productList.jsp';</script>");
    } else {
        // 실패 시 이전 페이지로 돌아가기
        out.println("<script>alert('장바구니 추가 실패. 다시 시도해 주세요.'); history.back();</script>");
    }
%>
