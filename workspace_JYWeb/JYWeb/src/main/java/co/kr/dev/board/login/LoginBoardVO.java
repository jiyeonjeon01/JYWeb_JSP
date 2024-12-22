package co.kr.dev.board.login;

import java.sql.Timestamp;

//num             NUMBER(7,0),                   -- 게시글 번호 (Primary Key)
//type            VARCHAR2(20) NOT NULL,         -- 게시판 유형 (NOTI, NORMAL, SHOPPING)
//student_id      VARCHAR2(20),                  -- 작성자 (STUDENT 테이블의 ID와 연결)
//title           VARCHAR2(100) NOT NULL,        -- 게시글 제목
//readcount       NUMBER(5,0) DEFAULT 0,         -- 조회수
//regdate         TIMESTAMP (6) DEFAULT SYSDATE, -- 작성일
//content         VARCHAR2(4000) NOT NULL,       -- 게시글 내용
//ref             NUMBER(5,0) DEFAULT 0,         -- 그룹 번호 (질문글 그룹과 동일)
//step            NUMBER(3,0) DEFAULT 0,         -- 같은 그룹 내 순서
//depth           NUMBER(3,0) DEFAULT 0,         -- 계층 깊이
//ip              VARCHAR2(45) NOT NULL,         -- 작성자 IP
//originfile      VARCHAR2(255),                 -- 첨부파일 원본 파일명
//sysfile         VARCHAR2(255)                  -- 첨부파일 저장 파일명

public class LoginBoardVO {
	private int num;
	private String type;
	private String studentId;
	private String title;
	private int readCount;
	private Timestamp regDate;
	private String content;
	private int ref;
	private int step;
	private int depth;
	private String ip;
	private String originFile;
	private String sysFile;
	public LoginBoardVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public LoginBoardVO(int num, String type, String studentId, String title, int readCount, Timestamp regDate,
			String content, int ref, int step, int depth, String ip, String originFile, String sysFile) {
		super();
		this.num = num;
		this.type = type;
		this.studentId = studentId;
		this.title = title;
		this.readCount = readCount;
		this.regDate = regDate;
		this.content = content;
		this.ref = ref;
		this.step = step;
		this.depth = depth;
		this.ip = ip;
		this.originFile = originFile;
		this.sysFile = sysFile;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getStudentId() {
		return studentId;
	}
	public void setStudentId(String studentId) {
		this.studentId = studentId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getReadCount() {
		return readCount;
	}
	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}
	public Timestamp getRegDate() {
		return regDate;
	}
	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
	public int getStep() {
		return step;
	}
	public void setStep(int step) {
		this.step = step;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
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
		return "LoginBoardVO [num=" + num + ", type=" + type + ", studentId=" + studentId + ", title=" + title
				+ ", readCount=" + readCount + ", regDate=" + regDate + ", content=" + content + ", ref=" + ref
				+ ", step=" + step + ", depth=" + depth + ", ip=" + ip + ", originFile=" + originFile + ", sysFile="
				+ sysFile + "]";
	}
}
