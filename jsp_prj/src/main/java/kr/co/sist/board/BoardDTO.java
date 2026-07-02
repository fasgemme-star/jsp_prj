package kr.co.sist.board;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoardDTO {
	private int num, cnt;
	private String id, title, content,  ip; 
	private Date inputDate;
}
