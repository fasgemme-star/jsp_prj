package client.orderCheck;

import java.util.ArrayList;
import java.util.List;

public class OrderCheckDAO {
	private static OrderCheckDAO oDAO;
	private OrderCheckDAO() {}
	
	public static OrderCheckDAO getInstance() {
		if (oDAO == null) {
			oDAO = new OrderCheckDAO();
		}
		return oDAO;
	} // getInstance()

	public List<OrderDTO> selectOrderChkList(String prdName, String startDate, String endDate) {
		List<OrderDTO> oList = new ArrayList<OrderDTO>();
	    return oList;
	}// selectOrderChkList

	public String selectOrderStatus(int orderId) {
	    return null;
	}// selectOrderStatus
}
