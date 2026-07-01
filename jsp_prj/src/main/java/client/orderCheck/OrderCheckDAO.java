package client.orderCheck;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dbcon.DbConnection;
import dbcon.Path;

public class OrderCheckDAO {
	private static OrderCheckDAO oDAO;
	private OrderCheckDAO() {}
	
	public static OrderCheckDAO getInstance() {
		if (oDAO == null) {
			oDAO = new OrderCheckDAO();
		}
		return oDAO;
	} // getInstance()

	public List<OrderDTO> selectOrderChkList(RangeDTO rDTO, String client_no) throws SQLException {
		List<OrderDTO> oList = new ArrayList<OrderDTO>();
		DbConnection dbcon = DbConnection.getInstance();
	    Connection con = null;
	    ResultSet rs = null;
	    OrderDTO oDTO = null;
	    PreparedStatement pstmt = null;
		StringBuilder query = new StringBuilder();
		query.append("	select o.order_id, option_name, po.PRICE, po.DISCOUNT, o.DELIVERY_STATUS	")
			.append("	from orders o join ORDER_DETAILS od on o.order_id=od.order_id join PRODUCT_OPTION po on od.OPTION_ID=po.OPTION_ID	")
			.append("	where client_no = ? and 1=1	");
		
		 if (rDTO.getKeyword() != null && !rDTO.getKeyword().isEmpty()) {
		        query.append("AND option_name LIKE ? ");
		    }
		 if (rDTO.getDate() != null && !rDTO.getDate().isEmpty()) {
		        query.append("AND order_date BETWEEN ADD_MONTHS(SYSDATE, -?) AND SYSDATE ");
		    }
		try {
			con = dbcon.getConn(new File(Path.DATABASE_PROPERTIES));
            pstmt = con.prepareStatement(query.toString());
            
            int paramIndex = 2;
            pstmt.setString(1, client_no);
            if (rDTO.getKeyword() != null && !rDTO.getKeyword().trim().isEmpty()) {
                pstmt.setString(paramIndex++, "%" + rDTO.getKeyword() + "%");
            }
            if (rDTO.getDate() != null && !rDTO.getDate().isEmpty()) {
            	pstmt.setString(paramIndex++, rDTO.getDate());
            }
    
            rs = pstmt.executeQuery();
            while(rs.next()) {
            	oDTO = new OrderDTO();
            	oDTO.setOrderID(rs.getString("order_id"));
            	oDTO.setPrdName(rs.getString("option_name"));
            	oDTO.setPrice(rs.getInt("PRICE"));
            	oDTO.setDiscount(rs.getInt("DISCOUNT"));
            	oDTO.setDeliveryStatus(rs.getString("DELIVERY_STATUS"));
            	oList.add(oDTO);
            }
            
		} finally {
			dbcon.dbClose(rs, pstmt, con);
		}
	    return oList;
	}// selectOrderChkList


	

}
