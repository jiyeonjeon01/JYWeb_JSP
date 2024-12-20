package co.kr.dev.student.model;

//seq      NUMBER(10) PRIMARY KEY,          -- 우편번호 시퀀스 (Primary Key)
//zipcode  VARCHAR2(10) NOT NULL,           -- 우편번호
//sido     VARCHAR2(30),                    -- 시/도
//gugun    VARCHAR2(30),                    -- 구/군
//dong     VARCHAR2(50),                    -- 동/읍/면
//bunji    VARCHAR2(100)                    -- 번지

public class ZipcodeVO {
	private int seq;
	private String zipcode;
	private String sido;
	private String gugun;
	private String dong;
	private String bunji;
	public ZipcodeVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ZipcodeVO(int seq, String zipcode, String sido, String gugun, String dong, String bunji) {
		super();
		this.seq = seq;
		this.zipcode = zipcode;
		this.sido = sido;
		this.gugun = gugun;
		this.dong = dong;
		this.bunji = bunji;
	}
	public ZipcodeVO(String zipcode, String sido, String gugun, String dong, String bunji) {
		super();
		this.zipcode = zipcode;
		this.sido = sido;
		this.gugun = gugun;
		this.dong = dong;
		this.bunji = bunji;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getSido() {
		return sido;
	}
	public void setSido(String sido) {
		this.sido = sido;
	}
	public String getGugun() {
		return gugun;
	}
	public void setGugun(String gugun) {
		this.gugun = gugun;
	}
	public String getDong() {
		return dong;
	}
	public void setFong(String dong) {
		this.dong = dong;
	}
	public String getBunji() {
		return bunji;
	}
	public void setBunji(String bunji) {
		this.bunji = bunji;
	}
	@Override
	public String toString() {
		return "ZipcodeVO [seq=" + seq + ", zipcode=" + zipcode + ", sido=" + sido + ", gugun=" + gugun + ", dong="
				+ dong + ", bunji=" + bunji + "]";
	}
}
