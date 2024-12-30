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
    <title>답변 게시글 상세보기</title>
    
    <link rel="stylesheet" href="<%=request.getContextPath()%>/common/common.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/board/qna/answer/answerShow.css">
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
            <article class="answerShowArti">
            <div class="answerShowDiv">
            
                <h2 class="answerShowTableTitle">게시글 상세보기</h2>

                
                <table class="answerShowTableTop">
                    <tr>
                        <th class="answerShowNum">글번호</th>
                        <td class="answerShowNum2"><%= post != null ? post.getNum() : "정보 없음" %></td>
                    	<th class="answerShowWriter">작성자</th>
                        <td class="answerShowWriter2"><%= post != null ? post.getStudentId() : "정보 없음" %></td>	
                    </tr>
                    <tr>
                        <th class="answerShowViews">조회수</th>
                        <td class="answerShowViews2"><%= post != null ? post.getReadCount() : 0 %></td>
                        <th class="answerShowDate">작성일</th>
                        <td class="answerShowDate2"><%= post != null ? sdf.format(post.getRegDate()) : "정보 없음" %></td>
                    </tr>
                    </table>
                    <table  class="answerShowTableBottom">
                    <tr>
                        <th class="answerShowTitle">제목</th>
                        <td class="answerShowTitle2"> <%= post.getTitle() != null ? post.getTitle() : "게시글이 존재하지 않습니다." %></td>
                    </tr>
                    <tr>
                        <th class="answerShowContent">내용</th>
                        <td class="answerShowContent2"><pre><%= post.getContent() != null ? post.getContent() : "내용이 없습니다." %></pre></td>
                    </tr>
                    <tr>
                        <th class="answerShowFile">첨부파일</th>
                        <td class="answerShowFile2">
                            <% if (post != null && post.getSysFile() != null && !post.getSysFile().isEmpty()) { %>
                                <img src="<%= filePath %>" alt="첨부된 이미지" class="attached-image">
                            <% } else { %>
                                첨부파일 없음
                            <% } %>
                        </td>
                    </tr>
					<tr>
					    <td colspan="2" class="answerShowBtnTd">
					        <div class="answerShowBtnWrapper">
					            <button class="answerShowBtn" onclick="document.location.href='<%=request.getContextPath()%>/board/qna/answer/update/updateForm.jsp?num=<%= num %>&pageNum=<%= pageNum %>'">수정하기</button>
					
					            <% 
					                // 삭제 버튼 조건: ADMIN이거나 studentId가 일치하는 경우
					                boolean isOwner = post != null && post.getStudentId() != null && post.getStudentId().equals(userId);
					                boolean isAdmin = "ADMIN".equals(role);
					
					                if (isOwner || isAdmin) { 
					            %>
					                <button class="answerShowBtn" onclick="document.location.href='<%=request.getContextPath()%>/board/qna/answer/delete/deleteProc.jsp?num=<%= num %>&pageNum=<%= pageNum %>'">삭제하기</button>
					            <% } %>
				
					
					            <button class="answerShowBtn" onclick="document.location.href='<%=request.getContextPath()%>/board/qna/qnaList.jsp?pageNum=<%= pageNum %>'">목록으로</button>
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
