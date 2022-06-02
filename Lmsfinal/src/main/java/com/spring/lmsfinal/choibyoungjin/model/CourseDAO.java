package com.spring.lmsfinal.choibyoungjin.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CourseDAO implements InterCourseDAO {
	
	@Resource
	private SqlSessionTemplate sqlsession;
	
	// tbl_subject 에서 학과이름 알아오기
	@Override
	public List<String> deptList() {
		List<String> deptList = sqlsession.selectList("courseCBJ.deptList");
		return deptList;
	}

	// 요일이름 알아오기
	@Override
	public List<String> dayList() {
		List<String> dayList = sqlsession.selectList("courseCBJ.dayList");
		return dayList;
	}

	// 대상학년 알아오기
	@Override
	public List<String> gradeList() {
		List<String> gradeList = sqlsession.selectList("courseCBJ.gradeList");
		return gradeList;
	}

	// 강좌명 알아오기
	@Override
	public List<String> classList() {
		List<String> classList = sqlsession.selectList("courseCBJ.classList");
		return classList;
	}

	// tbl_subject 에서 조건에 만족하는 강의들 가져오기
	@Override
	public List<Map<String, String>> subjectList(Map<String, Object> paraMap) {
		List<Map<String, String>> subjectList = sqlsession.selectList("courseCBJ.subjectList", paraMap);
		return subjectList;
	}

	// 신청 클릭시 과목 신청
	@Override
	public int course_submit(Map<String, String> paraMap) {
		int n = sqlsession.insert("courseCBJ.course_submit", paraMap);
		return n;
	}

	
	// 수강신청 완료된 목록	
	@Override
	public List<Map<String, String>> courseList(Map<String, Object> paraMap) {
		List<Map<String, String>> courseList = sqlsession.selectList("courseCBJ.courseList", paraMap);
		return courseList;
	}

	// 취소 클릭시 수강 목록 삭제
	@Override
	public int course_delete(Map<String, String> paraMap) {
		int n = sqlsession.delete("courseCBJ.course_delete", paraMap);
		return n;
	}
	
	
	// 신청인원 증가
	@Override
	public int applyperson_plus(Map<String, String> paraMap) {
		int n = sqlsession.delete("courseCBJ.applyperson_plus", paraMap);
		return n;
	}
	
	
	// 삭제시 신청인원 감소
	@Override
	public int applyperson_minus(Map<String, String> paraMap) {
		int n = sqlsession.delete("courseCBJ.applyperson_minus", paraMap);
		return n;
	}

	@Override
	public List<String> creditcount() {
		List<String> creditcount = sqlsession.selectList("courseCBJ.creditcount");
		return creditcount;
	}

	@Override
	public int getTotalCount(Map<String, Object> paraMap) {
		int n = sqlsession.selectOne("courseCBJ.getTotalCount", paraMap);
		return n;
	}

	@Override
	public int insertevalue(Map<String, String> paraMap) {
		int n = sqlsession.insert("courseCBJ.insertevalue", paraMap);
		return n;
	}



}
