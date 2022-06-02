package com.spring.lmsfinal.choibyoungjin.model;

import java.util.List;
import java.util.Map;

public interface InterCourseDAO {

	// tbl_subject 에서 학과이름 알아오기
	List<String> deptList();

	// 요일이름 알아오기
	List<String> dayList();

	// 대상학년 알아오기
	List<String> gradeList();

	// 강좌명 알아오기
	List<String> classList();

	// tbl_subject 에서 조건에 만족하는 강의들 가져오기
	List<Map<String, String>> subjectList(Map<String, Object> paraMap);

	// 신청 클릭시 과목 신청
	int course_submit(Map<String, String> paraMap);

	// 수강신청 완료된 목록	
	List<Map<String, String>> courseList(Map<String, Object> paraMap);

	// 취소 클릭시 수강 목록 삭제
	int course_delete(Map<String, String> paraMap);

	// 신청인원 증가
	int applyperson_plus(Map<String, String> paraMap);

	// 삭제시 신청인원 감소
	int applyperson_minus(Map<String, String> paraMap);

	List<String> creditcount();

	// 총 게시물 건수(totalCount) 구하기
	int getTotalCount(Map<String, Object> paraMap);

	// 강의평가에 컬럼 추가
	int insertevalue(Map<String, String> paraMap);


}
