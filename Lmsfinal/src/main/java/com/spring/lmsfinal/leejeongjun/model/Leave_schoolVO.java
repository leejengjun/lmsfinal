package com.spring.lmsfinal.leejeongjun.model;

public class Leave_schoolVO {
	
	private int leaveno;			// 휴학번호
	private int stdid;				// 학번
	private String startsemester;	// 시작학기
	private String endsemester;		// 종료학기
	
	private String regdate;			// 신청일자
	private String approve;			// 신청결과
	private String noreason;		// 반려이유
	private String returnsemester;	// 복학예정학기
	private String leavetype;		// 휴학종류
	private String leavereason;		// 휴학사유
	private String returnschool;	// 복학여부
	
	public Leave_schoolVO() {}
	
	public Leave_schoolVO(int leaveno, int stdid, String startsemester, String endsemester, 
			String regdate, String approve, String noreason, String returnsemester,
			String leavetype, String leavereason, String returnschool) {

		this.leaveno = leaveno;
		this.stdid = stdid;
		this.startsemester = startsemester;
		this.endsemester = endsemester;
		this.regdate = regdate;
		this.approve = approve;
		this.noreason = noreason;
		this.returnsemester = returnsemester;
		this.leavetype = leavetype;
		this.leavereason = leavereason;
		this.returnschool = returnschool;
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

	public String getStartsemester() {
		return startsemester;
	}

	public void setStartsemester(String startsemester) {
		this.startsemester = startsemester;
	}

	public String getEndsemester() {
		return endsemester;
	}

	public void setEndsemester(String endsemester) {
		this.endsemester = endsemester;
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

	public String getReturnsemester() {
		return returnsemester;
	}

	public void setReturnsemester(String returnsemester) {
		this.returnsemester = returnsemester;
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
	
}
