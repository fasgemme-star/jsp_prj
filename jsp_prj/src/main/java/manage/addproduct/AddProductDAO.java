package manage.addproduct;

public class AddProductDAO {
	private static AddProductDAO aDAO;
	private AddProductDAO() {}
	
	public static AddProductDAO getInstance() {
		if (aDAO == null) {
			aDAO = new AddProductDAO();
		}
		return aDAO;
	} // getInstance()
	
	public int insertProduct(ProductDTO pDTO) {
		
		return 0;
	}// insertProduct
	
}
