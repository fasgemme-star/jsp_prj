package manage.searchproduct;

import java.util.ArrayList;
import java.util.List;

public class SearchProductDAO {
	private static SearchProductDAO spDAO;
	private SearchProductDAO() {}
	
	public static SearchProductDAO getInstance() {
		if (spDAO == null) {
			spDAO = new SearchProductDAO();
		}
		return spDAO;
	} // getInstance()
	
	public int selectTotalCount(RangeDTO rDTO) {
		return 0;
	}// selectTotalCount
	
	public int selectTotalCount() {
		return 0;
	}// selectTotalCount
	
	public int selectOnSaleCount() {
		return 0;
	}// selectOnSaleCount
	
	public List<ProductDTO> selectSearchProduct(RangeDTO rDTO){
		List<ProductDTO> pList = new ArrayList<ProductDTO>();
		return pList;
	}// selectSearchProduct
	
	public int updateProduct(ProductDTO pDTO) {
		return 0;
	}// updateProduct
}
