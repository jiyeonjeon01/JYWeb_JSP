<%@page import="co.kr.dev.board.login.LoginBoardVO"%>
<%@page import="co.kr.dev.board.login.LoginBoardDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

// 게시글 번호와 현재 페이지 번호 가져오기
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");

// VO와 DAO 초기화
LoginBoardDAO dao = LoginBoardDAO.getInstance();
LoginBoardVO vo = new LoginBoardVO();
vo.setNum(num);

// 게시글 데이터 가져오기
LoginBoardVO post = dao.selectBoardDB(vo);

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
    <title>자유게시판 글보기</title>
    <style>
        .attached-image {
            max-width: 400px;
            max-height: 300px;
            display: block;
            margin: 10px auto;
        }
    </style>
</head>
<body>
    <main>
        <h2 style="text-align: center;">게시글 상세보기</h2>
        <table width="500" border="1" cellspacing="0" cellpadding="10" align="center">
            <tr>
                <th width="125">글번호</th>
                <td width="375"><%= post != null ? post.getNum() : "정보 없음" %></td>
            </tr>
            <tr>
                <th>작성자</th>
                <td><%= post != null ? post.getStudentId() : "정보 없음" %></td>
            </tr>
            <tr>
                <th>조회수</th>
                <td><%= post != null ? post.getReadCount() : 0 %></td>
            </tr>
            <tr>
                <th>작성일</th>
                <td><%= post != null ? sdf.format(post.getRegDate()) : "정보 없음" %></td>
            </tr>
            <tr>
                <th>제목</th>
                <td><%= post != null ? post.getTitle() : "정보 없음" %></td>
            </tr>
            <tr>
                <th>내용</th>
                <td><pre><%= post != null ? post.getContent() : "내용이 없습니다." %></pre></td>
            </tr>
            <tr>
                <th>첨부파일</th>
                <td>
                    <% if (post != null && post.getSysFile() != null && !post.getSysFile().isEmpty()) { %>
                        <img src="<%= filePath %>" alt="첨부된 이미지" class="attached-image">
                    <% } else { %>
                        첨부파일 없음
                    <% } %>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <input type="button" value="수정하기" onclick="document.location.href='<%=request.getContextPath()%>/board/normal/update/updateForm.jsp?num=<%= num %>&pageNum=<%= pageNum %>'">
                    <input type="button" value="삭제하기" onclick="document.location.href='<%=request.getContextPath()%>/board/normal/delete/deleteProc.jsp?num=<%= num %>&pageNum=<%= pageNum %>'">
                    <input type="button" value="답글쓰기" 
                        onclick="document.location.href='<%=request.getContextPath()%>/board/normal/write/normalForm.jsp?num=<%= num %>&ref=<%= ref %>&step=<%= step %>&depth=<%= depth %>'">
                    <input type="button" value="목록으로" onclick="document.location.href='<%=request.getContextPath()%>/board/normal/normalList.jsp?pageNum=<%= pageNum %>'">
                </td>
            </tr>
        </table>
    </main>
</body>
</html>
