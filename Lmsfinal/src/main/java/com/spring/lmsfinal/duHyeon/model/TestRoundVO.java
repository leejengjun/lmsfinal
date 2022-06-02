package com.spring.lmsfinal.duHyeon.model;

public class TestRoundVO {
	
	
	private String testclfc; 	// 시험구분 : seq써서 고유 시험번호를 만들 것이다 
	private String majorid;		// 학과코드 : 시험보는 학과의 고유 코드이다. 
	private String gyowonid;	// 교원번호 : 시험을 낼 교원의 아이디이다.
	private String subjectid;   // 강의코드 : 어떤 과목의 시험인지 알아오는 것이다.
	private String examtitle;	// 시험이름 : 기말 중간 그리고 기타를 입력할수 있게 만들었다.
	private String disclosure;	// 정답공개여부 : 시험지를 공개할지 안할지 알려주기 위하여 만들었다.
	private String startdate; 	// 시작일시 : 시험시간을 벗어난 시간엔 시험응시를 불가능 하게 하기위하여 만들었다.
	private String enddate; 	// 마감일시 :  						"
	private String questioncnt; // 문항수 : 문항수를 정하여 만들게 했다

	
	public String getTestclfc() {
		return testclfc;
	}
	public void setTestclfc(String testclfc) {
		this.testclfc = testclfc;
	}
	public String getMajorid() {
		return majorid;
	}
	public void setMajorid(String majorid) {
		this.majorid = majorid;
	}
	public String getGyowonid() {
		return gyowonid;
	}
	public void setGyowonid(String gyowonid) {
		this.gyowonid = gyowonid;
	}
	public String getSubjectid() {
		return subjectid;
	}
	public void setSubjectid(String subjectid) {
		this.subjectid = subjectid;
	}
	public String getExamtitle() {
		return examtitle;
	}
	public void setExamtitle(String examtitle) {
		this.examtitle = examtitle;
	}
	public String getDisclosure() {
		return disclosure;
	}
	public void setDisclosure(String disclosure) {
		this.disclosure = disclosure;
	}
	public String getStartdate() {
		return startdate;
	}
	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}
	public String getEnddate() {
		return enddate;
	}
	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}
	public String getQuestioncnt() {
		return questioncnt;
	}
	public void setQuestioncnt(String questioncnt) {
		this.questioncnt = questioncnt;
	}
	
	
	
	
}
