package kr.co.sist.user.member;

import java.sql.Date;

import lombok.Getter;
@Getter
public class MemberDTO {
	
	
	private int  intsmsReceiveYN;
	private int emailReceiveYN;
	private String  memberCode;
	private String  password;
	private String  passwordConfirm;
	private String  name;
	private String  email;
	private String  phone1;
	private String  phone2;
	private String  phone3;
	private String  zipcode;
	private String  address;
	private String  address2;
	
	private String[] hobby;
	
	private Date inputDate;

}
