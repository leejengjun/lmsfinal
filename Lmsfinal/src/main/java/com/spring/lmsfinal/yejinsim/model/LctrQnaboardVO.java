package com.spring.lmsfinal.yejinsim.model;

import org.springframework.web.multipart.MultipartFile;

public class LctrQnaboardVO {

	
	private String qnano;      // Q&A글번호
	private String stdid;      // 학번(학생ID)
	private String userid;     // 아이디
	private String qsubject;   // 글제목
	private String qcontent;   // Q&A내용
	private String qpwd;       // 글암호
	private String qcnt;       // 조회수
	private String qregdate;   // 작성일
	private String qstatus;    // 글삭제여부
	private String commentcnt; // 댓글개수
	private String qgroupno;   // 그룹번호(답변글)
	private String fk_qseq;    // 원글번호
	private String qdepthno;   // 원글DEPTHNO
	
	private MultipartFile attach;
	private String qfilename;  // 파일명
	private String qorgfile;  // 원파일명
	private String qfilesize;  // 파일사이즈
	public String getQnano() {
		return qnano;
	}
	public void setQnano(String qnano) {
		this.qnano = qnano;
	}
	public String getStdid() {
		return stdid;
	}
	public void setStdid(String stdid) {
		this.stdid = stdid;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getQsubject() {
		return qsubject;
	}
	public void setQsubject(String qsubject) {
		this.qsubject = qsubject;
	}
	public String getQcontent() {
		return qcontent;
	}
	public void setQcontent(String qcontent) {
		this.qcontent = qcontent;
	}
	public String getQpwd() {
		return qpwd;
	}
	public void setQpwd(String qpwd) {
		this.qpwd = qpwd;
	}
	public String getQcnt() {
		return qcnt;
	}
	public void setQcnt(String qcnt) {
		this.qcnt = qcnt;
	}
	public String getQregdate() {
		return qregdate;
	}
	public void setQregdate(String qregdate) {
		this.qregdate = qregdate;
	}
	public String getQstatus() {
		return qstatus;
	}
	public void setQstatus(String qstatus) {
		this.qstatus = qstatus;
	}
	public String getCommentcnt() {
		return commentcnt;
	}
	public void setCommentcnt(String commentcnt) {
		this.commentcnt = commentcnt;
	}
	public String getQgroupno() {
		return qgroupno;
	}
	public void setQgroupno(String qgroupno) {
		this.qgroupno = qgroupno;
	}
	public String getFk_qseq() {
		return fk_qseq;
	}
	public void setFk_qseq(String fk_qseq) {
		this.fk_qseq = fk_qseq;
	}
	public String getQdepthno() {
		return qdepthno;
	}
	public void setQdepthno(String qdepthno) {
		this.qdepthno = qdepthno;
	}
	public String getQfilename() {
		return qfilename;
	}
	public void setQfilename(String qfilename) {
		this.qfilename = qfilename;
	}
	public String getQorgfile() {
		return qorgfile;
	}
	public void setQorgfile(String qorgfile) {
		this.qorgfile = qorgfile;
	}
	public String getQfilesize() {
		return qfilesize;
	}
	public void setQfilesize(String qfilesize) {
		this.qfilesize = qfilesize;
	}
	public MultipartFile getAttach() {
		return attach;
	}
	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}
	
	
}
