package kr.co.sist.mypage;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.co.sist.member.MemberDTO;
import kr.co.sist.util.BoardUtil;

public class ProfileImageService {

	public JSONObject uploadImg(HttpServletRequest request) throws IOException, ServletException{
		JSONObject jsonObj = new JSONObject();
		
		//저장경로
		File saveDir = new File("C:/Users/user/git/jsp_prj/jsp_prj/src/main/webapp/upload/profile");
		
		//최대 파일 크기(15MByte)
		int maxSize = 1024 * 1024 * 15;
		
		//최대파일 허용크기(50Mbyte)
		int uploadMaxSize = 1024 * 1024 * 50;
		
		MultipartRequest mr = new MultipartRequest(request, saveDir.getAbsolutePath(), uploadMaxSize, "UTF-8", new DefaultFileRenamePolicy());
		
		File uploadFile = new File(saveDir.getAbsoluteFile() + File.separator + mr.getFilesystemName("upProfile"));
		
		//업로드 허용 크기
		if (uploadFile.length() > maxSize) {
			jsonObj.put("result", false);
			jsonObj.put("resultMsg", "파일의 크기가 15Mbyte를 초과할 수 없습니다.");
			uploadFile.delete();
		} // end if
		
		//업로드된 파일의 이름을 변경
		StringBuilder fileName = new StringBuilder(uploadFile.getAbsolutePath());
		String rename = BoardUtil.uuidFile(uploadFile);
		
		File renameFile = new File(uploadFile.getParent() + File.separator + rename);
		//업로드된 파일명을 알 수 없는 파일명으로 변경
		uploadFile.renameTo(renameFile);
		
		MyPageService mps = new MyPageService();
		HttpSession session = request.getSession();
		MemberDTO mDTO = (MemberDTO)session.getAttribute("userInfo");
		
		boolean resultFlag = false;
		if (mDTO != null) {
			String id = mDTO.getId();
			resultFlag = mps.modifyProfile(id, rename);
		}
		
		jsonObj.put("result", resultFlag);
		jsonObj.put("imgName", rename);
		return jsonObj;
	}
}
