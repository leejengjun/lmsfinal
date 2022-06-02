package com.spring.lmsfinal.yejinsim.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.spring.lmsfinal.choibyoungjin.model.StudentVO;
import com.spring.lmsfinal.duHyeon.model.SubjectNoticeVO;
import com.spring.lmsfinal.wonhyejin.model.AdminVO;

@Repository
public class MylectureDAO implements InterMylectureDAO {

	@Resource
	private SqlSessionTemplate sqlsession; // 원격 DB finalorauser3 에 연결

	// == 페이징 처리를 안한 검색어 없는 내 강의 목록 보여주기 == //
	@Override
	public List<MylectureVO> mylectureListNoSearch(String userid) {
		List<MylectureVO> mylectureList = sqlsession.selectList("yejinsim.mylectureListNoSearch", userid);
		
		return mylectureList;
	}

	// == 페이징 처리를 안한 검색어 없는 내 강의 신청 목록 보여주기 == //
	@Override
	public List<MylectureVO> applylectureListNoSearch(String userid) {
		List<MylectureVO> applylectureList = sqlsession.selectList("yejinsim.applylectureListNoSearch", userid);
		
		return applylectureList;
	}

	// 페이징 처리한 신청강의목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함 한 것)
		@Override
		public List<MylectureVO> applyListSearchWithPaging(Map<String, String> paraMap) {
			List<MylectureVO> applylectureList = sqlsession.selectList("yejinsim.applyListSearchWithPaging", paraMap);
			return applylectureList;
		}
		

	// == 검색어 입력시 자동글 완성하기 
	@Override
	public List<String> deptSearchShow(Map<String, String> paraMap) {
		List<String> wordList = sqlsession.selectList("yejinsim.deptSearchShow", paraMap);
		return wordList;
	}

	// == 페이징처리 안 한 검색어 있는 전체 학과 목록 보여주기
	@Override
	public List<MylectureVO> deptListSearch(Map<String, String> paraMap) {
		List<MylectureVO> deptList = sqlsession.selectList("yejinsim.deptListSearch", paraMap);
		
		return deptList;
	}

	// 학과코드에 따라 강의코드 주기 (Ajax)
	@Override
	public int subjectidShow(String majorid) {
		int subjectid = sqlsession.selectOne("yejinsim.subjectidShow", majorid);
		
		return subjectid;
	}

	
	@Override
	public int addlecture(MylectureVO mylecturevo) {
		int n = sqlsession.insert("yejinsim.addlecture",mylecturevo);
	
		return n;
	}

	
	// 강의 평가 문항 조회하기 
	@Override
	public List<MylectureVO> LctrevaluitemSearch(String subjectid) {
		List<MylectureVO> lctrEvaluitem = sqlsession.selectList("yejinsim.LctrevaluitemSearch", subjectid);
		return lctrEvaluitem;
	}

	// 강의 평가 결과 조회하기  (Ajax)
	@Override
	public List<MylectureVO> lctrevaluresultSearch(String subjectid) {
		List<MylectureVO> lctrEvaluResult = sqlsession.selectList("yejinsim.lctrevaluresultSearch", subjectid);
		return lctrEvaluResult;
	}

	// 강의평가의 평균값 결과 조회 (Ajax)
	@Override
	public List<MylectureVO> lctrevaluavgresultSearch(String subjectid) {
		List<MylectureVO> avlctrEvaluavgResult = sqlsession.selectList("yejinsim.lctrevaluavgresultSearch", subjectid);
		return avlctrEvaluavgResult;
	}

		
	// 학생의 내 강의실 조회하기
	@Override
	public List<MylectureVO> stumylectureListNoSearch(String userid) {
		List<MylectureVO> mylectureList = sqlsession.selectList("yejinsim.stumylectureListNoSearch", userid);
		return mylectureList;
	}

	// 총게시물건수 가져오기
	@Override
	public int getTotalNoticeCount(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("duHyeon.getTotalNoticeCount", paraMap);
		return n;
	}

	// 강의실 메인홈 -공지사항 글 목록 가져오기
	@Override
	public List<SubjectNoticeVO> noticeList(Map<String, String> paraMap) {
		List<SubjectNoticeVO> noticeList = sqlsession.selectList("duHyeon.noticeList", paraMap);
		return noticeList;
	}

	// 강의 정보 가져오기
	@Override
	public List<MylectureVO> getlectureInfo(Map<String, String> paraMap) {
		List<MylectureVO> mylectureList = sqlsession.selectList("yejinsim.getlectureInfo", paraMap);	
		return mylectureList;
	}

	// 강의실이름 가져오기
	@Override
	public String getClassname(String subjectid) {
		String classname = sqlsession.selectOne("yejinsim.getClassname", subjectid);
		
		return classname;
	}

	// 학생으로 로그인했을 때 수강하는 강의 정보 보여주기
	@Override
	public List<MylectureVO> stugetlectureInfo(Map<String, String> paraMap) {
		List<MylectureVO> mylectureList = sqlsession.selectList("yejinsim.stugetlectureInfo", paraMap);	
		return mylectureList;
	}

	// 교수의 총 신청강의 건수 가져오기
	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("yejinsim.getTotalCount", paraMap);
		return n;
	}

	// 강의 검색해오기 
	@Override
	public List<String> lectureSearchShow(Map<String, String> paraMap) {
		List<String> lectureList = sqlsession.selectList("yejinsim.lectureSearchShow", paraMap);
		return lectureList;
	}

	// 학생 로그인처리하기
	@Override
	public StudentVO keepLoginStudent(Map<String, String> paraMap) {
		StudentVO loginuser_student = sqlsession.selectOne("yejinsim.keepLoginStudent", paraMap);  // paraMap 이 속에 userid 와 pwd 가  있다. 리턴타입은 MemberVO
		return loginuser_student;
	}

	// 교수 로그인처리하기
	@Override
	public GyowonVO keepLoginGyowon(Map<String, String> paraMap) {
		GyowonVO loginuser_gyowon = sqlsession.selectOne("yejinsim.keepLoginGyowon", paraMap);  // paraMap 이 속에 userid 와 pwd 가  있다. 리턴타입은 MemberVO
		return loginuser_gyowon;
	}

	// 관리자 로그인처리하기
	@Override
	public AdminVO keepLoginAdmin(Map<String, String> paraMap) {
		AdminVO loginuser_admin = sqlsession.selectOne("yejinsim.keepLoginAdmin", paraMap);  // paraMap 이 속에 userid 와 pwd 가  있다. 리턴타입은 MemberVO
		return loginuser_admin;
	}

	

	
	
	
}
