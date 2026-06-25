<%@page import="kr.co.sist.site_property.SiteProperty"%>
<%@page import="kr.co.sist.site_property.SitePropertyVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
StringBuilder flagUrl = (StringBuilder)application.getAttribute("CommonUrl");
if ( flagUrl == null){
	
	SitePropertyVO spVO = SiteProperty.spVO;
	StringBuilder commonUrl = new StringBuilder();
		commonUrl.append(
		spVO.getProtocol())
		.append(spVO.getServerName())
		.append(spVO.getServerPort())
		.append(spVO.getContextRoot());
	application.setAttribute("CommonUrl", commonUrl);
	application.setAttribute("UploadDir", spVO.getUploadDir());
}// end if
%>
