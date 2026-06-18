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
		StringBuilder query = new StringBuilder();
		int cnt = 0;
		try {
			con = dbcon.getConn(new File(Path.DATABASE_PROPERTIES));
			
			query.append("insert into CATEGORY(category_id, category_name) values('C004','");
			query.append(name);
			query.append("'");
			
			pstmt = con.prepareStatement(query.toString());
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
		StringBuilder query = new StringBuilder();
		int cnt = 0;
		
		try {
			con = dbcon.getConn(new File(Path.DATABASE_PROPERTIES));

			query.append("update category set category_name = '");
			query.append(newName);
			query.append("' where category_id = '");
			query.append(categoryID);
			query.append("'");
			pstmt = con.prepareStatement(query.toString());
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
		StringBuilder query = new StringBuilder();
		int cnt = 0;
		
		try {
			con = dbcon.getConn(new File(Path.DATABASE_PROPERTIES));

			query.append("update category set isdeleted = 'Y' where category_id = '");
			query.append(categoryID);
			query.append("'");
			pstmt = con.prepareStatement(query.toString());
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
		StringBuilder query = new StringBuilder();
		
		try {
			// 3.쿼리문 생성 객체 얻기
			con = dbcon.getConn(new File(Path.DATABASE_PROPERTIES));

			query.append("select category_name from category where isdeleted = 'N'");
			pstmt = con.prepareStatement(query.toString());

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
