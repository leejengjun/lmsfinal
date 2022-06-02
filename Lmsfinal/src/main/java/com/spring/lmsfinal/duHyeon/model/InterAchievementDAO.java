package com.spring.lmsfinal.duHyeon.model;

import java.util.List;
import java.util.Map;

public interface InterAchievementDAO {

	// tbl_course 에서 smgMap을 가지고 강의 코드들을 받아 올 것임!
	List<Map<String, String>> getattList(Map<String, String> smgMap);

	// 수강중인 학생의 수 가져오기
	int getTotalStCount(Map<String, String> paraMap);

	//하나씩 넣어 줌
	int checkattend(Map<String, String> paraMap);
	
	// 현 주차시에 없을 때 학생만 뽑아오려 하는 것
	List<Map<String, String>> getstudentList(Map<String, String> smgMap);

	// 출석체클를 업데이트 해준다.
	int updateAtt(Map<String, String> paraMap);
	
	// full join해서 어떤 강의를 듣고있는 모든 학생에 대한 테이블을 받아온다.
	List<Map<String, String>> getGradeResultList(Map<String, String> smgMap);

	// 수강코드를 이용해서 smg받아올거
	Map<String, String> getSMG(Map<String, String> paraMap);

	// full join해서 어떤 강의를 듣고있는 한 학생에 대해서 가져온다.
	Map<String, String> getGradeResult(Map<String, String> smgMap);

	// 일단 업데이트해보기
	int updatecredit(Map<String, String> paraMap);

	// 없으면 인서트로 하기
	int insertcredit(Map<String, String> paraMap);

	// 출결 상태 가져오기
	List<Map<String, String>> getAttendCnt(Map<String, String> paraMap);

	// 테스트 라운드 리스트의 시험이름과 testclfc로 학생시험점수 테이블과 조인한뒤 점수를 input 태그에 넣어 줄 것임
	List<Map<String, String>> getTestclfcAndScore(Map<String, String> paraMap);

	// 정적 비율을 받아오기 위한 메소드
	Map<String, String> getCompute(Map<String, String> paraMap);

	Map<String, String> getTestScore(Map<String, String> paraMap);

}
