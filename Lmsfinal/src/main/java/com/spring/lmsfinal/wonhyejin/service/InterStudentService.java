package com.spring.lmsfinal.wonhyejin.service;

import java.util.List;
import java.util.Map;

import com.spring.lmsfinal.wonhyejin.model.StudentVO;



public interface InterStudentService {

//학생회원 등록
	int stdRegisterEnd(Map<String, String> paraMap);
	
// 학생 등록시 학과관련리스트 
	List<StudentVO> stdDeptlistSearch(Map<String, String> paraMap);

// 학생 등록시 교원 관련리스트 
	List<StudentVO> stdGyowonlistSearch(Map<String, String> paraMap);
	
// 학번 중복검사
	int stdidDuplicateCheck(String stdid);

// 이메일 중복 확인 하기 
	int stdemailDuplicateCheck(String stdemail);

// 학생 회원 전체 조회 
	int getTotalPage(Map<String, String> paraMap);

// 학생 회원 전체 조회 
	List<StudentVO> selectPagingStudent(Map<String, String> paraMap);
	

	
//학생1명보여주기
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
