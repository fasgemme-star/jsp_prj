package kr.co.sist.member;

import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;

import org.json.simple.JSONObject;

import kr.co.sist.chipher.DataDecryption;
import kr.co.sist.chipher.DataEncryption;
import kr.co.sist.mypage.MyPageDAO;

public class MemberService {
	
	public String searchMyPage(String id) {
		MemberDTO mDTO = null;
		JSONObject jsonObj = new JSONObject();
		MyPageDAO mpDAO = MyPageDAO.getInstance();

		try {
			mDTO = mpDAO.selectUserInfo(id);
			if (mDTO != null) {
				DataDecryption dd = new DataDecryption("a012345678912345");

				try {
					mDTO.setName(dd.decrypt(mDTO.getName()));
					mDTO.setEmail(dd.decrypt(mDTO.getEmail()));
					mDTO.setPhone(dd.decrypt(mDTO.getPhone()));
				} catch (Exception e) {
					e.printStackTrace();
				}
				jsonObj.put("name", mDTO.getName());
				jsonObj.put("email", mDTO.getEmail());
				jsonObj.put("phone", mDTO.getPhone());
				jsonObj.put("zipcode", mDTO.getZipcode());
				jsonObj.put("address", mDTO.getAddress());
				jsonObj.put("address2", mDTO.getAddress2());
				jsonObj.put("profile", mDTO.getProfile());
				jsonObj.put("ip", mDTO.getIp());
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd eeee a kk:mm:ss");
				jsonObj.put("inputdate", sdf.format(mDTO.getInputDate()));
			} // end if
		} catch (SQLException e) {
			e.printStackTrace();
		} // end catch
		return jsonObj.toJSONString();
	}// searchMyPage

	public boolean addMember(MemberDTO mDTO) {
		boolean flag = false;
		
		MemberDAO mDAO = MemberDAO.getInstance();
		try {
			//일방향Hash:비밀번호
			mDTO.setPassword(DataEncryption.messageDigest("SHA-1", mDTO.getPassword()));
	
			//암호화: 이름, 이메일, 전화번호
			String key = "a012345678912345";
			DataEncryption de = new DataEncryption(key);
			mDTO.setName(de.encrypt(mDTO.getName()));
			mDTO.setEmail(de.encrypt(mDTO.getEmail()));
			mDTO.setPhone(de.encrypt(mDTO.getPhone1()+"-"+mDTO.getPhone2()+"-"+mDTO.getPhone3()));
			
			mDAO.insertWebmember(mDTO);
			flag = true;
			if (mDTO.getHobby() != null) {
				mDAO.insertWebmemberHobby(mDTO);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} // end if
		
		return flag;
	}
	
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
