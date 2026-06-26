package manage.searchproduct;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dbcon.DbConnection;
import dbcon.Path;

public class SearchProductDAO {
	private static SearchProductDAO spDAO;
	private SearchProductDAO() {}
	
	public static SearchProductDAO getInstance() {
		if (spDAO == null) {
			spDAO = new SearchProductDAO();
		}
		return spDAO;
	} // getInstance()
	
		public RangeDTO selectCount() throws SQLException {
			DbConnection dbcon = DbConnection.getInstance();
	        Connection con = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        RangeDTO rDTO = new RangeDTO();
	        
	        String query = "SELECT COUNT(1) AS total_cnt, " +
	                       "COUNT(CASE WHEN STATUS = '판매중' THEN 1 END) AS active_cnt, " +
	                       "FROM product";	
	        
	        try {
	            con = dbcon.getConn(new File(Path.DATABASE_PROPERTIES));
	            pstmt = con.prepareStatement(query);
	            rs = pstmt.executeQuery();

	            if (rs.next()) {
	                // 넘겨받은 range 객체에 카운트 값을 바로 세팅합니다.
	            	rDTO.setTotalCnt(rs.getInt("total_cnt"));
	            	rDTO.setActiveCnt(rs.getInt("active_cnt"));
	            }
	        } finally {
	            dbcon.dbClose(rs, pstmt, con);
	        }
        
		return rDTO;
	}// selectTotalCount
	
	
	public List<ProductDTO> selectSearchProduct(RangeDTO rDTO) throws SQLException{
		List<ProductDTO> pList = new ArrayList<ProductDTO>();
		DbConnection dbcon = DbConnection.getInstance();
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    StringBuilder query = new StringBuilder("SELECT COUNT(1) CNT, PRODUCT_ID, PRODUCT_NAME, PRICE FROM PRODUCT WHERE 1=1 ");
		
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
	}// selectSearchProduct
	
	public int updateProduct(ProductDTO pDTO) throws SQLException {
		DbConnection dbcon = DbConnection.getInstance();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String query = "";
		/*
		 * UPDATE product SET category_id = ? and product_name = ? and price = ? WHERE
		 * product_id = ? UPDATE product_option SET STOCKQUANTITY = ? WHERE product_id =
		 * ?
		 */    
        try {
            con = dbcon.getConn(new File(Path.DATABASE_PROPERTIES));
            pstmt = con.prepareStatement(query);
            rs = pstmt.executeQuery();

            if (rs.next()) {
            }
        } finally {
            dbcon.dbClose(rs, pstmt, con);
        }
    
		return 0;
	}// updateProduct
}
