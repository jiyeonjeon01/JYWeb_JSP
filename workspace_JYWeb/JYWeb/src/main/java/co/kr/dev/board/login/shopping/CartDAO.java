package co.kr.dev.board.login.shopping;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import co.kr.dev.common.ConnectionPool;

public class CartDAO {
    // 싱글톤 패턴
    private static CartDAO instance;

    private CartDAO() {}

    public static CartDAO getInstance() {
        if (instance == null) {
            synchronized (CartDAO.class) {
                instance = new CartDAO();
            }
        }
        return instance;
    }

    // SQL 쿼리 정의
    private final String INSERT_SQL = "INSERT INTO CART (NUM, STUDENT_ID, PRODUCT_NUM, QUANTITY) " +
                                      "VALUES (CART_SEQ.NEXTVAL, ?, ?, ?)";
    private final String SELECT_ALL_SQL = "SELECT * FROM CART WHERE STUDENT_ID = ?";
    private final String DELETE_SQL = "DELETE FROM CART WHERE NUM = ?";
    private final String UPDATE_SQL = "UPDATE CART SET QUANTITY = ? WHERE NUM = ?";

    // 장바구니 추가
    public boolean insert(CartVO vo) {
        int result = 0;
        try (Connection con = ConnectionPool.getInstance().dbCon();
             PreparedStatement pstmt = con.prepareStatement(INSERT_SQL)) {

            pstmt.setString(1, vo.getStudentId());
            pstmt.setInt(2, vo.getProductNum());
            pstmt.setInt(3, vo.getQuantity());
            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result > 0;
    }

    // 특정 사용자의 장바구니 조회
    public List<CartVO> selectAll(String studentId) {
        List<CartVO> cartList = new ArrayList<>();
        try (Connection con = ConnectionPool.getInstance().dbCon();
             PreparedStatement pstmt = con.prepareStatement(SELECT_ALL_SQL)) {

            pstmt.setString(1, studentId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    cartList.add(new CartVO(
                        rs.getInt("NUM"),
                        rs.getString("STUDENT_ID"),
                        rs.getInt("PRODUCT_NUM"),
                        rs.getInt("QUANTITY")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cartList;
    }

    // 장바구니 아이템 삭제
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
    
 // 장바구니에서 특정 상품 삭제 (사용자 ID와 상품 번호를 기준으로)
    public boolean deleteCartItem(String userId, int productNum) {
        String sql = "DELETE FROM CART WHERE STUDENT_ID = ? AND PRODUCT_NUM = ?";
        try (Connection con = ConnectionPool.getInstance().dbCon();
             PreparedStatement pstmt = con.prepareStatement(sql)) {
            pstmt.setString(1, userId);
            pstmt.setInt(2, productNum);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // 장바구니 수량 업데이트
    public boolean update(int num, int quantity) {
        int result = 0;
        try (Connection con = ConnectionPool.getInstance().dbCon();
             PreparedStatement pstmt = con.prepareStatement(UPDATE_SQL)) {

            pstmt.setInt(1, quantity);
            pstmt.setInt(2, num);
            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result > 0;
    }

    // 수량 감소
    public boolean decreaseQuantity(String userId, int productNum) {
        String sql = "UPDATE CART SET QUANTITY = QUANTITY - 1 WHERE STUDENT_ID = ? AND PRODUCT_NUM = ?";
        try (Connection con = ConnectionPool.getInstance().dbCon();
             PreparedStatement pstmt = con.prepareStatement(sql)) {
            pstmt.setString(1, userId);
            pstmt.setInt(2, productNum);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // 수량 증가
    public boolean increaseQuantity(String userId, int productNum) {
        String sql = "UPDATE CART SET QUANTITY = QUANTITY + 1 WHERE STUDENT_ID = ? AND PRODUCT_NUM = ?";
        try (Connection con = ConnectionPool.getInstance().dbCon();
             PreparedStatement pstmt = con.prepareStatement(sql)) {
            pstmt.setString(1, userId);
            pstmt.setInt(2, productNum);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // 상품 삭제
    public boolean deleteByProduct(String userId, int productNum) {
        String sql = "DELETE FROM CART WHERE STUDENT_ID = ? AND PRODUCT_NUM = ?";
        try (Connection con = ConnectionPool.getInstance().dbCon();
             PreparedStatement pstmt = con.prepareStatement(sql)) {
            pstmt.setString(1, userId);
            pstmt.setInt(2, productNum);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // 장바구니 비우기 (추가 함수)
    public boolean clearCart(String userId) {
        String sql = "DELETE FROM CART WHERE STUDENT_ID = ?";
        try (Connection con = ConnectionPool.getInstance().dbCon();
             PreparedStatement pstmt = con.prepareStatement(sql)) {
            pstmt.setString(1, userId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
