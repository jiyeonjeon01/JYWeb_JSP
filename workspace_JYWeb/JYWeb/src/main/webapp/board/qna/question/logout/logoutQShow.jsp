<%@page import="co.kr.dev.board.logout.LogoutBoardVO"%>
<%@page import="co.kr.dev.board.logout.LogoutBoardDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");

    // 세션에서 사용자 정보 가져오기
    String userId = (String) session.getAttribute("userId");
    String role = (String) session.getAttribute("role");

    // 디버깅 출력
    System.out.println("[DEBUG] Session userId: " + userId);
    System.out.println("[DEBUG] Session role: " + role);

    // 게시글 번호와 현재 페이지 번호 가져오기
    int num = Integer.parseInt(request.getParameter("num"));
    String pageNum = request.getParameter("pageNum");

    // VO와 DAO 초기화
    LogoutBoardDAO dao = LogoutBoardDAO.getInstance();
    LogoutBoardVO vo = new LogoutBoardVO();
    vo.setNum(num);

    // 게시글 데이터 가져오기
    LogoutBoardVO post = dao.selectBoardDB(vo);
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    // 기본 이미지 경로 설정
    String defaultImagePath = request.getContextPath() + "/upload/default-image.jpg";
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
    <title>질문 게시판 로그아웃 게시글 상세보기</title>
    
    <link rel="stylesheet" href="<%=request.getContextPath()%>/common/common.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/board/qna/question/logout/logoutQShow.css">
</head>
<body>
    <!-- 헤더 -->
    <header>
        <% 
            if ("ADMIN".equals(role)) { 
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
            <article class="logoutQShowArti">
                <div class="logoutQShowDiv">
                    <h2 class="logoutQShowTableTitle">게시글 상세보기</h2>
                    
                    <table class="logoutQShowTableTop">
                        <tr>
                            <th class="logoutQShowNum">글번호</th>
                            <td class="logoutQShowNum2"><%= post != null ? post.getNum() : "정보 없음" %></td>
                            <th class="logoutQShowWriter">작성자</th>
                            <td class="logoutQShowWriter2"><%= post != null ? post.getWriter() : "정보 없음" %></td>	
                        </tr>
                        <tr>
                            <th class="logoutQShowViews">조회수</th>
                            <td class="logoutQShowViews2"><%= post != null ? post.getReadCount() : 0 %></td>
                            <th class="logoutQShowDate">작성일</th>
                            <td class="logoutQShowDate2"><%= post != null ? sdf.format(post.getRegDate()) : "정보 없음" %></td>
                        </tr>
                    </table>
                    <table class="logoutQShowTableBottom">
                        <tr>
                            <th class="logoutQShowTitle">제목</th>
                            <td class="logoutQShowTitle2"><%= post.getTitle() != null ? post.getTitle() : "게시글이 존재하지 않습니다." %></td>
                        </tr>
                        <tr>
                            <th class="logoutQShowContent">내용</th>
                            <td class="logoutQShowContent2"><pre><%= post.getContent() != null ? post.getContent() : "내용이 없습니다." %></pre></td>
                        </tr>
                        <tr>
                            <th class="logoutQShowFile">첨부파일</th>
                            <td class="logoutQShowFile2">
                                <% if (post != null && post.getSysFile() != null && !post.getSysFile().isEmpty()) { %>
                                    <img src="<%= filePath %>" alt="첨부된 이미지" class="attached-image">
                                <% } else { %>
                                    첨부파일 없음
                                <% } %>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="logoutQShowBtnTd">
                                <div class="logoutQShowBtnWrapper">
                                    <button class="logoutQShowBtn" onclick="document.location.href='<%=request.getContextPath()%>/board/qna/question/logout/update/updateForm.jsp?num=<%= num %>&pageNum=<%= pageNum %>'">수정하기</button>
                                    <button class="logoutQShowBtn" onclick="document.location.href='<%= "ADMIN".equals(role) ? request.getContextPath() + "/board/qna/question/logout/delete/deleteProc.jsp?num=" + num + "&pageNum=" + pageNum : request.getContextPath() + "/board/qna/question/logout/delete/deletePasswordForm.jsp?num=" + num + "&pageNum=" + pageNum %>'">삭제하기</button>
                                    
                                    <% if ("ADMIN".equals(role)) { %>
                                        <% System.out.println("[DEBUG] 답변하기 버튼 표시: ADMIN 권한 확인됨"); %>
                                        <button class="logoutQShowBtn" onclick="document.location.href='<%=request.getContextPath()%>/board/qna/answer/write/answerForm.jsp?num=<%= num %>&ref=<%= ref %>&step=<%= step %>&depth=<%= depth %>'">답변하기</button>
                                    <% } else { %>
                                        <% System.out.println("[DEBUG] 답변하기 버튼 숨김: 사용자 권한 = " + role); %>
                                    <% } %>
                                    
                                    <button class="logoutQShowBtn" onclick="document.location.href='<%=request.getContextPath()%>/board/qna/qnaList.jsp?pageNum=<%= pageNum %>'">목록으로</button>
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
