package com.spring.lmsfinal.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.lmsfinal.choibyoungjin.model.StudentVO;
import com.spring.lmsfinal.jeongKyeongEun.model.NoticeVO;
import com.spring.lmsfinal.model.InterLmsfinalDAO;
import com.spring.lmsfinal.wonhyejin.model.AdminVO;
import com.spring.lmsfinal.yejinsim.model.GyowonVO;

@Service
public class LmsfinalService implements InterLmsfinalService {

	@Autowired
	private InterLmsfinalDAO dao;
	
	@Override
	public int test_insert() {
		int n = dao.test_insert();	// DAO 단으로 넘어감. 
		return n;
	}

	// 시작페이지에서 메인 이미지를 보여주는 것(캐러셀)
	@Override
	public List<String> getImgfilenameList() {
		List<String> imgfilenameList = dao.getImgfilenameList();   // 의존 객체인 dao, 빨간줄 뜨면 create. InterBoardDAO 로 간다.
		return imgfilenameList;
	}

	// 학생 로그인 처리하기
	@Override
	public StudentVO getLoginStudent(Map<String, String> paraMap) {
		StudentVO loginuser_student = dao.getLoginStudent(paraMap);
		return loginuser_student;
	}

	// 교수 로그인 처리하기
	@Override
	public GyowonVO getLoginGyowon(Map<String, String> paraMap) {
		GyowonVO loginuser_gyowon = dao.getLoginGyowon(paraMap);
		return loginuser_gyowon;
	}

	// 관리자 로그인 처리하기
	@Override
	public AdminVO getLoginAdmin(Map<String, String> paraMap) {
		AdminVO loginuser_admin = dao.getLoginAdmin(paraMap);
		return loginuser_admin;
	}

	// 아이디 찾기
	@Override
	public String getFindUserid(Map<String, String> paraMap) {
		String findUserid = dao.getFindUserid(paraMap);
		return findUserid;
	}


	// 비밀번호 찾기
	@Override
	public String getFindPwd(Map<String, String> paraMap) {
		String findPwd = dao.getFindPwd(paraMap);
		return findPwd;
	}

	// 비밀번호 업데이트
	@Override
	public int getPwdUpdate(Map<String, String> paraMap) {
		int n = dao.getPwdUpdate(paraMap);
		return n;
	}

	@Override
	public List<NoticeVO> getBoardList(Map<String, String> paraMap) {
		// TODO Auto-generated method stub
		return null;
	}





	

	
	
}
