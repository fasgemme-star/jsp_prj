package manage.ordermanagement;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dbcon.DbConnection;
import dbcon.Path;
import manage.client.ClientDTO;
import manage.searchproduct.ProductDTO;

public class OrderManagementDAO {
	private static OrderManagementDAO oDAO;
	private OrderManagementDAO() {}
	
	public static OrderManagementDAO getInstance() {
		if (oDAO == null) {
			oDAO = new OrderManagementDAO();
		}
		return oDAO;
	} // getInstance()
	
	
	public List<OrderDTO> selectOrderList(RangeDTO rDTO) throws SQLException{
		List<OrderDTO> oList = new ArrayList<OrderDTO>();
		DbConnection dbcon = DbConnection.getInstance();
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    StringBuilder query = new StringBuilder();
	    		query.append("	od.order_details_id, o.order_id, o.delivery_status, o.order_date, po.option_id, po.option_name, po.price, po.price*(1 - po.discount * 0.01) discount_price, od.quantity, o.total_amount	");
	    		query.append( "	from orders o	");
	    		query.append( "	join order_details od on o.order_id = od.order_id	");
	    		query.append("	join product_option po on po.option_id = od.option_id	");
	    		query.append( "	join product p on p.product_id = po.product_id	");
	    		query.append( "	WHERE 1=1	");
		
	    if (rDTO.getKeyword() != null && !rDTO.getKeyword().isEmpty()) {
	        query.append("AND PRODUCT_NAME LIKE ? ");
	    }
	    if (rDTO.getDelivery_status() != null && !rDTO.getDelivery_status().equals("전체") && !rDTO.getDelivery_status().isEmpty()) {
            query.append("AND STATUS = ? ");
        }
	    if (rDTO.getStartDate() != null && !rDTO.getStartDate().isEmpty() && 
	    		rDTO.getEndDate() != null && !rDTO.getEndDate().isEmpty()) {
	            query.append("AND REG_DATE BETWEEN TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD') + 1 ");
	        }
	    query.append("ORDER BY PRODUCT_ID DESC");
	    
	    try {
            con = dbcon.getConn(new File(Path.DATABASE_PROPERTIES));
            pstmt = con.prepareStatement(query.toString());

            // 3. 파라미터 매핑 (paramIndex 가변 증가 방식)
            int paramIndex = 1;
            
            if (rDTO.getKeyword() != null && !rDTO.getKeyword().trim().isEmpty()) {
                pstmt.setString(paramIndex++, "%" + rDTO.getKeyword() + "%");
            }
            if (rDTO.getDelivery_status() != null && !rDTO.getDelivery_status().equals("전체") && !rDTO.getDelivery_status().isEmpty()) {
                pstmt.setString(paramIndex++, rDTO.getDelivery_status());
            }
            if (rDTO.getStartDate() != null && !rDTO.getStartDate().isEmpty() && 
            		rDTO.getEndDate() != null && !rDTO.getEndDate().isEmpty()) {
            	pstmt.setString(paramIndex++, rDTO.getStartDate());
            	pstmt.setString(paramIndex++, rDTO.getEndDate());
            }

            // 4. 쿼리 실행 및 결과 담기
            rs = pstmt.executeQuery();
            while (rs.next()) {
                OrderDTO oDTO = new OrderDTO();
                oDTO.setOrderDetailsID(rs.getString("order_details_id"));
                oDTO.setOrderID(rs.getString("order_id"));
                oDTO.setDeliveryStatus(rs.getString("delivery_status"));
                oDTO.setOrderDate(rs.getString("order_date"));
                oDTO.setOptionID(rs.getString("option_id")); 
                oDTO.setPrdName(rs.getString("option_name")); 
                oDTO.setPrice(rs.getInt("price")); 
                oDTO.setDiscountPrice(rs.getInt("discount_price")); 
                oDTO.setQuantity(rs.getInt("quantity")); 
                oDTO.setTotalAmount(rs.getInt("total_amount")); 
                
                oList.add(oDTO);
            }
        } finally {
            // 5. 자원 해제
            dbcon.dbClose(rs, pstmt, con);
        }
 
		
		return oList;
	}// selectOrderList
		
	public int updateDeliveryStatus(String orderID) throws SQLException {
		DbConnection dbcon = DbConnection.getInstance();
		Connection con = null;
		PreparedStatement pstmtMaxTN = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String queryMaxTN = "SELECT MAX(tracking_number) FROM orders";
		String query = "update orders set tracking_number = ? where order_id = ?";
		
		int cnt = 0;
		
		try {
			con = dbcon.getConn(new File(Path.DATABASE_PROPERTIES));
			con.setAutoCommit(false);
			
			String TrackingNumber = null;
			pstmtMaxTN = con.prepareStatement(queryMaxTN);
			rs = pstmtMaxTN.executeQuery();
			if (rs.next()) {
				TrackingNumber = rs.getString(1);
			}
			
			String nextTrackingNumber = "TN000001";
			if (TrackingNumber != null && TrackingNumber.startsWith("TN")) {
	            try {
	                int num = Integer.parseInt(TrackingNumber.substring(2));
	                num++;
	                nextTrackingNumber = String.format("TN%06d", num);
	            } catch (NumberFormatException e) {
	            	
	            }
	        }
			
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, nextTrackingNumber);
	        pstmt.setString(2, orderID);
			cnt = pstmt.executeUpdate();
			con.commit();
		}catch(SQLException e) {
			if (con != null) {
				try {
					con.rollback();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			}
			throw e;
		} finally { 
			// 6.연결 끊기
			dbcon.dbClose(rs, pstmt, null);
			dbcon.dbClose(null, pstmtMaxTN, con);
		} // end finally
		
		return cnt;
	}// updateDeliveryStatus
	
	public int updateClaimStatus(int claimID, String status) {
		return 0;
	}// updateClaimStatus
	
	public ClaimDTO selectClaimDetail(String OrderDetailid) {
		ClientDTO cDTO = new ClientDTO();
		DbConnection dbcon = DbConnection.getInstance();
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String query = "	select CLIENT_NAME, CLIENT_EMAIL, CLIENT_TEL, CLIENT_START_DATE, TOTAL_AMOUNT	"
	    		+ "	    from client c join orders o	"
	    		+ "	    on c.client_no = o.client_no where c.client_No = ? ";
		/*
		 * select CLAIM_ID, REQUESTDATE, CLAIM_TYPE, CLIENT_NAME, CLIENT_TEL, OPTION_ID,
		 * OPTION_NAME from claim c join order_details od on c.order_details_id =
		 * od.order_details_id join orders o on o.order_id = od.order_id join client c
		 * on c.client_no = o.client_no join product_option po on po.option_id =
		 * od.option_id ;
		 */
	    
	    try {
            con = dbcon.getConn(new File(Path.DATABASE_PROPERTIES));
            pstmt = con.prepareStatement(query);
            pstmt.setString(1, clientID);

            rs = pstmt.executeQuery();
            while (rs.next()) {
                cDTO.setClientName(rs.getString("CLIENT_NAME"));
                cDTO.setEmail(rs.getString("CLIENT_EMAIL"));
                cDTO.setPhone(rs.getString("CLIENT_TEL"));
                cDTO.setJoinDate(rs.getString("CLIENT_START_DATE"));
                cDTO.setTotalPayment(rs.getInt("TOTAL_AMOUNT"));
            }
        } finally {
            // 5. 자원 해제
            dbcon.dbClose(rs, pstmt, con);
        }

		return cDTO;
		
		
	}
	
}
