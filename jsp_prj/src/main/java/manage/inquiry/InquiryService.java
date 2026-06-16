package manage.inquiry;

import java.util.ArrayList;
import java.util.List;

public class InquiryService {
	private InquiryDAO iDAO = InquiryDAO.getInstance();
	
	public int totalCount(RangeDTO rDTO) {
		return 0;
	}// totalCount
	
	public int pageScale(int num) {
		return 0;
	}// pageScale
	
	public int totalPage(int totalCnt, int pageScale) {
		return 0;
	}// totalPage
	
	public int startNum(int totalPage, int pageScale) {
		return 0;
	}// startNum
	
	public int endNum(int totalpage, int pageScale) {
		return 0;
	}// endNum

	public List<InquiryDTO> getInquiryList(RangeDTO rDTO){
		List<InquiryDTO> iList = new ArrayList<InquiryDTO>();
		return iList;
	}// getInquiryList
	
	public InquiryDTO getInquiryDetail(String inquiryID) {
		InquiryDTO iDTO = new InquiryDTO();
		return iDTO;
	}// getInquiryDetail
	
	public List<InquiryDTO> getInquiryListByType(String categoryID){
		List<InquiryDTO> iList = new ArrayList<InquiryDTO>();
		return iList;
	}// getInquiryListByType
	
	public int answerInquiry(int inquiryID, String answer) {
		return 0;
	}// answerInquiry
	
	public int deleteInquiry(int inquiryID) {
		return 0;
	}// deleteInquiry
	
	public OrderDTO getOrderDetail(String orderID) {
		OrderDTO oDTO = new OrderDTO();
		return oDTO;
	}// getOrderDetail
	
}
