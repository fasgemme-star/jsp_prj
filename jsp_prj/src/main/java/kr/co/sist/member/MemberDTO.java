package kr.co.sist.member;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class MemberDTO {
	private String id, password, name, email, phone, phone1,phone2, phone3, zipcode, address,
	 address2, ip;
	private int smsReceiveYN, emailReceiveYN;
	
	private String[] hobby;
	private Date inputDate;
}
