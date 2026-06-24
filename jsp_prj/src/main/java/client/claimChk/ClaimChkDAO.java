package client.claimChk;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dbcon.DbConnection;
import dbcon.Path;

public class ClaimChkDAO {
	private static ClaimChkDAO cDAO;
	private ClaimChkDAO() {}
	
	public static ClaimChkDAO getInstance() {
		if (cDAO == null) {
			cDAO = new ClaimChkDAO();
		}
		return cDAO;
	} // getInstance()
	
	public List<ClaimDTO> selectClaimByUserID(String userID) throws SQLException{
		List<ClaimDTO> cList = new ArrayList<ClaimDTO>();
		DbConnection dbcon = DbConnection.getInstance();
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	    StringBuilder query = new StringBuilder();
	    
//	    select CLAIM_ID, REQUESTDATE, REASON, REASON_DETAIL, STATUS, PROCESSINGDATE, od.ORDER_DETAILS_ID, OPTION_NAME
//	    from claim c
//	    join ORDER_DETAILS od on c.ORDER_DETAILS_ID = od.ORDER_DETAILS_ID
//	    join PRODUCT_OPTION po on od.OPTION_ID = po.OPTION_ID
//	    join SHOPPING_CART sc on po.OPTION_ID = sc.OPTION_ID
//	    join client c on sc.client_no = c.client_no
//	    where c.client_no = 'C000001'
		
		try {
		    con = dbcon.getConn(new File(Path.DATABASE_PROPERTIES));
		    
		    pstmt = con.prepareStatement(query.toString());
		    //pstmt.setString(1,inqudityID);

		
		    rs = pstmt.executeQuery();
		    while (rs.next()) {
		    	//iDTO.setClientNo(rs.getString("client_no"));
		    }
		} finally {
		    // 5. 자원 해제
		    dbcon.dbClose(rs, pstmt, con);
		}

		
		
		
		return cList;
	}
	
	public ClaimDTO selectClaimDetail(String claimID) throws SQLException {
		ClaimDTO cDTO = new ClaimDTO();
		DbConnection dbcon = DbConnection.getInstance();
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	    StringBuilder query = new StringBuilder();
	    
	    try {
	    	con = dbcon.getConn(new File(Path.DATABASE_PROPERTIES));
		    
		    pstmt = con.prepareStatement(query.toString());
		    pstmt.setString(1,claimID);

		
		    rs = pstmt.executeQuery();
		    while (rs.next()) {
		    	//cDTO.setClientNo(rs.getString("client_no"));
		    }
		} finally {
		    // 5. 자원 해제
		    dbcon.dbClose(rs, pstmt, con);
		}

	    
	    
	    
	    return cDTO;
	    
	}
}
