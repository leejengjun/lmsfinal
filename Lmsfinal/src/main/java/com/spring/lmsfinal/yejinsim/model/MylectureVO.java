package com.spring.lmsfinal.yejinsim.model;

public class MylectureVO {

	
	private String subjectid;    // 강의코드
	private String majorid;      // 학과코드
	private String gyowonid;     // 교원번호(교원 아이디)
	private String classname;    // 강의 제목
	private String credit;       // 학점
	private String opensemester; // 개설 학기
	private String courseclfc;   // 이수 구분
	private String applyperson;  // 수강신청 인원
	private String totalperson;  // 정원
	private String applydate;    // 강의 개설 신청일자
	private String applystate;   // 강의 개설 신청 상태	
	
	private String deptname;    // 학과 이름
	private String rno;         // 내 강의 번호
	private String buildno;     // 건물 번호
	
	
	//강의실 시간
	private String periodid;     // 교시코드
	private String dayid;        // 요일코드
	
	//강의실 위치
	private String buildname;    // 건물 이름
	private String lctrid;       // 강의실 번호
	
	//강의계획서 번호
	private String seq_lectureplan; // 강의계획서 번호 
	private String gyoname; //교수이름
	
	
	
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
	public String getClassname() {
		return classname;
	}
	public void setClassname(String classname) {
		this.classname = classname;
	}
	public String getCredit() {
		return credit;
	}
	public void setCredit(String credit) {
		this.credit = credit;
	}
	public String getOpensemester() {
		return opensemester;
	}
	public void setOpensemester(String opensemester) {
		this.opensemester = opensemester;
	}
	public String getCourseclfc() {
		return courseclfc;
	}
	public void setCourseclfc(String courseclfc) {
		this.courseclfc = courseclfc;
	}
	public String getApplyperson() {
		return applyperson;
	}
	public void setApplyperson(String applyperson) {
		this.applyperson = applyperson;
	}
	public String getTotalperson() {
		return totalperson;
	}
	public void setTotalperson(String totalperson) {
		this.totalperson = totalperson;
	}
	public String getApplydate() {
		return applydate;
	}
	public void setApplydate(String applydate) {
		this.applydate = applydate;
	}
	public String getApplystate() {
		return applystate;
	}
	public void setApplystate(String applystate) {
		this.applystate = applystate;
	}
	public String getLctrid() {
		return lctrid;
	}
	public void setLctrid(String lctrid) {
		this.lctrid = lctrid;
	}
	public String getPeriodid() {
		return periodid;
	}
	public void setPeriodid(String periodid) {
		this.periodid = periodid;
	}
	public String getDayid() {
		return dayid;
	}
	public void setDayid(String dayid) {
		this.dayid = dayid;
	}
	public String getDeptname() {
		return deptname;
	}
	public void setDeptname(String deptname) {
		this.deptname = deptname;
	}
	public String getRno() {
		return rno;
	}
	public void setRno(String rno) {
		this.rno = rno;
	}
	public String getBuildno() {
		return buildno;
	}
	public void setBuildno(String buildno) {
		this.buildno = buildno;
	}
	public String getBuildname() {
		return buildname;
	}
	public void setBuildname(String buildname) {
		this.buildname = buildname;
	}
	public String getSeq_lectureplan() {
		return seq_lectureplan;
	}
	public void setSeq_lectureplan(String seq_lectureplan) {
		this.seq_lectureplan = seq_lectureplan;
	}
	public String getGyoname() {
		return gyoname;
	}
	public void setGyoname(String gyoname) {
		this.gyoname = gyoname;
	}
		
	//////////////////////////////////////////////
	//강의평가
	private String evalucode;
	private String courseno;
	private String firstqs;
	private String secondqs;
	private String thirdqs;
	private String fourqs;
	private String fiveqs;
	private String sixqs;
	private String sevenqs;
	private String eightqs;
	private String regdate;
	private String etc;
	private String checktype;
	
	
	//강의평가 결과 
	private String firstans;
	private String secondans;
	private String thirdans;
	private String fourans;
	private String fiveans;
	private String sixans;
	private String sevenans;
	private String eightans;
	private String regaate;
	private String etcans;
	
	public String getEvalucode() {
	return evalucode;
	}
	public void setEvalucode(String evalucode) {
	this.evalucode = evalucode;
	}
	public String getCourseno() {
	return courseno;
	}
	public void setCourseno(String courseno) {
	this.courseno = courseno;
	}
	public String getFirstqs() {
	return firstqs;
	}
	public void setFirstqs(String firstqs) {
	this.firstqs = firstqs;
	}
	public String getSecondqs() {
	return secondqs;
	}
	public void setSecondqs(String secondqs) {
	this.secondqs = secondqs;
	}
	public String getThirdqs() {
	return thirdqs;
	}
	public void setThirdqs(String thirdqs) {
	this.thirdqs = thirdqs;
	}
	public String getFourqs() {
	return fourqs;
	}
	public void setFourqs(String fourqs) {
	this.fourqs = fourqs;
	}
	public String getFiveqs() {
	return fiveqs;
	}
	public void setFiveqs(String fiveqs) {
	this.fiveqs = fiveqs;
	}
	public String getSixqs() {
	return sixqs;
	}
	public void setSixqs(String sixqs) {
	this.sixqs = sixqs;
	}
	public String getSevenqs() {
	return sevenqs;
	}
	public void setSevenqs(String sevenqs) {
	this.sevenqs = sevenqs;
	}
	public String getEightqs() {
	return eightqs;
	}
	public void setEightqs(String eightqs) {
	this.eightqs = eightqs;
	}
	public String getRegdate() {
	return regdate;
	}
	public void setRegdate(String regdate) {
	this.regdate = regdate;
	}
	public String getEtc() {
	return etc;
	}
	public void setEtc(String etc) {
	this.etc = etc;
	}
	public String getChecktype() {
	return checktype;
	}
	public void setChecktype(String checktype) {
	this.checktype = checktype;
	}
	public String getFirstans() {
		return firstans;
	}
	public void setFirstans(String firstans) {
		this.firstans = firstans;
	}
	public String getSecondans() {
		return secondans;
	}
	public void setSecondans(String secondans) {
		this.secondans = secondans;
	}
	public String getThirdans() {
		return thirdans;
	}
	public void setThirdans(String thirdans) {
		this.thirdans = thirdans;
	}
	public String getFourans() {
		return fourans;
	}
	public void setFourans(String fourans) {
		this.fourans = fourans;
	}
	public String getFiveans() {
		return fiveans;
	}
	public void setFiveans(String fiveans) {
		this.fiveans = fiveans;
	}
	public String getSixans() {
		return sixans;
	}
	public void setSixans(String sixans) {
		this.sixans = sixans;
	}
	public String getSevenans() {
		return sevenans;
	}
	public void setSevenans(String sevenans) {
		this.sevenans = sevenans;
	}
	public String getEightans() {
		return eightans;
	}
	public void setEightans(String eightans) {
		this.eightans = eightans;
	}
	public String getRegaate() {
		return regaate;
	}
	public void setRegaate(String regaate) {
		this.regaate = regaate;
	}
	public String getEtcans() {
		return etcans;
	}
	public void setEtcans(String etcans) {
		this.etcans = etcans;
	}
	
	/////////////////////////////////////////
	
	
	

}
