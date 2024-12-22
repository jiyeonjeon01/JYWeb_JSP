<%@ page contentType="text/html; charset=UTF-8"%>
<!-- 1. 세션 무효화 -->
<%
session.invalidate();
%>
<!-- 2. 메인 페이지로 리다이렉트 -->
<%
response.sendRedirect(request.getContextPath() + "/test.jsp");
%>
