package day0623;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class ForEachService {
	public String[] subjectArr() {
		String[] subject = {"Java SE", "C/C++", "Python", "PHP", "JavaScript"};
		return subject;
	}
	public List<String> subjectList() {
		List<String> subject = new ArrayList<String>();
		subject.add("Java SE");
		subject.add("C/C++");
		subject.add("Python");
		subject.add("PHP");
		subject.add("JavaScript");
		return subject;
	}
	
	public List<UserDTO2> searchUser(){
		List<UserDTO2> list = new ArrayList<UserDTO2>();
		if (new Random().nextBoolean()) {
			list.add(new UserDTO2("가", "1@e.com", 20));
			list.add(new UserDTO2("나", "2@e.com", 21));
			list.add(new UserDTO2("다", "3@e.com", 23));
			list.add(new UserDTO2("라", "4@e.com", 22));
			list.add(new UserDTO2("라", "4@e.com", 22));
			list.add(new UserDTO2("라", "4@e.com", 22));
			list.add(new UserDTO2("라", "4@e.com", 22));
			list.add(new UserDTO2("라", "4@e.com", 22));
			list.add(new UserDTO2("라", "4@e.com", 22));
			list.add(new UserDTO2("라", "4@e.com", 22));
			list.add(new UserDTO2("라", "4@e.com", 22));
			list.add(new UserDTO2("라", "4@e.com", 22));
			list.add(new UserDTO2("라", "4@e.com", 22));
			list.add(new UserDTO2("라", "4@e.com", 22));
			list.add(new UserDTO2("라", "4@e.com", 22));
			list.add(new UserDTO2("라", "4@e.com", 22));
		}
		
		return list;
	}
}
