package com.spring.lmsfinal.yejinsim.model;

public class LectureplanVO {

	private String seq_lectureplan; // 강의계획서 번호 
	private String subjectid;           // 강의코드
	private String majorid;             // 학과코드
	private String gyowonid;            // 교원번호
	private String lpsummary;        //  강의개요
	private String lpobject;         //  교과목표
	private String lpbook;           //  교재 및 참고문헌
	private String lpattendper;         //  출석점수비율
	private String lphomewkper;         //  과제점수비율
	private String lpexamper;           //  시험점수비율
	
	private String lectureweek;         //  주차시
	private String lptopic;          //  학습주제
	private String lpteaching;       //  수업방식
	private String lpmaterial;       //  교수학습자료
	private String lphomewk;         //  과제
	
	///////////////////////////////////
	private String classname;
	private String deptname;
	private String gyoname;
	private String count;  // 기존에 있던 주차별 계획의 행개수
	
	
	public String getSeq_lectureplan() {
		return seq_lectureplan;
	}
	public void setSeq_lectureplan(String seq_lectureplan) {
		this.seq_lectureplan = seq_lectureplan;
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
	public String getLpsummary() {
		return lpsummary;
	}
	public void setLpsummary(String lpsummary) {
		this.lpsummary = lpsummary;
	}
	public String getLpobject() {
		return lpobject;
	}
	public void setLpobject(String lpobject) {
		this.lpobject = lpobject;
	}
	public String getLpbook() {
		return lpbook;
	}
	public void setLpbook(String lpbook) {
		this.lpbook = lpbook;
	}
	public String getLpattendper() {
		return lpattendper;
	}
	public void setLpattendper(String lpattendper) {
		this.lpattendper = lpattendper;
	}
	public String getLphomewkper() {
		return lphomewkper;
	}
	public void setLphomewkper(String lphomewkper) {
		this.lphomewkper = lphomewkper;
	}
	public String getLpexamper() {
		return lpexamper;
	}
	public void setLpexamper(String lpexamper) {
		this.lpexamper = lpexamper;
	}
	public String getLectureweek() {
		return lectureweek;
	}
	public void setLectureweek(String lectureweek) {
		this.lectureweek = lectureweek;
	}
	public String getLptopic() {
		return lptopic;
	}
	public void setLptopic(String lptopic) {
		this.lptopic = lptopic;
	}
	public String getLpteaching() {
		return lpteaching;
	}
	public void setLpteaching(String lpteaching) {
		this.lpteaching = lpteaching;
	}
	public String getLpmaterial() {
		return lpmaterial;
	}
	public void setLpmaterial(String lpmaterial) {
		this.lpmaterial = lpmaterial;
	}
	public String getLphomewk() {
		return lphomewk;
	}
	public void setLphomewk(String lphomewk) {
		this.lphomewk = lphomewk;
	}
	public String getClassname() {
		return classname;
	}
	public void setClassname(String classname) {
		this.classname = classname;
	}
	public String getDeptname() {
		return deptname;
	}
	public void setDeptname(String deptname) {
		this.deptname = deptname;
	}
	public String getGyoname() {
		return gyoname;
	}
	public void setGyoname(String gyoname) {
		this.gyoname = gyoname;
	}
	public String getCount() {
		return count;
	}
	public void setCount(String count) {
		this.count = count;
	}
	
	
	
}
