package com.spring.lmsfinal.yejinsim.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;


@Repository
public class LectureroomDAO implements InterLectureroomDAO {

	@Resource
	private SqlSessionTemplate sqlsession; // 원격 DB finalorauser3 에 연결

	// 강의코드에 따라 강의실 배정 정보 보여주기 (ajax)
	@Override
	public List<LectureroomVO> timetableListSearch(String subjectid) {
		List<LectureroomVO> timetableList = sqlsession.selectList("yejinsim.timetableListSearch", subjectid);
		return timetableList;
	}
	
	// == 건물 목록 보여주기 == //
	@Override
	public List<LectureroomVO> buildingListSearch(Map<String, String> paraMap) {
		List<LectureroomVO> buildingList = sqlsession.selectList("yejinsim.buildingListSearch", paraMap);
		return buildingList;
	}

	// == 건물번호에 따라 강의실 목록 보여주기 == //
	@Override
	public List<LectureroomVO> lectureroomSearch(String buildno) {
		List<LectureroomVO> lectureroomList = sqlsession.selectList("yejinsim.lectureroomSearch", buildno);
		return lectureroomList;
	}

	
	// == 건물과 강의실과 정원에 따른 시간표 배열 가져오기(Ajax) ==
	@Override
	public List<LectureroomVO> lctrroomtimetableSearch(String seq_lctrid) {
		List<LectureroomVO> lctrroomtimetable = sqlsession.selectList("yejinsim.lctrroomtimetableSearch", seq_lctrid);
		return lctrroomtimetable;
	}

	// == 강의실 배정하기 (Ajax)
	@Override
	public int assignlectureroom(Map<String, Object> paraMap) {
		int n = sqlsession.update("yejinsim.assignlectureroom",paraMap);
	//	System.out.println("n 확인용 dao단 :" + n);
		return n;
	}

	// == 강의 정원 정하기 
	@Override
	public int assignlectureperson(Map<String, Object> paraMap) {
		int m = sqlsession.update("yejinsim.assignlectureperson",paraMap);
		return m;
	}
	

	

}
