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
	// 전체 학생 정보 조회
	private final String SELECT_ALL_SQL = "SELECT * FROM STUDENT";
	// 해당 아이디 조회
	private final String SELECT_ONE_SQL = "SELECT * FROM STUDENT WHERE ID = ?";
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
	// 회원가입시 동에 따른 우편번호 리스트 불러오기
	private final String SELECT_ZIP_SQL = "SELECT * FROM ZIPCODE WHERE DONG LIKE ?";

	// 인스턴스: 싱글톤 패턴으로 비효율 줄임, 한번만 실행하면 됨
	private static StudentDAO instance = new StudentDAO();

	public static StudentDAO getInstance() {
		return instance;
	}

	// 전체 학생 정보 조회
	public ArrayList<StudentVO> selectDB() {
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		ArrayList<StudentVO> studentList = new ArrayList<>();

		try {
			pstmt = con.prepareStatement(SELECT_ALL_SQL);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				StudentVO student = new StudentVO(rs.getString("ID"), rs.getString("PASS"), rs.getString("NAME"),
						rs.getString("PHONE1"), rs.getString("PHONE2"), rs.getString("PHONE3"), rs.getString("EMAIL"),
						rs.getString("ZIPCODE"), rs.getString("ADDRESS1"), rs.getString("ADDRESS2"),
						rs.getString("ORIGINFILE"), rs.getString("SYSFILE"), rs.getString("ROLE"));
				studentList.add(student);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			cp.dbClose(con, pstmt, rs);
		}
		return studentList;
	}

	// 특정 학생 정보 조회
	public StudentVO selectOneDB(StudentVO svo) {
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StudentVO resultVO = null;

		try {
			pstmt = con.prepareStatement(SELECT_ONE_SQL);
			pstmt.setString(1, svo.getId());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				String id = rs.getString("ID");
				String pass = rs.getString("PASS");
				String name = rs.getString("NAME");
				String phone1 = rs.getString("PHONE1");
				String phone2 = rs.getString("PHONE2");
				String phone3 = rs.getString("PHONE3");
				String email = rs.getString("EMAIL");
				String zipcode = rs.getString("ZIPCODE");
				String address1 = rs.getString("ADDRESS1");
				String address2 = rs.getString("ADDRESS2");
				String orginFile = rs.getString("ORIGINFILE");
				String sysFile = rs.getString("SYSFILE");
				String role = rs.getString("ROLE");
				resultVO = new StudentVO(id, pass, name, phone1, phone2, phone3, email, zipcode, address1, address2,
						orginFile, sysFile, role);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			cp.dbClose(con, pstmt, rs);
		}
		return resultVO;
	}

	// 해당 아이디 유일한지 아이디로 조회
	public boolean selectIdCheck(StudentVO svo) {
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;

		try {
			pstmt = con.prepareStatement(SELECT_COUNT_ID_SQL);
			pstmt.setString(1, svo.getId());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt("count");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			cp.dbClose(con, pstmt, rs);
		}
		return (count != 0) ? true : false;
	}

	// 로그인
	public int selectLoginCheck(StudentVO svo) {
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String pass = null;
		int check = -1; // id가 안맞을때

		try {
			pstmt = con.prepareStatement(SELECT_LOGINCHECK_SQL);
			pstmt.setString(1, svo.getId());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				pass = rs.getString("PASS");
				check = (pass.equals(svo.getPass()) == true) ? (1) : (0);
			} else {
				check = -1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			cp.dbClose(con, pstmt, rs);
		}
		return check;
	}

	// 회원가입하기
	public Boolean insertDB(StudentVO svo) {
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		int count = 0;
		int rs = 0;

		try {
			pstmt = con.prepareStatement(INSERT_ALL_SQL);
			pstmt.setString(1, svo.getId());
			pstmt.setString(2, svo.getPass());
			pstmt.setString(3, svo.getName());
			pstmt.setString(4, svo.getPhone1());
			pstmt.setString(5, svo.getPhone2());
			pstmt.setString(6, svo.getPhone3());
			pstmt.setString(7, svo.getEmail());
			pstmt.setString(8, svo.getZipcode());
			pstmt.setString(9, svo.getAddress1());
			pstmt.setString(10, svo.getAddress2());
			pstmt.setString(11, svo.getOriginFile());
			pstmt.setString(12, svo.getSysFile());
			pstmt.setString(13, svo.getRole());
			count = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			cp.dbClose(con, pstmt);
		}
		return (count > 0) ? true : false;
	}

	// 아이디로 회원수정하기 UPDATE_SQL
	public Boolean updateDB(StudentVO svo) {
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		int count = 0;
		try {
			pstmt = con.prepareStatement(UPDATE_SQL);
			pstmt.setString(1, svo.getPass());
			pstmt.setString(2, svo.getName());
			pstmt.setString(3, svo.getPhone1());
			pstmt.setString(4, svo.getPhone2());
			pstmt.setString(5, svo.getPhone3());
			pstmt.setString(6, svo.getEmail());
			pstmt.setString(7, svo.getZipcode());
			pstmt.setString(8, svo.getAddress1());
			pstmt.setString(9, svo.getAddress2());
			pstmt.setString(10, svo.getOriginFile());
			pstmt.setString(11, svo.getSysFile());
			pstmt.setString(12, svo.getRole());
			count = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			cp.dbClose(con, pstmt);
		}
		return (count > 0) ? true : false;
	}

	// 아이디로 회원 삭제하기
	public Boolean deleteDB(StudentVO svo) {
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		int count = 0;
		try {
			pstmt = con.prepareStatement(DELETE_SQL);
			pstmt.setString(1, svo.getId());
			count = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			cp.dbClose(con, pstmt);
		}
		return (count > 0) ? true : false;
	}

	// 회원가입시 동에 따른 우편번호 리스트 불러오기
	public ArrayList<ZipcodeVO> selectZipCode(ZipcodeVO zvo) {
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<ZipcodeVO> zipList = new ArrayList<ZipcodeVO>();
		try {
			pstmt = con.prepareStatement(SELECT_ZIP_SQL);
			// "방배동%"
			String dongValue = "%" + zvo.getDong() + "%";
			// select * from zipcode where dong like '%방배동%'
			pstmt.setString(1, dongValue);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String zipcode = rs.getString("zipcode");
				String sido = rs.getString("sido");
				String gugun = rs.getString("gugun");
				String dong = rs.getString("dong");
				String bunji = rs.getString("bunji");
				ZipcodeVO obj = new ZipcodeVO(zipcode, sido, gugun, dong, bunji);
				zipList.add(obj);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			cp.dbClose(con, pstmt, rs);
		}
		return zipList;
	}
}
