package day0624;

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
public class ProductDTO {
	private int prdNum;
	private String item;
	private String ShortInfo;
	private String itemImg;
	private Date inputDate;
	private int price;

}
