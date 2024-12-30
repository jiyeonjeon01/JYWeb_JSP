package co.kr.dev.board.logout;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import co.kr.dev.common.ConnectionPool;

public class LogoutBoardDAO {
    private static LogoutBoardDAO instance;

    // 싱글톤 패턴
    private LogoutBoardDAO() {}

    public static LogoutBoardDAO getInstance() {
        if (instance == null) {
            synchronized (LogoutBoardDAO.class) {
                instance = new LogoutBoardDAO();
            }
        }
        return instance;
    }

    // SQL Queries
    private final String SELECT_SQL = "SELECT * FROM LOGOUTBOARD ORDER BY NUM DESC";
    private final String SELECT_ONE_SQL = "SELECT * FROM LOGOUTBOARD WHERE NUM = ?";
    private final String INSERT_SQL = "INSERT INTO LOGOUTBOARD (NUM, TYPE, WRITER, EMAIL, PASS, TITLE, READCOUNT, REGDATE, CONTENT, REF, STEP, DEPTH, IP, ORIGINFILE, SYSFILE) "
            + "VALUES (LOGOUTBOARD_SEQ.NEXTVAL, ?, ?, ?, ?, ?, 0, SYSDATE, ?, ?, ?, ?, ?, ?, ?)";
    private final String UPDATE_SQL = "UPDATE LOGOUTBOARD SET TITLE = ?, CONTENT = ?, ORIGINFILE = ?, SYSFILE = ? WHERE NUM = ?";
    private final String DELETE_SQL = "DELETE FROM LOGOUTBOARD WHERE NUM = ?";
    private final String UPDATE_READCOUNT_SQL = "UPDATE LOGOUTBOARD SET READCOUNT = READCOUNT + 1 WHERE NUM = ?";

