package kr.co.sist.board;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class RangeDTO {
	private int startNum, endNum;
	private String fieldNum, field, keyword;//필드에 해당하는 숫자, 컬럼명, 검색값
	
	private String[] fieldArr= {"title", "content", "id"};
	
	public void setFieldNum(String fieldNum) {
		this.fieldNum=fieldNum;
		if (fieldNum == null || "".equals(fieldNum)) {
			fieldNum = "0";
		}
		
		field = fieldArr[Integer.parseInt(fieldNum)];
	}
}
