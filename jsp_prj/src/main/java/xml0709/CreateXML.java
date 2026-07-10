package xml0709;

import java.io.FileOutputStream;
import java.io.IOException;

import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.output.Format;
import org.jdom2.output.XMLOutputter;

public class CreateXML {

	public static void main(String[] args) {
		//JDOM Parser를 사용한 XML문서 생성.
		// 1.XML문서를 저장할 수 있는 문서 객체를 생성.
		Document xmlDoc = new Document();
		
		// 2.최상위 부모 노드
		Element rootNode = new Element("messages");
		
		// 3.XML문서 객체에 부모 노드를 추가
		xmlDoc.addContent(rootNode);

		// 4.자식 노드를 생성
		Element msgNode = new Element("message");
		
		// 5.자식 노드의 값 설정
		msgNode.setText("자식노드");
		
		// 자식 노드를 부모 노드에 추가
		rootNode.addContent(msgNode);
		
		
		Element msgNode2 = new Element("message");
		msgNode2.setText("자식노드2");
		Element msgNode3 = new Element("message");
		msgNode3.setText("자식노드3");
		rootNode.addContent(msgNode2);
		rootNode.addContent(msgNode3);
		
//		XMLOutputter xOut = new XMLOutputter(Format.getCompactFormat());//한줄
//		XMLOutputter xOut = new XMLOutputter(Format.getRawFormat());//한줄
		XMLOutputter xOut = new XMLOutputter(Format.getPrettyFormat());
		try {
			xOut.output(xmlDoc, System.out);
			FileOutputStream fos = new FileOutputStream("C:/Users/user/git/jsp_prj/jsp_prj/src/main/webapp/xml0709/hello2.xml");
			xOut.output(xmlDoc, fos);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
