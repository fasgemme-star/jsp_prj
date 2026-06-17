package manage.ordermanagement;

import java.util.ArrayList;
import java.util.List;

public class OrderManagementService {
	private OrderManagementDAO oDAO = OrderManagementDAO.getInstance();
	
	public int totalCount(RangeDTO rDTO) {
		return 0;
	}// totalCount
	
	public int pageScale(int num) {
		return 0;
	}// pageScale
	
	public int totalPage(int totalCnt, int pageScale) {
		return 0;
	}// totalPage
	
	public int startNum(int totalPage, int pageScale) {
		return 0;
	}// startNum
	
	public int endNum(int totalpage, int pageScale) {
		return 0;
	}// endNum
	
	public List<OrderDTO> getOrderList(){
		List<OrderDTO> oList = new ArrayList<OrderDTO>();
		return oList;
	}// getOrderList
	
	public OrderDTO getOrderDetail(String orderID) {
		OrderDTO oDTO = new OrderDTO();
		return oDTO;
	}// getOrderDetail
	
	public List<OrderDTO> searchOrderByClient(String clientID){
		List<OrderDTO> oList = new ArrayList<OrderDTO>();
		return oList;
	}// searchOrderByClient
	
	public List<OrderDTO> searchOrderByStatus(String status){
		List<OrderDTO> oList = new ArrayList<OrderDTO>();
		return oList;
	}// searchOrderByStatus
	
	public List<OrderDTO> searchOrderByDate(String startDate, String endDate){
		List<OrderDTO> oList = new ArrayList<OrderDTO>();
		return oList;
	}// searchOrderByDate
	
	public boolean processDelivery(int orderID) {
		return true;
	}// processDelivery
	
	public ClaimDTO getClaimDetail(String claimID) {
		ClaimDTO cDTO = new ClaimDTO();
		return cDTO;
	}// getClaimDetail
	
	public boolean approveCancle(String claimID) {
		return true;
	}// approveCancle
	
	public boolean rejectCancel(String claimID) {
		return true;
	}// rejectCancel
	
	public boolean approveExchange(String claimID) {
		return true;
	}// approveExchange
	
	public boolean rejectExchange(String claimID) {
		return true;
	}// rejectExchange
	
	public boolean approveReturn(String claimID) {
		return true;
	}// approveReturn
	
	public boolean rejectReturn(String claimID) {
		return true;
	}// rejectReturn

}
