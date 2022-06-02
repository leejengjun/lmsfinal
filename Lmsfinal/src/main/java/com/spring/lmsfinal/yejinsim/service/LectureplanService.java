package com.spring.lmsfinal.yejinsim.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.lmsfinal.yejinsim.model.InterLectureplanDAO;
import com.spring.lmsfinal.yejinsim.model.LectureplanVO;
import com.spring.lmsfinal.yejinsim.model.MylectureVO;

@Service
public class LectureplanService implements InterLectureplanService {

	@Autowired
	private InterLectureplanDAO dao;

	// 강의계획서 작성에 필요한 정보 받아오기
	@Override
	public List<MylectureVO> lctrListSearch(Map<String, String> paraMap) {
		List<MylectureVO> lctrinfoList = dao.lctrListSearch(paraMap);		
		return lctrinfoList;
	}

	// 강의계획서 작성하기 
	@Override
	public int addlectureplan(LectureplanVO lctrplanrvo) {
		int n = dao.addlectureplan(lctrplanrvo);
		return n;
	}

	// 강의계획서 보기
	@Override
	public LectureplanVO lctrplanSearch(Map<String, String> paraMap) {
		LectureplanVO lctrplanvo = dao.lctrplanSearch(paraMap); // 글 1개를 조회하기
		return lctrplanvo;
	}

	// 강의계획서 수정하기 
	@Override
	public int editlctrplan(LectureplanVO lctrplanvo) {
		int n = dao.editlctrplan(lctrplanvo);
		return n;
	}


	// 학과코드 가져오기 (이따 대체할 것)
	@Override
	public String getmajorid(String subjectid) {
		String majorid = dao.getmajorid(subjectid);
		return majorid;
	}

	
	// 주차별 강의계획서 정보 입력하기(ajax)
	@Override
	public int addlctrplandetail(Map<String, Object> paraMap) {
		int n = dao.addlctrplandetail(paraMap);
	//	System.out.println("확인용 2n" + n);
	       
        return n;
	}

	// 강의계획서 코드 가져오기 (이따 대체할 것)
	@Override
	public String getSeq_lectureplan(String subjectid) {
		String seq_lectureplan = dao.getSeq_lectureplan(subjectid);
		return seq_lectureplan;
	}

	// 주차별 강의계획서 정보 가져오기(ajax)
	@Override
	public List<LectureplanVO> lctrplandetailSearch(String subjectid) {
		List<LectureplanVO> lctrplandetailList = dao.lctrplandetailSearch(subjectid);		
		return lctrplandetailList;
	}

	// 강의 신청상태변경하기
	@Override
	public int changeapplystate(String subjectid) {
		int n = dao.changeapplystate(subjectid);
		return n;
	}

	// 주차별 강의계획서 수정하기
	@Override
	public int editlctrplandetail(Map<String, Object> paraMap) {
		int n = dao.editlctrplandetail(paraMap);
		return n;
	}
}
