package manage.admin;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dbcon.DbConnection;
import dbcon.Path;

public class AdminDAO {
	private static AdminDAO aDAO;
	private AdminDAO() {}
	
	public AdminDAO getInstance() {
		if (aDAO == null) {
			aDAO = new AdminDAO();
		}
		return aDAO;
	} // getInstance()
	
	public void login(String id, String pw) throws SQLException {
		DbConnection dbcon = DbConnection.getInstance();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = dbcon.getConn(new File(Path.DATABASE_PROPERTIES));
			String select = "select manager_name from manager where manager_id = 'admin01'";
			pstmt = con.prepareStatement(select);
			rs = pstmt.executeQuery();
			String name = "";
			if(rs.next()) {
				name = rs.getString("manager_name");
			}
			System.out.println(name);
		} finally {
			// 6.연결 끊기
			dbcon.dbClose(rs, pstmt, con);
		} // end finally
		
	}// login
	
	public boolean changePW(String id, String pw, String newPW) {
		boolean result=false;
		return result;
	}// changePW
	
	public AdminDTO getAdminInfo(String id) {
		AdminDTO aDTO = new AdminDTO();
		return aDTO;
	}// AdminDTO
	
}
