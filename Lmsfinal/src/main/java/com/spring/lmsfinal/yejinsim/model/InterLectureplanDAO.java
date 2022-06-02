package com.spring.lmsfinal.yejinsim.model;

import java.util.List;
import java.util.Map;

public interface InterLectureplanDAO {

	// 강의계획서 작성에 필요한 정보 받아오기
	List<MylectureVO> lctrListSearch(Map<String, String> paraMap);

	// 강의계획서 작성하기 
	int addlectureplan(LectureplanVO lctrplanrvo);

	// 강의계획서 보기
	LectureplanVO lctrplanSearch(Map<String, String> paraMap);

	//강의계획서 수정하기 
	int editlctrplan(LectureplanVO lctrplanvo);

	// 학과코드 가져오기 (이따 대체할 것)
	String getmajorid(String subjectid);

	// 주차별 강의계획서 정보 입력하기
	int addlctrplandetail(Map<String, Object> paraMap);

	// 강의계획서 코드 가져오기 (이따 대체할 것)
	String getSeq_lectureplan(String subjectid);

	// 주차별 강의계획서 정보 가져오기(ajax)
	List<LectureplanVO> lctrplandetailSearch(String subjectid);

	// 강의 신청상태변경하기
	int changeapplystate(String subjectid);

	// 주차별 강의계획서 수정하기
	int editlctrplandetail(Map<String, Object> paraMap);

}
