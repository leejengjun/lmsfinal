package com.spring.lmsfinal.wonhyejin.model;

import java.util.List;
import java.util.Map;

public interface InterStudentDAO {

//학생회원등록
	int stdRegisterEnd(Map<String, String> paraMap);
	
//학생회원 등록시 학과 관련 리스트 
	List<StudentVO> stdDeptlistSearch(Map<String, String> paraMap);

//	학생회원 등록시 교원 관련 리스트 
	List<StudentVO> stdGyowonlistSearch(Map<String, String> paraMap);
	
	
	
// 학번중복 검사 
	int stdidDuplicateCheck(String stdid);

//이메일 중복 확인 
	int stdemailDuplicateCheck(String stdemail);

// 학생 회원 전체 조회 
	int getTotalPage(Map<String, String> paraMap);
	
 // 학생 회원 전체 조회 
	List<StudentVO> selectPagingStudent(Map<String, String> paraMap);
	


	
//1명 조회 
	StudentVO studentOneDetail(String stdname);

// 상태변경_휴학승인
	int stuLeaveUpdate(Map<String, String> paraMap);
	
// 상태변경_휴학승인_apr
		void stuLeaveAprUpdate(String stdid);
		
// 상태변경_휴학거절
	int stuLeaveDelete(Map<String, String> paraMap);

// 상태변경_휴학거절_apr
	void stuLeaveAprDelete(String stdid);
	
	
	
//복학
	
// 상태변경_복학승인
	int stuReturnUpdate(Map<String, String> paraMap);
	
// 상태변경_복학승인_apr
	void stuReturnAprUpdate(String stdid);
		
// 상태변경_복학거절
	int stuReturnDelete(Map<String, String> paraMap);

// 상태변경_복학거절_apr
	void stuReturnAprDelete(String stdid);



	
	
}
