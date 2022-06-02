package com.spring.lmsfinal.leejeongjun.model;

import org.springframework.web.multipart.MultipartFile;

public class Return_schoolVO {
	
	private int returnseq;			// 복학번호
	private int stdid;				// 학번
	private String returnsemester;	// 복학학기
	private String returntype;		// 복학종류
	private String regdate;			// 신청일자
	private String approvedate;		// 승인일자
	private String approve;			// 승인여부
	
	private MultipartFile attach;	// form 태그에서 type="file" 인 파일을 받아서 저장되는 필드이다.
	
	private String fileName;		// 파일이름
	private String orgFilename;		// 진짜파일이름
	private String fileSize;			// 파일크기
	
	public Return_schoolVO() {}

	public Return_schoolVO(int returnseq, int stdid, String returnsemester, String returntype, String regdate,
			String approvedate, String approve, MultipartFile attach, String fileName, String orgFilename,
			String fileSize) {
		
		this.returnseq = returnseq;
		this.stdid = stdid;
		this.returnsemester = returnsemester;
		this.returntype = returntype;
		this.regdate = regdate;
		this.approvedate = approvedate;
		this.approve = approve;
		this.attach = attach;
		this.fileName = fileName;
		this.orgFilename = orgFilename;
		this.fileSize = fileSize;
	}

	public int getReturnseq() {
		return returnseq;
	}

	public void setReturnseq(int returnseq) {
		this.returnseq = returnseq;
	}

	public int getStdid() {
		return stdid;
	}

	public void setStdid(int stdid) {
		this.stdid = stdid;
	}

	public String getReturnsemester() {
		return returnsemester;
	}

	public void setReturnsemester(String returnsemester) {
		this.returnsemester = returnsemester;
	}

	public String getReturntype() {
		return returntype;
	}

	public void setReturntype(String returntype) {
		this.returntype = returntype;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getApprovedate() {
		return approvedate;
	}

	public void setApprovedate(String approvedate) {
		this.approvedate = approvedate;
	}

	public String getApprove() {
		return approve;
	}

	public void setApprove(String approve) {
		this.approve = approve;
	}

	public MultipartFile getAttach() {
		return attach;
	}

	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getOrgFilename() {
		return orgFilename;
	}

	public void setOrgFilename(String orgFilename) {
		this.orgFilename = orgFilename;
	}

	public String getFileSize() {
		return fileSize;
	}

	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}
	
	
	
}
