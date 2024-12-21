<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String userId = (String) session.getAttribute("userId");

    
    /*  userId = "admin";   */
/* 	userId = "jiyeon"; */
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Test Page</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/common/common.css"></link>
    <script language="javascript" src="<%=request.getContextPath()%>/common/common.js"></script>
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
    
    
	<!-- 메인 : slideShow  + section(aside +  -->
    <main>
        <jsp:include page="/include/slideShow/slideShow.jsp" />
        
        <section>
        <!-- 
        	<aside>
        		¿<%
        		 	if ("admin".equals(userId)) { 
        		%>
        			<jsp:include page="/include/aside/admin/adminAside.jsp" /> 
        		<% 
            		} else if (userId != null && !userId.isEmpty()) { 
        		%>
        			<jsp:include page="/include/aside/login/loginAside.jsp" /> 
        		<%	
            		} else { 
            	%>
                    <jsp:include page="/include/aside/logout/logoutAside.jsp" />
                <% 
            		}
        		%>
        		 
        	</aside>
        	
        	<article>
        	<div class="artiDiv">
        	<jsp:include page="/student/register/registerForm/registerForm.jsp" />
        	</div>
        	</article>
        	 -->
            
        </section>
    </main>
    
    <footer>
        <jsp:include page="/include/footer/footer.jsp" />
    </footer>
</body>
</html>
