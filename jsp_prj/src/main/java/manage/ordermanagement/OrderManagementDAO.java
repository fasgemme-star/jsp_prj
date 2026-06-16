package manage.ordermanagement;

import java.util.ArrayList;
import java.util.List;

public class OrderManagementDAO {
	private static OrderManagementDAO oDAO;
	private OrderManagementDAO() {}
	
	public static OrderManagementDAO getInstance() {
		if (oDAO == null) {
			oDAO = new OrderManagementDAO();
		}
		return oDAO;
	} // getInstance()
	
	public List<OrderDTO> selectOrderList(){
		List<OrderDTO> oList = new ArrayList<OrderDTO>();
		return oList;
	}// selectOrderList
	
	public OrderDTO selectOrderDetail(int orderID) {
		OrderDTO oDTO = new OrderDTO();
		return oDTO;
	}// selectOrderDetail
	
	public List<OrderDTO> selectOrderByClient(String clientID){
		List<OrderDTO> oList = new ArrayList<OrderDTO>();
		return oList;
	}// selectOrderByClient
	
	public List<OrderDTO> selectOrderByStatus(String status){
		List<OrderDTO> oList = new ArrayList<OrderDTO>();
		return oList;
	}// selectOrderByStatus
	
	public List<OrderDTO> selectOrderByDate(String startDate, String endDate){
		List<OrderDTO> oList = new ArrayList<OrderDTO>();
		return oList;
	}// selectOrderByDate
	
	public ClaimDTO selectClaimDetail(String claimID) {
		ClaimDTO cDTO = new ClaimDTO();
		return cDTO;
	}// selectClaimDetail
	
	public int updateDeliveryStatus(int orderID) {
		return 0;
	}// updateDeliveryStatus
	
	public int updateClaimStatus(int claimID, String status) {
		return 0;
	}// updateClaimStatus
	
}
