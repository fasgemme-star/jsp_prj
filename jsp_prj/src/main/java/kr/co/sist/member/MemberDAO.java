package kr.co.sist.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import kr.co.sist.dao.GetConnection;

public class MemberDAO {
	private static MemberDAO mDAO;
	private MemberDAO() {
		
	}

	public static MemberDAO getInstance() {
		if(mDAO == null) {
			mDAO = new MemberDAO();
		}
		return mDAO;
	}
	
	public boolean selectId(String id) throws SQLException{
		boolean idFlag = false;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		GetConnection gc = GetConnection.getInstance();
		
		try {
			con = gc.getConn();
			String query = "select 1 from web_member where id=?";
			
			pstmt = con.prepareStatement(query);
			
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			idFlag = rs.next();//레코드의 있으면 true 없으면 false
			
			
		} finally {
			gc.dbClose(rs, pstmt, con);
		} 
		return idFlag;
	}// selectId
}
