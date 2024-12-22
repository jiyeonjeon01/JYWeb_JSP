package co.kr.dev.board.login.shopping;

//num                 NUMBER(10),        -- 장바구니 ID
//student_id          VARCHAR2(20) NOT NULL, -- 사용자 ID (STUDENT 테이블 참조)
//product_num         NUMBER(7,0) NOT NULL, -- 상품 ID (PRODUCT 테이블 참조)
//quantity            NUMBER(3,0) DEFAULT 1 -- 수량

public class CartVO {
	private int num;
	private String studentId;
	private int productNum;
	private int quantity;
	public CartVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public CartVO(int num, String studentId, int productNum, int quantity) {
		super();
		this.num = num;
		this.studentId = studentId;
		this.productNum = productNum;
		this.quantity = quantity;
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
	public int getProductNum() {
		return productNum;
	}
	public void setProductNum(int productNum) {
		this.productNum = productNum;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	@Override
	public String toString() {
		return "CartVO [num=" + num + ", studentId=" + studentId + ", productNum=" + productNum + ", quantity="
				+ quantity + "]";
	}
}
