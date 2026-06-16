package manage.client;

import java.util.ArrayList;
import java.util.List;

public class ClientService {
	private ClientDAO cDAO = ClientDAO.getInstance();
	
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
	
	public int getTotalCount() {
		return 0;
	}// getTotalCount

	public int getNewCount() {
		return 0;
	}// getNewCount
	
	public List<ClientDTO> getClientList(){
		List<ClientDTO> cList = new ArrayList<ClientDTO>();
		return cList;
	}// getClientList
	
	public ClientDTO getClientDEtail(String ClientID) {
		ClientDTO cDTO = new ClientDTO();
		return cDTO;
	}// getClientDEtail
	
	public String changeClientPW(String ClientID) {
		return "";
	}// changeClientPW
	
	public void sendEmailNewPW(String msg) {
		
	}// sendEmailNewPW
		
}
