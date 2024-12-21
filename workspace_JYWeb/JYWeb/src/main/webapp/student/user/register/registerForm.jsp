<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/student/user/register/registerForm.css">
<script language="javascript"
	src="<%=request.getContextPath()%>/student/user/register/registerForm.js"></script>
<script>
        const contextPath = "<%=request.getContextPath()%>
	";
</script>
<style>
/* 회원가입 폼 전체 스타일 */
.regFormArticle {
	width: 100%;
	margin: 0 auto;
	border: 1px solid #ddd;
	border-radius: 10px;
	background-color: #f9f9f9; /* 배경색 */
	box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
	padding: 30px;
	box-sizing: border-box;
}

.regTitle {
	text-align: center;
	font-size: 1.8em;
	color: #333;
	margin-bottom: 30px;
}

/* 테이블 스타일 */
.boardTable {
	width: 80%;
	margin: 0 auto;
	border-collapse: collapse;
}

.boardTable th, .boardTable td {
	padding: 15px;
	font-size: 1em;
	vertical-align: middle;
}

/* 하늘색 박스 (왼쪽 제목 칸) */
.boardTable th {
	background-color: #d2e5ee; /* 하늘색 */
	color: #333;
	text-align: center;
	font-weight: bold;
	border-radius: 0; /* radius 제거 */
	width: 25%;
}

.boardTable td {
	background-color: #f9f9f9; /* 배경색 */
	text-align: left;
	display: flex;
	align-items: center;
	gap: 10px;
}

/* 입력 필드 및 버튼 스타일 */
.inputField, .selectField {
	flex: 1; /* 입력 필드가 남은 공간을 채움 */
	padding: 10px;
	font-size: 1em;
	border: 1px solid #ccc; /* 기본 테두리 */
	border-radius: 5px;
	box-sizing: border-box;
	height: 40px; /* 높이 통일 */
}

.selectField {
	width: 100px;
	text-align: center;
}

.btn {
	padding: 10px 15px;
	font-size: 0.9em;
	background-color: #d2e5ee; /* 버튼 색상 */
	color: #333;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	transition: background-color 0.3s ease;
	text-align: center;
	min-width: 80px;
	height: 40px; /* 버튼 높이 통일 */
}

.btn:hover {
	background-color: #b0d4e3;
	color: white;
}

/* 전화번호 한 줄 배치 */
.boardTable .phoneGroup {
	display: flex;
	gap: 10px;
}

/* 버튼 그룹 스타일 */
.regButtonGroup {
	text-align: center;
	margin-top: 20px;
}

.registerBtn {
	background-color: #d2e5ee; /* 중복확인 버튼과 동일한 색상 */
	color: black;
	padding: 10px 20px;
	border: none;
	border-radius: 5px;
	font-size: 1em;
	cursor: pointer;
	transition: background-color 0.3s;
}

.registerBtn:hover {
	background-color: #b0d4e3;
}

.resetBtn {
	background-color: #dadada;
	color: black;
	padding: 10px 20px;
	border: none;
	border-radius: 5px;
	font-size: 1em;
	cursor: pointer;
	transition: background-color 0.3s;
}

.resetBtn:hover {
	background-color: #b1b1b1;
}
</style>
</head>
<body>
	<article class="regFormArticle">
		<h2 class="regTitle">회원가입</h2>
		<form
			action="<%=request.getContextPath()%>/student/user/register/registerProc.jsp"
			method="post" name="regForm" enctype="multipart/form-data">
			<table class="boardTable">
				<tr>
					<th>아이디</th>
					<td><input type="text" name="id" required
						placeholder="영문자나 숫자, 3~15자" class="inputField">
						<button type="button" onclick="idCheck()" class="btn">중복확인</button>
					</td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="password" name="pass" required
						placeholder="영문자와 숫자, 6~15" class="inputField"></td>
				</tr>
				<tr>
					<th>비밀번호 확인</th>
					<td><input type="password" name="repass" required
						placeholder="비밀번호 확인" class="inputField"></td>
				</tr>
				<tr>
					<th>이름</th>
					<td><input type="text" name="name" required
						placeholder="이름 입력" class="inputField"></td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td><select name="phone1" class="selectField">
							<option value="02">02</option>
							<option value="010">010</option>
					</select> - <input type="text" name="phone2" size="5" class="inputField">
						- <input type="text" name="phone3" size="5" class="inputField">
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><input type="email" name="email" required
						placeholder="이메일 입력" class="inputField"></td>
				</tr>
				<tr>
					<th>우편번호</th>
					<td><input type="text" name="zipcode" placeholder="우편번호 입력"
						class="inputField">
						<button type="button" onclick="zipCheck()" class="btn">찾기</button>
					</td>
				</tr>
				<tr>
					<th>주소1</th>
					<td><input type="text" name="address1" size="50"
						placeholder="기본 주소" class="inputField"></td>
				</tr>
				<tr>
					<th>주소2</th>
					<td><input type="text" name="address2" size="50"
						placeholder="상세 주소" class="inputField"></td>
				</tr>
				<tr>
					<th>프로필 사진</th>
					<td><input type="file" name="profileFile" class="inputField"
						accept="image/*"></td>
				</tr>
			</table>
			<div class="regButtonGroup">
				<button type="button" onclick="inputCheck()" class="registerBtn">회원가입</button>
				<button type="reset" class="resetBtn">다시입력</button>
			</div>
		</form>
	</article>
</body>
</html>
