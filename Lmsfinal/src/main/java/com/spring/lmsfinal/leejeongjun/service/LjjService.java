package com.spring.lmsfinal.leejeongjun.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.lmsfinal.choibyoungjin.model.StudentVO;
import com.spring.lmsfinal.common.FileManager;
import com.spring.lmsfinal.leejeongjun.model.InterLjjDAO;
import com.spring.lmsfinal.leejeongjun.model.Leave_armyVO;
import com.spring.lmsfinal.leejeongjun.model.Leave_schoolVO;
import com.spring.lmsfinal.leejeongjun.model.Return_schoolVO;
import com.spring.lmsfinal.leejeongjun.model.TestinsertVO;

@Service
public class LjjService implements InterLjjService {

	@Autowired
	private InterLjjDAO dao;
	
	@Autowired	// Type에 따라 알아서 Bean 을 주입해준다.
	private FileManager fileManager;	// null이 아님.

//////////////강의평가 파트 시작 //////////////////////////////////////////////////////	
	// 해당 학기에 수강한 과목들 조회하기
	@Override
	public List<Map<String, String>> inputSemesterList(Map<String, String> paraMap) {
		List<Map<String, String>> inputSemesterList = dao.inputSemesterList(paraMap);
		return inputSemesterList;
	}

	// 선택한 과목의 수강코드로 해당 강의평가 문항 가져오기
	@Override
	public List<Map<String, String>> choice_LectureEvaluationQuestions(String choice_courseno) {
		List<Map<String, String>> lectureEvaluationQuestions = dao.choice_LectureEvaluationQuestions(choice_courseno);
		return lectureEvaluationQuestions;
	}

	// 강의평가 체크한 값들을 강의평가 완료 테이블에 update 하기 //
	@Override
	public int addlectureEvaluation(Map<String, String> paraMap) {
		int n = dao.addlectureEvaluation(paraMap);
		return n;
	}

	// 강의평가유무 업데이트하기
	@Override
	public int updateLectureEvaluation(Map<String, String> paraMap) {
		int m = dao.updateLectureEvaluation(paraMap);
		return m;
	}
//////////////강의평가 파트 끝 //////////////////////////////////////////////////////	

/////////////휴학신청 파트 시작//////////////////////////////////////////////////
	// 로그인한 학생의 정보 가져오기
	@Override
	public Map<String, String> selectOneStudent(String get_stdid) {
		Map<String, String> studentInfo = dao.selectOneStudent(get_stdid);
		return studentInfo;
	}

	// 휴학유무 확인하기
	@Override
	public Map<String, String> countApprove(Map<String, String> paraMap) {
		Map<String, String> countApprove = dao.countApprove(paraMap);
		return countApprove;
	}
	
