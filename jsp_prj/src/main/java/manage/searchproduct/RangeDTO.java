package manage.searchproduct;

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
public class RangeDTO {
	public String keyword;
	public String status;
	public String category;
	public String startDate;
	public String endDate;
	
	private int totalCnt;
    private int activeCnt;
	
}
