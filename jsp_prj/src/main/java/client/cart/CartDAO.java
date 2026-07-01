package client.cart;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import client.order.DeliveryDTO;
import dbcon.DbConnection;
import dbcon.Path;

public class CartDAO {
	private static CartDAO cDAO;
	private CartDAO() {}
	
	public static CartDAO getInstance() {
		if (cDAO == null) {
			cDAO = new CartDAO();
		}
		return cDAO;
	} // getInstance()
	
	public int insertCart(CartDTO cDTO) throws SQLException {
		DbConnection dbcon = DbConnection.getInstance();
		Connection con = null;
		PreparedStatement pstmt = null;
		String query = "insert into shopping_cart(client_no, option_id, quantity) values(?, ?, ?)";
		int cnt = 0;
		
		try {
			con = dbcon.getConn(new File(Path.DATABASE_PROPERTIES));
			pstmt = con.prepareStatement(query);
			
			pstmt.setString(1, cDTO.getClientID());
			pstmt.setString(2, cDTO.getPrdID());
			pstmt.setInt(3, cDTO.getQuantity());
			cnt = pstmt.executeUpdate();
			
		} finally { 
			// 6.연결 끊기
			dbcon.dbClose(null, pstmt, con);
		} // end finally
		
		return cnt;
		
	}// insertCart

	public int updateCart(CartDTO cDTO) throws SQLException {
		DbConnection dbcon = DbConnection.getInstance();
		Connection con = null;
		PreparedStatement pstmt = null;
		String query = "update shopping_cart set quantity = ? where client_no = ? and option_id = ?	";
		int cnt = 0;
		
		try {
			con = dbcon.getConn(new File(Path.DATABASE_PROPERTIES));
			pstmt = con.prepareStatement(query);
			
			pstmt.setInt(1, cDTO.getQuantity());
			pstmt.setString(2, cDTO.getClientID());
			pstmt.setString(3, cDTO.getPrdID());
			cnt = pstmt.executeUpdate();
			
		} finally { 
			// 6.연결 끊기
			dbcon.dbClose(null, pstmt, con);
		} // end finally
		return cnt;
	}// updateCart

	public int deleteCart(CartDTO cDTO) throws SQLException {
		DbConnection dbcon = DbConnection.getInstance();
		Connection con = null;
		PreparedStatement pstmt = null;
		int cnt = 0;
		String query = "	delete from shopping_cart where client_no = ? and option_id = ?	";
		try {
			con = dbcon.getConn(new File(Path.DATABASE_PROPERTIES));
			pstmt = con.prepareStatement(query);
			
			pstmt.setString(1, cDTO.getClientID());
			pstmt.setString(2, cDTO.getPrdID());
			cnt = pstmt.executeUpdate();
			
		} finally { 
			// 6.연결 끊기
			dbcon.dbClose(null, pstmt, con);
		} // end finally
		return cnt;
	}// deleteCart

	public int deleteCartAll(CartDTO cDTO) throws SQLException {
		DbConnection dbcon = DbConnection.getInstance();
		Connection con = null;
		PreparedStatement pstmt = null;
		int cnt = 0;
		String query = "	delete from shopping_cart where client_no = ? and option_id = ? and option_id in (select option_id from product_option where STOCKQUANTITY = 0)	";
		try {
			con = dbcon.getConn(new File(Path.DATABASE_PROPERTIES));
			pstmt = con.prepareStatement(query);
			
			pstmt.setString(1, cDTO.getClientID());
			pstmt.setString(2, cDTO.getPrdID());
			cnt = pstmt.executeUpdate();
			
		} finally { 
			// 6.연결 끊기
			dbcon.dbClose(null, pstmt, con);
		} // end finally
		return cnt;
	}// clearCart
	
	public List<OrderDTO> selectCart(String id) throws SQLException{
		List<OrderDTO> oList = new ArrayList<OrderDTO>();
		OrderDTO oDTO = null;
		DbConnection dbcon = DbConnection.getInstance();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = dbcon.getConn(new File(Path.DATABASE_PROPERTIES));
			String query = "	select option_name, price, discount, quantity  from shopping_cart sc join product_option po on sc.OPTION_ID=po.OPTION_ID where STOCKQUANTITY != 0 and client_no = ?	";
			
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				oDTO = new OrderDTO();
				oDTO.setPrdName(rs.getString("option_name"));
				oDTO.setPrice(rs.getInt("price"));
				oDTO.setDiscount(rs.getInt("discount"));
				oDTO.setQuantity(rs.getInt("quantity"));
				
				oList.add(oDTO);
			}
			
		} finally {
			dbcon.dbClose(rs, pstmt, con);
		} 
		
		return oList;
	}
	
	public List<OrderDTO> selectCartSoldOut(String id) throws SQLException{
		List<OrderDTO> oList = new ArrayList<OrderDTO>();
		OrderDTO oDTO = null;
		DbConnection dbcon = DbConnection.getInstance();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = dbcon.getConn(new File(Path.DATABASE_PROPERTIES));
			String query = "	select option_name, price, discount, quantity  from shopping_cart sc join product_option po on sc.OPTION_ID=po.OPTION_ID where STOCKQUANTITY = 0 and client_no = ?	";
			
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				oDTO = new OrderDTO();
				oDTO.setPrdName(rs.getString("option_name"));
				oDTO.setPrice(rs.getInt("price"));
				oDTO.setDiscount(rs.getInt("discount"));
				oDTO.setQuantity(rs.getInt("quantity"));
				
				oList.add(oDTO);
			}
			
		} finally {
			dbcon.dbClose(rs, pstmt, con);
		} 
		
		return oList;
	}
	
public String updateDeliveryRequest(DeliveryDTO deliveryDTO) {
    	
        return null;
    }// insertDeliveryAddr
}
