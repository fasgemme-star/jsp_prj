package kr.co.sist.board;

import java.sql.SQLException;

public class BoardService {

	/**
	 * 게시글의 총 레코드
	 * @return
	 */
	public int TotalCount() {
		BoardDAO bDAO = BoardDAO.getInstance();
		int cnt = 0;
		try {
			cnt = bDAO.selectTotalCount();
		} catch (SQLException e) {
			e.printStackTrace();
		} // end catch
		return cnt;
	}// searchMyPage
}
