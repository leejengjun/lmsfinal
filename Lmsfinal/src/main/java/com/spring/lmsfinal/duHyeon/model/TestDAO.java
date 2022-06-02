package com.spring.lmsfinal.duHyeon.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.spring.lmsfinal.yejinsim.model.MylectureVO;

@Repository
public class TestDAO implements InterTestDAO {

	@Resource
	private SqlSessionTemplate sqlsession; // 원격 DB finalorauser3 에 연결

	
	@Override
	public MylectureVO getSubjectOne(Map<String, String> paraMap) {
		
		MylectureVO mylecture = sqlsession.selectOne("duHyeon.getSubjectOne",paraMap);
		
		return mylecture;
	}

	// 폼에서 넘어온 정보로 TestRound 테이블에 인서트 해줄 메소드
	@Override
	public int addTestRound(Map<String, String> paraMap) {
		
		int n = sqlsession.insert("duHyeon.addTestRound", paraMap);
		
		return n;
	}

	// 교원번호와 과목코드가 담긴 파라맵을 이용하여 testRound가 들어있는 List를 받아오기 위한 메소드
	@Override
	public List<Map<String, String>> getTestRoundList(Map<String, String> paraMap) {
		
		
		List<Map<String, String>> testRoundList = sqlsession.selectList("duHyeon.getTestRoundList", paraMap);
		
		return testRoundList;
		
	}
	
	// 교원번호와 테스트 라운드 코드가 담긴 파라맵을 이용하여 testRound하나를 받아오기 위한 메소드
	@Override
	public Map<String, String> getTestRoundOne(Map<String, String> paraMap) {

		Map<String, String> testRoundOne = sqlsession.selectOne("duHyeon.getTestRoundOne", paraMap);
		
		return testRoundOne;
	}

	// 테스트 라운드를 수정하기위한
	@Override
	public int modifyTestRound(Map<String, String> paraMap) {
		int n = sqlsession.update("duHyeon.modifyTestRound", paraMap);
		
		return n;
	}

	
	// 특정 시험에대한 문제들을 가져올 메소드
	@Override
	public List<Map<String, String>> getQuestionList(Map<String, String> paraMap) {
		List<Map<String, String>> questionList = sqlsession.selectList("duHyeon.getQuestionList", paraMap);
		
		return questionList;
	}

	
	
	@Override
	public Map<String, String> getSMG(Map<String, String> paraMap) {
		Map<String, String> smgMap = sqlsession.selectOne("duHyeon.getSMG", paraMap);
		return smgMap;
	}

	@Override
	public int addQuestion(Map<String, String> paraMap) {
		int n = sqlsession.insert("duHyeon.addQuestion",paraMap);
		
		return n;
	}

	@Override
	public int addAnswer(Map<String, String> paraMap) {
		
		
		return sqlsession.insert("duHyeon.addAnswer",paraMap);
		
	}

	// 현재 만들어지는 문제의 시퀀스를 구해오는 메소드
	@Override
	public String getCurrentSeq(Map<String, String> paraMap) {
		String currentseq = sqlsession.selectOne("duHyeon.getQuestCurrentSeq", paraMap);
		
		return currentseq;
	}

	// 맵으로 해서 하나 받아올 것임
	@Override
	public Map<String, String> getQuestionOne(Map<String, String> paraMap) {
		Map<String, String> question = sqlsession.selectOne("duHyeon.getQuestionOne", paraMap);
		
		return question;
		
	}

	
	// 문제의 보기를 리스트로 받아올것
	@Override
	public List<Map<String, String>> getAnswerList(Map<String, String> paraMap) {
		List<Map<String, String>> answer = sqlsession.selectList("duHyeon.getAnswerList", paraMap);
		
		return answer;
	}

	
	// 문제 번호 수정하기
	@Override
	public int modifyQuestion(Map<String, String> paraMap) {
		
		int n = sqlsession.update("duHyeon.modifyQuestion", paraMap);
		
		return n;
	}

	
	// 문제 보기 수정하기 
	@Override
	public int modifyAnswer(Map<String, String> paraMap) {
		int n = sqlsession.update("duHyeon.modifyAnswer", paraMap);
		
		return n;
	}

	
	// 현재 학생이 수강하는 괌고인지 아닌지 확인하기 위한 메소드
	@Override
	public int isCourse(Map<String, String> smgMap) {
		int n = sqlsession.selectOne("duHyeon.isCourse", smgMap);
		return n;
	}

	// 저장해주기
	@Override
	public int insertStudentExam(StudentExamVO studentexamvo) {
		int n = sqlsession.update("duHyeon.insertStudentExam", studentexamvo);
		return n;
	}

	// 시험을 봤는지 안봤느지 확인하기
	@Override
	public int isTakeTheExam(Map<String, String> smgMap) {
		int n = sqlsession.selectOne("duHyeon.isTakeTheExam", smgMap);
		return n;
	}



}
