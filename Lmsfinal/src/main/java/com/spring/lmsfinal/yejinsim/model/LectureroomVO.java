package com.spring.lmsfinal.yejinsim.model;

public class LectureroomVO {

	private int seq_lctrassign;   // 강의실관리번호
	private int subjectid;    // 강의코드
	private int buildno;      // 건물번호
	private int periodid;     // 교시코드
	private int dayid;        // 요일코드
	private int seq_lctrid;   // 강의실번호
	private int majorid;      // 학과코드
	private int gyowonid;     // 교원번호
	private int opensemester; // 개설학기
	private int emptystate;   // 예약상태 
	private int maxperson;    // 수용인원
	// 정원 어딨어..?
	
	private String buildname; // 건물이름
	
	private String lctrid;     // 강의실명
	
	public int getSeq_lctrassign() {
		return seq_lctrassign;
	}
	public void setSeq_lctrassign(int seq_lctrassign) {
		this.seq_lctrassign = seq_lctrassign;
	}
	
	public int getSeq_lctrid() {
		return seq_lctrid;
	}
	public void setSeq_lctrid(int seq_lctrid) {
		this.seq_lctrid = seq_lctrid;
	}
	public int getSubjectid() {
		return subjectid;
	}
	public void setSubjectid(int subjectid) {
		this.subjectid = subjectid;
	}
	public int getBuildno() {
		return buildno;
	}
	public void setBuildno(int buildno) {
		this.buildno = buildno;
	}
	public int getPeriodid() {
		return periodid;
	}
	public void setPeriodid(int periodid) {
		this.periodid = periodid;
	}
	public String getLctrid() {
		return lctrid;
	}
	public void setLctrid(String lctrid) {
		this.lctrid = lctrid;
	}
	public int getDayid() {
		return dayid;
	}
	public void setDayid(int dayid) {
		this.dayid = dayid;
	}
	
	public int getMajorid() {
		return majorid;
	}
	public void setMajorid(int majorid) {
		this.majorid = majorid;
	}
	public int getGyowonid() {
		return gyowonid;
	}
	public void setGyowonid(int gyowonid) {
		this.gyowonid = gyowonid;
	}
	public int getOpensemester() {
		return opensemester;
	}
	public void setOpensemester(int opensemester) {
		this.opensemester = opensemester;
	}
	public int getEmptystate() {
		return emptystate;
	}
	public void setEmptystate(int emptystate) {
		this.emptystate = emptystate;
	}
	public int getMaxperson() {
		return maxperson;
	}
	public void setMaxperson(int maxperson) {
		this.maxperson = maxperson;
	}
	public String getBuildname() {
		return buildname;
	}
	public void setBuildname(String buildname) {
		this.buildname = buildname;
	}
	
}
