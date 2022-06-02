package com.spring.lmsfinal.service;

import java.util.List;
import java.util.Map;

import com.spring.lmsfinal.choibyoungjin.model.StudentVO;
import com.spring.lmsfinal.jeongKyeongEun.model.NoticeVO;
import com.spring.lmsfinal.wonhyejin.model.AdminVO;
import com.spring.lmsfinal.yejinsim.model.GyowonVO;

public interface InterLmsfinalService {

	int test_insert();

	// 시작페이지에서 메인 이미지를 보여주는 것(캐러셀)
	List<String> getImgfilenameList();
	
	// 학생 로그인 처리하기
	StudentVO getLoginStudent(Map<String, String> paraMap);

	// 교수 로그인 처리하기
	GyowonVO getLoginGyowon(Map<String, String> paraMap);

	// 관리자 로그인 처리하기
	AdminVO getLoginAdmin(Map<String, String> paraMap);

	// 아이디 찾기
	String getFindUserid(Map<String, String> paraMap);
	
	// 비밀번호찾기
	String getFindPwd(Map<String, String> paraMap);

	// 비밀번호 업데이트
	int getPwdUpdate(Map<String, String> paraMap);

	// 홈페이지에 글목록 가져오기
	List<NoticeVO> getBoardList(Map<String, String> paraMap);


}
