package admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import admin.complaint.ComplaintVO;
//import admin.review.ReviewVO;
import common.GetConn;
import member.MemberVO;

public class AdminDAO {
	private Connection conn = GetConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	
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

	// 회원 전체/부분 리스트
	public ArrayList<MemberVO> getMemberList(int startIndexNo, int pageSize, int level) {
		ArrayList<MemberVO> vos = new ArrayList<MemberVO>();
		try {
			if(level == 999) {
				sql = "select *, timestampdiff(day, lastDate, now()) as deleteDiff from junggomember order by idx desc limit ?,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, startIndexNo);
				pstmt.setInt(2, pageSize);
			}
			else {
				sql = "select *, timestampdiff(day, lastDate, now()) as deleteDiff  from junggomember where level = ? order by idx desc limit ?,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, level);
				pstmt.setInt(2, startIndexNo);
				pstmt.setInt(3, pageSize);
			}
			rs = pstmt.executeQuery();
			
			MemberVO vo = null;
			while(rs.next()) {
				vo = new MemberVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setPwd(rs.getString("pwd"));
				vo.setNickName(rs.getString("nickName"));
				vo.setName(rs.getString("name"));
				vo.setGender(rs.getString("gender"));
				vo.setBirthday(rs.getString("birthday"));
				vo.setTel(rs.getString("tel"));
				vo.setAddress(rs.getString("address"));
				vo.setEmail(rs.getString("email"));
				vo.setPhoto(rs.getString("photo"));
				vo.setContent(rs.getString("content"));
				vo.setUserInfor(rs.getString("userInfor"));
				vo.setUserDel(rs.getString("userDel"));
				vo.setPoint(rs.getInt("point"));
				vo.setLevel(rs.getInt("level"));
				vo.setVisitCnt(rs.getInt("visitCnt"));
				vo.setStartDate(rs.getString("startDate"));
				vo.setLastDate(rs.getString("lastDate"));
				vo.setTodayCnt(rs.getInt("todayCnt"));
				
				vo.setDeleteDiff(rs.getInt("deleteDiff"));
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();			
		}
		return vos;
	}

	// 회원 등급 변경처리
	public int setMemberLevelChange(int idx, int level) {
		int res = 0;
		try {
			if(level == 99) {
				sql = "update junggomember set level = ?, lastDate=now(), userDel='OK' where idx = ?";
			}
			else {
				sql = "update junggomember set level = ?, userDel='NO' where idx = ?";				
			}
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, level);
			pstmt.setInt(2, idx);
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();			
		}
		return res;
	}

	// 회원 DB에서 삭제처리하기
	public int MemberDeleteOk(int idx) {
		int res = 0;
		try {
			sql = "delete from junggomember where idx = ?";
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

	// 신규회원 건수
	public int getNewMemberListCount() {
		int mCount = 0;
		try {
			sql = "select count(idx) as cnt from junggomember where level = 1";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			rs.next();
			mCount = rs.getInt("cnt");
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();			
		}
		return mCount;
	}
	
	// 각 레벨별 건수 구하기
	public int getTotRecCnt(int level) {
		int totRecCnt = 0;
		try { 
			if(level == 999) {
				sql = "select count(*) as cnt from junggomember";
				pstmt = conn.prepareStatement(sql);
			}
			else {
				sql = "select count(*) as cnt  from junggomember where level = ? order by idx desc";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, level);
			}
			rs = pstmt.executeQuery();
			rs.next();
			totRecCnt = rs.getInt("cnt");
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();			
		}
		return totRecCnt;
	}

	// 신고내역 저장하기
	public int setBoardComplaintInput(ComplaintVO vo) {
	int res = 0;
	try {
		sql = "insert into junggocomplaint values (default, ?, ?, ?, ?, default)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, vo.getPart());
		pstmt.setInt(2, vo.getPartIdx());
		pstmt.setString(3, vo.getCpMid());
		pstmt.setString(4, vo.getCpContent());
		res = pstmt.executeUpdate();
	} catch (SQLException e) {
		System.out.println("SQL 오류 : " + e.getMessage());
	} finally {
		pstmtClose();			
	}
		return res;
	}

	// 신고글 유무 체크하기
	public String getReport(String part, int partIdx) {
		String report = "NO";
		try {
			sql = "select * from junggocomplaint where part = ? and partIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, part);
			pstmt.setInt(2, partIdx);
			rs = pstmt.executeQuery();
			
			if(rs.next()) report = "OK";
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();			
		}
		return report;
	}

	// 신고 전체 목록
	public ArrayList<ComplaintVO> ComplaintList() {
		ArrayList<ComplaintVO> vos = new ArrayList<ComplaintVO>();
		try {
			sql = "select date_format(c.cpDate, '%Y-%m-%d %H:%i') as cpDate, c.*, b.title as title, b.nickName as nickName, b.mid as mid, b.content as content, b.complaint as complaint "
					+ "from junggocomplaint c, junggoboard b where c.partIdx = b.idx order by idx desc";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			ComplaintVO vo = null;
			while(rs.next()) {
				vo = new ComplaintVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setPart(rs.getString("part"));
				vo.setPartIdx(rs.getInt("partIdx"));
				vo.setCpMid(rs.getString("cpMid"));
				vo.setCpContent(rs.getString("cpContent"));
				vo.setCpDate(rs.getString("cpDate"));
				
				vo.setTitle(rs.getString("title"));
				vo.setNickName(rs.getString("nickName"));
				vo.setMid(rs.getString("mid"));
				vo.setComplaint(rs.getString("complaint"));
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();			
		}
		return vos;
	}
	
	
	public void setComplaintCheck(String part, int partIdx, String complaint) {
		try {
			if(complaint.equals("NO")) {
				sql = "update "+part+" set junggocomplaint = 'OK' where idx = ?";
			}
			else {
				sql = "update "+part+" set junggocomplaint = 'NO' where idx = ?";
			}
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, partIdx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();			
		}
	}
	
	//신고글 삭제하기 
	public int setDeleteComplaint(int idx) {
		int res = 0;
	   try {
	       sql = "delete from junggocomplaint where idx = ?";
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

	// 신고글 수 확인
	public int getMemberReportListCount() {
		int rCount = 0;
		try {
			sql = "select count(*) as cnt from junggocomplaint";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			rs.next();
			rCount = rs.getInt("cnt");
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();			
		}
		return rCount;
	}

	public int getMemberBoardNewListCount() {
		int bCount = 0;
		try {
			sql = "select count(*) as cnt from junggoboard";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			rs.next();
			bCount = rs.getInt("cnt");
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();			
		}
		return bCount;
	}

}
