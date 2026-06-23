package manage.inquiry;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dbcon.DbConnection;
import dbcon.Path;

public class InquiryDAO {
	private static InquiryDAO iDAO;
	private InquiryDAO() {}
	
	public static InquiryDAO getInstance() {
		if (iDAO == null) {
			iDAO = new InquiryDAO();
		}
		return iDAO;
	} // getInstance()
	
	public int selectInquiryCnt() throws SQLException {
		DbConnection dbcon = DbConnection.getInstance();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "select count(1) cnt from inquiry where ANSWER_STATUS = '대기중'";
		int cnt = 0;
		
		try {
			con = dbcon.getConn(new File(Path.DATABASE_PROPERTIES));
			pstmt = con.prepareStatement(query);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				cnt = rs.getInt("cnt");
			}

		} finally { 
			// 6.연결 끊기
			dbcon.dbClose(rs, pstmt, con);
		} // end finally
		
		return cnt;
	}// selectInquiryCnt

	public List<InquiryDTO> selectInquiryList(){
		List<InquiryDTO> iList = new ArrayList<InquiryDTO>();
		DbConnection dbcon = DbConnection.getInstance();
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String query = "	select c.CLIENT_NO client_no, CLIENT_NAME, CLIENT_EMAIL, CLIENT_TEL, CLIENT_START_DATE, TOTAL_AMOUNT	"
	    		+ "	    from client c join \"order\" o	"
	    		+ "	    on c.client_no = o.client_no	";
	    
	    try {
            con = dbcon.getConn(new File(Path.DATABASE_PROPERTIES));
            pstmt = con.prepareStatement(query);

            // 4. 쿼리 실행 및 결과 담기
            rs = pstmt.executeQuery();
            while (rs.next()) {
                ClientDTO cDTO = new ClientDTO();
                cDTO.setClientNo(rs.getString("CLIENT_NO"));
                cDTO.setClientName(rs.getString("CLIENT_NAME"));
                cDTO.setEmail(rs.getString("CLIENT_EMAIL"));
                cDTO.setPhone(rs.getString("CLIENT_TEL"));
                cDTO.setJoinDate(rs.getString("START_DATE"));
                cDTO.setTotalPayment(rs.getInt("TOTAL_AMOUNT"));
                
                cList.add(cDTO);
            }
        } finally {
            // 5. 자원 해제
            dbcon.dbClose(rs, pstmt, con);
        }

		
		
		
		
		return iList;
	}// selectInquiryList
	
	public InquiryDTO selectInquiryDetail(int inqudityID) {
		InquiryDTO iDTO = new InquiryDTO();
		return iDTO;
	}// selectInquiryDetail
	
	public List<InquiryDTO> selectInquiryListByType(String CategoryID){
		List<InquiryDTO> iList = new ArrayList<InquiryDTO>();
		return iList;
	}// selectInquiryListByType
	
	public int updateInquiryAnswer(int inquiryID, String answer) {
		return 0;
	}// updateInquiryAnswer
	
	public int deleteInquiry(int inquiryID) {
		return 0;
	}// deleteInquiry
	
	public OrderDTO selectOrderDetail(String orderID) {
		OrderDTO oDTO = new OrderDTO();
		return oDTO;
	}// selectOrderDetail
	
}
