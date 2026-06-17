package client.claim;

public class ClaimDAO {
	private static ClaimDAO cDAO;
	private ClaimDAO() {}
	
	public static ClaimDAO getInstance() {
		if (cDAO == null) {
			cDAO = new ClaimDAO();
		}
		return cDAO;
	} // getInstance()
	
	public int insertClaim(ClaimDTO claimDTO) {
		return 0;
	}// insertClaim

	public ClaimDTO findClaimById(String claimID) {
	    ClaimDTO cDTO = new ClaimDTO();
	    return cDTO;
	}// findClaimById

	public int updateClaimStatus(String claimID, String claimStatus) {
		return 0;
	}// updateClaimStatus

}
