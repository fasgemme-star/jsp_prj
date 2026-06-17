package client.claimChk;

import java.util.ArrayList;
import java.util.List;

public class ClaimChkDAO {
	private static ClaimChkDAO cDAO;
	private ClaimChkDAO() {}
	
	public static ClaimChkDAO getInstance() {
		if (cDAO == null) {
			cDAO = new ClaimChkDAO();
		}
		return cDAO;
	} // getInstance()
	
	public List<ClaimDTO> selectClaimByUserID(String userID){
		List<ClaimDTO> cList = new ArrayList<ClaimDTO>();
		return cList;
	}

}
