package manage.dashboard;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;


public class DashBoardService {
	private DashBoardDAO dDAO = DashBoardDAO.getInstance();
	
	public int getTotalSales() {
		int total = -1;
		try {
			total = dDAO.selectTotalSales();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return total;
	}// getTotalSales

	public int getNewClientCount() {
		int total = -1;
		try {
			total = dDAO.selectTotalSales();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return total;
	}// getNewClientCount
	
	public int getNowItemCount() {
		return 0;
	}// getNowItemCount
	
	public int getNonResponseInquiryCount() {
		int total = -1;
		try {
			total = dDAO.selectNonInquiryCount();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return total;
	}// getNonResponseInquiryCount
	
	public int[] getNewClientStatistics() {
		int[] arr = null;
		try {
			arr = dDAO.selectNewClientCount();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return arr;
	}// getNewClientStatistics
	
	public int[] getDropOutClientStatistics() {
		int[] a = null;
		return a;
	}// getDropOutClientStatistics
	
	public List<Map<String, Integer>> getBestProductList(){
		List<Map<String, Integer>> bList = new ArrayList<Map<String,Integer>>();
		return bList;
	}// getBestProductList
	
	public static void main(String[] args) {
		
		
	}
}
