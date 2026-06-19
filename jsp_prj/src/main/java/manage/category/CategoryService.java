package manage.category;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoryService {
	private CategoryDAO cDAO = CategoryDAO.getInstance();
	
	public List<String> showCategroy(){
		List<String> cList = null;
		try {
			cList = cDAO.selectCategoryList();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return cList;
	}// showCategroy
	
	public int addCategory(String name) {
		try {
			if (cDAO.insertCategory(name) == 1) {
				//추가 성공
			} else {
				// 추가 실패
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
	}// addCategory

	public int modifyCategory(String categoryID, String newName) {
		try {
			if (cDAO.updateCategory(categoryID, newName) == 1 ){
				//성공
			} else {
				//실패
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
	}// modifyCategory
	
	public int removeCategory(String categoryID) {
		try {
			if (cDAO.deleteCategory(categoryID) == 1 ){
				//성공
			} else {
				//실패
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
	}// removeCategory
	
	public static void main(String[] args) {
		CategoryService c = new CategoryService();
		List<String> a = c.showCategroy();
		System.out.println(a);
	}
}
