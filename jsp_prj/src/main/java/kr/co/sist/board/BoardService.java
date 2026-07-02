package kr.co.sist.board;

import java.sql.SQLException;
import java.util.List;

public class BoardService {
	private int totalCount;
	private int pageScale;
	private int currentPage;
	private int startNum;
	
	/**
	 * 게시글의 총 레코드
	 * @return
	 */
	public int totalCount(RangeDTO rDTO) {
		BoardDAO bDAO = BoardDAO.getInstance();
		int cnt = 0;
		try {
			cnt = bDAO.selectTotalCount(rDTO);
		} catch (SQLException e) {
			e.printStackTrace();
		} // end catch
		totalCount = cnt;
		return cnt;
	}// searchMyPage
	
	/**
	 * 한 화면에 보여질 게시글의 수
	 * @return
	 */
	public int pageScale() {
		pageScale = 10;
		return pageScale;
	}
	
	/**
	 * 총 페이지 수
	 * @return
	 */
	public int totalPage() {
		return (int)Math.ceil((double)totalCount/pageScale);
	}
	
	/**
	 * 현재 페이지를 입력받아서 정수로 변환 후 반환.
	 * @param tempPage
	 * @return
	 */
	public int currentPage(String tempPage) {
		int currentPage = 1;
		if ( tempPage != null) {
			currentPage = Integer.parseInt(tempPage);
		}
		this.currentPage = currentPage;
		return currentPage;
	}
	
	/**
	 * 조회할 글의 시작번호
	 * @return 시작번호
	 */
	public int startNum() {
		int startNum = 1;
		startNum = currentPage * pageScale - pageScale + 1;
		this.startNum = startNum;
		return startNum;
	}
	
	/**
	 * 조회할 글의 끝 번호
	 * @return
	 */
	public int endNum() {
		int endNum = startNum + pageScale -1;
		return endNum;
	}// endNum
	
	/**
	 * 시작번호, 끝번호, 검색키워드, 검색필드를 받아서 시작과 끝 사이의 글을 검색 
	 * @param rDTO 시작번호, 끝번호, 검색키워드, 검색필드
	 * @return
	 */
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
