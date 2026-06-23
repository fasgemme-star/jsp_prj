package manage.client;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dbcon.DbConnection;
import dbcon.Path;

public class ClientDAO {
	private static ClientDAO cDAO;
	private ClientDAO() {}
	
	public static ClientDAO getInstance() {
		if (cDAO == null) {
			cDAO = new ClientDAO();
		}
		return cDAO;
	} // getInstance()
	
	public int selectTotalClient() throws SQLException {
		DbConnection dbcon = DbConnection.getInstance();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "select count(1) cnt from client";
		int cnt = 0;
		
		try {
			con = dbcon.getConn(new File(Path.DATABASE_PROPERTIES));
			pstmt = con.prepareStatement(query);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				cnt = rs.getInt("cnt");
			}

		} finally { 
			// 6.연결 끊기
			dbcon.dbClose(rs, pstmt, con);
		} // end finally

		return cnt;
	}// selectTotalClient
	
	public int selectNewClient() throws SQLException {
		DbConnection dbcon = DbConnection.getInstance();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "select count(1) cnt from client where client_start_date >= SYSDATE-30";
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
		
	}// selectNewClient
	
	public List<ClientDTO> selectClientList() throws SQLException{
		List<ClientDTO> cList = new ArrayList<ClientDTO>();
		DbConnection dbcon = DbConnection.getInstance();
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String query = "	select c.CLIENT_NO client_no, CLIENT_NAME, CLIENT_EMAIL, CLIENT_TEL, CLIENT_START_DATE, TOTAL_AMOUNT	"
	    		+ "	    from client c join \"order\" o	"
	    		+ "	    on c.client_no = o.client_no	";
	    
	    try {
            con = dbcon.getConn(new File(Path.DATABASE_PROPERTIES));
            pstmt = con.prepareStatement(query);

            // 4. 쿼리 실행 및 결과 담기
            rs = pstmt.executeQuery();
            while (rs.next()) {
                ClientDTO cDTO = new ClientDTO();
                cDTO.setClientNo(rs.getString("CLIENT_NO"));
                cDTO.setClientName(rs.getString("CLIENT_NAME"));
                cDTO.setEmail(rs.getString("CLIENT_EMAIL"));
                cDTO.setPhone(rs.getString("CLIENT_TEL"));
                cDTO.setJoinDate(rs.getString("START_DATE"));
                cDTO.setTotalPayment(rs.getInt("TOTAL_AMOUNT"));
                
                cList.add(cDTO);
            }
        } finally {
            // 5. 자원 해제
            dbcon.dbClose(rs, pstmt, con);
        }

		return cList;
	}// selectClientList
	
	public ClientDTO selectClientDetail(String clientID) throws SQLException {
		ClientDTO cDTO = new ClientDTO();
		DbConnection dbcon = DbConnection.getInstance();
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String query = "	select CLIENT_NAME, CLIENT_EMAIL, CLIENT_TEL, CLIENT_START_DATE, TOTAL_AMOUNT	"
	    		+ "	    from client c join \"order\" o	"
	    		+ "	    on c.client_no = o.client_no where c.client_No = ?";
	    
	    try {
            con = dbcon.getConn(new File(Path.DATABASE_PROPERTIES));
            pstmt = con.prepareStatement(query);
            pstmt.setString(1, clientID);

            rs = pstmt.executeQuery();
            while (rs.next()) {
                cDTO.setClientName(rs.getString("CLIENT_NAME"));
                cDTO.setEmail(rs.getString("CLIENT_EMAIL"));
                cDTO.setPhone(rs.getString("CLIENT_TEL"));
                cDTO.setJoinDate(rs.getString("START_DATE"));
                cDTO.setTotalPayment(rs.getInt("TOTAL_AMOUNT"));
            }
        } finally {
            // 5. 자원 해제
            dbcon.dbClose(rs, pstmt, con);
        }

		return cDTO;
	}// selectClientDetail
	
	public int updateClientPW(String ClientNo) throws SQLException {
		DbConnection dbcon = DbConnection.getInstance();
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    String query = "	update client set client_hash='2345' where client_no = ?	";
	    
	    int cnt = 0;
	    
	    try {
			con = dbcon.getConn(new File(Path.DATABASE_PROPERTIES));

			pstmt = con.prepareStatement(query);
			pstmt.setString(1, ClientNo);
			cnt = pstmt.executeUpdate();

		} finally {

			dbcon.dbClose(null, pstmt, con);

		} // end finally
		
		return cnt;
	}// updateClientPW
}
