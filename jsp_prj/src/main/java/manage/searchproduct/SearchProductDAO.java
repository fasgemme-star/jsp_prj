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
	        PreparedStatement pstmt2 = null;
	        ResultSet rs = null;
	        ResultSet rs2 = null;
	        RangeDTO rDTO = new RangeDTO();
	        
	        String queryTotal = "SELECT count(1) total_cnt FROM PRODUCT_OPTION";	
	        String queryOnSale = "SELECT count(1) active_cnt FROM PRODUCT_OPTION WHERE STOCKQUANTITY != 0";	
	        
	        try {
	            con = dbcon.getConn(new File(Path.DATABASE_PROPERTIES));
	            pstmt = con.prepareStatement(queryTotal);
	            pstmt2 = con.prepareStatement(queryOnSale);
	            rs = pstmt.executeQuery();
	            rs2 = pstmt2.executeQuery();

	            if (rs.next()) {
	            	rDTO.setTotalCnt(rs.getInt("total_cnt"));
	            }
	            if (rs2.next()) {
	            	rDTO.setActiveCnt(rs2.getInt("active_cnt"));
	            }
	        } finally {
	        	if (pstmt2 != null) {
					dbcon.dbClose(rs2, pstmt2, null);
				}
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
        PreparedStatement pstmt2 = null;
        int totalAffectedRows = 0;
        
        String query = "UPDATE product SET category_id = ?, product_name = ?, price = ? WHERE  product_id = ?";
        String query2 = "UPDATE product_option SET STOCKQUANTITY = ? WHERE product_id =	 ?";
		
		     
        try {
            con = dbcon.getConn(new File(Path.DATABASE_PROPERTIES));
            con.setAutoCommit(false);
            pstmt = con.prepareStatement(query);
            
            pstmt.setString(1, pDTO.getCategory());
            pstmt.setString(2, pDTO.getPrdName());
            pstmt.setInt(3, pDTO.getPrice());
            pstmt.setString(4, pDTO.getPrdID());
            
            int productCnt = pstmt.executeUpdate();
            
            if (productCnt == 0) {
                throw new SQLException();
            }
            pstmt2 = con.prepareStatement(query2);
            
            pstmt2.setInt(1, pDTO.getQuantity());
            pstmt2.setString(2, pDTO.getPrdID());
            
            int optionCnt = pstmt.executeUpdate();
            if (optionCnt == 0) {
                throw new SQLException();
            }
            con.commit();
            totalAffectedRows = productCnt + optionCnt;
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
        	if (con != null) {
                try {
                    con.setAutoCommit(true); // 커넥션 풀 반납 전 기본값 복구
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            dbcon.dbClose(null, pstmt, con);
            dbcon.dbClose(null, pstmt2, null);
        }
    
		return totalAffectedRows;
	}// updateProduct
	
	public int deleteProduct(ProductDTO pDTO) throws SQLException {
		DbConnection dbcon = DbConnection.getInstance();
        Connection con = null;
        PreparedStatement pstmt = null;
        int cnt = 0;
        String query = "UPDATE product_option SET is_deleted = 'Y' where option_id = ?";
        try {
			con = dbcon.getConn(new File(Path.DATABASE_PROPERTIES));

			pstmt = con.prepareStatement(query);
			pstmt.setString(1, pDTO.getPrdID());
			
			cnt = pstmt.executeUpdate();
			
		} finally { 
			// 6.연결 끊기
			dbcon.dbClose(null, pstmt, con);
		} // end finally
		
		return cnt;
	}
	
	
}
