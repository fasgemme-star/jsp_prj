package client.orderCheck;

import java.util.ArrayList;
import java.util.List;

public class OrderCheckService {
	OrderCheckDAO oDAO = OrderCheckDAO.getInstance();
	
	public List<OrderDTO> searchOrderChk(String prdName, String period) {
		List<OrderDTO> oList = new ArrayList<OrderDTO>();
	    return oList;
	}// searchOrderChk

	public List<OrderDTO> getOrderChkList() {
		List<OrderDTO> oList = new ArrayList<OrderDTO>();
	    return oList;
	}// getOrderChkList

	public boolean checkClaimAvailable(String orderId) {
	    return false;
	}// checkClaimAvailable
}
