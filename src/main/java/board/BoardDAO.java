package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import common.GetConn;

public class BoardDAO {
	private Connection conn = GetConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	private BoardVO vo = null;
	
	public void pstmtClose() {
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch (Exception e) {}
		}
	}
	
	public void rsClose() {
		if(rs != null) {
			try {
				rs.close();
			} catch (Exception e) {} 
			finally {
				pstmtClose();
			}
		}
	}
	

	// 전체 게시글 보기
	public ArrayList<BoardVO> getBoardList(int startIndexNo, int pageSize, String section, String part) {
		ArrayList<BoardVO> vos = new ArrayList<BoardVO>();
		try {
			if(section.equals("board")) {
				if(part.equals("거래분류")) {
				  sql = "select *, datediff(wDate, now()) as date_diff, timestampdiff(hour, wDate, now()) as hour_diff, "
				  		+ "(select count(*) from junggoboardReply where boardIdx = b.idx) as replyCnt "
				  		+ "from junggoboard b order by idx desc limit ?,?";
				  pstmt = conn.prepareStatement(sql);
				  pstmt.setInt(1, startIndexNo);
				  pstmt.setInt(2, pageSize);
				}
				else {
					sql = "select *, datediff(wDate, now()) as date_diff, timestampdiff(hour, wDate, now()) as hour_diff, "
				  		+ "(select count(*) from junggoboardReply where boardIdx = b.idx) as replyCnt "
				  		+ "from junggoboard b where part = ? order by idx desc limit ?,?";
				  pstmt = conn.prepareStatement(sql);
				  pstmt.setString(1, part);
				  pstmt.setInt(2, startIndexNo);
				  pstmt.setInt(3, pageSize);
				}
			  rs = pstmt.executeQuery();
			}
			while(rs.next()) {
				vo = new BoardVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setNickName(rs.getString("nickName"));
				vo.setTitle(rs.getString("title"));
				vo.setContent(rs.getString("content"));
				vo.setReadNum(rs.getInt("readNum"));
				vo.setPart(rs.getString("part"));
				vo.setPrice(rs.getInt("price"));
				vo.setOpenSw(rs.getString("openSw"));
				vo.setwDate(rs.getString("wDate"));
				vo.setGood(rs.getInt("good"));
				vo.setComplaint(rs.getString("complaint"));
				
				vo.setHour_diff(rs.getInt("hour_diff"));
				vo.setDate_diff(rs.getInt("date_diff"));
				
				vo.setReplyCnt(rs.getInt("replyCnt"));
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류.. : " + e.getMessage());
			e.printStackTrace();
		} finally {
			rsClose();			
		}
		return vos;
	}

	// 게시글 등록하기
	public int setBoardInput(BoardVO vo) {
		int res = 0;
		try {
			sql = "insert into junggoboard values (default,?,?,?,?,default,?,?,default,default,default,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getMid());
			pstmt.setString(2, vo.getNickName());
			pstmt.setString(3, vo.getTitle());
			pstmt.setString(4, vo.getContent());
			pstmt.setInt(5, vo.getPrice());
			pstmt.setString(6, vo.getOpenSw());
			pstmt.setString(7, vo.getPart());
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();			
		}
		return res;
	}

	// 게시글 내용보기
	public BoardVO getBoardContent(int idx) {
		BoardVO vo = new BoardVO();
		try {
			sql = "select * from junggoboard where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setNickName(rs.getString("nickName"));
				vo.setTitle(rs.getString("title"));
				vo.setContent(rs.getString("content"));
				vo.setReadNum(rs.getInt("readNum"));
				vo.setPart(rs.getString("part"));
				vo.setPrice(rs.getInt("price"));
				vo.setOpenSw(rs.getString("openSw"));
				vo.setwDate(rs.getString("wDate"));
				vo.setGood(rs.getInt("good"));
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();			
		}
		return vo;
	}

	// 조회수 증가처리
	public void setBoardReadNumPlus(int idx) {
		try {
			sql = "update junggoboard set readNum = readNum + 1 where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();			
		}
	}

	// 게시글 삭제하기
	public int setBoardDelete(int idx) {
		int res = 0;
		try {
			sql = "delete from junggoboard where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();			
		}
		return res;
	}
	
  // 게시물 총 레코드 건수  : (관리자옵션,게시물이름,분류명)  예: ("", "board", "신발")
	public int getTotRecCnt(String section, String part) {
		int totRecCnt = 0;
		try {
			if(section.equals("board")) {
				if(part.equals("거래분류")) {
					sql = "select count(*) as cnt from junggoboard";
				  pstmt = conn.prepareStatement(sql);
				}
				else {
					sql = "select count(*) as cnt from junggoboard where part = ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, part);
				}
			}
			rs = pstmt.executeQuery();
			rs.next();
			totRecCnt = rs.getInt("cnt");
		} catch (SQLException e) {
			System.out.println("SQL 오류!! : " + e.getMessage());
		} finally {
			rsClose();			
		}
		return totRecCnt;
	}

	// 이전글/다음글 idx,title가져오기
	public BoardVO getPreNextSearch(int idx, String str) {
		BoardVO vo = new BoardVO();
		try {
			if(str.equals("preVo")) sql = "select idx, title from junggoboard where idx < ? order by idx desc limit 1";
			else sql = "select idx, title from junggoboard where idx > ? order by idx limit 1";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				vo.setIdx(rs.getInt("idx"));
				vo.setTitle(rs.getString("title"));
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();			
		}
		return vo;
	}

	// 좋아요수 증가처리
	public int setBoardGoodCheck(int idx) {
		int res = 0;
		try {
			sql = "update junggoboard set good = good + 1 where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();			
		}
		return res;
	}

	// 좋아요수 증가/감소 처리
	public void setBoardGoodCheckPlusMinus(int idx, int goodCnt) {
		try {
			sql = "update junggoboard set good = good + ? where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, goodCnt);
			pstmt.setInt(2, idx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();			
		}
	}

	// 게시글 수정하기
	public int setBoardUpdateOk(BoardVO vo) {
		int res = 0;
		try {
			sql = "update junggoboard set title=?, content=?, openSw=?, price=?, wDate=now() where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getTitle());
			pstmt.setString(2, vo.getContent());
			pstmt.setString(3, vo.getOpenSw());
			pstmt.setInt(4, vo.getPrice());
			pstmt.setInt(5, vo.getIdx());
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();			
		}
		return res;
	}

	// 댓글 저장하기
	public int setReplyInput(BoardReplyVO vo) {
		int res = 0;
		try {
			sql = "insert into junggoboardReply values (default,?,?,?,default,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, vo.getBoardIdx());
			pstmt.setString(2, vo.getMid());
			pstmt.setString(3, vo.getNickName());
			pstmt.setString(4, vo.getContent());
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();			
		}
		return res;
	}

	// 댓글 삭제처리
	public int setBoardReplyDelete(int idx) {
		int res = 0;
		try {
			sql = "delete from junggoboardReply where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();			
		}
		return res;
	}

	// 작성된 댓글 가져오기
	public ArrayList<BoardReplyVO> getBoardReply(int idx) {
		ArrayList<BoardReplyVO> replyVos = new ArrayList<>();
		try {
			sql = "select * from junggoboardReply where boardIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			
			BoardReplyVO vo = null;
			while(rs.next()) {
				vo = new BoardReplyVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setBoardIdx(rs.getInt("boardIdx"));
				vo.setMid(rs.getString("mid"));
				vo.setNickName(rs.getString("nickName"));
				vo.setwDate(rs.getString("wDate"));
				vo.setContent(rs.getString("content"));
				
				replyVos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();			
		}
		return replyVos;
	}
	
	// 게시판 조건별 검색 리스트
	public int getTotRecCnt(String section, String search, String searchString) {
		int totRecCnt = 0;
		try {
			if(section.equals("board")) {
				if(search.equals("")) {
					sql = "select count(*) as cnt from junggoboard";
				  pstmt = conn.prepareStatement(sql);
				}
				else {
					sql = "select count(*) as cnt from junggoboard where "+search+" like ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, "%"+searchString+"%");
				}
			}
			rs = pstmt.executeQuery();
			rs.next();
			totRecCnt = rs.getInt("cnt");
		} catch (SQLException e) {
			System.out.println("SQL 오류!! : " + e.getMessage());
		} finally {
			rsClose();			
		}
		return totRecCnt;
	}

	public List<BoardVO> getBoardList(int startIndexNo, int pageSize, String section, String search, String searchString) {
		ArrayList<BoardVO> vos = new ArrayList<BoardVO>();
		try {
			if(section.equals("board")) {
				if(search.equals("")) {
				  sql = "select *, datediff(wDate, now()) as date_diff, timestampdiff(hour, wDate, now()) as hour_diff, "
				  		+ "(select count(*) from junggoboardReply where boardIdx = b.idx) as replyCnt "
				  		+ "from junggoboard b order by idx desc limit ?,?";
				  pstmt = conn.prepareStatement(sql);
				  pstmt.setInt(1, startIndexNo);
				  pstmt.setInt(2, pageSize);
				}
				else {
					sql = "select *, datediff(wDate, now()) as date_diff, timestampdiff(hour, wDate, now()) as hour_diff, "
				  		+ "(select count(*) from junggoboardReply where boardIdx = b.idx) as replyCnt "
				  		+ "from junggoboard b where "+search+" like ? order by idx desc limit ?,?";
				  pstmt = conn.prepareStatement(sql);
				  pstmt.setString(1, "%"+searchString+"%");
				  pstmt.setInt(2, startIndexNo);
				  pstmt.setInt(3, pageSize);
				}
			  rs = pstmt.executeQuery();
			}
			while(rs.next()) {
				vo = new BoardVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setNickName(rs.getString("nickName"));
				vo.setTitle(rs.getString("title"));
				vo.setContent(rs.getString("content"));
				vo.setReadNum(rs.getInt("readNum"));
				vo.setPart(rs.getString("part"));
				vo.setPrice(rs.getInt("price"));
				vo.setOpenSw(rs.getString("openSw"));
				vo.setwDate(rs.getString("wDate"));
				vo.setGood(rs.getInt("good"));
				vo.setComplaint(rs.getString("complaint"));
				
				vo.setHour_diff(rs.getInt("hour_diff"));
				vo.setDate_diff(rs.getInt("date_diff"));
				
				vo.setReplyCnt(rs.getInt("replyCnt"));
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류.. : " + e.getMessage());
			e.printStackTrace();
		} finally {
			rsClose();			
		}
		return vos;
	}

}
