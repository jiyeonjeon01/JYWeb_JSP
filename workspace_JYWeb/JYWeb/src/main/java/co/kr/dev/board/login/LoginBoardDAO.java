package co.kr.dev.board.login;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import co.kr.dev.common.ConnectionPool;

public class LoginBoardDAO {
	// 싱글톤1
	private static LoginBoardDAO instance;

	// 싱글톤2
	private LoginBoardDAO() {
		}

	// 싱글톤3
	public static LoginBoardDAO getInstance() {
		if (instance == null) {
			synchronized (LoginBoardDAO.class) {
				instance = new LoginBoardDAO();
			}
		}
		return instance;
	}
	
	
	
	private final String SELECT_SQL = "SELECT * FROM LOGINBOARD ORDER BY NUM DESC";
	private final String SELECT_START_END_SQL = "SELECT * FROM "
			+ "(SELECT ROWNUM AS RNUM, NUM, TYPE, STUDENT_ID, TITLE, READCOUNT, REGDATE, CONTENT, REF, STEP, DEPTH, IP, ORIGINFILE, SYSFILE"
			+ "FROM (SELECT * FROM LOGINBOARD ORDER BY REF DESC, STEP ASC)) WHERE NUM RNUM >= ? AND RNUM <= ?";
	private final String SELECT_COUNT_SQL = "SELECT COUNT(*) AS COUNT FROM LOGINBOARD";
	private final String SELECT_MAX_NUM_SQL = "SELECT MAX(NUM) AS NUM FROM LOGINBOARD";
	private final String SELECT_ONE_SQL = "SELECT * FROM LOGINBOARD WHERE NUM = ?";
	private final String SELECT_BY_ID_SQL = "SELECT COUNT(*) AS COUNT FROM STUDENT WHERE ID = ?";
	private final String INSERT_SQL = "INSERT INTO LOGINBOARD(NUM, TYPE, STUDENT_ID, TITLE, READCOUNT, REGDATE, CONTENT, REF, STEP, DEPTH, IP, ORIGINFILE, SYSFILE )"
			+ "VALUES (LOGINBOARD_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	private final String DELETE_SQL = "DELETE FROM LOGINBOARD WHERE NUM = ?";
	private final String UPDATE_SQL = "UPDATE LOGINBOARD SET TITLE = ?, CONTENT = ?, ORIGINFILE = ?, SYSFILE = ?, TYPE = ? WHERE NUM = ?";

	private final String UPDATE_STEP_SQL = "UPDATE LOGINBOARD SET STEP=STEP+1 WHERE REF = ? AND STEP > ? ";
	private final String UPDATE_READCOUNT_SQL = "UPDATE LOGINBOARD SET READCOUNT = READCOUNT + 1 WHERE NUM = ?";
	// SQL 선언 부분 (LoginBoardDAO 클래스 내부)
//	private final String SELECT_ONE_SQL = "SELECT NUM, TYPE, STUDENT_ID, TITLE, READCOUNT, REGDATE, CONTENT, REF, STEP, DEPTH, IP, ORIGINFILE, SYSFILE " +
//	                                      "FROM LOGINBOARD WHERE NUM = ?";
//	private final String UPDATE_READCOUNT_SQL = "UPDATE LOGINBOARD SET READCOUNT = READCOUNT + 1 WHERE NUM = ?";


	// Select all posts
    public ArrayList<LoginBoardVO> selectAll() {
        ArrayList<LoginBoardVO> boardList = new ArrayList<>();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            con = ConnectionPool.getInstance().dbCon();
            pstmt = con.prepareStatement(SELECT_SQL);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                boardList.add(extractVO(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionPool.getInstance().dbClose(con, pstmt, rs);
        }
        return boardList;
    }

 // Select a single post by num
    public LoginBoardVO selectOne(int num) {
        LoginBoardVO board = null;
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            con = ConnectionPool.getInstance().dbCon();
            pstmt = con.prepareStatement(SELECT_ONE_SQL);
            pstmt.setInt(1, num);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                board = extractVO(rs);
                // 디버깅: 게시글 정보를 출력
                System.out.println("게시글 정보: " + board.toString());
            } else {
                System.out.println("게시글을 찾을 수 없습니다. num=" + num);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionPool.getInstance().dbClose(con, pstmt, rs);
        }
        return board;
    }

    
    
