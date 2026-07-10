package xml0709;

import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.jsp.JspWriter;

import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.output.Format;
import org.jdom2.output.XMLOutputter;

public class DeptService {
	
	private Document searchAllDept() {
		Document xmlDoc = new Document();
		List<DeptDTO> list = new ArrayList<DeptDTO>();
		//데이터의 부가적인 정보 생성
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd EEEE KK:MM:ss");
		Element pubDateNode = new Element("pubDate");
		pubDateNode.setText(sdf.format(new Date()));
		Element resultNode = new Element("result");
		
		//데이터 생성
		DeptDAO dDAO = DeptDAO.getInstance();
		
		try {
			list = dDAO.selectAllDept();
			resultNode.setText(String.valueOf(true));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		Element deptsNode = new Element("depts");
		xmlDoc.addContent(deptsNode);
		deptsNode.addContent(resultNode);		
		
		Element deptNode = null;
		Element deptnoNode = null;
		Element dnameNode = null;
		Element locNode = null;
		for (DeptDTO dDTO:list) {
			deptNode = new Element("dept");
			deptsNode.addContent(deptNode);
			
			deptnoNode = new Element("deptno");
			deptNode.addContent(deptnoNode);
			deptnoNode.setText(String.valueOf(dDTO.getDEPTNO()));
			
			dnameNode = new Element("dname");
			deptNode.addContent(dnameNode);
			dnameNode.setText(dDTO.getDNAME());
			
			locNode = new Element("loc");
			deptNode.addContent(locNode);
			locNode.setText(dDTO.getLOC());
			
		} // end for
		
		return xmlDoc;
	} // searchAllDept
	
	public void consolePrint() throws IOException {
		XMLOutputter xOut = new XMLOutputter(Format.getPrettyFormat());
		xOut.output(searchAllDept(), System.out);
	}

	public void createFile(String path) throws IOException {
		XMLOutputter xOut = new XMLOutputter(Format.getPrettyFormat());
		FileOutputStream fos = new FileOutputStream(path);
		xOut.output(searchAllDept(), fos);
		if (fos!=null) {
			fos.close();
		}
		
	}
	
	public void webBrowerPrint(JspWriter out) throws IOException {
		XMLOutputter xOut = new XMLOutputter(Format.getPrettyFormat());
		xOut.output(searchAllDept(), out);
		
	}
	
}
