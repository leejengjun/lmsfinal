package com.spring.lmsfinal.duHyeon.model;

public class StudentExamVO {

	private String testclfc;
	private String majorid;
	private String gyowonid;
	private String subjectid;
	private String stdid;
	private String issubmit;
	private String score;
	private String questionarr;
	private String checkarr;
	
	public StudentExamVO(){}
	
	public StudentExamVO(String testclfc, String majorid, String gyowonid, String subjectid, String stdid, String issubmit,
			String score, String questionarr, String checkarr) {
		super();
		this.testclfc = testclfc;
		this.majorid = majorid;
		this.gyowonid = gyowonid;
		this.subjectid = subjectid;
		this.stdid = stdid;
		this.issubmit = issubmit;
		this.score = score;
		this.questionarr = questionarr;
		this.checkarr = checkarr;
	}
	
	
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
	public String getStdid() {
		return stdid;
	}
	public void setStdid(String stdid) {
		this.stdid = stdid;
	}
	public String getIssubmit() {
		return issubmit;
	}
	public void setSubmit(String submit) {
		this.issubmit = submit;
	}
	public String getScore() {
		return score;
	}
	public void setScore(String score) {
		this.score = score;
	}
	public String getQuestionarr() {
		return questionarr;
	}
	public void setQuestionarr(String questionarr) {
		this.questionarr = questionarr;
	}
	public String getCheckarr() {
		return checkarr;
	}
	public void setCheckarr(String checkarr) {
		this.checkarr = checkarr;
	}
	
	
}
