package com.spring.lmsfinal.leejeongjun.model;

public class TestinsertVO {

	private int courseno;
	private String content;
	
	public TestinsertVO() {}
	
	public TestinsertVO(int courseno, String content) {
		super();
		this.courseno = courseno;
		this.content = content;
	}

	public int getCourseno() {
		return courseno;
	}

	public void setCourseno(int courseno) {
		this.courseno = courseno;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	
	
}
