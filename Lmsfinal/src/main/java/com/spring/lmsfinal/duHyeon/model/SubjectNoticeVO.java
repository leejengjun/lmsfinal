package com.spring.lmsfinal.duHyeon.model;

import org.springframework.web.multipart.MultipartFile;

public class SubjectNoticeVO {

	private String subnoticeno;
	private String snsubject;
	private String sncontent;
	private String snregdate;
	private String snpwd;
	private String snstatus;
	private String subjectid;
	private String majorid;
	private String gyowonid;
	
	
	private String previousseq;      // 이전글번호
	private String previoussubject;  // 이전글제목
	private String nextseq;          // 다음글번호
	private String nextsubject;      // 다음글제목	
	

	private String classname;
	
	private MultipartFile attach;
	
	private String snfilename;    // WAS(톰캣)에 저장될 파일명(2020120809271535243254235235234.png) 
	private String snorgfilename; // 진짜 파일명(강아지.png)  // 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명
	private String snfilesize;	// 파일크기
	
	
	
	public SubjectNoticeVO() {}
	
	public SubjectNoticeVO(String subnoticeno, String snsubject, String sncontent, String snregdate, String snpwd,
			String snstatus, String subjectid, String majorid, String gyowonid,  String snfilename,
			String snorgfilename, String snfilesize) {
		super();
		this.subnoticeno = subnoticeno;
		this.snsubject = snsubject;
		this.sncontent = sncontent;
		this.snregdate = snregdate;
		this.snpwd = snpwd;
		this.snstatus = snstatus;
		this.subjectid = subjectid;
		this.majorid = majorid;
		this.gyowonid = gyowonid;
		this.snfilename = snfilename;
		this.snorgfilename = snorgfilename;
		this.snfilesize = snfilesize;
	}
	
	
	public String getSubnoticeno() {
		return subnoticeno;
	}
	public void setSubnoticeno(String subnoticeno) {
		this.subnoticeno = subnoticeno;
	}
	public String getSnsubject() {
		return snsubject;
	}
	public void setSnsubject(String snsubject) {
		this.snsubject = snsubject;
	}
	public String getSncontent() {
		return sncontent;
	}
	public void setSncontent(String sncontent) {
		this.sncontent = sncontent;
	}
	public String getSnregdate() {
		return snregdate;
	}
	public void setSnregdate(String snregdate) {
		this.snregdate = snregdate;
	}
	public String getSnpwd() {
		return snpwd;
	}
	public void setSnpwd(String snpwd) {
		this.snpwd = snpwd;
	}
	public String getSnstatus() {
		return snstatus;
	}
	public void setSnstatus(String snstatus) {
		this.snstatus = snstatus;
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
	public MultipartFile getAttach() {
		return attach;
	}
	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}
	public String getSnfilename() {
		return snfilename;
	}
	public void setSnfilename(String snfilename) {
		this.snfilename = snfilename;
	}
	public String getSnorgfilename() {
		return snorgfilename;
	}
	public void setSnorgfilename(String snorgfilename) {
		this.snorgfilename = snorgfilename;
	}
	public String getSnfilesize() {
		return snfilesize;
	}
	public void setSnfilesize(String snfilesize) {
		this.snfilesize = snfilesize;
	}
	

	//// 필요해서 추가했습니다. ///
	public String getClassname() {
		return classname;
	}

	public void setClassname(String classname) {
		this.classname = classname;
	}

	public String getPreviousseq() {
		return previousseq;
	}

	public void setPreviousseq(String previousseq) {
		this.previousseq = previousseq;
	}

	public String getPrevioussubject() {
		return previoussubject;
	}

	public void setPrevioussubject(String previoussubject) {
		this.previoussubject = previoussubject;
	}

	public String getNextseq() {
		return nextseq;
	}

	public void setNextseq(String nextseq) {
		this.nextseq = nextseq;
	}

	public String getNextsubject() {
		return nextsubject;
	}

	public void setNextsubject(String nextsubject) {
		this.nextsubject = nextsubject;
	}
	
	////////////////////////////
	
	
	
	
}
