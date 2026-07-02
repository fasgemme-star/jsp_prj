package kr.co.sist.board;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.Reader;
import java.sql.Clob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.sist.dao.GetConnection;
import kr.co.sist.member.MemberDTO;

public class BoardDAO {
	private static BoardDAO mpDAO;
	private BoardDAO() {
	}
	
	public static BoardDAO getInstance() {
		if (mpDAO == null) {
			mpDAO = new BoardDAO();
		}
		return mpDAO;
	}// getInstance
	
	public int selectTotalCount(RangeDTO rDTO) throws SQLException {
		int totalCount = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		GetConnection gc = GetConnection.getInstance();
		
		try {
			con = gc.getConn();
			StringBuilder query = new StringBuilder();
			query.append("select count(*) cnt from board	");
			
			if (rDTO.getKeyword() != null && !rDTO.getKeyword().isEmpty()) {
				query.append("where instr(").append(rDTO.getField())
				.append(",?) !=0");
			}
			
			pstmt = con.prepareStatement(query.toString());
			
			if (rDTO.getKeyword() != null && !rDTO.getKeyword().isEmpty()) {
				pstmt.setString(1, rDTO.getKeyword());
			}
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				totalCount=rs.getInt("cnt");
			}
			
		} finally {
			gc.dbClose(rs, pstmt, con);
		} 
		
		return totalCount;
	}// selectTotalCount
	
	public List<BoardDTO> selectBoard(RangeDTO rDTO) throws SQLException {
		List<BoardDTO> bList = new ArrayList<BoardDTO>();
		BoardDTO bDTO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		GetConnection gc = GetConnection.getInstance();
		StringBuilder query = new StringBuilder();
		
		try {
			con = gc.getConn();
			query.append( "	select num, id, title, input_date, cnt from( select num, id, title, input_date, cnt, row_number() over( order by input_date desc) rnum from board ");
			
			if (rDTO.getKeyword() != null && !rDTO.getKeyword().isEmpty()) {
				query.append(" where instr("	).append(rDTO.getField()).append(", ?) != 0");
			}
			
			query.append(") where rnum between ? and ?	");
			
			pstmt = con.prepareStatement(query.toString());
			int index = 0;
			if (rDTO.getKeyword() != null && !rDTO.getKeyword().isEmpty()) {
				pstmt.setString(++index, rDTO.getKeyword());
				
			}
			pstmt.setInt(++index, rDTO.getStartNum());
			pstmt.setInt(++index, rDTO.getEndNum());
			
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				bDTO = new BoardDTO();
				bDTO.setNum(rs.getInt("num"));
				bDTO.setId(rs.getString("id"));
				bDTO.setTitle(rs.getString("title"));
				bDTO.setInputDate(rs.getDate("input_date"));
				bDTO.setCnt(rs.getInt("cnt"));
				
				bList.add(bDTO);
			}
			
		} finally {
			gc.dbClose(rs, pstmt, con);
		} 
		
		return bList;
	}// selectTotalCount
	
	public void insertBoard(BoardDTO bDTO) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		GetConnection gc = GetConnection.getInstance();
		
		try {
			con = gc.getConn();
			String query = "	insert into board(num, id, title, content, ip) values(seq_board.nextval, ?, ?, ?, ?)	";
			
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, bDTO.getId());
			pstmt.setString(2, bDTO.getTitle());
			pstmt.setString(3, bDTO.getContent());
			pstmt.setString(4, bDTO.getIp());
			
			pstmt.executeUpdate();
			
			
		} finally {
			gc.dbClose(null, pstmt, con);
		} 
		
	}// selectTotalCount
	
	public BoardDTO selectBoardDetail(int num) throws SQLException {
		BoardDTO bDTO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		GetConnection gc = GetConnection.getInstance();
		
		try {
			con = gc.getConn();
			String query = "	select ID, TITLE, CONTENT, INPUT_DATE, ip, cnt from board where num =	? ";
			
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1,num);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				bDTO = new BoardDTO();
				bDTO.setNum(num);
				bDTO.setId(rs.getString("id"));
				bDTO.setTitle(rs.getString("title"));
				bDTO.setInputDate(rs.getDate("input_date"));
				bDTO.setIp(rs.getString("ip"));
				bDTO.setCnt(rs.getInt("cnt"));
				
				Clob clob = rs.getClob("content");
				StringBuilder content = new StringBuilder();
				if(clob != null) {
					BufferedReader br = new  BufferedReader(clob.getCharacterStream());
					try {
						String temp="";
						while( (temp = br.readLine()) != null) {
							content.append(temp).append("\n");
						}
						if (br != null) {
							br.close();
						}
					} catch(IOException ie) {
						ie.printStackTrace();
					}// end catch
				}// end if
				
				bDTO.setContent(content.toString());
			}// end if
			
		} finally {
			gc.dbClose(rs, pstmt, con);
		} 
		
		return bDTO;
	}// selectBoardDetail
	
	public void updateCnt(int num) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		GetConnection gc = GetConnection.getInstance();
		
		try {
			con = gc.getConn();
			String query = "	update board set cnt = cnt + 1 where num = ?	";
			
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, num);
			
			pstmt.executeUpdate();
			
			
		} finally {
			gc.dbClose(null, pstmt, con);
		} 
		
	}// selectTotalCount
	
	public int updateBoard(BoardDTO bDTO) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		GetConnection gc = GetConnection.getInstance();
		int cnt = 0;
		try {
			con = gc.getConn();
			String query = "	update board set title=?, content=?, ip=? where id = ? and num = ?	";
			
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, bDTO.getTitle());
			pstmt.setString(2, bDTO.getContent());
			pstmt.setString(3, bDTO.getIp());
			pstmt.setString(4, bDTO.getId());
			pstmt.setInt(5, bDTO.getNum());
			
			cnt = pstmt.executeUpdate();
			
			
		} finally {
			gc.dbClose(null, pstmt, con);
		} 
		return cnt;
	}// updateBoard
	
	public int deleteBoard(BoardDTO bDTO) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		GetConnection gc = GetConnection.getInstance();
		int cnt = 0;
		try {
			con = gc.getConn();
			String query = "	delete from board where id = ? and num = ?	";
			
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, bDTO.getId());
			pstmt.setInt(2, bDTO.getNum());
			
			cnt = pstmt.executeUpdate();
			
			
		} finally {
			gc.dbClose(null, pstmt, con);
		} 
		return cnt;
	}// deleteBoard
}
