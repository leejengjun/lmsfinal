package com.spring.lmsfinal.wonhyejin.service;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.spring.lmsfinal.common.AES256;
import com.spring.lmsfinal.wonhyejin.model.InterStudentDAO;
import com.spring.lmsfinal.wonhyejin.model.StudentVO;



@Service
public class StudentService implements InterStudentService {
	
	@Autowired
	private InterStudentDAO dao;

	 @Autowired
	  private AES256 aes;
	 
//학생회원 등록
	@Override
	public int stdRegisterEnd(Map<String, String> paraMap) {
		int n = dao.stdRegisterEnd(paraMap);
		return n;
	}
	
//학번 중복 확인 
	@Override
	public int stdidDuplicateCheck(String stdid) {
		int result = dao.stdidDuplicateCheck(stdid);
		return result;
	}
	
//이메일 중복 확인 하기 //
	@Override
	public int stdemailDuplicateCheck(String stdemail) {
		int result = dao.stdemailDuplicateCheck(stdemail);
		return result;
	}

// 학생 전체조회
	@Override
	public int getTotalPage(Map<String, String> paraMap) {
		int n = dao.getTotalPage(paraMap);
		return n;
	}
// 학생 전체조회
	@Override
	public List<StudentVO> selectPagingStudent(Map<String, String> paraMap) {
		List<StudentVO> studentList = dao.selectPagingStudent(paraMap);
		return studentList;
	}
	


	
//학생 1명조회
	@Override
	public StudentVO studentOneDetail(String stdname) {
		StudentVO studentvo = dao.studentOneDetail(stdname);
		return studentvo;
	}

// 상태변경_휴학승인
	@Override
	public int stuLeaveUpdate(Map<String, String> paraMap) {
		int n = dao.stuLeaveUpdate(paraMap);
		return n;
	}
	
// 상태변경_휴학승인_Apr
	@Override
	public void stuLeaveAprUpdate(String stdid) {
		dao.stuLeaveAprUpdate(stdid);
		
	}

		
// 상태변경_휴학거절
	@Override
	public int stuLeaveDelete(Map<String, String> paraMap) {
		int n = dao.stuLeaveDelete(paraMap);
		return n;
	}
	
// 상태변경_휴학거절_Apr
	@Override
	public void stuLeaveAprDelete(String stdid) {
		dao.stuLeaveAprDelete(stdid);
	
	}


///복학
	
// 상태변경_복학승인
	@Override
	public int stuReturnUpdate(Map<String, String> paraMap) {
		int n = dao.stuReturnUpdate(paraMap);
		return n;
	}
		
// 상태변경_복학승인_Apr
	@Override
	public void stuReturnAprUpdate(String stdid) {
		dao.stuReturnAprUpdate(stdid);
		
	}

			
// 상태변경_복학거절
	@Override
	public int stuReturnDelete(Map<String, String> paraMap) {
		int n = dao.stuReturnDelete(paraMap);
		return n;
	}
		
// 상태변경_복학거절_Apr
	@Override
	public void stuReturnAprDelete(String stdid) {
		dao.stuReturnAprDelete(stdid);
	
	}

	
}