    public LoginBoardVO selectBoardDB(LoginBoardVO vo) {
        LoginBoardVO bvo = null;
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            con = ConnectionPool.getInstance().dbCon();

            // 조회수 증가
            pstmt = con.prepareStatement(UPDATE_READCOUNT_SQL);
            pstmt.setInt(1, vo.getNum());
            pstmt.executeUpdate();
            pstmt.close(); // PreparedStatement 닫기

            // 게시글 데이터 가져오기
            pstmt = con.prepareStatement(SELECT_ONE_SQL);
            pstmt.setInt(1, vo.getNum());
            rs = pstmt.executeQuery();
            if (rs.next()) {
                bvo = extractVO(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionPool.getInstance().dbClose(con, pstmt, rs); // 연결 반환
        }

        // 데이터가 없는 경우 기본값 설정
        if (bvo == null) {
            bvo = new LoginBoardVO();
            bvo.setTitle("게시글이 존재하지 않습니다.");
            bvo.setContent("내용이 없습니다.");
            bvo.setReadCount(0);
            bvo.setStudentId("알 수 없음");
        }

        return bvo;
    }



    
    

    // Insert a new post
    public boolean insert(LoginBoardVO vo) {
        Connection con = null;
        PreparedStatement pstmt = null;
        int count = 0;

        try {
            con = ConnectionPool.getInstance().dbCon();

            // 답글인지 확인하고 ref, step, depth 설정
            int ref = vo.getNum() == 0 ? getMaxNum() + 1 : vo.getRef();
            int step = vo.getNum() == 0 ? 0 : vo.getStep() + 1;
            int depth = vo.getNum() == 0 ? 0 : vo.getDepth() + 1;

            if (vo.getNum() != 0) {
                // 답글인 경우 step 업데이트
                updateStep(ref, step);
            }

            pstmt = con.prepareStatement(INSERT_SQL);
            pstmt.setString(1, vo.getType());                 // TYPE
            pstmt.setString(2, vo.getStudentId());            // STUDENT_ID
            pstmt.setString(3, vo.getTitle());                // TITLE
            pstmt.setInt(4, 0);                               // READCOUNT (기본값 0)
            pstmt.setTimestamp(5, new Timestamp(System.currentTimeMillis())); // REGDATE
            pstmt.setString(6, vo.getContent());              // CONTENT
            pstmt.setInt(7, ref);                             // REF
            pstmt.setInt(8, step);                            // STEP
            pstmt.setInt(9, depth);                           // DEPTH
            pstmt.setString(10, vo.getIp());                  // IP
            pstmt.setString(11, vo.getOriginFile());          // ORIGINFILE
            pstmt.setString(12, vo.getSysFile());             // SYSFILE

            count = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionPool.getInstance().dbClose(con, pstmt);
        }
        return count > 0;
    }


    public boolean update(LoginBoardVO vo) {
        Connection con = null;
        PreparedStatement pstmt = null;
        int count = 0;

        try {
            con = ConnectionPool.getInstance().dbCon();
            pstmt = con.prepareStatement(UPDATE_SQL);

            // 디버깅 메시지 추가
            System.out.println("Executing UPDATE query...");
            System.out.println("SQL Query: " + UPDATE_SQL);
            System.out.println("TITLE: " + vo.getTitle());
            System.out.println("CONTENT: " + vo.getContent());
            System.out.println("ORIGINFILE: " + vo.getOriginFile());
            System.out.println("SYSFILE: " + vo.getSysFile());
            System.out.println("TYPE: " + vo.getType());
            System.out.println("NUM: " + vo.getNum());

            pstmt.setString(1, vo.getTitle());
            pstmt.setString(2, vo.getContent());
            pstmt.setString(3, vo.getOriginFile());
            pstmt.setString(4, vo.getSysFile());
            pstmt.setString(5, vo.getType());
            pstmt.setInt(6, vo.getNum());

            count = pstmt.executeUpdate();
            System.out.println("Rows affected: " + count); // 실행 결과 확인
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionPool.getInstance().dbClose(con, pstmt);
        }
        return count > 0;
    }


    // Delete a post
    public boolean delete(int num) {
        Connection con = null;
        PreparedStatement pstmt = null;
        int count = 0;

        try {
            con = ConnectionPool.getInstance().dbCon();
            pstmt = con.prepareStatement(DELETE_SQL);
            pstmt.setInt(1, num);

            count = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionPool.getInstance().dbClose(con, pstmt);
        }
        return count > 0;
    }

    // Update read count
    public void updateReadCount(int num) {
        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            con = ConnectionPool.getInstance().dbCon();
            pstmt = con.prepareStatement(UPDATE_READCOUNT_SQL);
            pstmt.setInt(1, num);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionPool.getInstance().dbClose(con, pstmt);
        }
    }

