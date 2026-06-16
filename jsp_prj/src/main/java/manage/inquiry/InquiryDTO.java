package manage.inquiry;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class InquiryDTO {
	private String inquiryID;
	private String clientID;
	private String clientName;
	private String title;
	private String content;
	private String answer;
	private String inquiryDate;
	private String answerDate;
	private String status;
	private String inquiryType;
	private String orderID;

}
