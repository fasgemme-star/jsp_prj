package manage.category;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dbcon.DbConnection;
import dbcon.Path;

public class CategoryDAO {
	private static CategoryDAO cDAO;
	private CategoryDAO() {}
	
	public static CategoryDAO getInstance() {
		if (cDAO == null) {
			cDAO = new CategoryDAO();
		}
		return cDAO;
	} // getInstance()
	
	public int insertCategory(String name) throws SQLException {
		DbConnection dbcon = DbConnection.getInstance();
		Connection con = null;
		PreparedStatement pstmt = null;
		String query = "INSERT INTO CATEGORY (category_id, category_name) VALUES ('C004', ?)";
		int cnt = 0;
		try {
			con = dbcon.getConn(new File(Path.DATABASE_PROPERTIES));
			
			pstmt = con.prepareStatement(query);
			pstmt.setString(1,name);
			cnt = pstmt.executeUpdate();
			
		} finally { 
			// 6.연결 끊기
			dbcon.dbClose(null, pstmt, con);
		} // end finally
		return cnt;
	}// insertCategory
	
	public int updateCategory(String categoryID, String newName) throws SQLException {
		DbConnection dbcon = DbConnection.getInstance();
		Connection con = null;
		PreparedStatement pstmt = null;
		String query = "UPDATE category SET category_name = ? WHERE category_id = ?";
		int cnt = 0;
		
		try {
			con = dbcon.getConn(new File(Path.DATABASE_PROPERTIES));

			pstmt = con.prepareStatement(query);
			pstmt.setString(1, newName);
	        pstmt.setString(2, categoryID);
			cnt = pstmt.executeUpdate();
			
		} finally { 
			// 6.연결 끊기
			dbcon.dbClose(null, pstmt, con);
		} // end finally
		
		return cnt;
	}// updateCategory
	
	public int deleteCategory(String categoryID) throws SQLException {
		DbConnection dbcon = DbConnection.getInstance();
		Connection con = null;
		PreparedStatement pstmt = null;
		String query = "UPDATE category SET isdeleted = 'Y' WHERE category_id = ?";
		int cnt = 0;
		
		try {
			con = dbcon.getConn(new File(Path.DATABASE_PROPERTIES));

			pstmt = con.prepareStatement(query);
	        
	        pstmt.setString(1, categoryID);
			cnt = pstmt.executeUpdate();
			
		} finally { 
			// 6.연결 끊기
			dbcon.dbClose(null, pstmt, con);
		} // end finally
		
		return cnt;
	}//deleteCategory
	
	public List<String> selectCategoryList() throws SQLException{
		List<String> cList = new ArrayList<String>();
		DbConnection dbcon = DbConnection.getInstance();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "SELECT category_name FROM category WHERE isdeleted = 'N'";
		
		try {
			// 3.쿼리문 생성 객체 얻기
			con = dbcon.getConn(new File(Path.DATABASE_PROPERTIES));

			pstmt = con.prepareStatement(query);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				cList.add(rs.getString("category_name"));
			} // end while

		} finally {
			// 6.연결 끊기
			dbcon.dbClose(rs, pstmt, con);

		} // end finally
		
		return cList;
	}

}