    // 전체 게시글 조회
    public List<LogoutBoardVO> selectAll() {
        List<LogoutBoardVO> boardList = new ArrayList<>();
        try (Connection con = ConnectionPool.getInstance().dbCon();
             PreparedStatement pstmt = con.prepareStatement(SELECT_SQL);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                boardList.add(extractVO(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return boardList;
    }

    // 특정 게시글 조회
    public LogoutBoardVO selectOne(int num) {
        LogoutBoardVO board = null;
        try (Connection con = ConnectionPool.getInstance().dbCon();
             PreparedStatement pstmt = con.prepareStatement(SELECT_ONE_SQL)) {
            pstmt.setInt(1, num);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    board = extractVO(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return board;
    }
    
    public LogoutBoardVO selectBoardDB(LogoutBoardVO vo) {
        LogoutBoardVO bvo = null;

        try (Connection con = ConnectionPool.getInstance().dbCon()) {
            // 조회수 증가
            try (PreparedStatement pstmt = con.prepareStatement("UPDATE LOGOUTBOARD SET READCOUNT = READCOUNT + 1 WHERE NUM = ?")) {
                pstmt.setInt(1, vo.getNum());
                pstmt.executeUpdate();
            }

            // 게시글 데이터 가져오기
            try (PreparedStatement pstmt = con.prepareStatement("SELECT * FROM LOGOUTBOARD WHERE NUM = ?")) {
                pstmt.setInt(1, vo.getNum());
                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        bvo = new LogoutBoardVO(
                            rs.getInt("NUM"),
                            rs.getString("TYPE"),
                            rs.getString("WRITER"),
                            rs.getString("EMAIL"),
                            rs.getString("PASS"),
                            rs.getString("TITLE"),
                            rs.getInt("READCOUNT"),
                            rs.getTimestamp("REGDATE"),
                            rs.getString("CONTENT"),
                            rs.getInt("REF"),
                            rs.getInt("STEP"),
                            rs.getInt("DEPTH"),
                            rs.getString("IP"),
                            rs.getString("ORIGINFILE"),
                            rs.getString("SYSFILE")
                        );
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // 데이터가 없는 경우 기본값 설정
        if (bvo == null) {
            bvo = new LogoutBoardVO();
            bvo.setTitle("게시글이 존재하지 않습니다.");
            bvo.setContent("내용이 없습니다.");
            bvo.setReadCount(0);
            bvo.setWriter("알 수 없음");
        }

        // 디버깅 메시지
        System.out.println("[DEBUG] 게시글 번호: " + vo.getNum());
        if (bvo != null) {
            System.out.println("[DEBUG] 게시글 데이터: " + bvo.toString());
        } else {
            System.out.println("[DEBUG] 게시글 데이터가 존재하지 않습니다.");
        }

        return bvo;
    }

 // 특정 타입의 게시글을 페이징하여 가져오기
    public List<LogoutBoardVO> getPostsByType(String type, int start, int end) {
        List<LogoutBoardVO> boardList = new ArrayList<>();
        String sql = "SELECT * FROM (" +
                     "SELECT ROWNUM RNUM, A.* FROM (" +
                     "SELECT * FROM LOGOUTBOARD WHERE TYPE = ? ORDER BY NUM DESC" +
                     ") A WHERE ROWNUM <= ?" +
                     ") WHERE RNUM >= ?";
        try (Connection con = ConnectionPool.getInstance().dbCon();
             PreparedStatement pstmt = con.prepareStatement(sql)) {
             
           
            System.out.println("Executing SQL: " + sql);
            System.out.println("Parameters: type=" + type + ", start=" + start + ", end=" + end);

            pstmt.setString(1, type); // WHERE TYPE = ?
            pstmt.setInt(2, end);    // ROWNUM <= ?
            pstmt.setInt(3, start);  // RNUM >= ?

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    boardList.add(extractVO(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return boardList;
    }


    // 특정 타입의 게시글 개수 가져오기
    public int getPostCountByType(String type) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM LOGOUTBOARD WHERE TYPE = ?";
        try (Connection con = ConnectionPool.getInstance().dbCon();
             PreparedStatement pstmt = con.prepareStatement(sql)) {
            pstmt.setString(1, type);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }


    // 게시글 삽입
    public boolean insert(LogoutBoardVO vo) {
        int count = 0;
        try (Connection con = ConnectionPool.getInstance().dbCon();
             PreparedStatement pstmt = con.prepareStatement(INSERT_SQL)) {
            pstmt.setString(1, vo.getType());
            pstmt.setString(2, vo.getWriter());
            pstmt.setString(3, vo.getEmail());
            pstmt.setString(4, vo.getPass());
            pstmt.setString(5, vo.getTitle());
            pstmt.setString(6, vo.getContent());
            pstmt.setInt(7, vo.getRef());
            pstmt.setInt(8, vo.getStep());
            pstmt.setInt(9, vo.getDepth());
            pstmt.setString(10, vo.getIp());
            pstmt.setString(11, vo.getOriginFile());
            pstmt.setString(12, vo.getSysFile());
            count = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count > 0;
    }

    // 게시글 수정
    public boolean update(LogoutBoardVO vo) {
        int count = 0;
        try (Connection con = ConnectionPool.getInstance().dbCon();
             PreparedStatement pstmt = con.prepareStatement(UPDATE_SQL)) {
            pstmt.setString(1, vo.getTitle());
            pstmt.setString(2, vo.getContent());
            pstmt.setString(3, vo.getOriginFile());
            pstmt.setString(4, vo.getSysFile());
            pstmt.setInt(5, vo.getNum());
            count = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count > 0;
    }

    // 게시글 삭제
    public boolean delete(int num) {
        int count = 0;
        try (Connection con = ConnectionPool.getInstance().dbCon();
             PreparedStatement pstmt = con.prepareStatement(DELETE_SQL)) {
            pstmt.setInt(1, num);
            count = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count > 0;
    }

    // 조회수 증가
    public void updateReadCount(int num) {
        try (Connection con = ConnectionPool.getInstance().dbCon();
             PreparedStatement pstmt = con.prepareStatement(UPDATE_READCOUNT_SQL)) {
            pstmt.setInt(1, num);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // ResultSet에서 LogoutBoardVO 객체 추출
    private LogoutBoardVO extractVO(ResultSet rs) throws SQLException {
        return new LogoutBoardVO(
            rs.getInt("NUM"),
            rs.getString("TYPE"),
            rs.getString("WRITER"),
            rs.getString("EMAIL"),
            rs.getString("PASS"),
            rs.getString("TITLE"),
            rs.getInt("READCOUNT"),
            rs.getTimestamp("REGDATE"),
            rs.getString("CONTENT"),
            rs.getInt("REF"),
            rs.getInt("STEP"),
            rs.getInt("DEPTH"),
            rs.getString("IP"),
            rs.getString("ORIGINFILE"),
            rs.getString("SYSFILE")
        );
    }
    
 // 모든 게시글(질문 + 답변) 가져오기
    public List<LogoutBoardVO> getAllPosts(int start, int end) {
        String sql = "SELECT * FROM ("
                   + "SELECT ROWNUM RNUM, A.* FROM ("
                   + "SELECT * FROM LOGOUTBOARD ORDER BY REF DESC, STEP ASC) A "
                   + "WHERE ROWNUM <= ?) WHERE RNUM >= ?";
        List<LogoutBoardVO> boardList = new ArrayList<>();
        try (Connection con = ConnectionPool.getInstance().dbCon();
             PreparedStatement pstmt = con.prepareStatement(sql)) {
            pstmt.setInt(1, end);
            pstmt.setInt(2, start);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                boardList.add(extractVO(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return boardList;
    }

    
    public int getPostCount() {
        String sql = "SELECT COUNT(*) FROM LOGOUTBOARD";
        try (Connection con = ConnectionPool.getInstance().dbCon();
             PreparedStatement pstmt = con.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1); // 총 게시글 수 반환
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0; // 오류 발생 시 0 반환
    }

    public List<LogoutBoardVO> getCombinedPosts(int start, int pageSize) {
        List<LogoutBoardVO> combinedPosts = new ArrayList<>();
        String sql = "SELECT * " +
                     "FROM LOGOUTBOARD " +
                     "WHERE type = 'QUESTION' " +
                     "ORDER BY ref ASC, step ASC, depth ASC " +
                     "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection con = ConnectionPool.getInstance().dbCon();
             PreparedStatement pstmt = con.prepareStatement(sql)) {
            pstmt.setInt(1, start);
            pstmt.setInt(2, pageSize);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    LogoutBoardVO post = new LogoutBoardVO();
                    post.setNum(rs.getInt("num"));
                    post.setType(rs.getString("type"));
                    post.setWriter(rs.getString("writer"));
                    post.setEmail(rs.getString("email"));
                    post.setPass(rs.getString("pass"));
                    post.setTitle(rs.getString("title"));
                    post.setReadCount(rs.getInt("readcount"));
                    post.setRegDate(rs.getTimestamp("regdate"));
                    post.setContent(rs.getString("content"));
                    post.setRef(rs.getInt("ref"));
                    post.setStep(rs.getInt("step"));
                    post.setDepth(rs.getInt("depth"));
                    post.setIp(rs.getString("ip"));
                    post.setOriginFile(rs.getString("originfile"));
                    post.setSysFile(rs.getString("sysfile"));
                    combinedPosts.add(post);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return combinedPosts;
    }

    
}
