package kr.co.sist.site_property;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.ToString;

@AllArgsConstructor
@Getter
@ToString
public class SitePropertyVO {
	private String protocol, serverName, serverPort, contextRoot, uploadDir, apiKey, siteInfo;	

}
