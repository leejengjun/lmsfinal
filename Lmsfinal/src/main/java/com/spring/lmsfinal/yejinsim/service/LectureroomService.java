package com.spring.lmsfinal.yejinsim.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.lmsfinal.yejinsim.model.InterLectureroomDAO;
import com.spring.lmsfinal.yejinsim.model.LectureroomDAO;
import com.spring.lmsfinal.yejinsim.model.LectureroomVO;

@Service
public class LectureroomService implements InterLectureroomService {
	
	@Autowired
	private InterLectureroomDAO dao;

	// 강의코드에 따라 강의실 배정 정보 보여주기 (ajax)
	@Override
	public List<LectureroomVO> timetableListSearch(String subjectid) {
		List<LectureroomVO> timetableList = dao.timetableListSearch(subjectid);
		
		return timetableList;
	}

	
	// == 건물 목록 보여주기 == //
	@Override
	public List<LectureroomVO> buildingListSearch(Map<String, String> paraMap) {
		List<LectureroomVO> buildingList = dao.buildingListSearch(paraMap);
		return buildingList;
	}

	// == 건물번호에 따라 강의실 목록 보여주기 == //
	@Override
	public List<LectureroomVO> lectureroomSearch(String buildno) {
		List<LectureroomVO> lectureroomList = dao.lectureroomSearch(buildno);
		return lectureroomList;
	}
	
	

	// == 건물과 강의실과 정원에 따른 시간표 배열 가져오기(Ajax) ==
	@Override
	public List<LectureroomVO> lctrroomtimetableSearch(String seq_lctrid) {
		List<LectureroomVO> lctrroomtimetable = dao.lctrroomtimetableSearch(seq_lctrid);
		return lctrroomtimetable;
	}

	// == 강의실 배정하기 
	@Override
	public int assignlectureroom(Map<String, Object> paraMap) {
		int n = dao.assignlectureroom(paraMap);
	//	System.out.println("n service 단 :" + n);
		return n;
	}


	// == 강의 정원 정하기 
	@Override
	public int assignlectureperson(Map<String, Object> paraMap) {
		int m  = dao.assignlectureperson(paraMap);
		return m;
	}

	
	
}
