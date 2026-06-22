package day0622;

public class TestDTO {
	private String name;
	private String email;
	private int age;
	
	public TestDTO() {
		System.out.println("기본 생성자");
	}
	
	public TestDTO(String name, String email, int age) {
		super();
		this.name = name;
		this.email = email;
		this.age = age;
		System.out.println("매개변수 생성자");
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	
}
