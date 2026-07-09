<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="kr.co.sist.util.BoardUtil"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.awt.DefaultFocusTraversalPolicy"%>
<%@page import="com.oreilly.servlet.multipart.FileRenamePolicy"%>
<%@page import="kr.co.sist.util.HangulUtil"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="kr.co.sist.board.BoardService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/siteProperty.jsp" %>
<%-- <%@ include file="../include/loginCheck.jsp" %> --%>
<%

String sessionID = "test";
String sessionName = "테스트";
pageContext.setAttribute("userID", sessionID);
pageContext.setAttribute("userName", sessionName);
%>
<%
if ("GET".equals(request.getMethod())){
	return;
} // end if
request.setCharacterEncoding("UTF-8"); 
%>
<jsp:useBean id="bDTO" class="kr.co.sist.board.BoardDTO" scope="page"/>
<jsp:setProperty name="bDTO" property="id" value="${ userID }"/>
<jsp:setProperty name="bDTO" property="ip" value="<%=request.getRemoteAddr() %>"/>
<%
//request는 web parameter를 받을 수 없다.
//File saveDir = new File("C:/Users/user/git/jsp_prj/jsp_prj/src/main/webapp/upload");
File saveDir = new File("C:/webhome/upload/profile");
//업로드 파일의 제약 크기
int maxSize = 1024 * 1024 * 10;
int uploadMaxSize = 1024 * 1024 * 50;

MultipartRequest mr = new MultipartRequest(request, saveDir.getAbsolutePath(), uploadMaxSize, "UTF-8", new DefaultFileRenamePolicy());
String fileNmae = mr.getFilesystemName("upfile");
File uploadFile = new File(saveDir.getAbsolutePath()+ File.separator + fileNmae);

if (uploadFile.length() > uploadMaxSize) {
	uploadFile.delete();
	out.println("파일은 최대 10Mbyte까지만 업로드 가능합니다.");
}else{
	
	//서버에서 실행되는 파일이 업로드 되지 않도록 처리
	if (mr.getContentType("upfile") != null && !mr.getContentType("upfile").contains("image") ) {
		//이상한 파일(해킹파일)
		File hackDir = new File("c:/dev/hack");
		
		FileInputStream fis = null;
		FileOutputStream fos = null;
		try{
			//악의적인 목적의 파일에 스트림을 연결
			fis = new FileInputStream(uploadFile);
			//악의적인 목적의 파일을 웹서비스가 되지 안흔ㄴ 디렉토리로 이동.
			fos = new FileOutputStream(hackDir.getAbsolutePath() + File.separator + uploadFile.getName());
			
			//한번에 읽어들일 데이터의 크기
			byte[] readData = new byte[512];
			
			int readSize = 0;
			//데이터를 EOF까지 읽는다.
			while((readSize = fis.read(readData)) != -1){
				fos.write(readData,0,readSize);
			}
			fos.flush();
			
		} finally{
			if(fis != null){fis.close();}
			if(fos != null){fos.close();}
			//파일 이동 후 삭제
			uploadFile.delete();
		}
		
	}
	if(mr.getContentType("upfile") != null ){
		String[] imgExt = { "jpg", "jpeg", "gif", "png", "bmp" };
		boolean fileFlag = false;
		String compareExt = uploadFile.getName().substring(uploadFile.getName().lastIndexOf(".")+1);
		for (int i = 0; i < imgExt.length; i++) {
			if (fileFlag = compareExt.toLowerCase().equals(imgExt[i])) {
				//파일명 변경
				bDTO.setUpfile(BoardUtil.uuidFile(uploadFile));
				//정상적인 파일(이미지 파일) -> 파일명을 변경하여 웹서비스 되는 디렉토리에 저장	
				uploadFile.renameTo(new File(uploadFile.getParent() + File.separator + bDTO.getUpfile()));
				break;
			}
		}
	}
	
//java.util.URLDecoder 사용
/* bDTO.setTitle(URLDecoder.decode(URLEncoder.encode( mr.getParameter("title"),"8859_1"),"UTF-8"));
//java.lang.String 사용
bDTO.setContent(new String( mr.getParameter("content").getBytes("8859_1"),"UTF-8")); */

 bDTO.setTitle(mr.getParameter("title"));
bDTO.setContent(mr.getParameter("content"));
out.println(bDTO);
BoardService bs = new BoardService();
pageContext.setAttribute("result", bs.addBoard(bDTO));
%>

<script type="text/javascript">
<c:choose>
<c:when test="${ result }">
	alert("글을 작성하였습니다.");
	location.href="boardList.jsp";
</c:when>
<c:otherwise>
	alert("글 저장 중 문제가 발생했습니다.\n 잠시 후 다시 시도해주세요.");
	history.back();
</c:otherwise>
</c:choose>
</script>

 <%}// else %>