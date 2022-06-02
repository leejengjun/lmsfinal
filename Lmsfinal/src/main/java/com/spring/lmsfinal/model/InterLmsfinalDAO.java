package com.spring.lmsfinal.model;

import java.util.List;
import java.util.Map;

import com.spring.lmsfinal.choibyoungjin.model.StudentVO;
import com.spring.lmsfinal.wonhyejin.model.AdminVO;
import com.spring.lmsfinal.yejinsim.model.GyowonVO;

public interface InterLmsfinalDAO {

	int test_insert();

	// 메인페이지에서 메인 이미지를 보여주는 것(캐러셀)
	List<String> getImgfilenameList();

	// 학생 로그인 처리하기
	StudentVO getLoginStudent(Map<String, String> paraMap);

	// 교수 로그인 처리하기
	GyowonVO getLoginGyowon(Map<String, String> paraMap);

	// 관리자 로그인 처리하기
	AdminVO getLoginAdmin(Map<String, String> paraMap);

	// 아이디찾기
	String getFindUserid(Map<String, String> paraMap);
	
	// 비밀번호 찾기
	String getFindPwd(Map<String, String> paraMap);

	// 비밀번호 업데이트
	int getPwdUpdate(Map<String, String> paraMap);

}
