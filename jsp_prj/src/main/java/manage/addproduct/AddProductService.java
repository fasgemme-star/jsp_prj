package manage.addproduct;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import dbcon.DbConnection;
import dbcon.Path;

public class AddProductService {
	private AddProductDAO aDAO = AddProductDAO.getInstance();
	
	public int addProduct(ProductDTO pDTO) throws SQLException {
		DbConnection dbcon = DbConnection.getInstance();
        Connection con = null;
        PreparedStatement pstmtPrd = null;
        PreparedStatement pstmtImg = null;
        PreparedStatement pstmtinfo = null;
        
        String productQuery = "	insert into table product(	"
        		+ "	CATEGORY_ID, PRODUCT_NAME, DESCRIPTION, PRICE, MIN_PURCHASE, MAX_PURCHASE, DISCOUNT,MANUFACTURER, ORIGIN, UNDERAGE_PURCHASE, WEIGHT, EXPIRATION_DATE, STORAGE_TYPE, UNIT, NOTICE) 	values(	"
        		+ "			  ?,    		?, 			 ?,		?, 			  ?,			?,		   ?,		   ?,       ?,                 ?,      ?,              ?,            ?,    ?,      ?)	";
       
       String productImgQuery = " insert into PRODUCT_IMAGE(IMAGE_TYPE, URL, PRODUCT_ID) values(	"
    		   + "	?, ?, (SELECT product_id FROM product ORDER BY PRODUCT_INPUT_DATE DESC FETCH FIRST 1 ROWS ONLY))	";	 
    		   
       String infoQuery = "	insert into ADDITIONAL_INFO (INFO_CONTENT, PRODUCT_ID) values(	"
    		   + "	?, (SELECT product_id FROM product ORDER BY PRODUCT_INPUT_DATE DESC FETCH FIRST 1 ROWS ONLY))	";

        try {
        	
        	con.setAutoCommit(false);
        	
            con = dbcon.getConn(new File(Path.DATABASE_PROPERTIES));
            pstmtPrd = con.prepareStatement(productQuery);
            pstmtPrd.setString(1, pDTO.getCategory());
            pstmtPrd.setString(2, pDTO.getPrdName());
            pstmtPrd.setString(3, pDTO.getPrdDescription());
            pstmtPrd.setInt(4, pDTO.getPrice());
            pstmtPrd.setInt(5, pDTO.getMinPurchae());
            pstmtPrd.setInt(6, pDTO.getMaxPurchase());
            pstmtPrd.setInt(7, pDTO.getDiscount());
            pstmtPrd.setString(8, pDTO.getManufacturer());
            pstmtPrd.setString(9, pDTO.getOrigin());
            pstmtPrd.setInt(10, pDTO.getUnderAgePurchase());
            pstmtPrd.setInt(11, pDTO.getWeight());
            pstmtPrd.setString(12, pDTO.getExpirationDate());
            pstmtPrd.setString(13, pDTO.getStorageType());
            pstmtPrd.setString(14, pDTO.getSalesUnit());
            pstmtPrd.setString(15, pDTO.getNotice());
            
            pstmtPrd.executeUpdate();

   
            
        } finally {
        	dbcon.dbClose(null, pstmtPrd, con);
        }
        
        
       
		return 0;
	}// addProduct

}
