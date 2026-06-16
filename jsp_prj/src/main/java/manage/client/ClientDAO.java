package manage.client;

import java.util.ArrayList;
import java.util.List;

public class ClientDAO {
	private static ClientDAO cDAO;
	private ClientDAO() {}
	
	public static ClientDAO getInstance() {
		if (cDAO == null) {
			cDAO = new ClientDAO();
		}
		return cDAO;
	} // getInstance()
	
	public int selectTotalClient() {
		return 0;
	}// selectTotalClient
	
	public int selectNewClient() {
		return 0;
	}// selectNewClient
	
	public List<ClientDTO> selectClientList(){
		List<ClientDTO> cList = new ArrayList<ClientDTO>();
		return cList;
	}// selectClientList
	
	public ClientDTO selectClientDetail(String clientID) {
		ClientDTO cDTO = new ClientDTO();
		return cDTO;
	}// selectClientDetail
	
	public String updateClientPW(String ClientID) {
		return "";
	}// updateClientPW
}
