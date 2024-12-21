<%@page import="co.kr.dev.student.model.StudentVO"%>
<%@page import="co.kr.dev.student.model.StudentDAO"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<!-- 1.사용자정보를 가져온다  -->
<!-- 2.curd  -->
<%
	request.setCharacterEncoding("UTF-8"); 
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	StudentDAO sdao = new StudentDAO();
	StudentVO svo = new StudentVO();
	svo.setId(id); 
	svo.setPass(pass);
	int check = sdao.selectLoginCheck(svo);  
%>
<!-- 3.화면설계(자바코드에 해야되는데 - > jsp service함수에서 진행한다. -->
<%
if(check == 1){//로그인 성공
		session.setAttribute("id", id);
		session.setAttribute("pass", pass);
		response.sendRedirect("login.jsp");
}else if(check == 0){//아이디는 있는데 비밀번호 오류
%>
<script>
		alert("비밀번호가 틀렸습니다");
		history.go(-1);
</script>
<% 
} else{//아이디 자체가 존재하지 않는 경우
%>
	<script>
		alert("아이디가 존재하지 않습니다");
		history.go(-1);
	</script>
<%
}
%>