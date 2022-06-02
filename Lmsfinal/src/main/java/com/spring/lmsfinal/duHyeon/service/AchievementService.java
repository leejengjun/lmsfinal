package com.spring.lmsfinal.duHyeon.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.lmsfinal.duHyeon.model.InterAchievementDAO;

@Service
public class AchievementService implements InterAchievementService {

	
	@Autowired
	private InterAchievementDAO dao;

	
	// tbl_course 에서 smgMap을 가지고 강의 코드들을 받아 올 것임!
	@Override
	public List<Map<String, String>> getattList(Map<String, String> smgMap) {
		
		List<Map<String, String>> attList = dao.getattList(smgMap);
		
		return attList;
	}

	
	// 수강중인 학생의 수 가져오기
	@Override
	public int getTotalStCount(Map<String, String> paraMap) {
		int n = dao.getTotalStCount(paraMap);
		return n;
	}

	//하나씩 넣어 줌
	@Override
	public int checkattend(Map<String, String> paraMap) {
		
		int n = dao.checkattend(paraMap);
		return n;
	}

	// 현 주차시에 출첵이 없다면 그냥 학생들만 받아옴
	@Override
	public List<Map<String, String>> getstudentList(Map<String, String> smgMap) {
		List<Map<String, String>> attList = dao.getstudentList(smgMap);
		return attList;
	}

	// 출석체클를 업데이트 해준다.
	@Override
	public int updateAtt(Map<String, String> paraMap) {
		int n = dao.updateAtt(paraMap);
		return n;
	}


	// full join해서 어떤 강의를 듣고있는 모든 학생에 대한 테이블을 받아온다.
	@Override
	public List<Map<String, String>> getGradeResultList(Map<String, String> smgMap) {
		
		List<Map<String, String>> graderesultList = dao.getGradeResultList(smgMap);
		return graderesultList;
	}

	// 수강코드를 이용해서 smg받아올거
	@Override
	public Map<String, String> getSMG(Map<String, String> paraMap) {
		Map<String, String> smgMap = dao.getSMG(paraMap);
		return smgMap;
	}

	
	
	// full join해서 어떤 강의를 듣고있는 한 학생에 대해서 가져온다.
	@Override
	public Map<String, String> getGradeResult(Map<String, String> smgMap) {
		Map<String, String> gradeResultOne = dao.getGradeResult(smgMap);
		return gradeResultOne;
	}


	// 업뎃 해보기
	@Override
	public int updatecredit(Map<String, String> paraMap) {
		int n = dao.updatecredit(paraMap);
		return n;
	}

	// 없으니께 인서트로 들어가부러
	@Override
	public int insertcredit(Map<String, String> paraMap) {
		int n = dao.insertcredit(paraMap);
		return n;
	}

	// 출결을 알아오는 것
	@Override
	public List<Map<String, String>> getAttendCnt(Map<String, String> paraMap) {
		List<Map<String, String>> attendCnt = dao.getAttendCnt(paraMap);
		return attendCnt;
	}

	// 테스트 라운드 리스트의 시험이름과 testclfc로 학생시험점수 테이블과 조인한뒤 점수를 input 태그에 넣어 줄 것임
	@Override
	public List<Map<String, String>> getTestclfcAndScore(Map<String, String> paraMap) {
		List<Map<String, String>> testList = dao.getTestclfcAndScore(paraMap);
		return testList;
	}

	// 정적 비율을 받아오기 위한 메소드
	@Override
	public Map<String, String> getCompute(Map<String, String> paraMap) {
		Map<String, String> compute = dao.getCompute(paraMap);
		return compute;
	}


	@Override
	public Map<String, String> getTestScore(Map<String, String> paraMap) {
		Map<String, String> testscore = dao.getTestScore(paraMap);
		
		return testscore;
	}
	
	
}
