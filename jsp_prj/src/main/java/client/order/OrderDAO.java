package client.order;

public class OrderDAO {
	private static OrderDAO oDAO;
	private OrderDAO() {}
	
	public static OrderDAO getInstance() {
		if (oDAO == null) {
			oDAO = new OrderDAO();
		}
		return oDAO;
	} // getInstance()
	
	public String insertOrder(OrderDTO orderDTO) {
        return null;
    }// insertOrder
	
    public String insertDeliveryAddr(DeliveryDTO deliveryDTO) {
        return null;
    }// insertDeliveryAddr
	
    public int findOrderById(String orderId) {
        return 0;
    }// findOrderById
    
    public int findOrdersByUserId(String clientId) {
        return 0;
    }// findOrdersByUserId
    
    public int insertPayment(OrderDTO orderDTO) {
        return 0;
    }// insertPayment
	
}
