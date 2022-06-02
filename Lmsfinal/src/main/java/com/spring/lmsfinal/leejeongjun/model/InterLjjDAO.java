package com.spring.lmsfinal.leejeongjun.model;

import java.util.List;
import java.util.Map;

import com.spring.lmsfinal.choibyoungjin.model.StudentVO;

public interface InterLjjDAO {

//////////////강의평가 파트 시작 //////////////////////////////////////////////////////	
	// 해당 학기에 수강한 과목들 조회하기
	List<Map<String, String>> inputSemesterList(Map<String, String> paraMap);

	// 선택한 과목의 수강코드로 해당 강의평가 문항 가져오기
	List<Map<String, String>> choice_LectureEvaluationQuestions(String choice_courseno);

	// 강의평가 체크한 값들을 강의평가 완료 테이블에 update 하기 //
	int addlectureEvaluation(Map<String, String> paraMap);

	// 강의평가유무 업데이트하기
	int updateLectureEvaluation(Map<String, String> paraMap);
//////////////강의평가 파트 끝 //////////////////////////////////////////////////////

/////////////휴학신청 파트 시작//////////////////////////////////////////////////
	// 로그인한 학생의 정보 가져오기
	Map<String, String> selectOneStudent(String get_stdid);

	// 휴학유무 확인하기
	Map<String, String> countApprove(Map<String, String> paraMap);
	
	// 일반휴학신청하기
	int leaveAdd(Leave_schoolVO leaveschoolvo);

	// 파일첨부있는 군휴학신청하기
	int leaveArmyAdd(Leave_armyVO leavearmyvo);

	// 로그인한 학생의 모든 휴학내역 조회
	List<Map<String, String>> leave_List(String get_stdid);

	// 파일첨부가 있는 휴학내역 조회
	Leave_armyVO getViewleave(Map<String, String> paraMap);

	// 휴학신청 취소하기
	int delLeave(Map<String, String> paraMap);

	// 일반휴학 신청 수정하기
	int edit_leave(Leave_schoolVO leaveschoolvo);

	// 군휴학 신청 수정하기
	int edit_leaveArmy(Leave_armyVO leavearmyvo);

	// 복학예정인 휴학내역 가져오기
	Map<String, String> getleaveReturn(Map<String, String> paraMap);

	// 복학신청하기(첨부파일x)
	int addReturnSchool(Map<String, String> paraMap);

	// 복학내역조회(파일첨부x)
	List<Map<String, String>> returnList(Map<String, String> paraMap);

	// 복학신청유무확인(파일첨부x)
	int checkReturn(String get_stdid);

	// 복학신청 취소하기
	int delreturn(Map<String, String> paraMap);

	// 복학신청하기(파일첨부O)
	int add_returnAttach(Return_schoolVO returnschoolvo);

	// 복학내역조회(파일첨부O)
	List<Map<String, String>> returnListAttach(Map<String, String> paraMap);

	// 파일첨부가 있는 복학내역 조회
	Return_schoolVO getViewreturn(Map<String, String> paraMap);

	// 학생테이블에서 학생상태를 휴학신청으로 변경하기
	int updateStdStateLeave(Map<String, String> paraMap);

	// 로그인한 학생의 학번을 이용하여 장학내역 조회하기
	List<Map<String, String>> stdscholarship_List(String get_stdid);

	int testinsert(TestinsertVO testinsertvo);

	int testinsert2(Map<String, String> paraMap);

	// 학생의 학번을 이용하여 수강테이블에서 해당학생이 이수한 학기 리스트 가져오기
	List<Map<String, String>> appsemesterList(String get_stdid);

	// 학번과 선택학기에 해당하는 성적리스트 가져오기
	List<Map<String, String>> getGradeList(Map<String, String> paraMap);

	

}
