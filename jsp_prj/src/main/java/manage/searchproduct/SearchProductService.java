package manage.searchproduct;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


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
	
	public int getInitialCount() {
		RangeDTO rDTO = new RangeDTO();
		try {
			rDTO = spDAO.selectCount();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		int total = rDTO.getTotalCnt();
		int onSaleCnt = rDTO.getActiveCnt();
		int soldoutCnt = total - onSaleCnt;
		
		return 0;
	}
	
	public List<ProductDTO> searchItem(RangeDTO rDTO){
		List<ProductDTO> pList = new ArrayList<ProductDTO>();
		try {
			pList = spDAO.selectSearchProduct(rDTO);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return pList;
	}
	

	public int changeProduct(ProductDTO pDTO) {
		return 0;
	}

	public int deleteProduct(ProductDTO pDTO) {
		return 0;
	}
}
