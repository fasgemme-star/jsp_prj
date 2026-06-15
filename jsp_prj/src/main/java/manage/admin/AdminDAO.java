package manage.admin;

public class AdminDAO {
	private static AdminDAO aDAO;
	private AdminDAO() {}
	
	public static AdminDAO getInstance() {
		if (aDAO == null) {
			aDAO = new AdminDAO();
		}
		return aDAO;
	} // getInstance()
	
	public int selectAdmin(String id, String pw) {
		return 0;
	}
	
	public int updatePW() {
		return 0;
	}
}
