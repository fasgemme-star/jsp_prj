package manage.dashboard;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class DashBoardDAO {
	private static DashBoardDAO dDAO;
	private DashBoardDAO() {}
	
	public static DashBoardDAO getInstance() {
		if (dDAO == null) {
			dDAO = new DashBoardDAO();
		}
		return dDAO;
	} // getInstance()
	
	public int selectTotalSales() {
		return 0;
	}// selectTotalSales
	
	public int selectNewClientWeekly() {
		return 0;
	}// selectNewClientWeekly
	
	public int selectProductOnNow() {
		return 0;
	}// selectProductOnNow
	
	public int selectNonInquiryCount() {
		return 0;
	}// selectNonInquiryCount
	
	public int[] selectNewClientCount() {
		int[] a = null;
		return a;
	}// selectNewClientCount
	
	public int[] selectclientDropOut() {
		int[] a = null;
		return a;
	}// selectclientDropOut
	
	public List<Map<String, Integer>> selectBestProduct(){
		List<Map<String, Integer>> bList = new ArrayList<Map<String,Integer>>();
		return bList;
	}// selectBestProduct
	
	
}
