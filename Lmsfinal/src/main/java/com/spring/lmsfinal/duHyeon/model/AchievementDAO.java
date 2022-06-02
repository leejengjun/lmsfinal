package com.spring.lmsfinal.duHyeon.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class AchievementDAO implements InterAchievementDAO {
	
	@Resource
	private SqlSessionTemplate sqlsession;

	
	// tbl_course 에서 smgMap을 가지고 강의 코드들을 받아 올 것임!
	@Override
	public List<Map<String, String>> getattList(Map<String, String> smgMap) {
		List<Map<String, String>> attList  = sqlsession.selectList("duHyeon.getattendanceList", smgMap);
		return attList;
	}


	// 수강중인 학생의 수 가져오기
	@Override
	public int getTotalStCount(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("duHyeon.getTotalStCount", paraMap);
		return n;
	}

	//하나씩 넣어 줌
	@Override
	public int checkattend(Map<String, String> paraMap) {
		int n = sqlsession.insert("duHyeon.checkattend", paraMap);
		return n;
	}

	// 현 주차시에 없을 때 학생만 뽑아오려 하는 것
	@Override
	public List<Map<String, String>> getstudentList(Map<String, String> smgMap) {
		List<Map<String, String>> attList = sqlsession.selectList("duHyeon.getstudentList", smgMap);
		return attList;
	}


	// 출석체클를 업데이트 해준다.
	@Override
	public int updateAtt(Map<String, String> paraMap) {
		int n = sqlsession.update("duHyeon.updateAtt", paraMap);
		return n;
	}


	// full join해서 어떤 강의를 듣고있는 모든 학생에 대한 테이블을 받아온다.
	@Override
	public List<Map<String, String>> getGradeResultList(Map<String, String> smgMap) {
		List<Map<String, String>> graderesultList = sqlsession.selectList("duHyeon.getGradeResult", smgMap);
		return graderesultList;
	}


	// 수강코드를 이용해서 smg받아올거
	@Override
	public Map<String, String> getSMG(Map<String, String> paraMap) {
		Map<String, String> smgMap = sqlsession.selectOne("duHyeon.getSMGThroughCourseno", paraMap);
		
		return smgMap;
	}


	// full join해서 어떤 강의를 듣고있는 한 학생에 대해서 가져온다.
	@Override
	public Map<String, String> getGradeResult(Map<String, String> smgMap) {
		Map<String, String> gradeResultOne = sqlsession.selectOne("duHyeon.getGradeResult", smgMap);
		return gradeResultOne;
	}


	@Override
	public int updatecredit(Map<String, String> paraMap) {
		int n = sqlsession.update("duHyeon.updatecredit",paraMap);
		return n;
	}

	// 없기 때문에 인서트 하기
	@Override
	public int insertcredit(Map<String, String> paraMap) {
		int n = sqlsession.insert("duHyeon.insertcredit", paraMap);
		return n;
	}

	// 출결 상태 가져오기
	@Override
	public List<Map<String, String>> getAttendCnt(Map<String, String> paraMap) {
		List<Map<String, String>> attendCnt = sqlsession.selectList("duHyeon.getAttendCnt", paraMap);
		return attendCnt;
	}


	// 테스트 라운드 리스트의 시험이름과 testclfc로 학생시험점수 테이블과 조인한뒤 점수를 input 태그에 넣어 줄 것임
	@Override
	public List<Map<String, String>> getTestclfcAndScore(Map<String, String> paraMap) {
		List<Map<String, String>> testList = sqlsession.selectList("duHyeon.getExamtitleAndScore", paraMap);
 		return testList;
	}

	// 정적 비율을 받아오기 위한 메소드
	@Override
	public Map<String, String> getCompute(Map<String, String> paraMap) {
		Map<String, String> compute = sqlsession.selectOne("duHyeon.getCompute", paraMap);
		return compute;
	}

	
	@Override
	public Map<String, String> getTestScore(Map<String, String> paraMap) {
		Map<String, String> testscore = sqlsession.selectOne("duHyeon.getTestScore", paraMap);
		return testscore;
	}
	
	
	
	

}
