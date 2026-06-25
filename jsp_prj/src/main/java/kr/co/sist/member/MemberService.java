package kr.co.sist.member;

import java.sql.SQLException;

public class MemberService {
	
	/**
	 * 아이디 중복 확인
	 * @param id
	 * @return true: 아이디가 존재, false: 아이디 없음
	 */
	public boolean searchDupId(String id) {
		boolean idFlag = false;
		
		MemberDAO mDAO = MemberDAO.getInstance();
		
		try {
			idFlag = mDAO.selectId(id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return idFlag;
	}// searchDupId
}
