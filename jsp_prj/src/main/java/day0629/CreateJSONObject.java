package day0629;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class CreateJSONObject {
	
	@SuppressWarnings("unchecked")
	public String jsonObj() {
		// 1.JSONObjet 생성
		JSONObject jsonObj = new JSONObject();
		
		// 2.값할당: 동일 이름이 없으면 추가, 있으면 덮어쓰기
		jsonObj.put("name", "홍길동");
		jsonObj.put("age", 20);
		jsonObj.put("addr", "서울시 강남구 대치동");
		jsonObj.put("addr", "서울시 동대문구 동대문동");
		jsonObj.put("flag", true);
		
		// 생성된 객체를 JSONObject 형태의 문자열로 반환
		return jsonObj.toJSONString();
	}// jsonObj
	
	@SuppressWarnings("unchecked")
	public String jsonArray() {

		JSONArray jsonArr = new JSONArray();
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("name", "test");
		jsonObj.put("age", 20);
		
		JSONObject jsonObj2 = new JSONObject();
		jsonObj2.put("name", "test2");
		jsonObj2.put("age", 22);
		
		jsonArr.add(jsonObj);
		jsonArr.add(jsonObj2);
		
		return jsonArr.toJSONString();
	}// jsonArray
	
	public String compositJson() {
		// 1.데이터와 부가적인 정보를 가진 JSONObject 생성.
		JSONObject infoJSON = new JSONObject();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd EEEE");
		infoJSON.put("pubDate", sdf.format(new Date()));
		infoJSON.put("auth", "테스트");

		// 2.데이터를 저장할 JSONArray 생성
		JSONArray jsonArr = new JSONArray();
		
		if(new Random().nextBoolean()) {
			// 2-1.데이터를 저장할 JSONObject 생성
			JSONObject dataJsonObj = new JSONObject();
			
			// 2-2.데이터 저장
			dataJsonObj.put("이름", "테스트");
			dataJsonObj.put("나이", 20);
			// 2-3.JSONArry에 데이터를 가진 JSONObject를 저장
			jsonArr.add(dataJsonObj);
			
			// 2-1.데이터를 저장할 JSONObject 생성
			JSONObject dataJsonObj2 = new JSONObject();
			
			// 2-2.데이터 저장
			dataJsonObj2.put("이름", "테스트2");
			dataJsonObj2.put("나이", 22);
			// 2-3.JSONArry에 데이터를 가진 JSONObject를 저장
			jsonArr.add(dataJsonObj2);
		}
		
		// 부가적인 정보 추가
		infoJSON.put("dataLength", jsonArr.size());
		infoJSON.put("resultFlag", !jsonArr.isEmpty());
		
		// 데이터 추가
		infoJSON.put("data", jsonArr);
		
		return infoJSON.toJSONString();
	}// compositJson
	
}// class
