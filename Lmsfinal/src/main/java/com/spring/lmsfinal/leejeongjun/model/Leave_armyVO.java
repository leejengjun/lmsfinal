package com.spring.lmsfinal.leejeongjun.model;

import org.springframework.web.multipart.MultipartFile;

public class Leave_armyVO {

	private int leaveno;			// 휴학번호
	private int stdid;				// 학번
	private String startsemester_army;	// 시작학기
	private String endsemester;		// 종료학기
	
	private String fileName;		// 파일이름
	private String orgFilename;		// 진짜파일이름
	private String fileSize; 		// 파일크기
	
	private String regdate;			// 신청일자
	private String approve;			// 신청결과
	private String noreason;		// 반려이유
	private String returnsemester_army;	// 복학예정학기
	private String leavetype;		// 휴학종류
	private String leavereason;		// 휴학사유
	private String returnschool;	// 복학여부
	private String armytype;		// 병종
	private String armystartdate;	// 군시작일자
	private String armyenddate;		// 군종료일자
	
	private MultipartFile attach;	// form 태그에서 type="file" 인 파일을 받아서 저장되는 필드이다.

	public Leave_armyVO() {}
	
	public Leave_armyVO(int leaveno, int stdid, String startsemester_army, String endsemester, String fileName,
			String orgFilename, String fileSize, String regdate, String approve, String noreason, String returnsemester_army,
			String leavetype, String leavereason, String returnschool, String armytype, String armystartdate,
			String armyenddate, MultipartFile attach) {
		super();
		this.leaveno = leaveno;
		this.stdid = stdid;
		this.startsemester_army = startsemester_army;
		this.endsemester = endsemester;
		this.fileName = fileName;
		this.orgFilename = orgFilename;
		this.fileSize = fileSize;
		this.regdate = regdate;
		this.approve = approve;
		this.noreason = noreason;
		this.returnsemester_army = returnsemester_army;
		this.leavetype = leavetype;
		this.leavereason = leavereason;
		this.returnschool = returnschool;
		this.armytype = armytype;
		this.armystartdate = armystartdate;
		this.armyenddate = armyenddate;
		this.attach = attach;
	}

	public int getLeaveno() {
		return leaveno;
	}

	public void setLeaveno(int leaveno) {
		this.leaveno = leaveno;
	}

	public int getStdid() {
		return stdid;
	}

	public void setStdid(int stdid) {
		this.stdid = stdid;
	}

	public String getStartsemester_army() {
		return startsemester_army;
	}

	public void setStartsemester_army(String startsemester_army) {
		this.startsemester_army = startsemester_army;
	}

	public String getEndsemester() {
		return endsemester;
	}

	public void setEndsemester(String endsemester) {
		this.endsemester = endsemester;
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

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getApprove() {
		return approve;
	}

	public void setApprove(String approve) {
		this.approve = approve;
	}

	public String getNoreason() {
		return noreason;
	}

	public void setNoreason(String noreason) {
		this.noreason = noreason;
	}

	public String getReturnsemester_army() {
		return returnsemester_army;
	}

	public void setReturnsemester_army(String returnsemester_army) {
		this.returnsemester_army = returnsemester_army;
	}

	public String getLeavetype() {
		return leavetype;
	}

	public void setLeavetype(String leavetype) {
		this.leavetype = leavetype;
	}

	public String getLeavereason() {
		return leavereason;
	}

	public void setLeavereason(String leavereason) {
		this.leavereason = leavereason;
	}

	public String getReturnschool() {
		return returnschool;
	}

	public void setReturnschool(String returnschool) {
		this.returnschool = returnschool;
	}

	public String getArmytype() {
		return armytype;
	}

	public void setArmytype(String armytype) {
		this.armytype = armytype;
	}

	public String getArmystartdate() {
		return armystartdate;
	}

	public void setArmystartdate(String armystartdate) {
		this.armystartdate = armystartdate;
	}

	public String getArmyenddate() {
		return armyenddate;
	}

	public void setArmyenddate(String armyenddate) {
		this.armyenddate = armyenddate;
	}

	public MultipartFile getAttach() {
		return attach;
	}

	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}
	
	
	
	
}
