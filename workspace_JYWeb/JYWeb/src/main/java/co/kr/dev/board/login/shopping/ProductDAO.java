package co.kr.dev.board.login.shopping;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import co.kr.dev.board.login.LoginBoardVO;
import co.kr.dev.common.ConnectionPool;

public class ProductDAO {
    // 싱글톤 패턴
    private static ProductDAO instance;

    private ProductDAO() {}

    public static ProductDAO getInstance() {
        if (instance == null) {
            synchronized (ProductDAO.class) {
                if (instance == null) {
                    instance = new ProductDAO();
                }
            }
        }
        return instance;
    }

    // SQL 정의
    private final String SELECT_ALL_SQL = "SELECT * FROM PRODUCT ORDER BY NUM DESC";
    private final String SELECT_ONE_SQL = "SELECT * FROM PRODUCT WHERE NUM = ?";
    private final String SELECT_BY_STUDENT_SQL = "SELECT * FROM PRODUCT WHERE STUDENT_ID = ? ORDER BY NUM DESC";
    private final String INSERT_SQL = "INSERT INTO PRODUCT (NUM, STUDENT_ID, NAME, PRICE, DETAIL, ORIGINFILE, SYSFILE) "
                                     + "VALUES (PRODUCT_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?)";
    private final String UPDATE_SQL = "UPDATE PRODUCT SET NAME = ?, PRICE = ?, DETAIL = ?, ORIGINFILE = ?, SYSFILE = ? WHERE NUM = ?";
    private final String DELETE_SQL = "DELETE FROM PRODUCT WHERE NUM = ?";
    private final String SELECT_MAX_NUM_SQL = "SELECT MAX(NUM) AS NUM FROM PRODUCT";

    // 모든 제품 조회
    public List<ProductVO> selectAll() {
        List<ProductVO> productList = new ArrayList<>();
        try (Connection con = ConnectionPool.getInstance().dbCon();
             PreparedStatement pstmt = con.prepareStatement(SELECT_ALL_SQL);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                productList.add(extractVO(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productList;
    }

    // 제품 번호로 하나의 제품 조회
    public ProductVO selectOne(int num) {
        ProductVO product = null;
        try (Connection con = ConnectionPool.getInstance().dbCon();
             PreparedStatement pstmt = con.prepareStatement(SELECT_ONE_SQL)) {

            pstmt.setInt(1, num);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    product = extractVO(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return product;
    }

    // 특정 작성자의 모든 제품 조회
    public List<ProductVO> selectByStudentId(String studentId) {
        List<ProductVO> productList = new ArrayList<>();
        try (Connection con = ConnectionPool.getInstance().dbCon();
             PreparedStatement pstmt = con.prepareStatement(SELECT_BY_STUDENT_SQL)) {

            pstmt.setString(1, studentId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    productList.add(extractVO(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productList;
    }

    // 제품 추가
    public boolean insert(ProductVO vo) {
        int result = 0;
        try (Connection con = ConnectionPool.getInstance().dbCon();
             PreparedStatement pstmt = con.prepareStatement(INSERT_SQL)) {

            pstmt.setString(1, vo.getStudentId());
            pstmt.setString(2, vo.getName());
            pstmt.setInt(3, vo.getPrice());
            pstmt.setString(4, vo.getDetail());
            pstmt.setString(5, vo.getOriginFile());
            pstmt.setString(6, vo.getSysFile());

            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result > 0;
    }

    // 제품 수정
    public boolean update(ProductVO vo) {
        int result = 0;
        try (Connection con = ConnectionPool.getInstance().dbCon();
             PreparedStatement pstmt = con.prepareStatement(UPDATE_SQL)) {

            pstmt.setString(1, vo.getName());
            pstmt.setInt(2, vo.getPrice());
            pstmt.setString(3, vo.getDetail());
            pstmt.setString(4, vo.getOriginFile());
            pstmt.setString(5, vo.getSysFile());
            pstmt.setInt(6, vo.getNum());

            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result > 0;
    }

    // 제품 삭제
    public boolean delete(int num) {
        int result = 0;
        try (Connection con = ConnectionPool.getInstance().dbCon();
             PreparedStatement pstmt = con.prepareStatement(DELETE_SQL)) {

            pstmt.setInt(1, num);
            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result > 0;
    }

    // 최대 번호 가져오기
    public int getMaxNum() {
        int maxNum = 0;
        try (Connection con = ConnectionPool.getInstance().dbCon();
             PreparedStatement pstmt = con.prepareStatement(SELECT_MAX_NUM_SQL);
             ResultSet rs = pstmt.executeQuery()) {

            if (rs.next()) {
                maxNum = rs.getInt("NUM");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return maxNum;
    }

    // ResultSet에서 ProductVO 객체 추출
    private ProductVO extractVO(ResultSet rs) throws SQLException {
        return new ProductVO(
                rs.getInt("NUM"),
                rs.getString("STUDENT_ID"),
                rs.getString("NAME"),
                rs.getInt("PRICE"),
                rs.getString("DETAIL"),
                rs.getString("ORIGINFILE"),
                rs.getString("SYSFILE")
        );
    }
    
 // 특정 사용자가 작성한 게시글 조회
    public List<ProductVO> getPostsByUserId(String userId) {
        List<ProductVO> posts = new ArrayList<>();
        // STUDENT_ID를 기준으로 게시글 조회
        String sql = "SELECT * FROM PRODUCT WHERE STUDENT_ID = ? ORDER BY PRICE";

        try (Connection con = ConnectionPool.getInstance().dbCon();
             PreparedStatement pstmt = con.prepareStatement(sql)) {
            pstmt.setString(1, userId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    posts.add(extractVO(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }
    
}
