<%@page import="co.kr.dev.student.model.StudentDAO"%>
<%@page import="co.kr.dev.student.model.ZipcodeVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%
// 입력값 처리
request.setCharacterEncoding("UTF-8");
String dong = request.getParameter("dong");
String check = request.getParameter("check");
ArrayList<ZipcodeVO> zipList = null;

// check 값이 "n"일 경우만 처리
if ("n".equals(check)) {
    if (dong != null && !dong.trim().isEmpty()) {
        ZipcodeVO zvo = new ZipcodeVO();
        zvo.setDong(dong);
        StudentDAO sdao = new StudentDAO();
        zipList = sdao.selectZipCode(zvo); // DAO 호출
    } else {
        zipList = new ArrayList<>();
    }
}
%>


<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>우편번호 찾기</title>
<script language="javascript"
	src="<%=request.getContextPath()%>/student/user/register/registerForm.js"></script>
</head>
<body>
	<h2>우편번호 찾기</h2>
	<form name="zipForm" method="post" action="zipCheck.jsp">
		<input type="hidden" name="check" value="n"> <label for="dong">동
			이름 입력:</label> <input type="text" name="dong" id="dong" placeholder="예: 방배동"
			required>
		<button type="button" onclick="document.zipForm.submit()">검색</button>
	</form>

	<%
	if (zipList != null && !zipList.isEmpty()) {
	%>
	<p>※ 검색 결과를 클릭하면 주소가 입력됩니다.</p>
	<table border="1" style="width: 100%; text-align: center;">
		<tr>
			<th>우편번호</th>
			<th>주소</th>
		</tr>
		<%
		for (ZipcodeVO data : zipList) {
			String tempZipcode = data.getZipcode();
			String tempSido = data.getSido();
			String tempGugun = data.getGugun();
			String tempDong = data.getDong();
			String tempBunji = data.getBunji();
			if (tempBunji == null)
				tempBunji = "";
		%>
		<tr>
			<td><a
				href="javascript:sendAddress('<%=tempZipcode%>', '<%=tempSido.replace("'", "\\'")%>', '<%=tempGugun.replace("'", "\\'")%>', '<%=tempDong.replace("'", "\\'")%>', '<%=tempBunji.replace("'", "\\'")%>')">
					<%=tempZipcode%>
			</a></td>
			<td><%=tempSido + " " + tempGugun + " " + tempDong + " " + tempBunji%></td>
		</tr>
		<%
		}
		%>
	</table>
	<%
	} else {
	%>
	<p>검색된 결과가 없습니다.</p>
	<%
	}
	%>
</body>
</html>
