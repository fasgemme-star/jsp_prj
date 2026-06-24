package kr.co.sist.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class GetConnection {
	private static GetConnection gc;
	
	private GetConnection() {}
	
	public static GetConnection getInstance() {
		if (gc == null) {
			gc = new GetConnection();
		} // end if
		return gc;
	} // getInstance
	
	//public Connection getConn(String dbcpName) throws SQLException {
	public Connection getConn() throws SQLException {
		Connection con = null;
		try {
			
		Context ctx = new InitialContext();
		//DataSource ds = (DataSource) ctx.lookup("java:comp/env/"+dbcpName);
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/dbcp");
		con = ds.getConnection();
		
		} catch (NamingException ne){
			ne.printStackTrace();
		}// end catch

		return con;
	}// getConn
	
	public void dbClose(ResultSet rs, Statement stmt, Connection con) throws SQLException {
		
		try {
			if (rs != null) {
				rs.close();
			} // end if

			if (stmt != null) {
				stmt.close();
			} // end if

		} finally {
			if (con != null) {
				con.close();
			} // end if
		} // end finally
	
	}// dbClose()
	
}// class
