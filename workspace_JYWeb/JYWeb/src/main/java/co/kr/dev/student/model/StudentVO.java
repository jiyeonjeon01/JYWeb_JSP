package co.kr.dev.student.model;

//id         VARCHAR2(20),                  -- 사용자 ID (Primary Key)
//pass       VARCHAR2(30) NOT NULL,         -- 비밀번호
//name       VARCHAR2(30) NOT NULL,         -- 사용자 이름
//phone1     VARCHAR2(3) NOT NULL,          -- 전화번호 앞자리
//phone2     VARCHAR2(4) NOT NULL,          -- 전화번호 중간자리
//phone3     VARCHAR2(4) NOT NULL,          -- 전화번호 뒷자리
//email      VARCHAR2(30) NOT NULL,         -- 이메일
//zipcode    VARCHAR2(7) NOT NULL,          -- 우편번호
//address1   VARCHAR2(120) NOT NULL,        -- 주소 (기본)
//address2   VARCHAR2(50) NOT NULL,         -- 주소 (상세)
//originfile VARCHAR2(255),                 -- 프로필 사진 원본 파일명
//sysfile    VARCHAR2(255),                 -- 프로필 사진 저장 파일명
//role       VARCHAR2(10) DEFAULT 'USER' NOT NULL, -- 사용자 역할 (USER/ADMIN)
//CONSTRAINT student_role_ck CHECK (role IN ('USER', 'ADMIN')) -- Role 제한

public class StudentVO {
	private String id;
	private String pass;
	private String name;
	private String phone1;
	private String phone2;
	private String phone3;
	private String email;
	private String zipcode;
	private String address1;
	private String address2;
	private String originFile;
	private String sysFile;
	private String role; 
	public StudentVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public StudentVO(String id, String pass, String name, String phone1, String phone2, String phone3, String email,
			String zipcode, String address1, String address2, String originFile, String sysFile, String role) {
		super();
		this.id = id;
		this.pass = pass;
		this.name = name;
		this.phone1 = phone1;
		this.phone2 = phone2;
		this.phone3 = phone3;
		this.email = email;
		this.zipcode = zipcode;
		this.address1 = address1;
		this.address2 = address2;
		this.originFile = originFile;
		this.sysFile = sysFile;
		this.role = role;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhone1() {
		return phone1;
	}
	public void setPhone1(String phone1) {
		this.phone1 = phone1;
	}
	public String getPhone2() {
		return phone2;
	}
	public void setPhone2(String phone2) {
		this.phone2 = phone2;
	}
	public String getPhone3() {
		return phone3;
	}
	public void setPhone3(String phone3) {
		this.phone3 = phone3;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getAddress1() {
		return address1;
	}
	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	public String getOriginFile() {
		return originFile;
	}
	public void setOriginFile(String originFile) {
		this.originFile = originFile;
	}
	public String getSysFile() {
		return sysFile;
	}
	public void setSysFile(String sysFile) {
		this.sysFile = sysFile;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	@Override
	public String toString() {
		return "StudentVO [id=" + id + ", pass=" + pass + ", name=" + name + ", phone1=" + phone1 + ", phone2=" + phone2
				+ ", phone3=" + phone3 + ", email=" + email + ", zipcode=" + zipcode + ", address1=" + address1
				+ ", address2=" + address2 + ", originFile=" + originFile + ", sysFile=" + sysFile + ", role=" + role
				+ "]";
	}
}
