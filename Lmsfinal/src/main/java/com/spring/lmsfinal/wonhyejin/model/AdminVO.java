package com.spring.lmsfinal.wonhyejin.model;

public class AdminVO {

	private String userid;       // 아이디
	private String pwd;          //  비밀번호
	private String status;       // 계정상태
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	
}
