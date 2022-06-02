package com.spring.lmsfinal.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.spring.lmsfinal.choibyoungjin.model.StudentVO;
import com.spring.lmsfinal.wonhyejin.model.AdminVO;
import com.spring.lmsfinal.yejinsim.model.GyowonVO;

@Repository
public class LmsfinalDAO implements InterLmsfinalDAO {

	@Resource
	private SqlSessionTemplate sqlsession;   // 로컬 DB 에 연결
 
	@Override
	public int test_insert() {
		int n = sqlsession.insert("lmsfinal.test_insert");
		return n;
	}

	// 시작페이지에서 메인 이미지를 보여주는 것(캐러셀)
	@Override
	public List<String> getImgfilenameList() {				
		List<String> imgfilenameList = sqlsession.selectList("lmsfinal.getImgfilenameList");   // 복수개니까 selectList
		return imgfilenameList;
	}

	// 학생 로그인처리하기
	@Override
	public StudentVO getLoginStudent(Map<String, String> paraMap) {
		StudentVO loginuser_student = sqlsession.selectOne("lmsfinal.getLoginStudent", paraMap);  // paraMap 이 속에 userid 와 pwd 가  있다. 리턴타입은 MemberVO
		return loginuser_student;
	}

	// 교수 로그인처리하기
	@Override
	public GyowonVO getLoginGyowon(Map<String, String> paraMap) {
		GyowonVO loginuser_gyowon = sqlsession.selectOne("lmsfinal.getLoginGyowon", paraMap);  // paraMap 이 속에 userid 와 pwd 가  있다. 리턴타입은 MemberVO
		return loginuser_gyowon;
	}

	// 관리자 로그인처리하기
	@Override
	public AdminVO getLoginAdmin(Map<String, String> paraMap) {
		AdminVO loginuser_admin = sqlsession.selectOne("lmsfinal.getLoginAdmin", paraMap);  // paraMap 이 속에 userid 와 pwd 가  있다. 리턴타입은 MemberVO
		return loginuser_admin;
	}

	// 아이디 찾기
	@Override
	public String getFindUserid(Map<String, String> paraMap) {
		String findUserid = sqlsession.selectOne("lmsfinal.getFindUserid", paraMap);
		return findUserid;
	}

	// 비밀번호 찾기
	@Override
	public String getFindPwd(Map<String, String> paraMap) {
		String findPwd = sqlsession.selectOne("lmsfinal.getFindPwd", paraMap);
		return findPwd;
	}

	// 비밀번호 업데이트
	@Override
	public int getPwdUpdate(Map<String, String> paraMap) {
		int n = sqlsession.update("lmsfinal.getPwdUpdate", paraMap);
		return n;
	}



	
}
