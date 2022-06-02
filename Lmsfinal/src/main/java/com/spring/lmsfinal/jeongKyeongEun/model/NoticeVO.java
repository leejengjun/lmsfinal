package com.spring.lmsfinal.jeongKyeongEun.model;

import org.springframework.web.multipart.MultipartFile;

public class NoticeVO {
	
	private int noticeno;    // 글번호
	private String nsubject;
	private String ncontent;
	private String nregdate;
	private int ncnt;
	private String nfilename;
	private String norgfile;
	private int nfilesize;
	private int nstatus;
	
	private String previousnno;       // 이전글번호
	private String previousnsubject;  // 이전글제목
	private String nextnno;           // 다음글번호
	private String nextnsubject;      // 다음글제목	
	
	/*
	   === #152. 파일을 첨부하도록 VO 수정하기
	      먼저, 오라클에서 tbl_board 테이블에 3개 컬럼(fileName, orgFilename, fileSize)을 추가한 다음에 아래의 작업을 한다. 
	*/
	private MultipartFile attach;
	/* form 태그에서 type="file" 인 파일을 받아서 저장되는 필드이다. 
	      진짜파일 ==> WAS(톰캣) 디스크에 저장됨.
           조심할것은 MultipartFile attach 는 오라클 데이터베이스 tbl_board 테이블의 컬럼이 아니다.   
	   /Board/src/main/webapp/WEB-INF/views/tiles1/board/add.jsp 파일에서 input type="file" 인 name 의 이름(attach)과 
	     동일해야만 파일첨부가 가능해진다.!!!!
 */
	
	public NoticeVO() {}  // 기본생성자!!
	
	public NoticeVO(int noticeno, String nsubject, String ncontent, String nregdate, int ncnt, String nfilename, String norgfile, int nfilesize, int nstatus) {
		this.noticeno = noticeno;
		this.nsubject = nsubject;
		this.ncontent = ncontent;
		this.nregdate = nregdate;
		this.ncnt = ncnt;
		this.nfilename = nfilename;
		this.norgfile = norgfile;
		this.nfilesize = nfilesize;
		this.nstatus = nstatus;
	}

	public int getNoticeno() {
		return noticeno;
	}

	public void setNoticeno(int noticeno) {
		this.noticeno = noticeno;
	}

	public String getNsubject() {
		return nsubject;
	}

	public void setNsubject(String nsubject) {
		this.nsubject = nsubject;
	}

	public String getNcontent() {
		return ncontent;
	}

	public void setNcontent(String ncontent) {
		this.ncontent = ncontent;
	}

	public String getNregdate() {
		return nregdate;
	}

	public void setNregdate(String nregdate) {
		this.nregdate = nregdate;
	}

	public int getNcnt() {
		return ncnt;
	}

	public void setNcnt(int ncnt) {
		this.ncnt = ncnt;
	}

	public String getNfilename() {
		return nfilename;
	}

	public void setNfilename(String nfilename) {
		this.nfilename = nfilename;
	}

	public String getNorgfile() {
		return norgfile;
	}

	public void setNorgfile(String norgfile) {
		this.norgfile = norgfile;
	}

	public int getNfilesize() {
		return nfilesize;
	}

	public void setNfilesize(int nfilesize) {
		this.nfilesize = nfilesize;
	}

	public int getNstatus() {
		return nstatus;
	}

	public void setNstatus(int nstatus) {
		this.nstatus = nstatus;
	}

	public String getPreviousnno() {
		return previousnno;
	}

	public void setPreviousnno(String previousnno) {
		this.previousnno = previousnno;
	}

	public String getPreviousnsubject() {
		return previousnsubject;
	}

	public void setPreviousnsubject(String previousnsubject) {
		this.previousnsubject = previousnsubject;
	}

	public String getNextnno() {
		return nextnno;
	}

	public void setNextnno(String nextnno) {
		this.nextnno = nextnno;
	}

	public String getNextnsubject() {
		return nextnsubject;
	}

	public void setNextnsubject(String nextnsubject) {
		this.nextnsubject = nextnsubject;
	}

	public MultipartFile getAttach() {
		return attach;
	}

	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}

	
	
	

}
