/* 회원가입폼 아이디 중복 확인 */
function idCheck() {
    const id = document.regForm.id.value.trim();
    const idPattern = /^[a-zA-Z0-9]{3,15}$/; // 영어와 숫자, 3~15자
    if (!id) {
        alert("아이디를 입력해 주세요.");
        document.regForm.id.focus();
    } else if (!idPattern.test(id)) {
        alert("아이디는 영어와 숫자로 구성된 3~15자여야 합니다.");
        document.regForm.id.focus();
    } else {
        const url = `${contextPath}/student/user/register/ex/idCheck.jsp?id=${encodeURIComponent(id)}`;
        window.open(url, "idCheckWindow", "width=500,height=300");
    }
}



/* 회원가입폼 주소체크 */
function zipCheck() {
    url = contextPath + "/student/user/register/ex/zipCheck.jsp?check=y";
    window.open(url, "zipCheckWindow", "width=600,height=300,scrollbars=yes");
}

/* 회원가입폼 동체크 */
function dongCheck() {
    let value = document.zipForm.dong.value.trim();
    if (value === "") {
        alert("동이름을 입력해 주세요.");
        document.zipForm.dong.focus();
        return;
    }
    document.zipForm.submit();
}

/* 주소내용을 불러주는 윈도우창 각 요소저장 */
function sendAddress(zipcode, sido, gugun, dong, bunji) {
    var cleanBunji = bunji && bunji !== "null" ? bunji : "";
    var cleanDong = dong && dong !== "null" ? dong : "";
    var cleanGugun = gugun && gugun !== "null" ? gugun : "";
    var cleanSido = sido && sido !== "null" ? sido : "";

    var address = cleanSido + " " + cleanGugun + " " + cleanDong + " " + cleanBunji;
    opener.document.regForm.zipcode.value = zipcode; // 우편번호 입력
    opener.document.regForm.address1.value = address.trim(); // 주소1 입력
    opener.document.regForm.address2.value = ""; // 주소2는 비워두고 사용자가 입력
    opener.document.regForm.address2.focus(); // 주소2 입력란에 포커스
    self.close(); // 창 닫기
}


/*회원가입폼 패턴검색*/
function inputCheck() {
	if (document.regForm.id.value == "") {
		alert("아이디를 입력해 주세요.");
		document.regForm.id.focus();
		return;
	}
	if (document.regForm.pass.value == "") {
		alert("비밀번호를 입력해 주세요.");
		document.regForm.pass.focus();
		return;
	}
	if (document.regForm.repass.value == "") {
		alert("비밀번호를 확인해 주세요");
		document.regForm.repass.focus();
		return;
	}
	if (document.regForm.pass.value !=
		document.regForm.repass.value) {
		alert("비밀번호가 일치하지 않습니다.");
		document.regForm.repass.focus();
		return;
	}
	if (document.regForm.name.value == "") {
		alert("이름을 입력해 주세요.");
		document.regForm.name.focus();
		return;
	}
	if (document.regForm.phone1.value == "") {
		alert("통신사를 입력해 주세요.");
		document.regForm.phone1.focus();
		return;
	}
	if (document.regForm.phone2.value == "") {
		alert("전화번호을 입력해 주세요.");
		document.regForm.phone2.focus();
		return;
	}
	if (document.regForm.phone3.value == "") {
		alert("전화번호을 입력해 주세요.");
		document.regForm.phone3.focus();
		return;
	}
	if (document.regForm.email.value == "") {
		alert("이메일을 입력해 주세요.");
		document.regForm.email.focus();
		return;
	}
	const pattern = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-za-z0-9\-]+/;
	var email = document.regForm.email.value;
	if (pattern.test(email) === false) {
		alert('E-mail주소 형식이 잘못되었습니다.\n\r다시 입력해 주세요!');
		document.regForm.email.focus();
		return;
	}

	if (document.regForm.zipcode.value == "") {
		alert("우편번호를 입력해 주세요.");
		document.regForm.zipcode.focus();
		return;
	}
	if (document.regForm.address1.value == "") {
		alert("주소를 입력해 주세요.");
		document.regForm.address1.focus();
		return;
	}
	if (document.regForm.address2.value == "") {
		alert("세부주소를 입력해 주세요.");
		document.regForm.address2.focus();
		return;
	}
	document.regForm.submit();
}

/*회원수정폼 패턴검색*/
function updateCheck() {
	if (document.regForm.pass.value == "") {
		alert("비밀번호를 입력해 주세요.");
		document.regForm.pass.focus();
		return;
	}
	if (document.regForm.repass.value == "") {
		alert("비밀번호를 확인해 주세요");
		document.regForm.repass.focus();
		return;
	}
	if (document.regForm.pass.value !=
		document.regForm.repass.value) {
		alert("비밀번호가 일치하지 않습니다.");
		document.regForm.repass.focus();
		return;
	}
	if (document.regForm.phone1.value == "") {
		alert("통신사를 입력해 주세요.");
		document.regForm.phone1.focus();
		return;
	}
	if (document.regForm.phone2.value == "") {
		alert("전화번호을 입력해 주세요.");
		document.regForm.phone2.focus();
		return;
	}
	if (document.regForm.phone3.value == "") {
		alert("전화번호을 입력해 주세요.");
		document.regForm.phone3.focus();
		return;
	}
	if (document.regForm.email.value == "") {
		alert("이메일을 입력해 주세요.");
		document.regForm.email.focus();
		return;
	}
	const pattern = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-za-z0-9\-]+/;
	var email = document.regForm.email.value;
	if (pattern.test(email) === false) {
		alert('E-mail주소 형식이 잘못되었습니다.\n\r다시 입력해 주세요!');
		document.regForm.email.focus();
		return;
	}
	if (document.regForm.zipcode.value == "") {
		alert("우편번호를 입력해 주세요.");
		document.regForm.zipcode.focus();
		return;
	}
	if (document.regForm.address1.value == "") {
		alert("주소를 입력해 주세요.");
		document.regForm.address1.focus();
		return;
	}
	if (document.regForm.address2.value == "") {
		alert("세부주소를 입력해 주세요.");
		document.regForm.address2.focus();
		return;
	}
	document.regForm.submit();
}