    // Update step for replies
    private void updateStep(int ref, int step) {
        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            con = ConnectionPool.getInstance().dbCon();
            pstmt = con.prepareStatement(UPDATE_STEP_SQL);
            pstmt.setInt(1, ref);
            pstmt.setInt(2, step);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionPool.getInstance().dbClose(con, pstmt);
        }
    }

    // Get max num for new posts
    private int getMaxNum() {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int maxNum = 0;

        try {
            con = ConnectionPool.getInstance().dbCon();
            pstmt = con.prepareStatement("SELECT MAX(NUM) AS NUM FROM LOGINBOARD");
            rs = pstmt.executeQuery();

            if (rs.next()) {
                maxNum = rs.getInt("NUM");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionPool.getInstance().dbClose(con, pstmt, rs);
        }
        return maxNum;
    }

    private LoginBoardVO extractVO(ResultSet rs) throws SQLException {
        return new LoginBoardVO(
            rs.getInt("NUM"),
            rs.getString("TYPE"),
            rs.getString("STUDENT_ID"),
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
    public ArrayList<LoginBoardVO> getAllPosts(int start, int end) {
        String sql = "SELECT * FROM ("
                   + "SELECT ROWNUM AS RNUM, A.* FROM ("
                   + "SELECT * FROM LOGINBOARD ORDER BY REF DESC, STEP ASC) A "
                   + "WHERE ROWNUM <= ?) WHERE RNUM >= ?";
        ArrayList<LoginBoardVO> list = new ArrayList<>();
        try (Connection con = ConnectionPool.getInstance().dbCon();
             PreparedStatement pstmt = con.prepareStatement(sql)) {
            pstmt.setInt(1, end);
            pstmt.setInt(2, start);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                list.add(extractVO(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    
    
    public int getPostCountByType(String type) {
        String sql = "SELECT COUNT(*) FROM LOGINBOARD WHERE TYPE = ?";
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            con = ConnectionPool.getInstance().dbCon();
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, type);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionPool.getInstance().dbClose(con, pstmt, rs); // 연결 닫기
        }
        return 0;
    }

    
    
    public ArrayList<LoginBoardVO> getPostsByType(String type, int start, int end) {
        String sql = "SELECT * FROM ("
                   + "SELECT ROWNUM AS RNUM, A.* FROM ("
                   + "SELECT * FROM LOGINBOARD WHERE TYPE = ? ORDER BY REF DESC, STEP ASC) A "
                   + "WHERE ROWNUM <= ?) WHERE RNUM >= ?";
        ArrayList<LoginBoardVO> list = new ArrayList<>();
        try (Connection con = ConnectionPool.getInstance().dbCon();
             PreparedStatement pstmt = con.prepareStatement(sql)) {
            pstmt.setString(1, type);
            pstmt.setInt(2, end);
            pstmt.setInt(3, start);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                LoginBoardVO vo = new LoginBoardVO();
                vo.setNum(rs.getInt("NUM"));
                vo.setTitle(rs.getString("TITLE"));
                vo.setStudentId(rs.getString("STUDENT_ID"));
                vo.setReadCount(rs.getInt("READCOUNT"));
                vo.setRegDate(rs.getTimestamp("REGDATE"));
                vo.setContent(rs.getString("CONTENT"));
                vo.setRef(rs.getInt("REF"));
                vo.setStep(rs.getInt("STEP"));
                vo.setDepth(rs.getInt("DEPTH"));
                vo.setIp(rs.getString("IP"));
                list.add(vo);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    
    public List<LoginBoardVO> selectRecentPosts(int limit) {
        List<LoginBoardVO> list = new ArrayList<>();
        String sql = "SELECT * FROM LOGINBOARD ORDER BY REGDATE DESC FETCH FIRST ? ROWS ONLY";
        try (Connection conn = ConnectionPool.getInstance().dbCon();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, limit);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    list.add(extractVO(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }



 // 특정 사용자가 작성한 게시글 조회
    public List<LoginBoardVO> getPostsByUserId(String userId) {
        List<LoginBoardVO> posts = new ArrayList<>();
        // STUDENT_ID를 기준으로 게시글 조회
        String sql = "SELECT * FROM LOGINBOARD WHERE STUDENT_ID = ? ORDER BY REGDATE DESC";

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


    public int getPostCount() {
        String sql = "SELECT COUNT(*) FROM LOGINBOARD";
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


    public List<LoginBoardVO> getCombinedPosts(int start, int pageSize) {
        List<LoginBoardVO> combinedPosts = new ArrayList<>();
        String sql = "SELECT * " +
                     "FROM LOGINBOARD " +
                     "WHERE type IN ('QUESTION', 'ANSWER') " +
                     "ORDER BY ref ASC, step ASC, depth ASC " +
                     "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection con = ConnectionPool.getInstance().dbCon();
             PreparedStatement pstmt = con.prepareStatement(sql)) {
            pstmt.setInt(1, start);
            pstmt.setInt(2, pageSize);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    LoginBoardVO post = new LoginBoardVO();
                    post.setNum(rs.getInt("num"));
                    post.setType(rs.getString("type"));
                    post.setTitle(rs.getString("title"));
                    post.setStudentId(rs.getString("student_id"));
                    post.setRegDate(rs.getTimestamp("regdate"));
                    post.setReadCount(rs.getInt("readcount"));
                    post.setIp(rs.getString("ip"));
                    post.setRef(rs.getInt("ref"));
                    post.setStep(rs.getInt("step"));
                    post.setDepth(rs.getInt("depth"));
                    combinedPosts.add(post);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return combinedPosts;
    }


    
    

}
