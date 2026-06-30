package client.cart;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

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

	
			
			
			
		} finally { 
			// 6.연결 끊기
			dbcon.dbClose(null, pstmt, con);
		} // end finally
		
		return cnt;
		
	}// insertCart

	public int updateCart(String cartID, int quantity) {
	    return 0;
	}// updateCart

	public int deleteCart(String cartID) {
	    return 0;
	}// deleteCart

	public int clearCart(String clientID) {
	    return 0;
	}// clearCart
}
