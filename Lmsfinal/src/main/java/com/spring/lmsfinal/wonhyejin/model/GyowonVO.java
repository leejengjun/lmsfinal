package com.spring.lmsfinal.wonhyejin.model;

public class GyowonVO {

	private String gyowonid;       // 교원 아이디           
	private String gyopwd;         // 비밀번호 (SHA-256 암호화 대상)       
	private String gyoemail;       // 교원 이메일     
	private String gyomajorid;     // 학과코드   
	private String gyoname;        // 교원 이름 (한글)            
	private String gyonameeng;     // 교원 이름 (영문)
	private String gyobirthday;    // 교원 생일  
	private String gyojumin;       // 교원 주민번호    
	private String gyonation;      // 교원  국적      
	private String gyoaddress;     // 교원 주소
	private String gyopostcode;    // 교원 우편번호   
	private String gyomobile;      // 교원 핸드폰번호
	private String position;       // 교원  직위 
	private String appointmentdt;  // 교원 임용일자
	private String workstatus;     // 교원 근로상태코드
	private String degree;  	   // 교원 최종학력
	private String career1;        // 교원 경력1   
	private String careerTime1;    // 교원 경력1 근무기간
	private String career2;        // 교원 경력2    
	private String careerTime2;    // 교원 경력2 근무기간  
	private String status;         // 교원 계정 상태 (교원은 3)
	
	String deptname;
	
	private String majorid;
	
	public GyowonVO() {}
	
	public GyowonVO(String gyowonid, String gyopwd, String gyoemail, String gyomajorid, String gyoname,
			String gyonameeng, String gyobirthday, String gyojumin, String gyonation, String gyoaddress,
			String gyopostcode, String gyomobile, String position, String appointmentdt, String workstatus,
			String degree, String career1, String careerTime1, String career2, String careerTime2, String status) {
		
		this.gyowonid = gyowonid;
		this.gyopwd = gyopwd;
		this.gyoemail = gyoemail;
		this.gyomajorid = gyomajorid;
		this.gyoname = gyoname;
		this.gyonameeng = gyonameeng;
		this.gyobirthday = gyobirthday;
		this.gyojumin = gyojumin;
		this.gyonation = gyonation;
		this.gyoaddress = gyoaddress;
		this.gyopostcode = gyopostcode;
		this.gyomobile = gyomobile;
		this.position = position;
		this.appointmentdt = appointmentdt;
		this.workstatus = workstatus;
		this.degree = degree;
		this.career1 = career1;
		this.careerTime1 = careerTime1;
		this.career2 = career2;
		this.careerTime2 = careerTime2;
		this.status = status;
	}

	public String getGyowonid() {
		return gyowonid;
	}

	public void setGyowonid(String gyowonid) {
		this.gyowonid = gyowonid;
	}

	public String getGyopwd() {
		return gyopwd;
	}

	public void setGyopwd(String gyopwd) {
		this.gyopwd = gyopwd;
	}

	public String getGyoemail() {
		return gyoemail;
	}

	public void setGyoemail(String gyoemail) {
		this.gyoemail = gyoemail;
	}

	public String getGyomajorid() {
		return gyomajorid;
	}

	public void setGyomajorid(String gyomajorid) {
		this.gyomajorid = gyomajorid;
	}

	public String getGyoname() {
		return gyoname;
	}

	public void setGyoname(String gyoname) {
		this.gyoname = gyoname;
	}

	public String getGyonameeng() {
		return gyonameeng;
	}

	public void setGyonameeng(String gyonameeng) {
		this.gyonameeng = gyonameeng;
	}

	public String getGyobirthday() {
		return gyobirthday;
	}

	public void setGyobirthday(String gyobirthday) {
		this.gyobirthday = gyobirthday;
	}

	public String getGyojumin() {
		return gyojumin;
	}

	public void setGyojumin(String gyojumin) {
		this.gyojumin = gyojumin;
	}

	public String getGyonation() {
		return gyonation;
	}

	public void setGyonation(String gyonation) {
		this.gyonation = gyonation;
	}

	public String getGyoaddress() {
		return gyoaddress;
	}

	public void setGyoaddress(String gyoaddress) {
		this.gyoaddress = gyoaddress;
	}

	public String getGyopostcode() {
		return gyopostcode;
	}

	public void setGyopostcode(String gyopostcode) {
		this.gyopostcode = gyopostcode;
	}

	public String getGyomobile() {
		return gyomobile;
	}

	public void setGyomobile(String gyomobile) {
		this.gyomobile = gyomobile;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getAppointmentdt() {
		return appointmentdt;
	}

	public void setAppointmentdt(String appointmentdt) {
		this.appointmentdt = appointmentdt;
	}

	public String getWorkstatus() {
		return workstatus;
	}

	public void setWorkstatus(String workstatus) {
		this.workstatus = workstatus;
	}

	public String getDegree() {
		return degree;
	}

	public void setDegree(String degree) {
		this.degree = degree;
	}

	public String getCareer1() {
		return career1;
	}

	public void setCareer1(String career1) {
		this.career1 = career1;
	}

	public String getCareerTime1() {
		return careerTime1;
	}

	public void setCareerTime1(String careerTime1) {
		this.careerTime1 = careerTime1;
	}

	public String getCareer2() {
		return career2;
	}

	public void setCareer2(String career2) {
		this.career2 = career2;
	}

	public String getCareerTime2() {
		return careerTime2;
	}

	public void setCareerTime2(String careerTime2) {
		this.careerTime2 = careerTime2;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

///////
	public String getDeptname() {
		return deptname;
	}
	public void setDeptname(String deptname) {
		this.deptname = deptname;
	}
	public String getMajorid() {
		return majorid;
	}

	public void setMajorid(String majorid) {
		this.majorid = majorid;
	}
	
}