	// 일반휴학 신청하기(트랜잭션처리)
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class}) // 롤백 시킨 다음에 컨트롤러에게 던져준다!
	public int leaveAdd(Leave_schoolVO leaveschoolvo, String stdstateid) throws Throwable {
		int n = 0, m=0; 
		
		n = dao.leaveAdd(leaveschoolvo);	// 일반휴학신청(휴학테이블에 insert)
		
		if(n==1) {
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("stdid", Integer.toString(leaveschoolvo.getStdid()));
			paraMap.put("stdstateid", stdstateid);
			m = dao.updateStdStateLeave(paraMap);
		}
		return m;
	}

	// 파일첨부 있는 군휴학 신청하기
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class}) // 롤백 시킨 다음에 컨트롤러에게 던져준다!
	public int leaveArmyAdd(Leave_armyVO leavearmyvo, String stdstateid) throws Throwable {
		int n = 0, m=0;  
		
		n = dao.leaveArmyAdd(leavearmyvo);
		
		if(n==1) {
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("stdid", Integer.toString(leavearmyvo.getStdid()));
			paraMap.put("stdstateid", stdstateid);
			m = dao.updateStdStateLeave(paraMap);
		}
		return m;
	}

	// 로그인한 학생의 모든 휴학내역 조회
	@Override
	public List<Map<String, String>> leave_List(String get_stdid) {
		List<Map<String, String>> leave_list = dao.leave_List(get_stdid);
		return leave_list;
	}

	// 파일첨부가 있는 휴학내역 조회
	@Override
	public Leave_armyVO getViewleave(Map<String, String> paraMap) {
		Leave_armyVO leavearmyvo = dao.getViewleave(paraMap);	// 휴학내역 1개 조회하기
		return leavearmyvo;
	}

	// 휴학신청 취소하기
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class}) // 롤백 시킨 다음에 컨트롤러에게 던져준다!
	public int delLeave(Map<String, String> paraMap) throws Throwable {
		int n = 0, m=0;   
		
		n = dao.delLeave(paraMap);
		
		// 파일첨부가 있는 글이라면 휴학신청 취소전에 첨부파일도 삭제해주기
		if(n==1) {
			String path = paraMap.get("path");
			String filename = paraMap.get("filename");
			
			if( filename != null && !"".equals(filename) ) {
				try {
					fileManager.doFileDelete(filename, path);
				} catch (Exception e) {
					e.printStackTrace();
				}
				
			}
			m = dao.updateStdStateLeave(paraMap);
		}
		
		return m;
	}

	// 일반휴학 신청 수정하기
	@Override
	public int edit_leave(Leave_schoolVO leaveschoolvo) {
		int n = dao.edit_leave(leaveschoolvo);
		return n;
	}

	// 군휴학 신청 수정하기
	@Override
	public int edit_leaveArmy(Leave_armyVO leavearmyvo) {
		int n = dao.edit_leaveArmy(leavearmyvo);
		return n;
	}

	// 복학예정인 휴학내역 가져오기
	@Override
	public Map<String, String> getleaveReturn(Map<String, String> paraMap) {
		Map<String, String> choice_std_leave_return = dao.getleaveReturn(paraMap);
		return choice_std_leave_return;
	}

	// 복학신청하기(파일첨부x 트랜잭션처리)
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class}) // 롤백 시킨 다음에 컨트롤러에게 던져준다!
	public int addReturnSchool(Map<String, String> paraMap) throws Throwable {
		int n = 0, m=0;  
		
		n = dao.addReturnSchool(paraMap);
		
		if(n==1) {
			m = dao.updateStdStateLeave(paraMap);
		}
		return m;
	}

	// 복학내역조회(파일첨부x)
	@Override
	public List<Map<String, String>> returnList(Map<String, String> paraMap) {
		List<Map<String, String>> return_list = dao.returnList(paraMap);
		return return_list;
	}

	// 복학신청유무확인(파일첨부x)
	@Override
	public int checkReturn(String get_stdid) {
		int check_return = dao.checkReturn(get_stdid);
		return check_return;
	}

	// 복학신청 취소하기(트랜잭션처리)
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class}) // 롤백 시킨 다음에 컨트롤러에게 던져준다!
	public int delreturn(Map<String, String> paraMap) {
		int n = 0, m=0;  
		
		n = dao.delreturn(paraMap);
		
		// 파일첨부가 있는 글이라면 복학신청 취소전에 첨부파일도 삭제해주기
		if(n==1) {
			String path = paraMap.get("path");
			String filename = paraMap.get("filename");
			
			if( filename != null && !"".equals(filename) ) {
				try {
					fileManager.doFileDelete(filename, path);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			m = dao.updateStdStateLeave(paraMap);
		}
		
		return m;
	}

	// 복학신청하기(파일첨부O 트랜잭션처리)
	@Override
	public int add_returnAttach(Return_schoolVO returnschoolvo, String stdstateid) {
		
		int n = 0, m=0;  
		
		n = dao.add_returnAttach(returnschoolvo);
		
		if(n==1) {
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("stdid", Integer.toString(returnschoolvo.getStdid()));
			paraMap.put("stdstateid", stdstateid);
			m = dao.updateStdStateLeave(paraMap);
		}
		
		return m;
	}

	// 복학내역조회(파일첨부O)
	@Override
	public List<Map<String, String>> returnListAttach(Map<String, String> paraMap) {
		List<Map<String, String>> return_listAttach = dao.returnListAttach(paraMap);
		return return_listAttach;
	}

	// 파일첨부가 있는 복학내역 조회
	@Override
	public Return_schoolVO getViewreturn(Map<String, String> paraMap) {
		Return_schoolVO returnschoolvo = dao.getViewreturn(paraMap);
		return returnschoolvo;
	}

	// 로그인한 학생의 학번을 이용하여 장학내역 조회하기
	@Override
	public List<Map<String, String>> stdscholarship_List(String get_stdid) {
		List<Map<String, String>> stdscholarshipList = dao.stdscholarship_List(get_stdid);
		return stdscholarshipList;
	}

	@Override
	public int testinsert(TestinsertVO testinsertvo) {
		int n = dao.testinsert(testinsertvo);
		return n;
	}

	@Override
	public int testinsert2(Map<String, String> paraMap) {
		int n = dao.testinsert2(paraMap);
		return n;
	}

	// 학생의 학번을 이용하여 수강테이블에서 해당학생이 이수한 학기 리스트 가져오기
	@Override
	public List<Map<String, String>> appsemesterList(String get_stdid) {
		List<Map<String, String>> appsemesterList = dao.appsemesterList(get_stdid);
		return appsemesterList;
	}

	// 학번과 선택학기에 해당하는 성적리스트 가져오기
	@Override
	public List<Map<String, String>> getGradeList(Map<String, String> paraMap) {
		List<Map<String, String>> getGradeList = dao.getGradeList(paraMap);
		return getGradeList;
	}

	
	

}
