package manage.inquiry;

import java.util.ArrayList;
import java.util.List;

public class InquiryDAO {
	private static InquiryDAO iDAO;
	private InquiryDAO() {}
	
	public static InquiryDAO getInstance() {
		if (iDAO == null) {
			iDAO = new InquiryDAO();
		}
		return iDAO;
	} // getInstance()

	public List<InquiryDTO> selectInquiryList(){
		List<InquiryDTO> iList = new ArrayList<InquiryDTO>();
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
