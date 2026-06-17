package client.cart;

public class CartDAO {
	private static CartDAO cDAO;
	private CartDAO() {}
	
	public static CartDAO getInstance() {
		if (cDAO == null) {
			cDAO = new CartDAO();
		}
		return cDAO;
	} // getInstance()
	
	public int insertCart(CartDTO cDTO) {
	    return 0;
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
