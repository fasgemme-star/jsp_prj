package client.order;

public class OrderService {
	OrderDAO oDAO = OrderDAO.getInstance();
	public String getOrder(String orderId) {
	    return "";
	}// getOrder

	public String selectDeliveryAddr(String clientId) {
	    return "";
	}// selectDeliveryAddr

	public String writeDeliveryRequest(String orderId, String deliveryRequest) {
	    return "";
	}// writeDeliveryRequest

	public String getOrderProduct(String orderId) {
	    return "";
	}// getOrderProduct

	public int calculateTotalPrice(OrderDTO oDTO) {
	    return 0;
	}// calculateTotalPrice

	public String processPayment(OrderDTO oDTO) {
	    return "";
	}// processPayment
}
