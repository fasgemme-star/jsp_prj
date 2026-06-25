package manage.dashboard;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import dbcon.DbConnection;
import dbcon.Path;

public class DashBoardDAO {
	private static DashBoardDAO dDAO;
	private DashBoardDAO() {}
	
	public static DashBoardDAO getInstance() {
		if (dDAO == null) {
			dDAO = new DashBoardDAO();
		}
		return dDAO;
	} // getInstance()
	
	public int selectTotalSales() throws SQLException {
		DbConnection dbcon = DbConnection.getInstance();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder query = new StringBuilder();
		int total = -1;
		try {
			con = dbcon.getConn(new File(Path.DATABASE_PROPERTIES));
			
			query.append("select sum(total_amount) sum from \"order\"");
			pstmt = con.prepareStatement(query.toString());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				total = rs.getInt("sum");
			}
		} finally { 
			// 6.연결 끊기
			dbcon.dbClose(rs, pstmt, con);
		} // end finally
		
		return total;
	}// selectTotalSales
	
	public int selectNewClientWeekly() throws SQLException {
		DbConnection dbcon = DbConnection.getInstance();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder query = new StringBuilder();
		int total = -1;
		try {
			con = dbcon.getConn(new File(Path.DATABASE_PROPERTIES));
			
			query.append("select count(1) cnt from client where client_start_date >= SYSDATE-7");
			pstmt = con.prepareStatement(query.toString());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				total = rs.getInt("cnt");
			}
		} finally { 
			// 6.연결 끊기
			dbcon.dbClose(rs, pstmt, con);
		} // end finally
		
		return total;
		
	}// selectNewClientWeekly
	
	public int selectProductOnNow() throws SQLException {
		DbConnection dbcon = DbConnection.getInstance();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "select count(1) cnt from product where is_deleted = 'N'";
		int cnt = 0;
		try {
			con = dbcon.getConn(new File(Path.DATABASE_PROPERTIES));
			
			pstmt = con.prepareStatement(query);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				cnt = rs.getInt("cnt");
			}
		} finally { 
			// 6.연결 끊기
			dbcon.dbClose(rs, pstmt, con);
		} // end finally
		
		return cnt;
	}// selectProductOnNow
	
	public int selectNonInquiryCount() throws SQLException {
		DbConnection dbcon = DbConnection.getInstance();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder query = new StringBuilder();
		int total = -1;
		try {
			con = dbcon.getConn(new File(Path.DATABASE_PROPERTIES));
			
			query.append("select count(1) cnt from inquiry where answer_status = '대기중'");
			pstmt = con.prepareStatement(query.toString());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				total = rs.getInt("cnt");
			}
		} finally { 
			// 6.연결 끊기
			dbcon.dbClose(rs, pstmt, con);
		} // end finally
		
		return total;
	}// selectNonInquiryCount
	
	public int[] selectNewClientCount() throws SQLException {
		DbConnection dbcon = DbConnection.getInstance();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder query = new StringBuilder();
		int[] newClientArr = null;
		int i=0;
		try {
			con = dbcon.getConn(new File(Path.DATABASE_PROPERTIES));
			query.append("	select cnt, year from(	");
			query.append("	select count(1) cnt, to_char(CLIENT_START_DATE,'YYYY-MM') as year from client	");
			query.append("	group by to_char(CLIENT_START_DATE,'YYYY-MM') order by year)	");
			query.append("	where year between TO_CHAR(ADD_MONTHS(SYSDATE,-12),'YYYY')||'-01' and TO_CHAR(ADD_MONTHS(SYSDATE,-12),'YYYY')||'-12'	");
			
			pstmt = con.prepareStatement(query.toString());
			rs = pstmt.executeQuery();
			newClientArr = new int[12];
			if(rs.next()) {
				newClientArr[i++] = rs.getInt("cnt");
			}
		} finally { 
			// 6.연결 끊기
			dbcon.dbClose(rs, pstmt, con);
		} // end finally
		
		return newClientArr;
	}// selectNewClientCount
	
	public int[] selectclientDropOut() throws SQLException {
		DbConnection dbcon = DbConnection.getInstance();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder query = new StringBuilder();
		int[] newClientArr = null;
		int i=0;
		try {
			con = dbcon.getConn(new File(Path.DATABASE_PROPERTIES));
			query.append("	select cnt, year from(	");
			query.append("	select count(1) cnt, to_char(CLIENT_START_DATE,'YYYY-MM') as year from client	");
			query.append("	group by to_char(CLIENT_START_DATE,'YYYY-MM') order by year)	");
			query.append("	where is_deleted = 'Y' year between TO_CHAR(ADD_MONTHS(SYSDATE,-12),'YYYY')||'-01' and TO_CHAR(ADD_MONTHS(SYSDATE,-12),'YYYY')||'-12'	");
			
			pstmt = con.prepareStatement(query.toString());
			rs = pstmt.executeQuery();
			newClientArr = new int[12];
			if(rs.next()) {
				newClientArr[i++] = rs.getInt("cnt");
			}
		} finally { 
			// 6.연결 끊기
			dbcon.dbClose(rs, pstmt, con);
		} // end finally
		
		return newClientArr;
	}// selectclientDropOut
	
	public List<Map<String, Integer>> selectBestProduct(){
		List<Map<String, Integer>> bList = new ArrayList<Map<String,Integer>>();
		
		return bList;
	}// selectBestProduct
	
	
}
