package kr.co.sist.site_property;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import kr.co.sist.dao.GetConnection;

/**
 * 
 */
public class SiteProperty {
	
	public static SitePropertyVO spVO;
	
	//static 영역은 클래스가 사용되면 한번만 자동호출되는 영역
	static {
		//JDBC: DBCP와 관련 없이 사이트에 공통정보를 로딩. -> DBCP가 문제가 발생 해도 사이트의 공통부분을 사용자에게 제공할 수 있다.
		//DBCP: DBCP에 문제가 발생하면 사이트 자체를 제공할 수 없다.
		GetConnection gc = GetConnection.getInstance();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String selectSiteProperty="	select PROTOCOL, SERVER_NAME, SERVER_PORT, CONTEXT_ROOT, "
				+ "UPLOAD_DIR, API_KEY, SITE_INFO from site_property where type = 2	"; 
		
		try {
			con = gc.getConn();
			pstmt = con.prepareStatement(selectSiteProperty);
			rs = pstmt.executeQuery();
			
			//rs.nest(); 무조건 존재하는 데이터라면 if를 생략할 수 있다.
			if (rs.next()) {
				spVO = new SitePropertyVO(
						rs.getString("PROTOCOL"),
						rs.getString("SERVER_NAME"),
						rs.getString("SERVER_PORT"),
						rs.getString("CONTEXT_ROOT")==null?"":rs.getString("CONTEXT_ROOT"),
						rs.getString("UPLOAD_DIR"),
						rs.getString("API_KEY"),
						rs.getString("SITE_INFO"));
			} // end if
			gc.dbClose(rs, pstmt, con);
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		
	}// static

}// class
