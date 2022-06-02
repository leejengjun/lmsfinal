package com.spring.lmsfinal.wonhyejin.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;



@Repository
public class StudentDAO implements InterStudentDAO {
	@Resource
	private SqlSessionTemplate sqlsession;

//학생회원등록
	@Override
	public int stdRegisterEnd(Map<String, String> paraMap) {
		int n = sqlsession.insert("wonhyejin.stdRegisterEnd",paraMap);
		return n;
	}

// 학번중복 검사 
	@Override
	public int stdidDuplicateCheck(String stdid) {
		
		int result = sqlsession.selectOne("wonhyejin.stdidDuplicateCheck", stdid);
		return result;
	}

//이메일 중복확인
	@Override
	public int stdemailDuplicateCheck(String stdemail) {
		int result = sqlsession.selectOne("wonhyejin.stdemailDuplicateCheck", stdemail);
		return result;
	}

// 학생 회원 전체 조회 
	@Override
	public int getTotalPage(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("wonhyejin.getTotalPage", paraMap);
		return n;
	}
	
// 학생 회원 전체 조회 
	@Override
	public List<StudentVO> selectPagingStudent(Map<String, String> paraMap) {
		List<StudentVO> studentList = sqlsession.selectList("wonhyejin.selectPagingStudent", paraMap);
		return studentList;
	}
	
	
	
//학생1명조회
	@Override
	public StudentVO studentOneDetail(String stdname) {
		StudentVO studentvo = sqlsession.selectOne("wonhyejin.studentOneDetail",stdname);
		return studentvo;
	}

// 학생 휴학신청 승인
	@Override
	public int stuLeaveUpdate(Map<String, String> paraMap) {
		int n = sqlsession.update("wonhyejin.stuLeaveUpdate",paraMap);
		return n;
	}
	
// 학생 휴학신청 거절
	@Override
	public int stuLeaveDelete(Map<String, String> paraMap) {
		int n = sqlsession.update("wonhyejin.stuLeaveDelete",paraMap);
		return n;
	}

// 학생 휴학신청 승인_apr
	@Override
	public void stuLeaveAprUpdate(String stdid) {
		sqlsession.update("wonhyejin.stuLeaveAprUpdate", stdid);
		
	}
	
// 학생 휴학신청 거절_apr
	@Override
	public void stuLeaveAprDelete(String stdid) {
		sqlsession.update("wonhyejin.stuLeaveAprDelete", stdid);
		
	}

	

///복학
	
// 학생 복학신청 승인
	@Override
	public int stuReturnUpdate(Map<String, String> paraMap) {
		int n = sqlsession.update("wonhyejin.stuReturnUpdate",paraMap);
		return n;
	}
	
// 학생 복학신청 승인_apr
	@Override
	public void stuReturnAprUpdate(String stdid) {
		sqlsession.update("wonhyejin.stuReturnAprUpdate", stdid);
		
	}
	
	
// 학생 복학신청 거절
	@Override
	public int stuReturnDelete(Map<String, String> paraMap) {
		int n = sqlsession.update("wonhyejin.stuReturnDelete",paraMap);
		return n;
	}


	
// 학생 복학신청 거절_apr
	@Override
	public void stuReturnAprDelete(String stdid) {
		sqlsession.update("wonhyejin.stuReturnAprDelete", stdid);
		
	}

	
}
