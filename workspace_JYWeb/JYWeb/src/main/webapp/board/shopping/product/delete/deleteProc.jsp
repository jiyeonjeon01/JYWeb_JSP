<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="co.kr.dev.board.login.shopping.ProductDAO" %>
<%@ page import="java.io.File" %>

<%
    // 로그인 상태와 role 확인
    String userId = (String) session.getAttribute("userId");
    String role = (String) session.getAttribute("role");

    // 관리자 권한 확인
    if (userId == null || userId.isEmpty() || !"ADMIN".equalsIgnoreCase(role)) {
        session.setAttribute("redirectUrl", request.getRequestURI());
        response.sendRedirect(request.getContextPath() + "/student/user/login/loginForm.jsp");
        return;
    }

    // 삭제할 상품 번호 가져오기
    String productNumParam = request.getParameter("productNum");
    if (productNumParam == null || productNumParam.isEmpty()) {
        response.sendRedirect(request.getContextPath() + "/board/shopping/product/productList.jsp");
        return;
    }

    int productNum = Integer.parseInt(productNumParam);

    // DAO를 통해 상품 정보 삭제
    ProductDAO productDAO = ProductDAO.getInstance();
    boolean isDeleted = productDAO.delete(productNum);

    if (isDeleted) {
        // 삭제 성공 시 목록 페이지로 이동
        response.sendRedirect(request.getContextPath() + "/board/shopping/product/productList.jsp");
    } else {
        // 삭제 실패 시 오류 메시지 출력
        out.println("<script>alert('상품 삭제 실패'); history.back();</script>");
    }
%>
