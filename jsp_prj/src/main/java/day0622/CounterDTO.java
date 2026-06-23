package day0622;

public class CounterDTO {
	private int cnt;

	public CounterDTO() {
		System.out.println("conterDTO");
		cnt = 0;
	}// CounterDTO

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt += cnt;
	}
	
	
}// class
