package client.claim;

public class ClaimService {
	ClaimDAO cDAO = ClaimDAO.getInstance();
	public String requestCancel(String clientID, ClaimDTO claimDTO) {
	    return "";
	}// requestCancel

	public String requestReturn(String clientID, ClaimDTO claimDTO) {
	    return "";
	}// requestReturn

	public String requestExchange(String clientID, ClaimDTO claimDTO) {
	    return "";
	}// requestExchange

	public String updateClaimStatus(String claimID, String claimStatus) {
	    return "";
	}// updateClaimStatus

	public String getClaimDetail(String claimID) {
	    return "";
	}// getClaimDetail
}
