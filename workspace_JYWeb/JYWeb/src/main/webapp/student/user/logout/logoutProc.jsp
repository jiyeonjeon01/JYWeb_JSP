<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 세션 무효화
    session.invalidate();

    // 로그아웃 후 이동할 페이지 설정
    String redirectPage = request.getContextPath() + "/index.jsp";

    // 리다이렉트 처리
    response.sendRedirect(redirectPage);
%>
