package manage.category;

import java.util.ArrayList;
import java.util.List;

public class CategoryService {
	private CategoryDAO cDAO;
	
	public List<String> showCategroy(){
		List<String> list = new ArrayList<String>();
		return list;
	}// showCategroy
	
	public int addCategory(CategoryDTO cDTO) {
		return 0;
	}// addCategory

	public int modifyCategory(CategoryDTO cDTO) {
		return 0;
	}// modifyCategory
	
	public int removeCategory(String categoryID) {
		return 0;
	}// removeCategory
}
