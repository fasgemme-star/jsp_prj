package manage.searchproduct;

import java.util.ArrayList;
import java.util.List;

import manage.client.RangeDTO;

public class SearchProductService {
	private SearchProductDAO spDAO = SearchProductDAO.getInstance();
	
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
	
	public int countTotal() {
		return 0;
	}
	
	public int countOnSale() {
		return 0;
	}
	
	public int countSoldOut() {
		return 0;
	}
	
	public List<ProductDTO> searchItem(String name){
		List<ProductDTO> plist = new ArrayList<ProductDTO>();
		return plist;
	}
	
	public List<ProductDTO> searchItem(String startdate, String endDate){
		List<ProductDTO> plist = new ArrayList<ProductDTO>();
		return plist;
	}

	public int changeProduct(ProductDTO pDTO) {
		return 0;
	}

	public int deleteProduct(ProductDTO pDTO) {
		return 0;
	}
}
