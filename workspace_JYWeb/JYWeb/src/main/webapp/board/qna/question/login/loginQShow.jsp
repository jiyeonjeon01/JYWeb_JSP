<%@page import="co.kr.dev.board.login.LoginBoardVO"%>
<%@page import="co.kr.dev.board.login.LoginBoardDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
    String userId = (String) session.getAttribute("userId");
String role = (String) session.getAttribute("role");
%>
<%
request.setCharacterEncoding("UTF-8");

// 게시글 번호와 현재 페이지 번호 가져오기
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");


// VO와 DAO 초기화
LoginBoardDAO dao = LoginBoardDAO.getInstance();
LoginBoardVO vo = new LoginBoardVO();
vo.setNum(num);

//게시글 데이터 가져오기
LoginBoardVO post = dao.selectBoardDB(vo);
String questionTitle = post != null ? post.getTitle() : null;

//제목을 세션에 저장
if (questionTitle != null) {
 session.setAttribute("title", questionTitle);
} else {
 session.setAttribute("title", "제목 없음");
}


SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

// 기본 이미지 경로 설정
String defaultImagePath = request.getContextPath() + "/upload/default-image.jpg";

// 파일 경로 설정
String filePath = (post != null && post.getSysFile() != null && !post.getSysFile().isEmpty()) 
    ? request.getContextPath() + "/uploads/" + URLEncoder.encode(post.getSysFile(), "UTF-8")
    : defaultImagePath;

// 답글 관련 필드 초기화
int ref = post != null ? post.getRef() : 0;
int step = post != null ? post.getStep() : 0;
int depth = post != null ? post.getDepth() : 0;
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>질문 게시글 로그인 상세보기</title>
    
    <link rel="stylesheet" href="<%=request.getContextPath()%>/common/common.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/board/qna/question/login/loginQShow.css">
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
            <article class="loginQShowArti">
            <div class="loginQShowDiv">
            
                <h2 class="loginQShowTableTitle">게시글 상세보기</h2>

                
                <table class="loginQShowTableTop">
                    <tr>
                        <th class="loginQShowNum">글번호</th>
                        <td class="loginQShowNum2"><%= post != null ? post.getNum() : "정보 없음" %></td>
                    	<th class="loginQShowWriter">작성자</th>
                        <td class="loginQShowWriter2"><%= post != null ? post.getStudentId() : "정보 없음" %></td>	
                    </tr>
                    <tr>
                        <th class="loginQShowViews">조회수</th>
                        <td class="loginQShowViews2"><%= post != null ? post.getReadCount() : 0 %></td>
                        <th class="loginQShowDate">작성일</th>
                        <td class="loginQShowDate2"><%= post != null ? sdf.format(post.getRegDate()) : "정보 없음" %></td>
                    </tr>
                    </table>
                    <table  class="loginQShowTableBottom">
                    <tr>
                        <th class="loginQShowTitle">제목</th>
                        <td class="loginQShowTitle2"> <%= post.getTitle() != null ? post.getTitle() : "게시글이 존재하지 않습니다." %></td>
                    </tr>
                    <tr>
                        <th class="loginQShowContent">내용</th>
                        <td class="loginQShowContent2"><pre><%= post.getContent() != null ? post.getContent() : "내용이 없습니다." %></pre></td>
                    </tr>
                    <tr>
                        <th class="loginQShowFile">첨부파일</th>
                        <td class="loginQShowFile2">
                            <% if (post != null && post.getSysFile() != null && !post.getSysFile().isEmpty()) { %>
                                <img src="<%= filePath %>" alt="첨부된 이미지" class="attached-image">
                            <% } else { %>
                                첨부파일 없음
                            <% } %>
                        </td>
                    </tr>
					<tr>
					    <td colspan="2" class="loginQShowBtnTd">
					        <div class="loginQShowBtnWrapper">
					            <% 
					                // 글 작성자 확인
					                boolean isOwner = post != null && post.getStudentId() != null && post.getStudentId().equals(userId);
					                // 관리자 확인
					                boolean isAdmin = "ADMIN".equals(role);
					                
					                // 수정 버튼 조건: 작성자이거나 관리자
					                if (isOwner || isAdmin) { 
					            %>
					                <button class="loginQShowBtn" onclick="document.location.href='<%=request.getContextPath()%>/board/qna/question/login/update/updateForm.jsp?num=<%= num %>&pageNum=<%= pageNum %>'">수정하기</button>
					            <% } %>
					
					            <% 
					                // 삭제 버튼 조건: 작성자이거나 관리자
					                if (isOwner || isAdmin) { 
					            %>
					                <button class="loginQShowBtn" onclick="document.location.href='<%=request.getContextPath()%>/board/qna/question/login/delete/deleteProc.jsp?num=<%= num %>&pageNum=<%= pageNum %>'">삭제하기</button>
					            <% } %>
					
					            <% 
					                // 답변하기 버튼 조건: 관리자만
					                if (isAdmin) { 
					            %>
					                <button class="loginQShowBtn" onclick="document.location.href='<%=request.getContextPath()%>/board/qna/answer/write/answerForm.jsp?num=<%= num %>&ref=<%= ref %>&step=<%= step %>&depth=<%= depth %>'">답변하기</button>
					            <% } %>
					
					            <button class="loginQShowBtn" onclick="document.location.href='<%=request.getContextPath()%>/board/qna/qnaList.jsp?pageNum=<%= pageNum %>'">목록으로</button>
					        </div>
					    </td>
					</tr>
					



                </table>
                
                </div>
            </article>
        </section>
    </main>
    
    <footer>
        <jsp:include page="/include/footer/footer.jsp" />
    </footer>
</body>
</html>
