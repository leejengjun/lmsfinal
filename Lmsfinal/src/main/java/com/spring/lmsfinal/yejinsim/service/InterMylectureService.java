package com.spring.lmsfinal.yejinsim.service;

import java.util.List;
import java.util.Map;

import com.spring.lmsfinal.choibyoungjin.model.StudentVO;
import com.spring.lmsfinal.duHyeon.model.SubjectNoticeVO;
import com.spring.lmsfinal.wonhyejin.model.AdminVO;
import com.spring.lmsfinal.yejinsim.model.GyowonVO;
import com.spring.lmsfinal.yejinsim.model.LectureroomVO;
import com.spring.lmsfinal.yejinsim.model.MylectureVO;

public interface InterMylectureService {
	
	// == 페이징 처리를 안한 검색어 없는 내 강의 목록 보여주기 == //
	List<MylectureVO> mylectureListNoSearch(String userid);

	// == 페이징 처리를 안한 검색어 없는 내 강의 신청 목록 보여주기 == //
	List<MylectureVO> applylectureListNoSearch(String userid);
	
	// 검색어 입력시 자동글 완성하기(학과)
	List<String> deptSearchShow(Map<String, String> paraMap);

	// 페이징처리 안 한 검색어 있는 전체 학과 목록 보여주기
	List<MylectureVO> deptListSearch(Map<String, String> paraMap);

	// 학과코드에 따라 강의코드 주기 (Ajax)
	int subjectidShow(String majorid);

	// 강의 개설 신청하기 
	int addlecture(MylectureVO mylecturevo);

	// 강의 평가 문항 조회하기 
	List<MylectureVO> LctrevaluitemSearch(String subjectid);

	// 강의 평가 결과 조회하기  (Ajax)
	List<MylectureVO> lctrevaluresultSearch(String subjectid);

	// 강의평가의 평균값 결과 조회 (Ajax)
	List<MylectureVO> lctrevaluavgresultSearch(String subjectid);

		
	// 학생의 내 강의실 조회하기
	List<MylectureVO> stumylectureListNoSearch(String userid);

	// 강의실 메인홈 - 총게시물건수 가져오기(페이징처리 안함)
	int getTotalNoticeCount(Map<String, String> paraMap);

	// 강의 정보 가져오기
	List<MylectureVO> getlectureInfo(Map<String, String> paraMap);

	// 강의실 메인홈 -공지사항 글 목록 가져오기
	List<SubjectNoticeVO> noticeList(Map<String, String> paraMap);

	// 강의실이름 가져오기
	String getClassname(String subjectid);

	// 학생으로 로그인했을 때 수강하는 강의 정보 보여주기
	List<MylectureVO> stugetlectureInfo(Map<String, String> paraMap);

	// 교수의 총 신청강의 건수 가져오기
	int getTotalCount(Map<String, String> paraMap);

	// 페이징 처리한 신청강의목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함 한 것)
	List<MylectureVO> applyListSearchWithPaging(Map<String, String> paraMap);

	// 강의 검색해오기 
	List<String> lectureSearchShow(Map<String, String> paraMap);

	// 학생 로그인 정보 유지하기
	StudentVO keepLoginStudent(Map<String, String> paraMap);

	// 교원 로그인 정보 유지하기
	GyowonVO keepLoginGyowon(Map<String, String> paraMap);

	// 관리자 로그인 정보 유지하기
	AdminVO keepLoginAdmin(Map<String, String> paraMap);

	
	

}
