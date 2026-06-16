package manage.dashboard;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class DashBoardService {
	private DashBoardDAO dDAO = DashBoardDAO.getInstance();
	
	public int getTotalSales() {
		return 0;
	}// getTotalSales

	public int getNewClientCount() {
		return 0;
	}// getNewClientCount
	
	public int getNowItemCount() {
		return 0;
	}// getNowItemCount
	
	public int getNonResponseInquiryCount() {
		return 0;
	}// getNonResponseInquiryCount
	
	public int[] getNewClientStatistics() {
		int[] a = null;
		return a;
	}// getNewClientStatistics
	
	public int[] getDropOutClientStatistics() {
		int[] a = null;
		return a;
	}// getDropOutClientStatistics
	
	public List<Map<String, Integer>> getBestProductList(){
		List<Map<String, Integer>> bList = new ArrayList<Map<String,Integer>>();
		return bList;
	}// getBestProductList
	
}
