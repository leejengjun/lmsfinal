package com.spring.lmsfinal.leejeongjun.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.spring.lmsfinal.choibyoungjin.model.StudentVO;

@Repository
public class LjjDAO implements InterLjjDAO {

	@Resource
	private SqlSessionTemplate sqlsession;

////////////// 강의평가 파트 시작 //////////////////////////////////////////////////////
	// 해당 학기에 수강한 과목들 조회하기
	@Override
	public List<Map<String, String>> inputSemesterList(Map<String, String> paraMap) {
		List<Map<String, String>> inputSemesterList = sqlsession.selectList("leejeongjun.inputSemesterList", paraMap);
		return inputSemesterList;
	}

	// 선택한 과목의 수강코드로 해당 강의평가 문항 가져오기
	@Override
	public List<Map<String, String>> choice_LectureEvaluationQuestions(String choice_courseno) {
		List<Map<String, String>> lectureEvaluationQuestions = sqlsession.selectList("leejeongjun.choice_LectureEvaluationQuestions", choice_courseno);
		return lectureEvaluationQuestions;
	}

	// 강의평가 체크한 값들을 강의평가 완료 테이블에 update 하기 //
	@Override
	public int addlectureEvaluation(Map<String, String> paraMap) {
		int n = sqlsession.update("leejeongjun.addlectureEvaluation", paraMap);
		return n;
	}

	// 강의평가유무 업데이트하기
	@Override
	public int updateLectureEvaluation(Map<String, String> paraMap) {
		int m = sqlsession.update("leejeongjun.updateLectureEvaluation", paraMap);
		return m;
	}
//////////////강의평가 파트 끝 //////////////////////////////////////////////////////

/////////////휴학신청 파트 시작//////////////////////////////////////////////////
	// 로그인한 학생의 정보 가져오기
	@Override
	public Map<String, String> selectOneStudent(String get_stdid) {
		Map<String, String> studentInfo = sqlsession.selectOne("leejeongjun.selectOneStudent", get_stdid);
		return studentInfo;
	}

	// 휴학유무 확인하기
	@Override
	public Map<String, String> countApprove(Map<String, String> paraMap) {
		Map<String, String> countApprove = sqlsession.selectOne("leejeongjun.countApprove", paraMap); 
		return countApprove;
	}
	
	// 일반휴학신청하기
	@Override
	public int leaveAdd(Leave_schoolVO leaveschoolvo) {
		int n = sqlsession.insert("leejeongjun.leaveAdd", leaveschoolvo);
		return n;
	}

	// 파일첨부 있는 군휴학 신청하기
	@Override
	public int leaveArmyAdd(Leave_armyVO leavearmyvo) {
		int n = sqlsession.insert("leejeongjun.leaveArmyAdd", leavearmyvo);
		return n;
	}

	// 로그인한 학생의 모든 휴학내역 조회
	@Override
	public List<Map<String, String>> leave_List(String get_stdid) {
		List<Map<String, String>> leave_list = sqlsession.selectList("leejeongjun.leave_list", get_stdid);
		return leave_list;
	}

	// 파일첨부가 있는 휴학내역 1개 조회
	@Override
	public Leave_armyVO getViewleave(Map<String, String> paraMap) {
		Leave_armyVO leavearmyvo = sqlsession.selectOne("leejeongjun.getViewleave", paraMap);
		return leavearmyvo;
	}

	// 휴학신청 취소하기
	@Override
	public int delLeave(Map<String, String> paraMap) {
		int n = sqlsession.delete("leejeongjun.delLeave", paraMap);
		return n;
	}

	// 일반휴학신청 수정하기
	@Override
	public int edit_leave(Leave_schoolVO leaveschoolvo) {
		int n = sqlsession.update("leejeongjun.edit_leave", leaveschoolvo);
		return n;
	}

