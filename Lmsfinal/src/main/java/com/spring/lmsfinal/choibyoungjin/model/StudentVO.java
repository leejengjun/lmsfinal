package com.spring.lmsfinal.choibyoungjin.model;

public class StudentVO {
	
	private int stdid;
	private int stdmajorid;
	private int dmajorid;
	private int minorid;
	private int stdstateid;
	private int scholarcode;
	private int gyowonid;
	private String stdpwd;
	private String stdname;
	private String stdemail;
	private int status;
	private String stdnameeng;
	private String stdnation;
	private String stdbirthday;
	private String entday;
	private String entstate;
	private String stdjumin;	
	private String enttype;
	private String examnum;
	private String stdpostcode;
	private String stdaddress;
	private String stdmobile;	
	private String schoolfrom1;
	private String graddate1;
	private String schoolfrom2;
	private String graddate2;
	private String completesemester;

	private String stdmobile_hyphen;
	
	private String majorname;
	private String minorname;
	private String dmajorname;
	private String statename;
	private String gyoname;
	private int grade;
	
	public int getStdid() {
		return stdid;
	}
	public void setStdid(int stdid) {
		this.stdid = stdid;
	}
	public int getStdmajorid() {
		return stdmajorid;
	}
	public void setStdmajorid(int majorid) {
		this.stdmajorid = majorid;
	}
	public int getDmajorid() {
		return dmajorid;
	}
	public void setDmajorid(int dmajorid) {
		this.dmajorid = dmajorid;
	}
	public int getMinorid() {
		return minorid;
	}
	public void setMinorid(int minorid) {
		this.minorid = minorid;
	}
	public int getStdstateid() {
		return stdstateid;
	}
	public void setStdstateid(int stdstateid) {
		this.stdstateid = stdstateid;
	}
	public int getScholarcode() {
		return scholarcode;
	}
	public void setScholarcode(int scolarcode) {
		this.scholarcode = scolarcode;
	}
	public int getGyowonid() {
		return gyowonid;
	}
	public void setGyowonid(int gyowonid) {
		this.gyowonid = gyowonid;
	}
	public String getStdpwd() {
		return stdpwd;
	}
	public void setStdpwd(String stdpwd) {
		this.stdpwd = stdpwd;
	}
	public String getStdname() {
		return stdname;
	}
	public void setStdname(String stdname) {
		this.stdname = stdname;
	}
	public String getStdemail() {
		return stdemail;
	}
	public void setStdemail(String stdemail) {
		this.stdemail = stdemail;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getStdnameeng() {
		return stdnameeng;
	}
	public void setStdnameeng(String stdnameeng) {
		this.stdnameeng = stdnameeng;
	}
	public String getStdnation() {
		return stdnation;
	}
	public void setStdnation(String stdnation) {
		this.stdnation = stdnation;
	}
	public String getStdbirthday() {
		return stdbirthday;
	}
	public void setStdbirthday(String stdbirthday) {
		this.stdbirthday = stdbirthday;
	}
	public String getEntday() {
		return entday;
	}
	public void setEntday(String entday) {
		this.entday = entday;
	}
	public String getEntstate() {
		return entstate;
	}
	public void setEntstate(String entstate) {
		this.entstate = entstate;
	}
	public String getStdjumin() {
		return stdjumin;
	}
	public void setStdjumin(String stdjumin) {
		this.stdjumin = stdjumin;
	}
	public String getEnttype() {
		return enttype;
	}
	public void setEnttype(String enttype) {
		this.enttype = enttype;
	}
	public String getExamnum() {
		return examnum;
	}
	public void setExamnum(String examnum) {
		this.examnum = examnum;
	}
	public String getStdpostcode() {
		return stdpostcode;
	}
	public void setStdpostcode(String stdpostcode) {
		this.stdpostcode = stdpostcode;
	}
	public String getStdaddress() {
		return stdaddress;
	}
	public void setStdaddress(String stdaddress) {
		this.stdaddress = stdaddress;
	}
	public String getStdmobile() {
		return stdmobile;
	}
	public void setStdmobile(String stdmobile) {
		this.stdmobile = stdmobile;
	}
	public String getSchoolfrom1() {
		return schoolfrom1;
	}
	public void setSchoolfrom1(String schoolfrom1) {
		this.schoolfrom1 = schoolfrom1;
	}
	public String getGraddate1() {
		return graddate1;
	}
	public void setGraddate1(String graddate1) {
		this.graddate1 = graddate1;
	}
	public String getSchoolfrom2() {
		return schoolfrom2;
	}
	public void setSchoolfrom2(String schoolfrom2) {
		this.schoolfrom2 = schoolfrom2;
	}
	public String getGraddate2() {
		return graddate2;
	}
	public void setGraddate2(String graddate2) {
		this.graddate2 = graddate2;
	}
	public String getMajorname() {
		return majorname;
	}
	public void setMajorname(String majorname) {
		this.majorname = majorname;
	}
	public String getMinorname() {
		return minorname;
	}
	public void setMinorname(String minorname) {
		this.minorname = minorname;
	}
	public String getDmajorname() {
		return dmajorname;
	}
	public void setDmajorname(String dmajorname) {
		this.dmajorname = dmajorname;
	}
	public String getStatename() {
		return statename;
	}
	public void setStatename(String statename) {
		this.statename = statename;
	}
	public String getGyoname() {
		return gyoname;
	}
	public void setGyoname(String gyoname) {
		this.gyoname = gyoname;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	} 
	public String getCompletesemester() {
		return completesemester;
	}
	public void setCompletesemester(String completesemester) {
		this.completesemester = completesemester;
	}

	///// 일정관리를 위한 getter setter /////
	public String getUserid() {
		return Integer.toString(stdid);
	}
	public void setUserid(int userid) {
		this.stdid = userid;
	}
	public String getName() {
		return stdname;
	}
	public void setName(String name) {
		this.stdname = name;
	}
	public String getStdmobile_hyphen() {
		return stdmobile_hyphen;
	}
	public void setStdmobile_hyphen(String stdmobile_hyphen) {
		this.stdmobile_hyphen = stdmobile_hyphen;
	}
	
	
}
