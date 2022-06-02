package com.spring.lmsfinal.duHyeon.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.lmsfinal.duHyeon.model.InterTestDAO;
import com.spring.lmsfinal.duHyeon.model.StudentExamVO;
import com.spring.lmsfinal.duHyeon.model.TestAnswersVO;
import com.spring.lmsfinal.duHyeon.model.TestRoundVO;
import com.spring.lmsfinal.yejinsim.model.MylectureVO;

@Service
public class TestService implements InterTestService {

	
	@Autowired
	private InterTestDAO dao;
	
	
	
	@Override
	public MylectureVO getSubjectOne(Map<String, String> paraMap) {
		
		MylectureVO mylecture = dao.getSubjectOne(paraMap);
		
		return mylecture;
	}


	// 폼에서 넘어온 정보로 TestRound 테이블에 인서트 해줄 메소드
	@Override
	public int addTestRound(Map<String, String> paraMap) {
		
		int n =dao.addTestRound(paraMap);
		
		return n;
	}

	// 교원번호와 과목코드가 담긴 파라맵을 이용하여 testRound가 들어있는 List를 받아오기 위한 메소드
	@Override
	public List<Map<String, String>> getTestRoundList(Map<String, String> paraMap) {
		
		List<Map<String, String>> testRoundList = dao.getTestRoundList(paraMap);
		
		return testRoundList;
	}

	// 교원번호와 테스트 라운드 코드가 담긴 파라맵을 이용하여 testRound하나를 받아오기 위한 메소드
	@Override
	public Map<String, String> getTestRoundOne(Map<String, String> paraMap) {

		Map<String, String> testRoundOne = dao.getTestRoundOne(paraMap);
		return testRoundOne;
	}

	// 테스트라운드를 수정하기위한
	@Override
	public int modifyTestRound(Map<String, String> paraMap) {
		int n =dao.modifyTestRound(paraMap);
		
		return n;
	}


	// 특정 시험에대한 문제들을 가져올 메소드
	@Override
	public List<Map<String, String>> getQuestionList(Map<String, String> paraMap) {
		List<Map<String, String>> questinoList = dao.getQuestionList(paraMap);
		return questinoList;
	}


	@Override
	public Map<String, String> getSMG(Map<String, String> paraMap) {
		Map<String, String> smgMap = dao.getSMG(paraMap);
		return smgMap;
	}

	// 이것은 문제를 인서트 해주는 것이다.
	@Override
	public int addQuestion(Map<String, String> paraMap) {
		
		return dao.addQuestion(paraMap);
	}


	@Override
	public int addAnswer(Map<String, String> paraMap) {
		
		return dao.addAnswer(paraMap);
	}


	// 현재 만들어지는 문제의 seq를 구해오는 메소드 
	
	@Override
	public String getCurrentSeq(Map<String, String> paraMap) {
		String currentSeq = dao.getCurrentSeq(paraMap);
		
		return currentSeq;
	}


	@Override
	public Map<String, String> getQuestionOne(Map<String, String> paraMap) {
		Map<String, String> question = dao.getQuestionOne(paraMap);
		return question;
	}


	// 문제의 보기를 리스트로 받아올것
	@Override
	public List<Map<String, String>> getAnswerList(Map<String, String> paraMap) {
		
		List<Map<String, String>> answer = dao.getAnswerList(paraMap);
		return answer;
	}

	// 문제 번호 수정하기
	@Override
	public int modifyQuestion(Map<String, String> paraMap) {
		
		int n = dao.modifyQuestion(paraMap);
		
		return n;
	}

	// 문제 보기 수정하기
	@Override
	public int modifyAnswer(Map<String, String> paraMap) {
		int n = dao.modifyAnswer(paraMap);
		
		return n;
	}

	// 현재 학생이 수강하는 괌고인지 아닌지 확인하기 위한 메소드 
	@Override
	public int isCourse(Map<String, String> smgMap) {
		
		int n = dao.isCourse(smgMap);
		
		return n;
	}


	// 저장해주기
	@Override
	public int insertStudentExam(StudentExamVO studentexamvo) {
		int n = dao.insertStudentExam(studentexamvo);
		return n;
	}

	// 시험을 봤는지 안봤느지 확인하기
	@Override
	public int isTakeTheExam(Map<String, String> smgMap) {
		int n = dao.isTakeTheExam(smgMap);
		return n;
	}




}
