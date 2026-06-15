package day0612;

import java.util.ArrayList;
import java.util.List;



public class TestService {
	
	public List<TestDTO> searchMember() {
		List<TestDTO> list = new ArrayList<TestDTO>();
		list.add(new TestDTO("가", 21));
		list.add(new TestDTO("나", 22));
		list.add(new TestDTO("다", 23));
		list.add(new TestDTO("라", 24));
		list.add(new TestDTO("마", 25));
		return list;
	}


}
