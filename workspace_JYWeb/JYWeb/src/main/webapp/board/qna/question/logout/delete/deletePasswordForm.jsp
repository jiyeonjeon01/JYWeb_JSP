<%@ page contentType="text/html; charset=UTF-8"%>

<%
    String userId = (String) session.getAttribute("userId");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>비밀번호 확인</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/common/common.css">
    <style>
        /* 폼 스타일 */
        .passwordFormWrapper {
            width: 100%;
            max-width: 400px;
            margin: 50px auto;
            border: 1px solid #ddd;
            border-radius: 10px;
            background-color: #f9f9f9;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
            padding: 30px;
            box-sizing: border-box;
            text-align: center;
        }

        .passwordFormTitle {
            font-size: 1.8em;
            color: #333;
            margin-bottom: 20px;
        }

        .passwordTable {
            width: 100%;
            margin: 0 auto;
            border-collapse: collapse;
        }

        .passwordTable th, .passwordTable td {
            padding: 15px;
            font-size: 1em;
            vertical-align: middle;
        }

        .passwordTable th {
            background-color: #d2e5ee;
            color: #333;
            text-align: center;
            font-weight: bold;
            width: 30%;
        }

        .passwordTable td {
            background-color: #f9f9f9;
            text-align: left;
        }

        .inputField {
            width: 100%;
            padding: 10px;
            font-size: 1em;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        .buttonGroup {
            text-align: center;
            margin-top: 20px;
        }

        .submitBtn, .cancelBtn {
            padding: 10px 20px;
            font-size: 1em;
            background-color: #d2e5ee;
            color: #333;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            text-decoration: none;
        }

        .submitBtn:hover {
            background-color: #b0d4e3;
        }

        .cancelBtn {
            background-color: #dadada;
            color: black;
        }

        .cancelBtn:hover {
            background-color: #b1b1b1;
        }
    </style>
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
            <div class="passwordFormWrapper">
                <h2 class="passwordFormTitle">비밀번호 확인</h2>
                <form action="<%=request.getContextPath()%>/board/qna/question/logout/delete/deleteProc2.jsp" method="post">
                    <input type="hidden" name="num" value="<%= request.getParameter("num") %>">
                    <input type="hidden" name="pageNum" value="<%= request.getParameter("pageNum") %>">
                    <table class="passwordTable">
                        <tr>
                            <th>비밀번호</th>
                            <td><input type="password" name="pass" placeholder="비밀번호 입력" required class="inputField"></td>
                        </tr>
                    </table>
                    <div class="buttonGroup">
                        <button type="submit" class="submitBtn">확인</button>
                        <button type="button" class="cancelBtn" onclick="history.back();">취소</button>
                    </div>
                </form>
            </div>
            
        </section>
    </main>
    
    <footer>
        <jsp:include page="/include/footer/footer.jsp" />
    </footer>
</body>
</html>