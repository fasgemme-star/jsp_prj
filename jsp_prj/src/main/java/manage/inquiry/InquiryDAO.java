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

	public List<InquiryDTO> selectInquiryList(int status) throws SQLException{
		List<InquiryDTO> iList = new ArrayList<InquiryDTO>();
		InquiryDTO iDTO = new InquiryDTO();
		DbConnection dbcon = DbConnection.getInstance();
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    StringBuilder query = new StringBuilder();
	    		query.append("	select c.client_no, c.client_name, INQUIRY_ID, INQUIRY_TITLE, INQUIRY_CONTENT,	");
	    		query.append( "	INQUIRY_DATE, ANSWER_STATUS, ANSWER, ANSWER_DATE, it.INQUIRY_TYPE, od.ORDER_DETAILS_ID	");
	    		query.append( "	from client c	");
	    		query.append( "	join \"order\" o on c.CLIENT_NO = o.CLIENT_NO	");
	    		query.append("	join ORDER_DETAILS od on o.ORDER_ID = od.ORDER_ID	");
	    		query.append("	join inquiry i on od.ORDER_DETAILS_ID = i.ORDER_DETAILS_ID	");
	   			query.append( "	join INQUIRY_TYPE it on i.INQUIRY_CODE = it.INQUIRY_CODE where 1=1	");
	    
	    try {
            con = dbcon.getConn(new File(Path.DATABASE_PROPERTIES));
            //전체: 0, 미처리: 1, 완료: 2
            if (status != 0) {
            	query.append(" AND	ANSWER_STATUS = '?'	");
            }
            pstmt = con.prepareStatement(query.toString());
            if(status == 1) {
            	pstmt.setString(1,"대기중");
            } else if (status == 2) {
            	pstmt.setString(1,"답변완료");
			}
   
            rs = pstmt.executeQuery();
            while (rs.next()) {
            	iDTO.setClientNo(rs.getString("client_no"));
            	iDTO.setClientName(rs.getString("client_name"));
            	iDTO.setInquiryID(rs.getString("INQUIRY_ID"));
            	iDTO.setTitle(rs.getString("INQUIRY_TITLE"));
            	iDTO.setContent(rs.getString("INQUIRY_CONTENT"));
            	iDTO.setInquiryDate(rs.getString("INQUIRY_DATE"));
            	iDTO.setStatus(rs.getString("ANSWER_STATUS"));
            	iDTO.setAnswer(rs.getString("ANSWER"));
            	iDTO.setAnswerDate(rs.getString("ANSWER_DATE"));
            	iDTO.setInquiryType(rs.getString("INQUIRY_TYPE"));
            	iDTO.setOrderID(rs.getString("ORDER_DETAILS_ID"));
           
            	iList.add(iDTO);
            }
        } finally {
            // 5. 자원 해제
            dbcon.dbClose(rs, pstmt, con);
        }

		return iList;
	}// selectInquiryList
	
	public InquiryDTO selectInquiryDetail(String inqudityID) throws SQLException {
		InquiryDTO iDTO = new InquiryDTO();
		DbConnection dbcon = DbConnection.getInstance();
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	    StringBuilder query = new StringBuilder();
		query.append("	select c.client_no, c.client_name, INQUIRY_TITLE, INQUIRY_CONTENT,	");
		query.append( "	INQUIRY_DATE, ANSWER_STATUS, ANSWER, ANSWER_DATE, it.INQUIRY_TYPE, od.ORDER_DETAILS_ID	");
		query.append( "	from client c	");
		query.append( "	join \"order\" o on c.CLIENT_NO = o.CLIENT_NO	");
		query.append("	join ORDER_DETAILS od on o.ORDER_ID = od.ORDER_ID	");
		query.append("	join inquiry i on od.ORDER_DETAILS_ID = i.ORDER_DETAILS_ID	");
			query.append( "	join INQUIRY_TYPE it on i.INQUIRY_CODE = it.INQUIRY_CODE where inquiry_id = ? ");

		try {
		    con = dbcon.getConn(new File(Path.DATABASE_PROPERTIES));
		    
		    pstmt = con.prepareStatement(query.toString());
		    pstmt.setString(1,inqudityID);

		
		    rs = pstmt.executeQuery();
		    while (rs.next()) {
		    	iDTO.setClientNo(rs.getString("client_no"));
		    	iDTO.setClientName(rs.getString("client_name"));
		    	iDTO.setTitle(rs.getString("INQUIRY_TITLE"));
		    	iDTO.setContent(rs.getString("INQUIRY_CONTENT"));
		    	iDTO.setInquiryDate(rs.getString("INQUIRY_DATE"));
		    	iDTO.setStatus(rs.getString("ANSWER_STATUS"));
		    	iDTO.setAnswer(rs.getString("ANSWER"));
		    	iDTO.setAnswerDate(rs.getString("ANSWER_DATE"));
		    	iDTO.setInquiryType(rs.getString("INQUIRY_TYPE"));
		    	iDTO.setOrderID(rs.getString("ORDER_DETAILS_ID"));
		    }
		} finally {
		    // 5. 자원 해제
		    dbcon.dbClose(rs, pstmt, con);
		}

		return iDTO;
	}// selectInquiryDetail
		
	public int updateInquiryAnswer(String inquiryID, String answer) throws SQLException {
		DbConnection dbcon = DbConnection.getInstance();
		Connection con = null;
		PreparedStatement pstmt = null;
		String query = "update inquiry set answer = ? where inquiry_id = ?";
		int cnt = 0;
		try {
			con = dbcon.getConn(new File(Path.DATABASE_PROPERTIES));
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, answer);
			pstmt.setString(2, inquiryID);
			
			cnt = pstmt.executeUpdate();
			
		} finally { 
			// 6.연결 끊기
			dbcon.dbClose(null, pstmt, con);
		} // end finally
		
		return cnt;
	}// updateInquiryAnswer
	
	public int deleteInquiry(String inquiryID) throws SQLException {
		DbConnection dbcon = DbConnection.getInstance();
		Connection con = null;
		PreparedStatement pstmt = null;
		String query = "update inquiry set inquiry_status = 'Y' where inquiry_id = ?";
		int cnt = 0;
		try {
			con = dbcon.getConn(new File(Path.DATABASE_PROPERTIES));
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, inquiryID);
			
			cnt = pstmt.executeUpdate();
			
		} finally { 
			// 6.연결 끊기
			dbcon.dbClose(null, pstmt, con);
		} // end finally
		
		return cnt;
	}// deleteInquiry
	
	public OrderDTO selectOrderDetail(String orderID) {
		OrderDTO oDTO = new OrderDTO();
		return oDTO;
	}// selectOrderDetail
	
}
