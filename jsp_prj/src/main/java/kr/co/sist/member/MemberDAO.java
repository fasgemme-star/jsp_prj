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
	
	
	public void insertWebmember(MemberDTO mDTO) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		GetConnection gc = GetConnection.getInstance();
		
		try {
			con = gc.getConn();
			StringBuilder query = new StringBuilder();
			query
			.append("	insert into WEB_MEMBER(ID, PASSWORD, NAME, EMAIL, PHONE1, ZIPCODE, ADDRESS1, ADDRESS2, IP, SMSRECEIVEYN, EMAILRECEIVEYN)	")
			.append("	values(?,?,?,?,?,?,?, ?,?,?,?)	");
			
			pstmt = con.prepareStatement(query.toString());
			
			pstmt.setString(1, mDTO.getId());
			pstmt.setString(2, mDTO.getPassword());
			pstmt.setString(3, mDTO.getName());
			pstmt.setString(4, mDTO.getEmail());
			pstmt.setString(5, mDTO.getPhone());
			pstmt.setString(6, mDTO.getZipcode());
			pstmt.setString(7, mDTO.getAddress());
			pstmt.setString(8, mDTO.getAddress2());
			pstmt.setString(9, mDTO.getIp());
			pstmt.setInt(10, mDTO.getSmsReceiveYN());
			pstmt.setInt(11, mDTO.getEmailReceiveYN());
			
			pstmt.executeQuery();
			
		} finally {
			gc.dbClose(null, pstmt, con);
		}
	
	}
	
	public void insertWebmemberHobby(MemberDTO mDTO) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		GetConnection gc = GetConnection.getInstance();
		
		try {
			con = gc.getConn();
			StringBuilder query = new StringBuilder();
			query
			.append("	insert into HOBBY(ID, hobby)	")
			.append("	values(?,?)	");
			
			pstmt = con.prepareStatement(query.toString());
			String[] hobby = mDTO.getHobby();
			for ( int i = 0 ; i < hobby.length; i++) {				
				pstmt.setString(1, mDTO.getId());
				pstmt.setString(2, hobby[i]);
			}
			
			pstmt.executeQuery();
			
		} finally {
			gc.dbClose(null, pstmt, con);
		} // end finally
		
	}// insertWebmemberHobby
	
	
}
