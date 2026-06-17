package client.cart;

import java.util.List;

public class CartService {
	CartDAO cDAO = CartDAO.getInstance();
	
	public int addCart(CartDTO cartDTO) {
		return 0;
	}// addCart

	public List<CartDTO> getCartList(String clientID) {
	    return null;
	}// getCartList

	public int updateCart(String cartID, int quantity) {
		return 0;
	}// updateCart

	public int deleteCart(String cartID) {
		return 0;
	}// deleteCart

	public int clearCart(String clientID) {
		return 0;
	}// clearCart

	public int selectDelivery(DeliveryDTO deliveryDTO) {
		return 0;
	}// selectDelivery
}
