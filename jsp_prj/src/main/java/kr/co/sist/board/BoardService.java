package kr.co.sist.board;

import java.sql.SQLException;
import java.util.List;

public class BoardService {

	/**
	 * 게시글의 총 레코드
	 * @return
	 */
	public int totalCount() {
		BoardDAO bDAO = BoardDAO.getInstance();
		int cnt = 0;
		try {
			cnt = bDAO.selectTotalCount();
		} catch (SQLException e) {
			e.printStackTrace();
		} // end catch
		return cnt;
	}// searchMyPage
	
	public List<BoardDTO> searchBoard(RangeDTO rDTO){
		BoardDAO bDAO = BoardDAO.getInstance();
		List<BoardDTO> bList = null;
		try {
			bList = bDAO.selectBoard(rDTO);
		} catch (SQLException e) {
			e.printStackTrace();
		} // end catch
		return bList;
	}// searchBoard
	
	public boolean addBoard(BoardDTO bDTO) {
		BoardDAO bDAO = BoardDAO.getInstance();
		boolean flag = false;
		try {
			bDAO.insertBoard(bDTO);
			flag=true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return flag;
	}// addBoard
	
	public BoardDTO searchBoardDetail(int num) {
		BoardDAO bDAO = BoardDAO.getInstance();
		BoardDTO bDTO = new BoardDTO();
		try {
			bDTO = bDAO.selectBoardDetail(num);
		
		} catch (SQLException e) {
			e.printStackTrace();
		} // end catch
		return bDTO;
	}// searchBoardDetail
	
	public void modifyCount(int num) {
		BoardDAO bDAO = BoardDAO.getInstance();
		try {
			bDAO.updateCnt(num);
		} catch (SQLException e) {
			e.printStackTrace();
		} // end catch
	}// modifyCount
	
	public boolean modifyBoard(BoardDTO bDTO) {
		BoardDAO bDAO = BoardDAO.getInstance();
		boolean flag = false;
		try {
			flag = bDAO.updateBoard(bDTO)==1;
			flag=true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return flag;
	}// modifyBoard
	
	public boolean removeBoard(BoardDTO bDTO) {
		BoardDAO bDAO = BoardDAO.getInstance();
		boolean flag = false;
		try {
			flag = bDAO.deleteBoard(bDTO)==1;
			flag=true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return flag;
	}// modifyBoard
	
}
