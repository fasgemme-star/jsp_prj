package kr.co.sist.member;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class MemberDTO {
	private String id, password, name, email, phone1, zipcode, address1,
	 address2, ip, smsReceiveYN, emailReceiveYN;

}
