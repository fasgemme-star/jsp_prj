package kr.co.sist.mypage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import kr.co.sist.dao.GetConnection;
import kr.co.sist.member.MemberDTO;

public class MyPageDAO {
	private static MyPageDAO mpDAO;
	private MyPageDAO() {
	}
	
	public static MyPageDAO getInstance() {
		if (mpDAO == null) {
			mpDAO = new MyPageDAO();
		}
		return mpDAO;
	}// getInstance
	
	public MemberDTO selectUserInfo(String id) throws SQLException {
		MemberDTO mDTO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		GetConnection gc = GetConnection.getInstance();
		
		try {
			con = gc.getConn();
			String query = "	select name, email, phone1, zipcode, address1, address2, profile, ip, inputdate from web_member where id=?	";
			
			pstmt = con.prepareStatement(query);
			
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				mDTO = new MemberDTO();
				mDTO.setId(id);
				mDTO.setName(rs.getString("name"));
				mDTO.setEmail(rs.getString("email"));
				mDTO.setPhone(rs.getString("phone1"));
				mDTO.setZipcode(rs.getString("zipcode"));
				mDTO.setAddress(rs.getString("address1"));
				mDTO.setAddress2(rs.getString("address2"));
				mDTO.setProfile(rs.getString("profile"));
				mDTO.setIp(rs.getString("ip"));
				mDTO.setInputDate(rs.getDate("inputdate"));
			}
			
		} finally {
			gc.dbClose(rs, pstmt, con);
		} 
		
		return mDTO;
	}
	
	
}
