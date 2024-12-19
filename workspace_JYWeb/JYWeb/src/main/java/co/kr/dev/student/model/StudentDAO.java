package co.kr.dev.student.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import co.kr.dev.common.ConnectionPool;

//private String id; pk
//private String pass;
//private String name;
//private String phone1;
//private String phone2;
//private String phone3;
//private String email;
//private String zipcode;
//private String address1;
//private String address2;
//private String originFile; 널 가능
//private String sysFile; 널 가능
//private String role; 디폴트 user 체크 (user, admin)

public class StudentDAO {
	// 전체 조회
	private final String SELECT_ALL_SQL = "SELECT * FROM STUDENT";
	// 해당 아이디 유일한지 아이디로 조회
	private final String SELECT_COUNT_ID_SQL = "SELECT COUNT(*) AS COUNT FROM STUDENT WHERE ID = ?";
	// 로그인
	private final String SELECT_LOGINCHECK_SQL = "SELECT COUNT(*) FROM STUDENT WHERE ID = ? AND PASS = ?";
	// 회원가입하기
	private final String INSERT_ALL_SQL = "INSERT INTO STUDENT VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ,? ,?)";
	// 아이디로 회원수정하기
	private final String UPDATE_SQL = "UPDATE STUDENT SET PASS = ?, NAME = ?, PHONE1 = ?, PHONE2 = ?, PHONE3 = ?" 
	 + "EMAIL = ?, ZIPCODE = ?, ADDRESS1 = ?, ADDRESS2 = ?, ORIGINFILE = ?, SYSFILE = ?, ROLE = ? WHERE ID = ?";
	// 아이디로 회원 삭제하기
	private final String DELETE_SQL = "DELETE FROM STUDENT WHERE ID = ?";
	
	
	// 인스턴스: 싱글톤 패턴으로 비효율 줄임, 한번만 실행하면 됨
	private static StudentDAO instance = new StudentDAO();
	public static StudentDAO getInstance() {
		return instance;
	}
	
	// 전체 조회
	public ArrayList<StudentVO> selectDB() {
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        ArrayList<StudentVO> studentList = new ArrayList<>();
        
        try {
        	pstmt = con.prepareStatement(SELECT_ALL_SQL);
        	rs = pstmt.executeQuery();
        	
        	while(rs.next()) {
        		StudentVO student = new StudentVO(
        				rs.getString("ID"),
        				rs.getString("PASS"),
        				rs.getString("NAME"),
        				rs.getString("PHONE1"),
        				rs.getString("PHONE2"),
        				rs.getString("PHONE3"),
        				rs.getString("EMAIL"),
        				rs.getString("ZIPCODE"),
        				rs.getString("ADDRESS1"),
        				rs.getString("ADDRESS2"),
        				rs.getString("ORIGINFILE"),
        				rs.getString("SYSFILE"),
        				rs.getString("ROLE")
        			); 
        		studentList.add(student);
        	}
        	
        } catch (SQLException e) {
        	e.printStackTrace();
        } finally {
        	cp.dbClose(con, pstmt, rs);
        }
        return studentList;
	}
	
	// 아이디 중복 체크(해당 아이디가 1개만 있는지)
	public boolean selectIdCheck(StudentVO svo) {
		ConnectionPool cp = ConnectionPool.getInstance();
        Connection con = cp.dbCon();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        ArrayList<ZipcodeVO> zipList = new ArrayList<>();
        
        try {
        	pstmt = con.
        }
        
	}
	
	
	
	
	
	
	
}
