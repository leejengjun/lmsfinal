package com.spring.lmsfinal.yejinsim.model;

import java.util.List;
import java.util.Map;

public interface InterLectureroomDAO {

	// 강의코드에 따라 강의실 배정 정보 보여주기 (ajax)
    List<LectureroomVO> timetableListSearch(String subjectid);

	
	// == 건물 목록 보여주기 == //
	List<LectureroomVO> buildingListSearch(Map<String, String> paraMap);

	// == 건물번호에 따라 강의실 목록 보여주기 == //
	List<LectureroomVO> lectureroomSearch(String buildno);

	// == 건물과 강의실과 정원에 따른 시간표 배열 가져오기(Ajax) ==
	List<LectureroomVO> lctrroomtimetableSearch(String seq_lctrid);

	// == 강의실 배정하기 
	int assignlectureroom(Map<String, Object> paraMap);

	// == 강의 정원 정하기 
	int assignlectureperson(Map<String, Object> paraMap);
	
	
}
