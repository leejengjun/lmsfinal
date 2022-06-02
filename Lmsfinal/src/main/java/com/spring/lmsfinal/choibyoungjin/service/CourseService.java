package com.spring.lmsfinal.choibyoungjin.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.lmsfinal.choibyoungjin.model.InterCourseDAO;
import com.spring.lmsfinal.choibyoungjin.model.InterProfileDAO;
import com.spring.lmsfinal.choibyoungjin.model.StudentVO;
import com.spring.lmsfinal.choibyoungjin.model.TestVO;

@Service
public class CourseService implements InterCourseService {

	@Autowired
	private InterCourseDAO dao;

	// tbl_subject 에서 학과이름 알아오기
	@Override
	public List<String> deptList() {
		List<String> deptList = dao.deptList();
		return deptList;
	}	
	
	// 요일이름 알아오기
	@Override
	public List<String> dayList() {
		List<String> dayList = dao.dayList();
		return dayList;
	}

	// 대상학년 알아오기
	@Override
	public List<String> gradeList() {
		List<String> gradeList = dao.gradeList();
		return gradeList;
	}
	
	// 강좌명 알아오기
	@Override
	public List<String> classList() {
		List<String> classList = dao.classList();
		return classList;
	}
	
	// tbl_subject 에서 조건에 만족하는 강의들 가져오기
	@Override
	public List<Map<String, String>> subjectList(Map<String, Object> paraMap) {
		List<Map<String, String>> subjectList = dao.subjectList(paraMap);
		return subjectList;
	}

	// 신청 클릭시 과목 신청
	@Override
	public int course_submit(Map<String, String> paraMap) {

		int n = dao.course_submit(paraMap);						
		
		return n;
	}

	
	// 수강신청 완료된 목록	
	@Override
	public List<Map<String, String>> courseList(Map<String, Object> paraMap) {
		List<Map<String, String>> courseList = dao.courseList(paraMap);
		return courseList;
	}

	// 취소 클릭시 수강 목록 삭제
	@Override
	public int course_delete(Map<String, String> paraMap) {

		int n = dao.course_delete(paraMap);
		
		return n;
	}

	// 신청인원 증가
	@Override
	public int applyperson_plus(Map<String, String> paraMap) {

		int n = dao.applyperson_plus(paraMap);
		
		return n;
	}

	
	// 삭제시 신청인원 감소
	@Override
	public int applyperson_minus(Map<String, String> paraMap) {

		int n = dao.applyperson_minus(paraMap);
		
		return n;
	}

	@Override
	public List<String> creditcount() {
		List<String> creditcount = dao.creditcount();
		return creditcount;
	}

	
	// 총 게시물 건수(totalCount) 구하기
	@Override
	public int getTotalCount(Map<String, Object> paraMap) {
		int n = dao.getTotalCount(paraMap);
		return n;
	}

	// 강의평가에 컬럼 추가
	@Override
	public int insertevalue(Map<String, String> paraMap) {
		int n = dao.insertevalue(paraMap);
		
		return n;
	}




}
