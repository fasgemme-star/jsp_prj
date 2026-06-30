package client.orderCheck;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dbcon.DbConnection;
import dbcon.Path;

public class OrderCheckDAO {
	private static OrderCheckDAO oDAO;
	private OrderCheckDAO() {}
	
	public static OrderCheckDAO getInstance() {
		if (oDAO == null) {
			oDAO = new OrderCheckDAO();
		}
		return oDAO;
	} // getInstance()

	public List<OrderDTO> selectOrderChkList(RangeDTO rDTO, String client_no) throws SQLException {
		List<OrderDTO> oList = new ArrayList<OrderDTO>();
		DbConnection dbcon = DbConnection.getInstance();
	    Connection con = null;
	    ResultSet rs = null;
	    OrderDTO oDTO = null;
	    PreparedStatement pstmt = null;
		StringBuilder query = new StringBuilder();
		query.append("	select o.order_id, option_name, po.PRICE, po.DISCOUNT, o.DELIVERY_STATUS	")
			.append("	from orders o join ORDER_DETAILS od on o.order_id=od.order_id join PRODUCT_OPTION po on od.OPTION_ID=po.OPTION_ID	")
			.append("	where client_no = ? and 1=1	");
		
		 if (rDTO.getKeyword() != null && !rDTO.getKeyword().isEmpty()) {
		        query.append("AND option_name LIKE ? ");
		    }
		 if (rDTO.getDate() != null && !rDTO.getDate().isEmpty()) {
		        query.append("AND order_date BETWEEN ADD_MONTHS(SYSDATE, -?) AND SYSDATE ");
		    }
		try {
			con = dbcon.getConn(new File(Path.DATABASE_PROPERTIES));
            pstmt = con.prepareStatement(query.toString());
            
            int paramIndex = 2;
            pstmt.setString(1, client_no);
            if (rDTO.getKeyword() != null && !rDTO.getKeyword().trim().isEmpty()) {
                pstmt.setString(paramIndex++, "%" + rDTO.getKeyword() + "%");
            }
            if (rDTO.getDate() != null && !rDTO.getDate().isEmpty()) {
            	pstmt.setString(paramIndex++, rDTO.getDate());
            }
    
            rs = pstmt.executeQuery();
            while(rs.next()) {
            	oDTO = new OrderDTO();
            	oDTO.setOrderID(rs.getString("order_id"));
            	oDTO.setPrdName(rs.getString("option_name"));
            	oDTO.setPrice(rs.getInt("PRICE"));
            	oDTO.setDiscount(rs.getInt("DISCOUNT"));
            	oDTO.setDeliveryStatus(rs.getString("DELIVERY_STATUS"));
            	oList.add(oDTO);
            }
            
		} finally {
			dbcon.dbClose(rs, pstmt, con);
		}
	    return oList;
	}// selectOrderChkList

	/**
	 * @param cDTO
	 * @return	1: 성공, 0: 실패
	 * @throws SQLException
	 */
	public int insertClaim(ClaimDTO cDTO) throws SQLException {
		DbConnection dbcon = DbConnection.getInstance();
		Connection con = null;
		PreparedStatement pstmt = null;
		String query = "	insert into claim(claim_type, reason, reason_detail) values(?,?,?)	";
		int cnt = 0;
		try {
			con = dbcon.getConn(new File(Path.DATABASE_PROPERTIES));
			
			pstmt = con.prepareStatement(query);
			pstmt.setString(1,cDTO.getClaimType());
			pstmt.setString(2,cDTO.getReason());
			pstmt.setString(3,cDTO.getReasonDetail());
			cnt = pstmt.executeUpdate();
			
		} finally { 
			// 6.연결 끊기
			dbcon.dbClose(null, pstmt, con);
		} // end finally
		return cnt;
	}// insertClaim
	
	/**
	 * @param cDTO
	 * @return 1: 취소 성공, 0: 취소 실패
	 * @throws SQLException
	 */
	public int selectClaimCancel(ClaimDTO cDTO) throws SQLException {
		DbConnection dbcon = DbConnection.getInstance();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "	select * from order_details od join orders o on od.order_id = o.order_id where client_no = ? and order_details_id = ? and delivery_status != '배송중'	";
		try {
			con = dbcon.getConn(new File(Path.DATABASE_PROPERTIES));
			
			pstmt = con.prepareStatement(query);
			pstmt.setString(1,cDTO.getClientID());
			pstmt.setString(2,cDTO.getOrderDetailsID());
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				return 1;
			} else {
				return 0;
			}
		} finally { 
			// 6.연결 끊기
			dbcon.dbClose(null, pstmt, con);
		} // end finally
	}
}
