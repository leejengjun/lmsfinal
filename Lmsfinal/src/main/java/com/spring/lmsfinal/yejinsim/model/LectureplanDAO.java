package com.spring.lmsfinal.yejinsim.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;


@Repository
public class LectureplanDAO implements InterLectureplanDAO {

	@Resource
	private SqlSessionTemplate sqlsession; // 원격 DB finalorauser3 에 연결

	// 강의계획서 작성에 필요한 정보 받아오기
	@Override
	public List<MylectureVO> lctrListSearch(Map<String, String> paraMap) {
		List<MylectureVO> lctrinfoList = sqlsession.selectList("yejinsim.lctrListSearch", paraMap);
		return lctrinfoList;
	}

	// 강의계획서 작성하기 
	@Override
	public int addlectureplan(LectureplanVO lctrplanrvo) {
		int n = sqlsession.insert("yejinsim.addlectureplan",lctrplanrvo);	
		return n;
	}

	// 강의계획서 보기
	@Override
	public LectureplanVO lctrplanSearch(Map<String, String> paraMap) {
		LectureplanVO lctrplanvo = sqlsession.selectOne("yejinsim.lctrplanSearch",paraMap);
		return lctrplanvo;
	}

	// 강의계획서 수정하기 
	@Override
	public int editlctrplan(LectureplanVO lctrplanvo) {
		int n = sqlsession.update("yejinsim.editlctrplan", lctrplanvo);
		return n;
	}


	// 학과코드 가져오기 (이따 대체할 것)
	@Override
	public String getmajorid(String subjectid) {
		String majorid = sqlsession.selectOne("yejinsim.getmajorid", subjectid);
		return majorid;
	}

	// 주차별 강의계획서 정보 입력하기
	@Override
	public int addlctrplandetail(Map<String, Object> paraMap) {
		int n = sqlsession.insert("yejinsim.addlctrplandetail",paraMap);	
	//	System.out.println("확인용 n3" + n);     
		return n;
	}

	// 강의계획서 코드 가져오기 (이따 대체할 것)
	@Override
	public String getSeq_lectureplan(String subjectid) {
		String seq_lectureplan = sqlsession.selectOne("yejinsim.getSeq_lectureplan", subjectid);
		return seq_lectureplan;
	}

	// 주차별 강의계획서 정보 가져오기(ajax)
	@Override
	public List<LectureplanVO> lctrplandetailSearch(String subjectid) {
		List<LectureplanVO> lctrplandetailList = sqlsession.selectList("yejinsim.lctrplandetailSearch", subjectid);
		return lctrplandetailList;
	}

	// 강의 신청상태변경하기
	@Override
	public int changeapplystate(String subjectid) {
		int n = sqlsession.update("yejinsim.changeapplystate", subjectid);
		return n;
	}

	// 주차별 강의계획서 수정하기
	@Override
	public int editlctrplandetail(Map<String, Object> paraMap) {
		int n = sqlsession.update("yejinsim.editlctrplan", paraMap);
		return n;
	}
}
