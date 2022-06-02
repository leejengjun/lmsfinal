package com.spring.lmsfinal.yejinsim.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.lmsfinal.choibyoungjin.model.StudentVO;
import com.spring.lmsfinal.duHyeon.model.SubjectNoticeVO;
import com.spring.lmsfinal.wonhyejin.model.AdminVO;
import com.spring.lmsfinal.yejinsim.model.GyowonVO;
import com.spring.lmsfinal.yejinsim.model.InterMylectureDAO;
import com.spring.lmsfinal.yejinsim.model.LectureroomVO;
import com.spring.lmsfinal.yejinsim.model.MylectureVO;

@Service
public class MylectureService implements InterMylectureService {

	@Autowired
	private InterMylectureDAO dao;

	// == 페이징 처리를 안한 검색어 없는 내 강의 목록 보여주기 == //
	@Override
	public List<MylectureVO> mylectureListNoSearch(String userid) {
		List<MylectureVO> mylectureList = dao.mylectureListNoSearch(userid);
		
		return mylectureList;
	}

	// == 페이징 처리를 안한 검색어 없는 내 강의 신청 목록 보여주기 == //
	@Override
	public List<MylectureVO> applylectureListNoSearch(String userid) {
		List<MylectureVO> applylectureList = dao.applylectureListNoSearch(userid);
		
		return applylectureList;
	}

	// 페이징 처리한 신청강의목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함 한 것)
	@Override
	public List<MylectureVO> applyListSearchWithPaging(Map<String, String> paraMap) {
		List<MylectureVO> applylectureList = dao.applyListSearchWithPaging(paraMap);
		return applylectureList;
	}

	
	// == 검색어 입력시 자동글 완성하기
	@Override
	public List<String> deptSearchShow(Map<String, String> paraMap) {
		List<String> wordList = dao.deptSearchShow(paraMap);
		return wordList;
	}

	// == 페이징처리 안 한 검색어 있는 전체 학과 목록 보여주기
	@Override
	public List<MylectureVO> deptListSearch(Map<String, String> paraMap) {
		List<MylectureVO> deptList = dao.deptListSearch(paraMap);
		
		return deptList;
	}

	
	
	
	// 학과코드에 따라 강의코드 주기 (Ajax)
	@Override
	public int subjectidShow(String majorid) {
		int subjectid = dao.subjectidShow(majorid);
		return subjectid;
	}

	// 강의 개설 신청하기 
	@Override
	public int addlecture(MylectureVO mylecturevo) {
		int n = dao.addlecture(mylecturevo);
		return n;
	}

	

	// 강의 평가 문항 조회하기 
	@Override
	public List<MylectureVO> LctrevaluitemSearch(String subjectid) {
		List<MylectureVO> lctrEvaluitem = dao.LctrevaluitemSearch(subjectid);		
		return lctrEvaluitem;
	}

	// 강의 평가 결과 조회하기  (Ajax)
	@Override
	public List<MylectureVO> lctrevaluresultSearch(String subjectid) {
		List<MylectureVO> lctrEvaluResult = dao.lctrevaluresultSearch(subjectid);		
		return lctrEvaluResult;
	}

	// 강의평가의 평균값 결과 조회 (Ajax)
	@Override
	public List<MylectureVO> lctrevaluavgresultSearch(String subjectid) {
		List<MylectureVO> avlctrEvaluavgResult = dao.lctrevaluavgresultSearch(subjectid);		
		return avlctrEvaluavgResult;
	}

	
	// 학생의 내 강의실 조회하기
	@Override
	public List<MylectureVO> stumylectureListNoSearch(String userid) {
		List<MylectureVO> mylectureList = dao.stumylectureListNoSearch(userid);
		return mylectureList;
	}

	// 총게시물건수 가져오기
	@Override
	public int getTotalNoticeCount(Map<String, String> paraMap) {
		int n = dao.getTotalNoticeCount(paraMap);
		return n;
	}

	// 강의실 메인홈 -공지사항 글 목록 가져오기
	@Override
	public List<SubjectNoticeVO> noticeList(Map<String, String> paraMap) {
		List<SubjectNoticeVO> noticeList = dao.noticeList(paraMap);
		return noticeList;
	}

	// 강의 정보 가져오기
	@Override
	public List<MylectureVO> getlectureInfo(Map<String, String> paraMap) {
		List<MylectureVO> mylectureList = dao.getlectureInfo(paraMap);
		return mylectureList;
	}

	// 강의실이름 가져오기
	@Override
	public String getClassname(String subjectid) {
		String classname = dao.getClassname(subjectid);
		return classname;
	}

	// 학생으로 로그인했을 때 수강하는 강의 정보 보여주기
	@Override
	public List<MylectureVO> stugetlectureInfo(Map<String, String> paraMap) {
		List<MylectureVO> mylectureList = dao.stugetlectureInfo(paraMap);
		return mylectureList;
	}

	// 교수의 총 신청강의 건수 가져오기
	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		int n = dao.getTotalCount(paraMap);
		return n;
	}

	// 강의 검색해오기 
	@Override
	public List<String> lectureSearchShow(Map<String, String> paraMap) {
		List<String> lectureList = dao.lectureSearchShow(paraMap);
		return lectureList;
	}

	// 학생 로그인 정보 유지하기
	@Override
	public StudentVO keepLoginStudent(Map<String, String> paraMap) {
		StudentVO loginuser_student = dao.keepLoginStudent(paraMap);
		return loginuser_student;
	}

	// 교원 로그인 정보 유지하기
	@Override
	public GyowonVO keepLoginGyowon(Map<String, String> paraMap) {
		GyowonVO loginuser_gyowon = dao.keepLoginGyowon(paraMap);
		return loginuser_gyowon;
	}

	// 관리자 로그인 정보 유지하기
	@Override
	public AdminVO keepLoginAdmin(Map<String, String> paraMap) {
		AdminVO loginuser_admin = dao.keepLoginAdmin(paraMap);
		return loginuser_admin;
	}

	
	
	
}
