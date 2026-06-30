package kr.co.sist.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import kr.co.sist.dao.GetConnection;
import kr.co.sist.member.MemberDTO;

public class BoardDAO {
	private static BoardDAO mpDAO;
	private BoardDAO() {
	}
	
	public static BoardDAO getInstance() {
		if (mpDAO == null) {
			mpDAO = new BoardDAO();
		}
		return mpDAO;
	}// getInstance
	
	public int selectTotalCount() throws SQLException {
		int totalCount = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		GetConnection gc = GetConnection.getInstance();
		
		try {
			con = gc.getConn();
			String query = "	select count(*) cnt from board	";
			
			pstmt = con.prepareStatement(query);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				totalCount=rs.getInt("cnt");
			}
			
		} finally {
			gc.dbClose(rs, pstmt, con);
		} 
		
		return totalCount;
	}
	
	
}
