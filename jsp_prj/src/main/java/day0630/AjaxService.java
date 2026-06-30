package day0630;

import org.json.simple.JSONArray;

//import java.math.BigDecimal;

import org.json.simple.JSONObject;

public class AjaxService {
	@SuppressWarnings("unchecked")
	public String paramProcess(AjaxDTO aDTO) {
		// 1.JSONObject 생성
		JSONObject jsonObj = new JSONObject();
		// 2.값 할당
		jsonObj.put("userName", aDTO.getNa());
		/*
		 * BigDecimal bd = aDTO.getAge(); int age = 0; if (bd != null) { age =
		 * bd.intValue(); } // end if
		 */		
		jsonObj.put("userAge", aDTO.getAge());
		jsonObj.put("userAddr", aDTO.getAddress());
		jsonObj.put("type", aDTO.getType());
		
		String[] data = {"java SE","Oracle DBMS","JDBC","HTML"};
		JSONObject jsonTemp = null;
		JSONArray jsonArr = new JSONArray();
		
		for (int i=0; i < data.length; i++) {
			jsonTemp = new JSONObject();
			jsonTemp.put("subject", data[i]);
			jsonArr.add(jsonTemp);
		}
		
		jsonObj.put("data", jsonArr);
		
		
		// 3.JSONObject문자열 반환
		return jsonObj.toJSONString();
	}
}
