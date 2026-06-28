package manage.ordermanagement;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import dbcon.DbConnection;
import dbcon.Path;
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
	
	
	public List<OrderDTO> selectOrderList(){
		List<OrderDTO> oList = new ArrayList<OrderDTO>();
		DbConnection dbcon = DbConnection.getInstance();
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    StringBuilder query = new StringBuilder("");
		
	    if (rDTO.getKeyword() != null && !rDTO.getKeyword().isEmpty()) {
	        query.append("AND PRODUCT_NAME LIKE ? ");
	    }
	    if (rDTO.getStatus() != null && !rDTO.getStatus().equals("전체") && !rDTO.getStatus().isEmpty()) {
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
            if (rDTO.getStatus() != null && !rDTO.getStatus().equals("전체") && !rDTO.getStatus().isEmpty()) {
                pstmt.setString(paramIndex++, rDTO.getStatus());
            }
            if (rDTO.getStartDate() != null && !rDTO.getStartDate().isEmpty() && 
            		rDTO.getEndDate() != null && !rDTO.getEndDate().isEmpty()) {
            	pstmt.setString(paramIndex++, rDTO.getStartDate());
            	pstmt.setString(paramIndex++, rDTO.getEndDate());
            }

            // 4. 쿼리 실행 및 결과 담기
            rs = pstmt.executeQuery();
            while (rs.next()) {
                ProductDTO pDTO = new ProductDTO();
                pDTO.setPrdID(rs.getString("PRODUCT_ID"));
                pDTO.setPrdName(rs.getString("PRODUCT_NAME"));
                pDTO.setStatus(rs.getString("STATUS"));
                pDTO.setPrice(rs.getInt("PRICE")); // 가격 데이터 담기
                
                pList.add(pDTO);
            }
        } finally {
            // 5. 자원 해제
            dbcon.dbClose(rs, pstmt, con);
        }
 
	    return pList;
		
		return oList;
	}// selectOrderList
	
	public OrderDTO selectOrderDetail(int orderID) {
		OrderDTO oDTO = new OrderDTO();
		return oDTO;
	}// selectOrderDetail
	
	public List<OrderDTO> selectOrderByClient(String clientID){
		List<OrderDTO> oList = new ArrayList<OrderDTO>();
		return oList;
	}// selectOrderByClient
	
	public List<OrderDTO> selectOrderByStatus(String status){
		List<OrderDTO> oList = new ArrayList<OrderDTO>();
		return oList;
	}// selectOrderByStatus
	
	public List<OrderDTO> selectOrderByDate(String startDate, String endDate){
		List<OrderDTO> oList = new ArrayList<OrderDTO>();
		return oList;
	}// selectOrderByDate
	
	public ClaimDTO selectClaimDetail(String claimID) {
		ClaimDTO cDTO = new ClaimDTO();
		DbConnection dbcon = DbConnection.getInstance();
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String query ="";
	    
		return cDTO;
	}// selectClaimDetail
	
	public int updateDeliveryStatus(int orderID) {
		return 0;
	}// updateDeliveryStatus
	
	public int updateClaimStatus(int claimID, String status) {
		return 0;
	}// updateClaimStatus
	
}
