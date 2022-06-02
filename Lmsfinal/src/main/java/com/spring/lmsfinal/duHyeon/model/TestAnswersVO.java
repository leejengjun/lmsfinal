package com.spring.lmsfinal.duHyeon.model;

public class TestAnswersVO {
	
	private String answersseq;
	private String questionseq;
	private String testclfc;
	private String subjectid;
	private String majorid;
	private String gyowonid;
	private String answer;
	
	
	
	public TestAnswersVO() {}
	
	
	public TestAnswersVO(String questionseq, String testclfc, String subjectid, String majorid, String gyowonid,
			String answer) {
		this.questionseq = questionseq;
		this.testclfc = testclfc;
		this.subjectid = subjectid;
		this.majorid = majorid;
		this.gyowonid = gyowonid;
		this.answer = answer;
	}


	public String getAnswersseq() {
		return answersseq;
	}
	public void setAnswersseq(String answersseq) {
		this.answersseq = answersseq;
	}
	public String getQuestionseq() {
		return questionseq;
	}
	public void setQuestionseq(String questionseq) {
		this.questionseq = questionseq;
	}
	public String getTestclfc() {
		return testclfc;
	}
	public void setTestclfc(String testclfc) {
		this.testclfc = testclfc;
	}
	public String getSubjectid() {
		return subjectid;
	}
	public void setSubjectid(String subjectid) {
		this.subjectid = subjectid;
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
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	
	
	
	
	
	
}
