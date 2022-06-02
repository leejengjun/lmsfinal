package com.spring.lmsfinal.duHyeon.service;

import java.util.List;
import java.util.Map;

import com.spring.lmsfinal.duHyeon.model.StudentExamVO;
import com.spring.lmsfinal.duHyeon.model.TestAnswersVO;
import com.spring.lmsfinal.duHyeon.model.TestRoundVO;
import com.spring.lmsfinal.yejinsim.model.MylectureVO;

public interface InterTestService {
	
	// 교원 아이디와 과목코드를 가져와 과목의 이름을 받아오기위한 메소드
	MylectureVO getSubjectOne(Map<String, String> paraMap);

	// 폼에서 넘어온 정보로 TestRound 테이블에 인서트 해줄 메소드
	int addTestRound(Map<String, String> paraMap);

	// 교원번호와 과목코드가 담긴 파라맵을 이용하여 testRound가 들어있는 List를 받아오기 위한 메소드
	List<Map<String, String>> getTestRoundList(Map<String, String> paraMap);

	// 교원번호와 테스트 라운드 코드가 담긴 파라맵을 이용하여 testRound하나를 받아오기 위한 메소드
	Map<String, String> getTestRoundOne(Map<String, String> paraMap);

	// 테스트라운드를 수정하기위한
	int modifyTestRound(Map<String, String> paraMap);

	// 특정 시험에대한 문제들을 가져올 메소드
	List<Map<String, String>> getQuestionList(Map<String, String> paraMap);

	Map<String, String> getSMG(Map<String, String> paraMap);

	
	// 이것은 문제를 인서트 해주는 것이다.
	int addQuestion(Map<String, String> paraMap);

	
	int addAnswer(Map<String, String> paraMap);

	// 현재 추가하는 문제의 seq를 받아올 메소드
	String getCurrentSeq(Map<String, String> paraMap);

	// 맵으로 해서 받아오ㅁ
	Map<String, String> getQuestionOne(Map<String, String> paraMap);

	// 문제의 보기를 리스트로 받아올것
	List<Map<String, String>> getAnswerList(Map<String, String> paraMap);

	// 문제 번호 수정하기
	int modifyQuestion(Map<String, String> paraMap);

	// 문제 보기 수정하
	int modifyAnswer(Map<String, String> paraMap);

	// 현재 학생이 수강하는 괌고인지 아닌지 확인하기 위한 메소드 
	int isCourse(Map<String, String> smgMap);

	// 저장해주기
	int insertStudentExam(StudentExamVO studentexamvo);

	// 시험을 봤는지 안봤느지 확인하기
	int isTakeTheExam(Map<String, String> smgMap);

	

	
	

}
