package manage.addproduct;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import dbcon.DbConnection;
import dbcon.Path;

public class AddProductDAO {
	private static AddProductDAO aDAO;
	private AddProductDAO() {}
	
	public static AddProductDAO getInstance() {
		if (aDAO == null) {
			aDAO = new AddProductDAO();
		}
		return aDAO;
	} // getInstance()
	
	public int insertProduct(ProductDTO pDTO) throws SQLException {
		DbConnection dbcon = DbConnection.getInstance();
		Connection con = null;
		PreparedStatement pstmt = null;
		StringBuilder query = new StringBuilder();
		int cnt = 0;
		//insert into product(CATEGORY_ID, PRODUCT_NAME, DESCRIPTION, PRICE, MIN_PURCHASE, MAX_PURCHASE, DISCOUNT, MANUFACTURER, ORIGIN, UNDERAGE_PURCHASE, WEIGHT, EXPIRATION_DATE, STORAGE_TYPE, UNIT, NOTICE) values()
		//insert into PRODUCT_IMAGE(IMAGE_TYPE, URL, PRODUCT_ID) values()
		try {
			con = dbcon.getConn(new File(Path.DATABASE_PROPERTIES));

			query.append("update manager set manager_hash = '");
			//query.append(newPW);
			query.append("' where manager_id = '");
			//query.append(id);
			query.append("'");
			pstmt = con.prepareStatement(query.toString());
			cnt = pstmt.executeUpdate();
			
		} finally { 
			// 6.연결 끊기
			dbcon.dbClose(null, pstmt, con);
		} // end finally
		
		
		return cnt;
	}// insertProduct
	
}
