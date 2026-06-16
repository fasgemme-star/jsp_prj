package manage.category;

import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {
	private static CategoryDAO cDAO;
	private CategoryDAO() {}
	
	public static CategoryDAO getInstance() {
		if (cDAO == null) {
			cDAO = new CategoryDAO();
		}
		return cDAO;
	} // getInstance()
	
	public int insertCategory(CategoryDTO cDTO) {
		return 0;
	}// insertCategory
	
	public int updateCategory(CategoryDTO cDTO) {
		return 0;
	}// updateCategory
	
	public int deleteCategory(String categoryID) {
		return 0;
	}//deleteCategory
	
	public List<CategoryDTO> selectCategoryList(){
		List<CategoryDTO> cList = new ArrayList<CategoryDTO>();
		return cList;
	}

}