	// 군휴학신청 수정하기
	@Override
	public int edit_leaveArmy(Leave_armyVO leavearmyvo) {
		int n = sqlsession.update("leejeongjun.edit_leaveArmy", leavearmyvo);
		return n;
	}

	// 복학예정인 휴학내역 가져오기
	@Override
	public Map<String, String> getleaveReturn(Map<String, String> paraMap) {
		Map<String, String> choice_std_leave_return = sqlsession.selectOne("leejeongjun.getleaveReturn", paraMap);
		return choice_std_leave_return;
	}

	// 복학신청하기(첨부파일x)
	@Override
	public int addReturnSchool(Map<String, String> paraMap) {
		int n = sqlsession.insert("leejeongjun.addReturnSchool", paraMap);
		return n;
	}

	// 복학내역조회(파일첨부x)
	@Override
	public List<Map<String, String>> returnList(Map<String, String> paraMap) {
		List<Map<String, String>> return_list = sqlsession.selectList("leejeongjun.returnList", paraMap);
		return return_list;
	}

	// 복학신청유무확인(파일첨부x)
	@Override
	public int checkReturn(String get_stdid) {
		int check_return = sqlsession.selectOne("leejeongjun.checkReturn", get_stdid);
		return check_return;
	}

	// 복학신청취소하기
	@Override
	public int delreturn(Map<String, String> paraMap) {
		int n = sqlsession.delete("leejeongjun.delreturn", paraMap);
		return n;
	}

	// 복학신청하기(파일첨부O)
	@Override
	public int add_returnAttach(Return_schoolVO returnschoolvo) {
		int n = sqlsession.insert("leejeongjun.add_returnAttach", returnschoolvo);
		return n;
	}

	// 복학내역조회(파일첨부O)
	@Override
	public List<Map<String, String>> returnListAttach(Map<String, String> paraMap) {
		List<Map<String, String>> return_listAttach = sqlsession.selectList("leejeongjun.returnListAttach", paraMap);
		return return_listAttach;
	}

	// 파일첨부가 있는 복학내역 조회
	@Override
	public Return_schoolVO getViewreturn(Map<String, String> paraMap) {
		Return_schoolVO returnschoolvo = sqlsession.selectOne("leejeongjun.getViewreturn", paraMap);
		return returnschoolvo;
	}

	// 학생테이블에서 학생상태를 휴학신청으로 변경하기
	@Override
	public int updateStdStateLeave(Map<String, String> paraMap) {
		int n = sqlsession.update("leejeongjun.updateStdStateLeave", paraMap );
		return n;
	}

	// 로그인한 학생의 학번을 이용하여 장학내역 조회하기
	@Override
	public List<Map<String, String>> stdscholarship_List(String get_stdid) {
		List<Map<String, String>> stdscholarshipList = sqlsession.selectList("leejeongjun.stdscholarship_List", get_stdid);
		return stdscholarshipList;
	}

	@Override
	public int testinsert(TestinsertVO testinsertvo) {
		int n = sqlsession.insert("leejeongjun.testinsert", testinsertvo);
		return n;
	}

	@Override
	public int testinsert2(Map<String, String> paraMap) {
		int n = sqlsession.insert("leejeongjun.testinsert2", paraMap);
		return n;
	}

	// 학생의 학번을 이용하여 수강테이블에서 해당학생이 이수한 학기 리스트 가져오기
	@Override
	public List<Map<String, String>> appsemesterList(String get_stdid) {
		List<Map<String, String>> appsemesterList = sqlsession.selectList("leejeongjun.appsemesterList", get_stdid);
		return appsemesterList;
	}

	// 학번과 선택학기에 해당하는 성적리스트 가져오기
	@Override
	public List<Map<String, String>> getGradeList(Map<String, String> paraMap) {
		List<Map<String, String>> getGradeList = sqlsession.selectList("leejeongjun.getGradeList", paraMap);
		return getGradeList;
	}

	

}
