package co.kr.dev.board.login.shopping;

//num             NUMBER(7, 0), -- pk   
//student_id      VARCHAR2(20),                  -- 작성자 (STUDENT 테이블의 ID와 연결)
//name            VARCHAR2(40) NOT NULL,
//price           NUMBER(15) NOT NULL,
//detail          VARCHAR2(300),
//originfile      VARCHAR2(255), -- 첨부파일 원본 파일명
//sysfile         VARCHAR2(255)  -- 첨부파일 저장 파일명

public class ProductVO {
	private int num;
	private String studentId;
	private String name;
	private int price;
	private String detail;
	private String originFile;
	private String sysFile;
	public ProductVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ProductVO(int num, String studentId, String name, int price, String detail, String originFile, String sysFile) {
		super();
		this.num = num;
		this.studentId = studentId;
		this.name = name;
		this.price = price;
		this.detail = detail;
		this.originFile = originFile;
		this.sysFile = sysFile;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getStudentId() {
		return studentId;
	}
	public void setStudentId(String studentId) {
		this.studentId = studentId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
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
	@Override
	public String toString() {
		return "ProductVO [num=" + num + ", studentId=" + studentId + ", name=" + name + ", price=" + price
				+ ", detail=" + detail + ", originFile=" + originFile + ", sysFile=" + sysFile + "]";
	}
}
